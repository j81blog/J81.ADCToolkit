function Invoke-ADCDeleteSSLCertKey {
    <#
    .SYNOPSIS
        Delete SSL CertKey
    .DESCRIPTION
        Delete SSL CertKey
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER CertKey
        Specify the CertKey Name
    .EXAMPLE
        Invoke-ADCDeleteSSLCertKey -CertKey "wildcard_domain.com"
    .NOTES
        File Name : Invoke-ADCDeleteSSLCertKey
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [String]$CertKey
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSSLCertKey: Starting"
    }
    process {
        try {
            Write-Verbose "Deleting `"$CertKey`""
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type sslcertkey -Resource $CertKey
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCDeleteSSLCertKey: Finished"
    }
}
