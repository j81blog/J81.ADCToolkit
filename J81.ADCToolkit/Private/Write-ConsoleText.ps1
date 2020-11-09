function Write-ConsoleText {
    [cmdletbinding(DefaultParameterSetName = "Line")]
    param(
        [Parameter(ParameterSetName = "Title", Position = 0)]
        [Parameter(ParameterSetName = "Line", Position = 0)]
        [Parameter(ParameterSetName = "Message", Position = 0)]
        [String]$Message,
        
        [Parameter(ParameterSetName = "Title")]
        [Switch]$Title,
        
        [Parameter(ParameterSetName = "Line")]
        [Switch]$Line,
        
        [Parameter(ParameterSetName = "Line")]
        [Int]$Length = 30,
        
        [Parameter(ParameterSetName = "Title")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Message")]
        [Switch]$NoConsoleOutput = $Global:NoConsoleOutput,
        
        [Parameter(ParameterSetName = "Message")]
        [Parameter(ParameterSetName = "Line")]
        [Switch]$NoNewLine,
        
        [Parameter(ParameterSetName = "Title")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Message")]
        [System.ConsoleColor]$ForeGroundColor = "White",
        
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Message")]
        [Parameter(ParameterSetName = "Blank")]
        [Alias("Blank")]
        [Switch]$PreBlank,

        [Parameter(ParameterSetName = "Title")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Message")]
        [Switch]$PostBlank
    )
    if (-Not $NoConsoleOutput) {
        if ($PreBlank) {
            Write-Host ""
        }
        if ($Title) {
            Write-Host ""
            Write-Host -ForeGroundColor $ForeGroundColor "$Message"
        } elseif ($Line) {
            $NoNewLine = $true
            if ($Message.Length -ge $($Length -5)) {
                $Message = $Message.substring(0,$($Length -5))
            }
            Write-Host -ForeGroundColor $ForeGroundColor -NoNewLine:$NoNewLine " -$($Message.PadRight($($Length -4), ".")): "
        } elseif (-Not [String]::IsNullOrEmpty($Message)) {
            Write-Host -ForeGroundColor $ForeGroundColor -NoNewLine:$NoNewLine "$Message"
        }
        if ($PostBlank) {
            Write-Host ""
        } 
    }
}
