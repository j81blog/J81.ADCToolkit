function Write-ConsoleText {
    <#
    .SYNOPSIS
        Write Console Text (Write-Host wrapper)
    .DESCRIPTION
        Write Console Text (Write-Host wrapper)
    .PARAMETER Message
        The message
    .PARAMETER Title
        Treat the message as a title, begin with blank line and start at the beginning
    .PARAMETER Line
        Treat the message as a line item, begin with blank space and a - character, then the message and fill up to -Length xx with ".", end with ": "
        Example: " -Message Text......: "
    .PARAMETER Length
        Fill message up to xx Length (only with -Line parameter)
        Default: 30 characters
    .PARAMETER NoConsoleOutput
        Don't write any console (Silent) output
    .PARAMETER NeNewLine
        Don't end with a return to new line.
    .PARAMETER ForeGroundColor
        Define a [System.ConsoleColor] Color for the text.
    .PARAMETER PreBlank
        Add a blank line before the message text
    .PARAMETER PostBlank
        Add a blank line after the message text
    .EXAMPLE
        Write-ConsoleText -Title "Message Text"
        
        Message Text
    .EXAMPLE
        Write-ConsoleText -Blank
        
    .EXAMPLE
        Write-ConsoleText -Line "Message Text"
         -Message Text................: 
    .NOTES
        File Name : Write-ConsoleText
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(DefaultParameterSetName = "Line")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "")]
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
        [Switch]$NoConsoleOutput = $Script:NoConsoleOutput,
        
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
            if ($Message.Length -ge $($Length - 5)) {
                $Message = $Message.substring(0, $($Length - 5))
            }
            Write-Host -ForeGroundColor $ForeGroundColor -NoNewLine:$NoNewLine " -$($Message.PadRight($($Length -4), ".")): "
        } elseif (-Not [String]::IsNullOrEmpty($Message)) {
            Write-Host -ForeGroundColor $ForeGroundColor -NoNewLine:$NoNewLine "$Message"
        }
        if ($PostBlank) {
            Write-Host ""
        } 
    } else {
        Write-Verbose "Silent, $Message"
    }
}
