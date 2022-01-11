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
        Version   : v2111.2607
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    #>
    [cmdletbinding()]
    param(
        $ADCSession = (Get-ADCSession),

        [switch]$PassThru
    )

    try {
        $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type logout -NitroPath nitro/v1/config
    } finally { 
        if (-Not [String]::IsNullOrEmpty($($ADCSession.ManagementURL))) {
            $ManagementURL = $ADCSession.ManagementURL
        } else {
            $ManagementURL = $null
        }
        if (-Not [String]::IsNullOrEmpty($($ADCSession.Username))) {
            $Username = $ADCSession.Username
        } else {
            $Username = $null
        }
        $Script:ADCSession = [PSObject]@{
            ManagementURL     = $ManagementURL
            WebSession        = $null
            Username          = $Username
            Version           = "UNKNOWN";
            IsConnected       = $false
            SessionExpiration = $(Get-Date)
        }
    }
    if ($PassThru) {
        return $Script:ADCSession
    }
}