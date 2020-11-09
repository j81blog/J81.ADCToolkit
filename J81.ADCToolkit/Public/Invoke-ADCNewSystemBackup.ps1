function Invoke-ADCNewSystemBackup {
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [hashtable]$Session = (Invoke-ADCGetActiveSession),
            
        [String]$Name = "ADCBackup_$((Get-Date).ToString("yyyyMMdd_HHmm"))",
    
        [String]$Comment = "Backup created by PoSH function Invoke-ADCNewSystemBackup",
            
        [ValidateSet("full", "basic")]
        [String]$Level = "full",
            
        [alias("SaveConfig")]
        [Switch]$SaveConfigFirst
    )
    if ($SaveConfigFirst) {
        Write-Verbose "SaveConfig parameter specified, saving config"
        Invoke-ADCSaveNSConfig -Session $Session | Out-Null
    }
    if ($PSCmdlet.ShouldProcess($Name, 'Create Backup')) {
        try {
            $payload = @{"filename" = "$Name"; "level" = "$($Level.ToLower())"; "comment" = "$Comment" }
            $response = Invoke-ADCNitroApi -Session $Session -Method POST -Type systembackup -Payload $payload -Action create -GetWarning
        } catch {
            $response = $null
        }
    }
    return $response
}
