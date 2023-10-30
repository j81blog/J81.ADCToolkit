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
    #$projectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
    Write-Host "APPVEYOR_JOB_ID.:${env:APPVEYOR_JOB_ID}"
} elseif (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $environment = "GITHUB"
    #$projectRoot = Resolve-Path -Path $env:GITHUB_WORKSPACE
} else {
    # Local Testing 
    $environment = "LOCAL"
    
}
$projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
Write-Host "Environment.....:$environment"
Write-Host "Project root....:$ProjectRoot"

$moduleProjectName = Split-Path -Path $projectRoot -Leaf
$modules = Get-ChildItem -Path $projectRoot -Include "$moduleProjectName*" | Select-Object -ExpandProperty Name
Write-Host "Modules found...:$($modules -join ", ")"

if (-Not (Get-Module -ListAvailable -Name J81.ADCToolkit)) {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name J81.ADCToolkit
    Write-Host "J81.ADCToolkit Module installed"
}

$moduleData = @()
ForEach ($moduleName in $modules) {
    Write-Host "Module Name.....:$moduleName"
    $newModule = @{}
    $newModule.ModuleName = $moduleName
    $moduleRoot = Join-Path -Path $projectRoot -ChildPath $moduleName
    $newModule.ModuleName = $moduleName
    $newModule.ModuleRoot = $moduleRoot
    $newModule.ManifestFilepath = Join-Path -Path $moduleRoot -ChildPath "$moduleName.psd1"
    $newModule.ModuleFilepath = Join-Path -Path $moduleRoot -ChildPath "$moduleName.psm1"
    Write-Host "Module path.....:$($newModule.ModuleFilepath)"
    Write-Host "Module detected.:$(Test-Path -Path $newModule.ModuleFilepath)"
    $moduleData += [PSCustomObject]$newModule
}

$env:PROJECTROOT = $ProjectRoot
$env:MODULEPROJECTNAME = $moduleProjectName
$env:ENVIRONMENT = $environment
$env:MODULE_DATA_JSON = $($moduleData | ConvertTo-Json -Compress)

Write-Host "==============================="
Write-Host $(Get-ChildItem -Path env: | Sort-Object -Property Name | Out-String)
Write-Host "==============================="

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
