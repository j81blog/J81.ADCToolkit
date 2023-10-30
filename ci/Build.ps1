<#
    .SYNOPSIS
        AppVeyor build script.
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

# Line break for readability in AppVeyor console
Write-Host ""

if (Get-Variable -Name projectRoot -ErrorAction "SilentlyContinue") {
    # Do something
} else {
    Write-Warning -Message "Required variable does not exist: $projectRoot."
}

# Build the markdown
$string = @()
$string += "# AppVeyor Variables"
$string += " "
$string += "| Variable | Value |"
$string += "|:--|:--|"
$string += "| APPVEYOR | $env:APPVEYOR |"
$string += "| APPVEYOR_URL | $env:APPVEYOR_URL |"
$string += "| APPVEYOR_API_URL | $env:APPVEYOR_API_URL |"
$string += "| APPVEYOR_ACCOUNT_NAME | $env:APPVEYOR_ACCOUNT_NAME |"
$string += "| APPVEYOR_PROJECT_ID | $env:APPVEYOR_PROJECT_ID |"
$string += "| APPVEYOR_PROJECT_NAME | $env:APPVEYOR_PROJECT_NAME |"
$string += "| APPVEYOR_PROJECT_SLUG | $env:APPVEYOR_PROJECT_SLUG |"
$string += "| APPVEYOR_BUILD_FOLDER | $env:APPVEYOR_BUILD_FOLDER |"
$string += "| APPVEYOR_BUILD_ID | $env:APPVEYOR_BUILD_ID |"
$string += "| APPVEYOR_BUILD_NUMBER | $env:APPVEYOR_BUILD_NUMBER |"
$string += "| APPVEYOR_BUILD_VERSION | $env:APPVEYOR_BUILD_VERSION |"
$string += "| APPVEYOR_BUILD_WORKER_IMAGE | $env:APPVEYOR_BUILD_WORKER_IMAGE |"
$string += "| APPVEYOR_PULL_REQUEST_NUMBER | $env:APPVEYOR_PULL_REQUEST_NUMBER |"
$string += "| APPVEYOR_PULL_REQUEST_TITLE | $env:APPVEYOR_PULL_REQUEST_TITLE |"
$string += "| APPVEYOR_PULL_REQUEST_HEAD_REPO_NAME | $env:APPVEYOR_PULL_REQUEST_HEAD_REPO_NAME |"
$string += "| APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH | $env:APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH |"
$string += "| APPVEYOR_PULL_REQUEST_HEAD_COMMIT | $env:APPVEYOR_PULL_REQUEST_HEAD_COMMIT |"
$string += "| APPVEYOR_JOB_ID | $env:APPVEYOR_JOB_ID |"
$string += "| APPVEYOR_JOB_NAME | $env:APPVEYOR_JOB_NAME |"
$string += "| APPVEYOR_JOB_NUMBER | $env:APPVEYOR_JOB_NUMBER |"
$string += "| APPVEYOR_REPO_PROVIDER | $env:APPVEYOR_REPO_PROVIDER |"
$string += "| APPVEYOR_REPO_SCM | $env:APPVEYOR_REPO_SCM |"
$string += "| APPVEYOR_REPO_NAME | $env:APPVEYOR_REPO_NAME |"
$string += "| APPVEYOR_REPO_BRANCH | $env:APPVEYOR_REPO_BRANCH |"
$string += "| APPVEYOR_REPO_TAG | $env:APPVEYOR_REPO_TAG |"
$string += "| APPVEYOR_REPO_TAG_NAME | $env:APPVEYOR_REPO_TAG_NAME |"
$string += "| APPVEYOR_REPO_COMMIT | $env:APPVEYOR_REPO_COMMIT |"
$string += "| APPVEYOR_REPO_COMMIT_AUTHOR | $env:APPVEYOR_REPO_COMMIT_AUTHOR |"
$string += "| APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL | $env:APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL |"
$string += "| APPVEYOR_REPO_COMMIT_TIMESTAMP | $env:APPVEYOR_REPO_COMMIT_TIMESTAMP |"
$string += "| APPVEYOR_REPO_COMMIT_MESSAGE | $env:APPVEYOR_REPO_COMMIT_MESSAGE |"
$string += "| APPVEYOR_REPO_COMMIT_MESSAGE_EXTENDED | $env:APPVEYOR_REPO_COMMIT_MESSAGE_EXTENDED |"
$string += "| APPVEYOR_SCHEDULED_BUILD | $env:APPVEYOR_SCHEDULED_BUILD |"
$string += "| APPVEYOR_FORCED_BUILD | $env:APPVEYOR_FORCED_BUILD |"
$string += "| APPVEYOR_RE_BUILD | $env:APPVEYOR_RE_BUILD |"
$string += "| APPVEYOR_RE_RUN_INCOMPLETE | $env:APPVEYOR_RE_RUN_INCOMPLETE |"
$string += "| PLATFORM | $env:PLATFORM |"
$string += "| CONFIGURATION | $env:CONFIGURATION |"

# Write $string out to $Path
$Path = "$projectRoot\ci\Variables.md"
$string | Out-File -FilePath $Path -Force
