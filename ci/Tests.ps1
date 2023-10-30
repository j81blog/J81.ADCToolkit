<#
    .SYNOPSIS
        AppVeyor tests script.
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
    Write-Host "GITHUB_RUN_NUMBER.:${env:GITHUB_RUN_NUMBER}"
} else {
    # Local Testing 
    $environment = "LOCAL"
    
}
$projectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
Write-Host "Environment.....: $environment"
Write-Host "Project root....: $ProjectRoot"
$moduleInfoJson = Join-Path -Path $PSScriptRoot -ChildPath "ModuleInfo.json"
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

if (-Not (Get-Module -ListAvailable -Name J81.ADCToolkit)) {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module -Name J81.ADCToolkit
    Write-Host "J81.ADCToolkit Module installed, required for testing"
}

# Line break for readability in AppVeyor console
Write-Host ""

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
