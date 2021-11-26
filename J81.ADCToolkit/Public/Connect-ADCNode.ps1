function Connect-ADCNode {
    <#
    .SYNOPSIS
        Establish a session with Citrix ADC.
    .DESCRIPTION
        Establish a session with Citrix ADC.
    .PARAMETER ManagementURL
        The URI/URL to connect to, E.g. "https://citrixadc.domain.local".
    .PARAMETER Credential
        The credential to authenticate to the ADC with.
    .PARAMETER Timeout
        Timeout in seconds for session object.
    .PARAMETER HA
        Connect all possible HA Nodes
    .PARAMETER PassThru
        Return the ADC session object.
    .EXAMPLE
        PS C:\>Connect-ADCNode -ManagementURL https://citrixacd.domain.local -Credential (Get-Credential)
        Connect to the ADC node with the specified management url and credential
    .NOTES
        File Name : Connect-ADCNode
        Version   : v2111.2522
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
                    Initial source https://github.com/devblackops/NetScaler
    #>
    [cmdletbinding(DefaultParameterSetName = 'Connect')]
    param(
        [Parameter(ParameterSetName = 'Connect')]    
        [ValidatePattern('^(https?:[\/]{2}.*)$', Options = 'None')]
        [ValidateNotNullOrEmpty()]
        [System.Uri]$ManagementURL = (Read-Host -Prompt "Enter the Citrix ADC Management URL. E.g. https://citrixacd.domain.local"),
    
        [Parameter(ParameterSetName = 'Connect', Mandatory)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = (Get-Credential -Message "Enter username and password for the Citrix ADC`r`nE.g. nsroot / P@ssw0rd" ),
        
        [Parameter(ParameterSetName = 'Connect')]
        [int]$Timeout = 900,

        [Parameter(ParameterSetName = 'Connect')]
        [switch]$HA,

        [Parameter(ParameterSetName = 'Connect')]
        [switch]$Force,

        [Parameter(ParameterSetName = 'Connect')]
        [switch]$PassThru
    )
    # Based on https://github.com/devblackops/NetScaler
    try {
        $SessionExpiration = (Get-Date).AddSeconds($Timeout)
    } catch {
        $SessionExpiration = (Get-Date).AddSeconds(60)
    }
    if ($HA) {
        $ADCSession = Connect-ADCHANodes -ManagementURL $ManagementURL -Credential $Credential -PassThru
    } else {
        $login = @{
            login = @{
                username = $Credential.UserName;
                password = $Credential.GetNetworkCredential().Password
                timeout  = $Timeout
            }
        }
        $loginJson = ConvertTo-Json -InputObject $login
        $saveSession = @{ }
        $params = @{
            Uri             = "$($ManagementURL.AbsoluteUri)nitro/v1/config/login"
            Method          = 'POST'
            Body            = $loginJson
            SessionVariable = 'saveSession'
            ContentType     = 'application/json'
            ErrorVariable   = 'restError'
            Verbose         = $false
        }
        if ($ManagementURL.AbsoluteUri -match "^https://.*?$") {
            if ('PSEdition' -notin $PSVersionTable.Keys -or $PSVersionTable.PSEdition -eq 'Desktop') {
                Write-Verbose "Connecting to $ManagementURL... Connection is SSL, Ignoring SSL checks"
                if (-Not ("TrustAllCertsPolicy" -as [type])) {
                    Add-Type -TypeDefinition @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
    ServicePoint srvPoint, X509Certificate certificate,
    WebRequest request, int certificateProblem) {
        return true;
    }
}
"@ 
                }
                [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
            } else {
                $params.Add("SkipCertificateCheck", $true)
            }
            # Set Tls versions
            $currentMaxTls = [Math]::Max([Net.ServicePointManager]::SecurityProtocol.value__, [Net.SecurityProtocolType]::Tls.value__)
            $newTlsTypes = [enum]::GetValues('Net.SecurityProtocolType') | Where-Object { $_ -gt $currentMaxTls }
            $newTlsTypes | ForEach-Object {
                [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor $_
            }            
        } else {
            Write-Verbose -Message "Connecting to $ManagementURL..."
        }
        try {
            $response = Invoke-RestMethod @params    
            if ($response.severity -eq 'ERROR') {
                throw "Error. See response: `n$($response | Format-List -Property * | Out-String)"
            } else {
                Write-Verbose -Message "Response:`n$(ConvertTo-Json -InputObject $response | Out-String)"
            }
        } catch [Exception] {
            throw $_
        }
        $ADCSession = [PSObject]@{
            ManagementURL     = $ManagementURL;
            WebSession        = [Microsoft.PowerShell.Commands.WebRequestSession]$saveSession;
            Username          = $Credential.UserName;
            Version           = "UNKNOWN";
            IsConnected       = $false
            SessionExpiration = $SessionExpiration
        }    
        try {
            Write-Verbose -Message "Trying to retrieve the ADC version"
            $params = @{
                Uri           = "$($ManagementURL.AbsoluteUri)nitro/v1/config/nsversion"
                Method        = 'GET'
                WebSession    = $ADCSession.WebSession
                ContentType   = 'application/json'
                ErrorVariable = 'restError'
                Verbose       = $false
            }
            if ((-Not ('PSEdition' -notin $PSVersionTable.Keys -or $PSVersionTable.PSEdition -eq 'Desktop')) -and ($ManagementURL.AbsoluteUri -match "^https://.*?$")) {
                $params.Add("SkipCertificateCheck", $true)
            }
            $response = Invoke-RestMethod @params
            Write-Verbose -Message "Response:`n$(ConvertTo-Json -InputObject $response | Out-String)"
            $ADCSession.version = ($response.nsversion.version.Split(","))[0]
            $ADCSession.IsConnected = $true
        } catch {
            Write-Verbose -Message "Error. See response: `n$($response | Format-List -Property * | Out-String)"
        }
    }
    $Script:ADCSession = $ADCSession
        
    if ($PassThru) {
        return $ADCSession
    } else {
        return $ADCSession.IsConnected
    }
}