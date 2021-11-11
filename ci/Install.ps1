<#
    .SYNOPSIS
        AppVeyor install script.
#>
[OutputType()]
param ()

# Set variables
if (Test-Path -Path 'env:APPVEYOR_BUILD_FOLDER') {
    # AppVeyor Testing
    $workspace = "APPVEYOR"
    $projectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
    $module = $env:Module
    $source = $env:Source
} elseif (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $workspace = "GITHUB"
    $projectRoot = Resolve-Path -Path $env:GITHUB_WORKSPACE
    $module = Split-Path -Path $projectRoot -Leaf
    $source = $module
}else {
    # Local Testing 
    $workspace = "LOCAL"
    $projectRoot = $ProjectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
    $module = Split-Path -Path $projectRoot -Leaf
    $source = $module
}
$moduleParent = Join-Path -Path $projectRoot -ChildPath $source
$manifestPath = Join-Path -Path $moduleParent -ChildPath "$module.psd1"
$modulePath = Join-Path -Path $moduleParent -ChildPath "$module.psm1"

# Echo variables
Write-Host ""
Write-Host "ProjectRoot:     $projectRoot."
Write-Host "Module name:     $module."
Write-Host "Module parent:   $moduleParent."
Write-Host "Module manifest: $manifestPath."
Write-Host "Module path:     $modulePath."

# Line break for readability in AppVeyor console
Write-Host ""
Write-Host "PowerShell Version:" $PSVersionTable.PSVersion.ToString()

# Import module
Write-Host ""
Write-Host "Importing module." -ForegroundColor "Cyan"
Import-Module $manifestPath -Force

# Install packages

if (-Not ($packageProvider = Get-PackageProvider -ListAvailable | Where-Object {$_.Name -like "Nuget" -and $_.Version -ge $([System.Version]"2.8.5.208")})) {
    Install-PackageProvider -Name NuGet -MinimumVersion "2.8.5.208"
}

If (Get-PSRepository -Name PSGallery | Where-Object { $_.InstallationPolicy -ne "Trusted" }) {
    Write-Host "Trust repository: PSGallery." -ForegroundColor Cyan
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}
$Modules = @("Pester", "PSScriptAnalyzer", "posh-git", "MarkdownPS")
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