<#
    .SYNOPSIS
        AppVeyor install script.
#>
[OutputType()]
param ()
Write-Host ""
Write-Host "Script..........:$($myInvocation.myCommand.name)"

# Set variables
if (Test-Path -Path 'env:APPVEYOR_BUILD_FOLDER') {
    # AppVeyor Testing
    $environment = "APPVEYOR"
    Write-Host "APPVEYOR_JOB_ID.:${env:APPVEYOR_JOB_ID}"
} elseif (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $environment = "GITHUB"
} else {
    # Local Testing 
    $environment = "LOCAL"
    
}
$projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
Write-Host "Environment.....: $environment"
Write-Host "Project root....: $ProjectRoot"
$moduleInfoJson = Join-Path -Path $PSScriptRoot -ChildPath "ModuleData.json"
Write-Host "Module info file: $moduleInfoJson"
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

# Install packages

if (-Not ($packageProvider = Get-PackageProvider -ListAvailable | Where-Object { $_.Name -like "Nuget" -and $_.Version -ge $([System.Version]"2.8.5.208") })) {
    Install-PackageProvider -Name NuGet -MinimumVersion "2.8.5.208"
}

If (Get-PSRepository -Name PSGallery | Where-Object { $_.InstallationPolicy -ne "Trusted" }) {
    Write-Host "Trust repository: PSGallery." -ForegroundColor Cyan
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}
$Modules = @("Pester", "PSScriptAnalyzer", "posh-git", "MarkdownPS", "$moduleProjectName")
ForEach ($Module in $Modules) {
    Write-Host "Checking module $Module." -ForegroundColor Cyan
    If ([System.Version]((Find-Module -Name $Module | Sort-Object -Property Version -Descending | Select-Object -First 1).Version) -gt [System.Version](Get-Module -Name $Module -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1).Version) {
        Write-Host "Installing module $Module." -ForegroundColor Cyan
        Install-Module -Name $Module -SkipPublisherCheck -Force -Verbose
        Write-Host "Loading $Module" -ForegroundColor Cyan
        Import-Module -Name $Module -Force
    } else {
        Write-Host "Loading $Module" -ForegroundColor Cyan
        Import-Module -Name $Module -Force
    }
}
