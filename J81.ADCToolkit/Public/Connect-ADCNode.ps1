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
        #>
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Uri]$ManagementURL,
    
        [Parameter(Mandatory = $true)]
        [PSCredential]$Credential,
    
        [int]$Timeout = 3600,
    
        [switch]$PassThru
    )
    # Based on https://github.com/devblackops/NetScaler
    
    function Set-IgnoreTLSSettings {
        Write-Verbose "Ignoring SSL checks"
        $Provider = New-Object Microsoft.CSharp.CSharpCodeProvider
        $Provider.CreateCompiler() | Out-Null
        $Params = New-Object System.CodeDom.Compiler.CompilerParameters
        $Params.GenerateExecutable = $false
        $Params.GenerateInMemory = $true
        $Params.IncludeDebugInformation = $false
        $Params.ReferencedAssemblies.Add("System.DLL") > $null
        $TASource = @'
                namespace Local.ToolkitExtensions.Net.CertificatePolicy
                {
                    public class TrustAll : System.Net.ICertificatePolicy
                    {
                        public bool CheckValidationResult(System.Net.ServicePoint sp,System.Security.Cryptography.X509Certificates.X509Certificate cert, System.Net.WebRequest req, int problem)
                        {
                            return true;
                        }
                    }
                }
'@ 
        $TAResults = $Provider.CompileAssemblyFromSource($Params, $TASource)
        $TAAssembly = $TAResults.CompiledAssembly
        $TrustAll = $TAAssembly.CreateInstance("Local.ToolkitExtensions.Net.CertificatePolicy.TrustAll")
        [System.Net.ServicePointManager]::CertificatePolicy = $TrustAll
        [System.Net.ServicePointManager]::SecurityProtocol = 
        [System.Net.SecurityProtocolType]::Tls13 -bor `
            [System.Net.SecurityProtocolType]::Tls12 -bor `
            [System.Net.SecurityProtocolType]::Tls11
    }
    Write-Verbose -Message "Connecting to $ManagementURL..."
    if ($ManagementURL.scheme -eq "https") {
        Write-Verbose "Connection is SSL"
        Set-IgnoreTLSSettings
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
    $Global:ADCSession = $ADCSession
        
    if ($PassThru) {
        return $ADCSession
    }
}
