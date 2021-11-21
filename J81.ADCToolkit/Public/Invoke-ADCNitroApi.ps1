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
    .PARAMETER Summary
        Return a subset of the requested data (if supported)
    .PARAMETER NitroPath
        Specify the nitro path to the specified command.
        E.g. 'nitro/v1/config'
    .PARAMETER OnErrorAction
        Use this parameter to set the onerror status for nitro request. Applicable only for bulk requests.
        Acceptable values: "EXIT", "CONTINUE", "ROLLBACK", default to "EXIT"
    .EXAMPLE
        Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsip
    .EXAMPLE
        $Payload = @{ name = $name }
        Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lbvserver -Action enable -Payload $Payload
    .NOTES
        File Name : Invoke-ADCNitroApi
        Version   : v2111.1520
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
                    Initial source https://github.com/devblackops/NetScaler
    #>
    [CmdletBinding()]
    param (
        [alias("Session")]
        [Parameter(Mandatory)]
        [PSObject]$ADCSession,

        [Parameter(Mandatory)]
        [ValidateSet('DELETE', 'GET', 'POST', 'PUT')]
        [string]$Method,

        [Parameter(Mandatory)]
        [string]$Type,

        [string]$Resource,

        [string]$Action,

        [hashtable]$Arguments = @{ },
        
        [ValidateCount(0, 1)]
        [hashtable]$Query = @{ },

        [ValidateScript( { $Method -in 'GET', 'GET-ALL' })]
        [hashtable]$Filters = @{ },

        [ValidateScript( { $Method -ne 'GET' })]
        [hashtable]$Payload = @{ },

        [switch]$GetWarning = $false,

        [ValidateScript( { $Method -in 'GET', 'GET-ALL' })]
        [switch]$Summary = $false,

        [ValidateSet('EXIT', 'CONTINUE', 'ROLLBACK')]
        [string]$OnErrorAction = 'EXIT',

        [ValidatePattern('^nitro\/v[0-9]\/(config|stat)$')]
        [string]$NitroPath = "nitro/v1/config",

        [Parameter(DontShow, ValueFromRemainingArguments)]
        [Object]$RemainingArguments
    )
    if ([string]::IsNullOrEmpty($($ADCSession.ManagementURL.AbsoluteUri))) {
        throw "ERROR. Probably not logged into the ADC, Connect by running `"Connect-ADCNode`""
    }
    $uri = "$($ADCSession.ManagementURL.AbsoluteUri)$($NitroPath)/$Type"

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
    $response = [PSCustomObject]@{
        errorcode = 0
        message   = "Done"
        severity  = "NONE"
    }
    $webResult = $null
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
        if ((-Not ('PSEdition' -notin $PSVersionTable.Keys -or $PSVersionTable.PSEdition -eq 'Desktop')) -and ($uri -match "^https://.*?$")) {
            $restParams.Add("SkipCertificateCheck", $true)
        }
        #$response = Invoke-RestMethod @restParams
        $webResult = Invoke-WebRequest @restParams
        if (-Not [String]::IsNullOrEmpty($($webResult.Content))) {
            $response = ConvertFrom-Json $([String]::new($webResult.Content))
        }
    } catch [Exception] {
        try {
            $response = $restError.Message | ConvertFrom-Json -ErrorAction Stop
        } catch {
            $response = $restError.Message
        }
        if ($restError.InnerException.Message) {
            $response | Add-Member -MemberType NoteProperty -Name ErrorMessage -Value $restError.InnerException.Message-ErrorAction SilentlyContinue
        }
        if ($Type -eq 'reboot' -and $restError[0].Message -eq 'The underlying connection was closed: The connection wasclosed unexpectedly.') {
            Write-Warning -Message 'Connection closed due to reboot'
        } else {
            if ([String]::IsNullOrEmpty($($restError.Message)) -and -not ($ErrorActionPreference -eq "SilentlyContinue")) {
                Throw $_.Exception.Message
            }
        }
    }
    if ($response -and $type) {
        $response | Add-Member -MemberType NoteProperty -Name type -Value $Type -ErrorAction SilentlyContinue
    }
    if ($webResult.statuscode) {
        $response | Add-Member -MemberType NoteProperty -Name StatusCode -Value $webResult.statuscode -ErrorAction SilentlyContinue
    }
    if ($webResult.StatusDescription) {
        $response | Add-Member -MemberType NoteProperty -Name StatusDescription -Value $webResult.StatusDescription -ErrorAction SilentlyContinue
    }
    Write-Output $response
    if (($response.severity -eq 'ERROR') -and -not ($ErrorActionPreference -eq "SilentlyContinue")) {
        Write-Verbose "ERROR: $($response | Format-List -Property * | Out-String)"
        Throw "[$($response.errorcode)] $($response.message)"
    }
}
