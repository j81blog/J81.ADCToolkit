# Output GitHub rate limit
<#
    .SYNOPSIS
        Output GitHub API request window
#>
[OutputType()]
param ()
Write-Host ""
Write-Host "Script............:$($myInvocation.myCommand.name)"

# Set variables
if (Test-Path -Path 'env:APPVEYOR_BUILD_FOLDER') {
    # AppVeyor Testing
    $environment = "APPVEYOR"
    Write-Host "APPVEYOR_JOB_ID...:${env:APPVEYOR_JOB_ID}"
} elseif (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $environment = "GITHUB"
    Write-Host "GITHUB_RUN_NUMBER.:${env:GITHUB_RUN_NUMBER}"
} else {
    # Local Testing 
    $environment = "LOCAL"
    
}
$projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
Write-Host "Environment.......: $environment"
Write-Host "Project root......: $ProjectRoot"
$moduleInfoJson = Join-Path -Path $PSScriptRoot -ChildPath "ModuleInfo.json"
Write-Host "Module info file..: $moduleInfoJson"
if (Test-Path -Path $moduleInfoJson) {
    $ModuleInfo = Get-Content -Path $moduleInfoJson | ConvertFrom-Json
} else {
    Write-Host "$moduleInfoJson not found!"
    Exit 1
}

$moduleProjectName = $ModuleInfo.ProjectName
$moduleData = $ModuleInfo.ModuleData

Write-Host "==============================="

# Line break for readability in AppVeyor console
Write-Host ""


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
