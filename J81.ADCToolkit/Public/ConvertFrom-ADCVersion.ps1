function ConvertFrom-ADCVersion {
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [OutputType([Version])]
        [object]
        $Session
    )
    Process {
        try {
            if (-Not ($Session.Version -is [Version])) {
                $RawVersion = Select-String -InputObject $Session.Version -Pattern '[0-9]+\.[0-9]+' -AllMatches
                return [Version]"$($RawVersion.Matches[0].Value).$($RawVersion.Matches[1].Value)"
            } else {
                return $Session.Version
            }
        } catch {
            return [Version]"0.0.0.0"
        }
    }
}
