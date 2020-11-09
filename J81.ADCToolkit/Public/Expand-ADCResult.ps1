function Expand-ADCResult {
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [object]
        $Result
    )
    Process {
        try {
            $Result | Select-Object -ExpandProperty $($Result.type) -ErrorAction Stop
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $Result
        }
    }
}
