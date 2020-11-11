function Invoke-ADCGetSSLCertLink {
    <#
        .SYNOPSIS
            Get TLS Certificate links
        .DESCRIPTION
            Get TLS Certificate links
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Filter
            Specify a filter
            -Filter @{certkeyname="domain.com"}
			or -Filter ${"linkcertkeyname"="Lets Encrypt Authority X3"}
        .PARAMETER Summary
            If specified a subset of info will be returned
        .EXAMPLE
            Invoke-ADCGetSSLCertLink
        .EXAMPLE
            Invoke-ADCGetSSLCertLink -Filter @{certkeyname="domain.com"}
        .NOTES
            File Name : Invoke-ADCGetSSLCertLink
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertlink/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding()]  
    Param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetSSLCertLink: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type sslcertlink -Filter $Filter -Summary:$Summary -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSSLCertLink: Finished"
    }
}
