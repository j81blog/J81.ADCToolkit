function Invoke-ADCChangeSSLCertKey {
    <#
    .SYNOPSIS
        Change properties of a CertKey
    .DESCRIPTION
        Change properties of a CertKey
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Name for the Certificate Key pair. Must begin with an ASCII alphanumeric or underscore (_) character, 
        and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
        equal sign (=), and hyphen (-) characters.
    .PARAMETER Cert
        Name of and, optionally, path to the X509 certificate file that is used to form the certificate-key pair.
        The certificate file should be present on the appliance's hard-disk drive or solid-state drive.
        Storing a certificate in any location other than the default might cause inconsistency in a high availability setup.
        /nsconfig/ssl/ is the default path.
    .PARAMETER Key
        Name of and, optionally, path to the private-key file that is used to form the certificate-key pair.
        The certificate file should be present on the appliance's hard-disk drive or solid-state drive.
        Storing a certificate in any location other than the default might cause inconsistency in a high availability setup.
        /nsconfig/ssl/ is the default path.
    .PARAMETER Password
        Passphrase that was used to encrypt the private-key. Use this option to load encrypted private-keys in PEM format.
    .PARAMETER Passplain
        Passphrase used to encrypt the private-key. Required when adding an encrypted private-key in PEM format.
    .PARAMETER Inform
        Input format of the certificate and the private-key files. The three formats supported by the appliance are:
        PEM - Privacy Enhanced Mail
        DER - Distinguished Encoding Rule
        PFX - Personal Information Exchange.
    .PARAMETER ExpiryMonitor
        Issue an alert when the certificate is about to expire.
    .PARAMETER NoDomainCheck
        Override the check for matching domain names during a certificate update operation.
    .PARAMETER PassThru
        Return details about the created CertKey.
    .EXAMPLE
        Invoke-ADCChangeSSLCertKey -CertKey "www.domain.com" -Cert "www.domain.com_2022.pfx" -Key "www.domain.com_2022.pfx" -Password -Passplain "P@ssw0rd!"
    .NOTES
        File Name : Invoke-ADCChangeSSLCertKey
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [parameter(Mandatory = $true)]
        [String]$CertKey = (Read-Host -Prompt "Name for the Certificate Key pair"),
        
        [ValidateRange(1, 65534)]
        [String]$Cert,
        
        [Parameter(Mandatory = $false)]
        [String]$Key,
        
        [Switch]$Password,
        
        [String]$PassPlain,

        [ValidateSet("PEM", "DER", "PFX")]
        [string]$Inform,

        [Switch]$NoDomainCheck
    )
    begin {
        Write-Verbose "Invoke-ADCChangeSSLCertKey: Starting"
    }
    process {
        try {
            $Payload = @{
                certkey = $CertKey
            }
            if ($PSBoundParameters.ContainsKey('Cert')) { $Payload.Add('cert', $Cert) }
            if ($PSBoundParameters.ContainsKey('Key')) { $Payload.Add('key', $Key) }
            if ($PSBoundParameters.ContainsKey('Inform')) { $Payload.Add('inform', $Inform) }
            if ($PSBoundParameters.ContainsKey('Password')) { $Payload.Add('password', ($Password.ToString()).ToLower()) }
            if ($PSBoundParameters.ContainsKey('Passplain')) { $Payload.Add('passplain', $Passplain) }
            if ($PSBoundParameters.ContainsKey('NoDomainCheck')) { $Payload.Add('nodomaincheck', $NoDomainCheck) }
            try {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Payload $Payload -Action update -GetWarning
            } catch {
                Write-Verbose "ERROR: $($_.Exception.Message)"
                $response = $null
            }
            Write-Output $response
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCChangeSSLCertKey: Finished"
    }
}
