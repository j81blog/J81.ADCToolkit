function Invoke-ADCSaveNSConfig {
    <#
    .SYNOPSIS
        Save the ADC running config as startup config
    .DESCRIPTION
        Save the ADC running config as startup config
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .EXAMPLE
        Invoke-ADCSaveNSConfig
    .NOTES
        File Name : Invoke-ADCSaveNSConfig
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ns/nsfeature/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession)
    )
    begin {
        Write-Verbose "Invoke-ADCSaveNSConfig: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type nsconfig -Action save
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCSaveNSConfig: Finished"
    }
}
