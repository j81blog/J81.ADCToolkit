<#
    .SYNOPSIS
        AppVeyor tests script.
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

# Set variables
if (Test-Path -Path 'env:APPVEYOR_BUILD_FOLDER') {
    # AppVeyor Testing
    $environment = "APPVEYOR"
    $projectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
    Write-Host "APPVEYOR_JOB_ID.:${env:APPVEYOR_JOB_ID}"
} elseif (Test-Path -Path 'env:GITHUB_WORKSPACE') {
    # Github Testing
    $environment = "GITHUB"
    $projectRoot = Resolve-Path -Path $env:GITHUB_WORKSPACE
} else {
    # Local Testing 
    $environment = "LOCAL"
    $projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
}
Write-Host "Environment.....:$environment"
Write-Host "Project root....:$ProjectRoot"

$moduleProjectName = Split-Path -Path $projectRoot -Leaf
$modules = Get-ChildItem -Path $projectRoot -Include "$moduleProjectName*" | Select-Object -ExpandProperty Name
Write-Host "Modules found...:$($modules -join ","))"

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

$ProgressPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue
$WarningPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue

if (Get-Variable -Name projectRoot -ErrorAction "SilentlyContinue") {
    # Configure the test environment
    $testsPath = Join-Path -Path $projectRoot -ChildPath "Tests"
    Write-Host "Tests path......:$testsPath"
    $testOutput = Join-Path -Path $projectRoot -ChildPath "TestsResults.xml"
    Write-Host "Output path.....:$testOutput"
    $testConfig = New-PesterConfiguration -Hashtable @{
        Run        = @{
            Path     = $testsPath
            PassThru = $True
        }
        TestResult = @{
            Enabled      = $true
            OutputFormat = "NUnitXml"
            OutputPath   = $testOutput
        }
        Output     = @{
            Verbosity = "Detailed"
        }
    }
    # Line break for readability in AppVeyor console
    Write-Host ""
    # Invoke Pester tests
    $res = Invoke-Pester -Configuration $testConfig

    # Upload test results to AppVeyor
    if ($res.FailedCount -gt 0) { Throw "$($res.FailedCount) tests failed." }
    if ($environment -in $("LOCAL", "GITHUB")) {
        #nothing to do
    } elseif (Test-Path -Path 'env:APPVEYOR_JOB_ID') {
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path -Path $testOutput))
    } else {
        Write-Warning -Message "Cannot find: APPVEYOR_JOB_ID"
    }
} else {
    Write-Warning -Message "Required variable does not exist: projectRoot."
}

# Line break for readability in AppVeyor console
Write-Host ""
