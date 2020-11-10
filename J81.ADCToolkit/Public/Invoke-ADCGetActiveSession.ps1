function Invoke-ADCGetActiveSession {
    <#
        .SYNOPSIS
            Verify and retrieve an active session variable
        .DESCRIPTION
            Verify and retrieve an active session variable
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .NOTES
            File Name : Invoke-ADCGetActiveSession
            Version   : v0.1
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
    if ([String]::IsNullOrEmpty($ADCSession)) {
        throw "Connect to the Citrix ADC Applicance first!"
    } else {
        return $ADCSession
    }
}
