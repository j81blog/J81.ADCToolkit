function Invoke-ADCLinkSSLCertKey {
    <#
    .SYNOPSIS
        Link SSL CertKey to a Certificate Authority certificate-key
    .DESCRIPTION
        Link SSL CertKey to a Certificate Authority certificate-key
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Specify the CertKey Name
    .PARAMETER LinkCertKeyName
        Name of the Certificate Authority certificate-key pair to which to link a certificate-key pair.
    .EXAMPLE
        Invoke-ADCLinkSSLCertKey -CertKey "wildcard_domain.com" -LinkCertKeyName "ISSUE-CA01"
    .NOTES
        File Name : Invoke-ADCLinkSSLCertKey
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

        [parameter(Mandatory = $true)]
        [string]$LinkCertKeyName

    )
    begin {
        Write-Verbose "Invoke-ADCLinkSSLCertKey: Starting"
    }
    process {
        try {
            Write-Verbose "Linking `"$CertKey`""
            $Payload = @{
                certkey         = $CertKey
                linkcertkeyname = $LinkCertKeyName
            }

            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Payload $Payload -Action link -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCLinkSSLCertKey: Finished"
    } 
}
