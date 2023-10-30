# Output GitHub rate limit
<#
    .SYNOPSIS
        Output GitHub API request window
#>
[OutputType()]
param ()
Write-Host ""
Write-Host "Script..........:$($myInvocation.myCommand.name)"
Write-Host "==============================="
$ProjectRoot = $env:PROJECTROOT
$moduleProjectName = $env:MODULEPROJECTNAME
$environment = $env:ENVIRONMENT
Write-Host "Environment.....:$environment"
Write-Host "Project name....:$moduleProjectName"
Write-Host "Project root....:$ProjectRoot"
Write-Host "Module data.....:$($moduleData | Format-List |Out-String)"
Write-Host "Module data json:$($null -eq $env:MODULE_DATA_JSON)"

if ( $null -eq $env:MODULE_DATA_JSON) {
    $moduleData = $env:MODULE_DATA_JSON | ConvertFrom-Json
} else {
    Write-Host "No ModuleData found"
    exit 1
}
Write-Host "Modules found...:$($modules -join ",")"
Write-Host "==============================="

try {
    $SslProtocol = "Tls12"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::$SslProtocol
    $params = @{
        ContentType        = "application/vnd.github.v3+json"
        ErrorAction        = "SilentlyContinue"
        MaximumRedirection = 0
        DisableKeepAlive   = $true
        UseBasicParsing    = $true
        UserAgent          = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
        Uri                = "https://api.github.com/rate_limit"
    }
    $GitHubRate = Invoke-RestMethod @params
} catch {
}
Write-Host ""
Write-Host "We have $($GitHubRate.rate.remaining) requests left to the GitHub API in this window."
$ResetWindow = [System.TimeZone]::CurrentTimeZone.ToLocalTime(([System.DateTime]'1/1/1970').AddSeconds($GitHubRate.rate.reset))
$TargetTZone = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match "W. Europe Standard Time*" } | Select-Object -First 1
$TimeZoneInfo = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId(($ResetWindow), $TargetTZone.Id)
Write-Host "GitHub rate limit window resets at: $($TimeZoneInfo.ToShortDateString()) $($TimeZoneInfo.ToShortTimeString()), W. Europe Standard Time."
Write-Host ""
