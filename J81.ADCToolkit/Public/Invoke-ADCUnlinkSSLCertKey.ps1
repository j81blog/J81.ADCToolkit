function Invoke-ADCUnlinkSSLCertKey {
    <#
    .SYNOPSIS
        Unlink SSL CertKey to a Certificate Authority certificate-key
    .DESCRIPTION
        Unlink SSL CertKey to a Certificate Authority certificate-key
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Specify the CertKey Name
    .EXAMPLE
        Invoke-ADCUnlinkSSLCertKey -CertKey "wildcard_domain.com"
    .NOTES
        File Name : Invoke-ADCUnlinkSSLCertKey
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
        [String]$CertKey = (Read-Host -Prompt "Name for the Certificate Key pair")
    )
    begin {
        Write-Verbose "Invoke-ADCUnlinkSSLCertKey: Starting"
    }
    process {
        try {
            Write-Verbose "Unlinking `"$CertKey`""
            $Payload = @{
                certkey = $CertKey
            }
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type sslcertkey -Payload $Payload -Action unlink -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCUnlinkSSLCertKey: Finished"
    } 
}
