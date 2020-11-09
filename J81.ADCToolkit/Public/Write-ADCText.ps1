function Write-ADCText {
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [object]
        $Result,
            
        [Switch]$PassThru
    )
    process {
        switch ($Result.severity) {
            "ERROR" { Write-ConsoleText -ForeGroundColor Red "ERROR [$($Result.errorcode)] $($Result.message)"; break }
            "NONE" { Write-ConsoleText -ForeGroundColor Green "Done"; break }
            "WARNING" { Write-ConsoleText -ForeGroundColor Yellow "WARNING $($Result.message)"; break }
            $null { Write-ConsoleText -ForeGroundColor Yellow "N/A"; break }
            default { Write-ConsoleText "Something else happened |$($Result.severity)|"; break }
        }
        if ($PassThru) { $Result }
    }
}
