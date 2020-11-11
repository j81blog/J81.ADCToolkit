function Invoke-ADCGetSSLCertKey {
    <#
        .SYNOPSIS
            Get SSL Certificate names (CertKey)
        .DESCRIPTION
            Get SSL Certificate names (CertKey)
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Filter
            Specify a filter
            -Filter @{"certkey"="star_domain.com"}
			or -Filter ${"status"="Expired"}
        .PARAMETER Summary
            If specified a subset of info will be returned
        .EXAMPLE
            Invoke-ADCGetSSLCertKey
        .NOTES
            File Name : Invoke-ADCGetSSLCertKey
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
            
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetSSLCertKey: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertkey -Filter $Filter -Summary:$Summary -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSSLCertKey: Finished"
    }
}