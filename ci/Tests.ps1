<#
    .SYNOPSIS
        AppVeyor tests script.
#>
[OutputType()]
param ()

if (Test-Path 'env:APPVEYOR_BUILD_FOLDER') {
    # AppVeyor Testing
    $projectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
    $module = $env:Module
    $source = $env:Source
} else {
    # Local Testing 
    Import-Module Pester
    $projectRoot = $ProjectRoot = ( Resolve-Path -Path ( Split-Path -Parent -Path $PSScriptRoot ) ).Path
    $module = Split-Path -Path $projectRoot -Leaf
    $source = $module
}
$moduleParent = Join-Path -Path $projectRoot -ChildPath $source
$manifestPath = Join-Path -Path $moduleParent -ChildPath "$module.psd1"
$modulePath = Join-Path -Path $moduleParent -ChildPath "$module.psm1"
$ProgressPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue
$WarningPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue

if (Get-Variable -Name projectRoot -ErrorAction "SilentlyContinue") {

    # Configure the test environment
    $testsPath = Join-Path -Path $projectRoot -ChildPath "tests"
    $testOutput = Join-Path -Path $projectRoot -ChildPath "TestsResults.xml"
    
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

    Write-Host "Tests path:      $testsPath."
    Write-Host "Output path:     $testOutput."

    # Invoke Pester tests
    $res = Invoke-Pester -Configuration $testConfig

    # Upload test results to AppVeyor
    if ($res.FailedCount -gt 0) { Throw "$($res.FailedCount) tests failed." }
    if (Test-Path -Path env:APPVEYOR_JOB_ID) {
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path -Path $testOutput))
    } else {
        Write-Warning -Message "Cannot find: APPVEYOR_JOB_ID"
    }
} else {
    Write-Warning -Message "Required variable does not exist: projectRoot."
}

# Line break for readability in AppVeyor console
Write-Host ""