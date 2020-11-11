function Invoke-ADCNitroApi {
    <#
        .SYNOPSIS
            Invoke ADC NITRO REST API
        .DESCRIPTION
            Invoke ADC NITRO REST API
        .PARAMETER ADCSession
            An existing custom ADC Web Request Session object returned by Connect-ADCNode
        .PARAMETER Method
            Specifies the method used for the web request
        .PARAMETER Type
            Type of the ADC appliance resource
        .PARAMETER Resource
            Name of the ADC appliance resource, optional
        .PARAMETER Action
            Name of the action to perform on the ADC appliance resource
        .PARAMETER Arguments
            One or more arguments for the web request, in hashtable format
        .PARAMETER Query
            Specifies a query that can be send  in the web request
        .PARAMETER Filters
            Specifies a filter that can be send to the remote server, in hashtable format
        .PARAMETER Payload
            Payload  of the web request, in hashtable format
        .PARAMETER GetWarning
            Switch parameter, when turned on, warning message will be sent in 'message' field and 'WARNING' value is set in severity field of the response in case there is a warning.
            Turned off by default
        .PARAMETER OnErrorAction
            Use this parameter to set the onerror status for nitro request. Applicable only for bulk requests.
            Acceptable values: "EXIT", "CONTINUE", "ROLLBACK", default to "EXIT"
        .EXAMPLE
            Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsip
        #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [alias("Session")]
        [PSObject]$ADCSession,
    
        [Parameter(Mandatory = $true)]
        [ValidateSet('DELETE', 'GET', 'POST', 'PUT')]
        [string]$Method,
    
        [Parameter(Mandatory = $true)]
        [string]$Type,
    
        [string]$Resource,
    
        [string]$Action,
    
        [hashtable]$Arguments = @{ },
            
        [ValidateCount(0, 1)]
        [hashtable]$Query = @{ },
    
        [switch]$Stat = $false,
    
        [ValidateScript( { $Method -eq 'GET' })]
        [hashtable]$Filters = @{ },
    
        [ValidateScript( { $Method -ne 'GET' })]
        [hashtable]$Payload = @{ },
    
        [switch]$GetWarning = $false,
    
        [ValidateScript( { $Method -eq 'GET' })]
        [switch]$Summary = $false,
    
        [ValidateSet('EXIT', 'CONTINUE', 'ROLLBACK')]
        [string]$OnErrorAction = 'EXIT',
            
        [Switch]$Clean
    )
    # https://github.com/devblackops/NetScaler
    if ([string]::IsNullOrEmpty($($ADCSession.ManagementURL.AbsoluteUri))) {
        throw "ERROR: Probably not logged into the ADC"
    }
    if ($Stat) {
        $uri = "$($ADCSession.ManagementURL.AbsoluteUri)nitro/v1/stat/$Type"
    } else {
        $uri = "$($ADCSession.ManagementURL.AbsoluteUri)nitro/v1/config/$Type"
    }
    if (-not ([string]::IsNullOrEmpty($Resource))) {
        $uri += "/$Resource"
    }
    if ($Method -ne 'GET') {
        if (-not ([string]::IsNullOrEmpty($Action))) {
            $uri += "?action=$Action"
        }
    
        if ($Arguments.Count -gt 0) {
            $queryPresent = $true
            if ($uri -like '*?action*') {
                $uri += '&args='
            } else {
                $uri += '?args='
            }
            $argsList = @()
            foreach ($arg in $Arguments.GetEnumerator()) {
                $argsList += "$($arg.Name):$([System.Uri]::EscapeDataString($arg.Value))"
            }
            $uri += $argsList -join ','
        }
    } else {
        $queryPresent = $false
        if ($Arguments.Count -gt 0) {
            $queryPresent = $true
            $uri += '?args='
            $argsList = @()
            foreach ($arg in $Arguments.GetEnumerator()) {
                $argsList += "$($arg.Name):$([System.Uri]::EscapeDataString($arg.Value))"
            }
            $uri += $argsList -join ','
        }
        if ($Filters.Count -gt 0) {
            $uri += if ($queryPresent) { '&filter=' } else { '?filter=' }
            $filterList = @()
            foreach ($filter in $Filters.GetEnumerator()) {
                $filterList += "$($filter.Name):$([System.Uri]::EscapeDataString($filter.Value))"
            }
            $uri += $filterList -join ','
        }
        if ($Query.Count -gt 0) {
            $uri += $Query.GetEnumerator() | ForEach-Object { "?$($_.Name)=$([System.Uri]::EscapeDataString($_.Value))" }
        }
        if ($Summary) {
            $uri += "?view=$([System.Uri]::EscapeDataString("summary"))"
        }
    }
    Write-Verbose -Message "URI: $uri"
    $jsonPayload = $null
    if ($Method -ne 'GET') {
        $warning = if ($GetWarning) { 'YES' } else { 'NO' }
        $hashtablePayload = @{ }
        $hashtablePayload.'params' = @{'warning' = $warning; 'onerror' = $OnErrorAction; <#"action"=$Action#> }
        $hashtablePayload.$Type = $Payload
        $jsonPayload = ConvertTo-Json -InputObject $hashtablePayload -Depth 100
        Write-Verbose -Message "Method: $Method | Payload:`n$jsonPayload"
    }
        
    $response = $null
    $restError = $null
    try {
        $restError = @()
        $restParams = @{
            Uri           = $uri
            ContentType   = 'application/json'
            Method        = $Method
            WebSession    = $ADCSession.WebSession
            ErrorVariable = 'restError'
            Verbose       = $false
        }
        if ($Method -ne 'GET') {
            $restParams.Add('Body', $jsonPayload)
        }
        $response = Invoke-RestMethod @restParams
			
    } catch [Exception] {
        if ($Type -eq 'reboot' -and $restError[0].Message -eq 'The underlying connection was closed: The connection was closed unexpectedly.') {
            Write-Warning -Message 'Connection closed due to reboot'
        } else {
            try {
                $response = $restError.Message | ConvertFrom-Json
            } catch {
                throw $_
            }
        }
    }
    if ($response -and $type) {
        $response | Add-Member -Membertype NoteProperty -Name type -value $Type
    }
    Write-Verbose "Resp: $response"
    if ($response.severity -eq 'ERROR') {
        throw "Error. See response: `n$($response | Format-List -Property * | Out-String)"
    } 
    if (-Not [String]::IsNullOrEmpty($response)) {
        Write-Output $response
    }
}
