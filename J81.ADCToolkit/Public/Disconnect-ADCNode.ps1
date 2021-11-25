function Disconnect-ADCNode {
    <#
    .SYNOPSIS
        Disconnect a session with Citrix ADC.
    .DESCRIPTION
        Disconnect a session with Citrix ADC.
    .PARAMETER ADCSession
        The Session variable
    .EXAMPLE
        PS C:\>Disconnect-ADCNode
        Disconnect the (current active) ADC Node
    .NOTES
        File Name : Disconnect-ADCNode
        Version   : v2111.2522
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    #>
    [cmdletbinding()]
    param(
        $ADCSession = $Script:ADCSession,

        [switch]$PassThru
    )

    try {
        $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type logout -NitroPath nitro/v1/config
    } catch { }

    $Script:ADCSession = [PSObject]@{
        ManagementURL     = $null
        WebSession        = $null
        Username          = $null
        Version           = "UNKNOWN";
        IsConnected       = $false
        SessionExpiration = $(Get-Date)
    }
    if ($PassThru) {
        return $Script:ADCSession
    }
}