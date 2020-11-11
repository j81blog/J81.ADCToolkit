function Invoke-ADCGetActiveSession {
    <#
    .SYNOPSIS
        Verify and retrieve an active session variable
    .DESCRIPTION
        Verify and retrieve an active session variable
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .EXAMPLE
        Invoke-ADCGetActiveSession
    .NOTES
        File Name : Invoke-ADCGetActiveSession
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        $ADCSession = $Script:ADCSession
    )
    Write-Verbose "Invoke-ADCAddLBvServer: Starting"
    if ([String]::IsNullOrEmpty($ADCSession)) {
        throw "Connect to the Citrix ADC Appliance first!"
    } else {
        Write-Verbose "Active Session found, returning Session data"
        Write-Output $ADCSession
    }
    Write-Verbose "Invoke-ADCAddLBvServer: Finished"
}
