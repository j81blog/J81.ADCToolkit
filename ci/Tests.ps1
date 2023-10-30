<#
    .SYNOPSIS
        AppVeyor tests script.
#>
[OutputType()]
param ()
Write-Host ""
Write-Host "Script..........:$($myInvocation.myCommand.name)"
Write-Host "==============================="
Write-Host $(Get-ChildItem -Path env: | Sort-Object -Property Name | Out-String)
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
