function Invoke-ADCGetNSFeature {
    <#
        .SYNOPSIS
            Get feature state
        .DESCRIPTION
            Get feature state
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .EXAMPLE
            Invoke-ADCGetNSFeature
        .NOTES
            File Name : Invoke-ADCGetNSFeature
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ns/nsfeature/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding()]  
    Param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession)
    )
    begin {
        Write-Verbose "Invoke-ADCGetNSFeature: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsfeature
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNSFeature: Finished"
    }
}
