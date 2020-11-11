function Invoke-ADCGetNSIP {
    <#
        .SYNOPSIS
            Get NSIP Info
        .DESCRIPTION
            Get NSIP Info
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Filter
            Specify a filter
            -Filter @{"type"="nsip"}
        .PARAMETER Summary
            If specified a subset of info will be returned
        .EXAMPLE
            Invoke-ADCGetHANode -Summary
        .NOTES
            File Name : Invoke-ADCGetHANode
            Version   : v0.2
            Author    : John Billekens
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        #
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetHANode: Starting"
    }
    process {
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsip -Filter $Filter -Summary:$Summary -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetHANode: Finished"
    }
}
