function Invoke-ADCNewSystemBackup {
    <#
    .SYNOPSIS
        Create a ADC Backup
    .DESCRIPTION
        Create a ADC Backup
    .PARAMETER ADCSession
        Result from Connect-ADCNode
    .PARAMETER Name
        Backup name
    .PARAMETER Comment
        Backup comment text
    .PARAMETER Level
        Backup level, "full" or "basic"
    .PARAMETER SaveConfigFirst
        If defined, the configuration will be saved first before creating a backup
    .EXAMPLE
        Invoke-ADCNewSystemBackup
    .NOTES
        File Name : Invoke-ADCNewSystemBackup
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [String]$Name = "ADCBackup_$((Get-Date).ToString("yyyyMMdd_HHmm"))",
    
        [String]$Comment = "Backup created by PoSH function Invoke-ADCNewSystemBackup",
            
        [ValidateSet("full", "basic")]
        [String]$Level = "full",
            
        [alias("SaveConfig")]
        [Switch]$SaveConfigFirst
    )
    begin {
        Write-Verbose "Invoke-ADCNewSystemBackup: Starting"
    }
    process {
        if ($SaveConfigFirst) {
            Write-Verbose "SaveConfig parameter specified, saving config"
            Invoke-ADCSaveNSConfig -ADCSession $ADCSession | Out-Null
        }
        if ($PSCmdlet.ShouldProcess($Name, 'Create Backup')) {
            try {
                $payload = @{"filename" = "$Name"; "level" = "$($Level.ToLower())"; "comment" = "$Comment" }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type systembackup -Payload $payload -Action create -GetWarning
            } catch {
                Write-Verbose "ERROR: $($_.Exception.Message)"
                $response = $null
            }
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCNewSystemBackup: Finished"
    }
}
