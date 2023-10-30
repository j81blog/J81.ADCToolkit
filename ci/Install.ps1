<#
    .SYNOPSIS
        AppVeyor install script.
#>
[OutputType()]
param ()
Write-Host ""
Write-Host "Script..........:$($myInvocation.myCommand.name)"
Write-Host "==============================="
Write-Host "Environment.....:$environment"
Write-Host "Project root....:$ProjectRoot"
Write-Host "Modules found...:$($modules -join ",")"
Write-Host "Module data.....:$($moduleData | Format-List |Out-String)"
Write-Host "==============================="

# Install packages

if (-Not ($packageProvider = Get-PackageProvider -ListAvailable | Where-Object { $_.Name -like "Nuget" -and $_.Version -ge $([System.Version]"2.8.5.208") })) {
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
