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
    .PARAMETER PassThru
        Return the ADC session object.
    .EXAMPLE
        Connect-ADCNode -ManagementURL https://citrixacd.domain.local -Credential (Get-Credential)
    #>
    [cmdletbinding()]
    param(
        [ValidatePattern('^(https?:[\/]{2}.*)$', Options = 'None')]
        [ValidateNotNullOrEmpty()]
        [System.Uri]$ManagementURL = (Read-Host -Prompt "Enter the Citrix ADC Management URL. E.g. https://citrixacd.domain.local"),
    
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = (Get-Credential -Message "Enter username and password for the Citrix ADC`r`nE.g. nsroot / P@ssw0rd" ),
        
        [int]$Timeout = 900,
    
        [switch]$PassThru
    )
    # Based on https://github.com/devblackops/NetScaler
    
    if ($ManagementURL.scheme -eq "https") {
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
        # Set Tls versions
        [System.Net.ServicePointManager]::SecurityProtocol = 
        [System.Net.SecurityProtocolType]::Tls13 -bor `
            [System.Net.SecurityProtocolType]::Tls12 -bor `
            [System.Net.SecurityProtocolType]::Tls11
    } else {
        Write-Verbose -Message "Connecting to $ManagementURL..."
    }
    try {
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
        ManagementURL = $ManagementURL;
        WebSession    = [Microsoft.PowerShell.Commands.WebRequestSession]$saveSession;
        Username      = $Credential.UserName;
        Version       = "UNKNOWN";
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
        $response = Invoke-RestMethod @params
        Write-Verbose -Message "Response:`n$(ConvertTo-Json -InputObject $response | Out-String)"
        $ADCSession.version = ($response.nsversion.version.Split(","))[0]
    } catch {
        Write-Verbose -Message "Error. See response: `n$($response | Format-List -Property * | Out-String)"
    }
    $Script:ADCSession = $ADCSession
        
    if ($PassThru) {
        return $ADCSession
    }
}
