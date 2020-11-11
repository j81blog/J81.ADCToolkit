function Invoke-ADCGetNSConfig {
    <#
        .SYNOPSIS
            Get NSIP Info
        .DESCRIPTION
            Get NSIP Info
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Filter
            Specify a filter
            -Filter @{"type"="NSIP"}
        .EXAMPLE
            Invoke-ADCGetNSConfig
        .NOTES
            File Name : Invoke-ADCGetNSConfig
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ns/nsconfig/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [hashtable]$Filter = @{ }
    )
    begin {
        Write-Verbose "Invoke-ADCGetNSConfig: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsconfig -Filter $Filter -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNSConfig: Finished"
    }
}
