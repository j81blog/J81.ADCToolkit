function Invoke-ADCGetSystemFileDirectories {
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [Parameter(Mandatory = $true)]
        [alias("FilePath")]
        [String]$FileLocation
    )
    $Output = @()
    $Output += "$FileLocation"
    try {
        $dirs = Invoke-ADCGetSystemFile -FileLocation $FileLocation -ADCSession $Session | Expand-ADCResult | Where-Object { $_.filemode -eq "DIRECTORY" } | Foreach-Object { "$($_.filelocation)/$($_.filename)" }
    } catch {
        
    }
    if ($dirs.count -gt 0) {
        $Output += $dirs | ForEach-Object { Invoke-ADCGetSystemFileDirectories -FileLocation $_ -ADCSession $Session }
    }
    return $Output
}
