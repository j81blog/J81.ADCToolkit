<#
    .SYNOPSIS
        AppVeyor pre-deploy script.
#> 
[OutputType()]
param ()

# Line break for readability in AppVeyor console
Write-Host ""
$WarningPreference = [System.Management.Automation.ActionPreference]::Continue

# Make sure we're using the main branch and that it's not a pull request
# Environmental Variables Guide: https://www.appveyor.com/docs/environment-variables/
If ($env:APPVEYOR_REPO_BRANCH -ne 'main') {
    Write-Warning -Message "Skipping version increment and push for branch $env:APPVEYOR_REPO_BRANCH"
} ElseIf ($env:APPVEYOR_PULL_REQUEST_NUMBER -gt 0) {
    Write-Warning -Message "Skipping version increment and push for pull request #$env:APPVEYOR_PULL_REQUEST_NUMBER"
} Else {

    If (Test-Path 'env:APPVEYOR_BUILD_FOLDER') {
        # AppVeyor Testing
        $projectRoot = Resolve-Path -Path $env:APPVEYOR_BUILD_FOLDER
        $module = $env:Module
    } Else {
        # Local Testing 
        $projectRoot = Resolve-Path -Path (((Get-Item (Split-Path -Parent -Path $MyInvocation.MyCommand.Definition)).Parent).FullName)
        $module = Split-Path -Path $projectRoot -Leaf
    }
    $moduleParent = Join-Path -Path $projectRoot -ChildPath $source
    $manifestPath = Join-Path -Path $moduleParent -ChildPath "$module.psd1"
    #$modulePath = Join-Path -Path $moduleParent -ChildPath "$module.psm1"

    # Tests success, push to GitHub
    If ($res.FailedCount -eq 0) {

        # We're going to add 1 to the revision value since a new commit has been merged to main
        # This means that the major / minor / build values will be consistent across GitHub and the Gallery
        Try {
            # Start by importing the manifest to determine the version, then add 1 to the revision
            $manifest = Test-ModuleManifest -Path $manifestPath
            [System.Version]$version = $manifest.Version
            Write-Output "Old Version: $version"
            # [System.String]$newVersion = New-Object -TypeName System.Version -ArgumentList ($version.Major, $version.Minor, $env:APPVEYOR_BUILD_NUMBER)
            [System.String]$newVersion = New-Object -TypeName System.Version -ArgumentList ((Get-Date -Format "yyMM"), $env:APPVEYOR_BUILD_NUMBER)
            Write-Output "New Version: $newVersion"

            # Update the manifest with the new version value and fix the weird string replace bug
            $functionList = ((Get-ChildItem -Path (Join-Path -Path $moduleParent -ChildPath "Public")).BaseName)
            Update-ModuleManifest -Path $manifestPath -ModuleVersion $newVersion -FunctionsToExport $functionList
            (Get-Content -Path $manifestPath) -replace 'PSGet_$module', $module | Set-Content -Path $manifestPath
            (Get-Content -Path $manifestPath) -replace 'NewManifest', $module | Set-Content -Path $manifestPath
            (Get-Content -Path $manifestPath) -replace 'FunctionsToExport = ', 'FunctionsToExport = @(' | Set-Content -Path $manifestPath -Force
            (Get-Content -Path $manifestPath) -replace "$($functionList[-1])'", "$($functionList[-1])')" | Set-Content -Path $manifestPath -Force

            # Update major version format appveyor.yml as month changes
            $yml = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath "appveyor.yml"
            $replaceString = "version: .*\.\{build\}"
            $versionString = "version: $(Get-Date -Format "yyMM").{build}"
            (Get-Content -Path $yml) -replace $replaceString, $versionString | Set-Content -Path $yml

            # Update version number for latest release in CHANGELOG.md
            $changeLog = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath "CHANGELOG.md"
            #$changeLog = [System.IO.Path]::Combine($env:APPVEYOR_BUILD_FOLDER, "docs", "changelog.md")
            $replaceString = "^## VERSION$"
            if (Test-Path -Path $changeLog) {
                $content = Get-Content -Path $changeLog
                If ($content -match $replaceString) {
                    $content -replace $replaceString, "## $newVersion" | Set-Content -Path $changeLog
                } Else {
                    Write-Host "No match in $changeLog for '## VERSION'. Manual update of CHANGELOG required." -ForegroundColor Cyan
                }
            }

        } Catch {
            Throw $_
        }

        # Publish the new version back to main on GitHub
        Try {
            # Set up a path to the git.exe cmd, import posh-git to give us control over git
            $env:Path += ";$env:ProgramFiles\Git\cmd"
            Import-Module posh-git -ErrorAction "Stop"

            # Dot source Invoke-Process.ps1. Prevent 'RemoteException' error when running specific git commands
            . $projectRoot\ci\Invoke-Process.ps1

            # Configure the git environment
            git config --global credential.helper store
            Add-Content -Path (Join-Path -Path $env:USERPROFILE -ChildPath ".git-credentials") -Value "https://$($env:GitHubKey):x-oauth-basic@github.com`n"
            Write-Host "APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL: $($env:APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL)"
            Write-Host "APPVEYOR_REPO_COMMIT_AUTHOR: $($env:APPVEYOR_REPO_COMMIT_AUTHOR)"
            git config --global user.email "$($env:APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL)"
            git config --global user.name "$($env:APPVEYOR_REPO_COMMIT_AUTHOR)"
            git config --global core.autocrlf true
            git config --global core.safecrlf false

            # Push changes to GitHub
            Invoke-Process -FilePath "git" -ArgumentList "checkout main"
            git add --all
            git status
            git commit -s -m "AppVeyor validate: $newVersion"
            Invoke-Process -FilePath "git" -ArgumentList "push origin main"
            Write-Host "$module $newVersion pushed to GitHub." -ForegroundColor "Cyan"
        } Catch {
            # Sad panda; it broke
            Write-Warning -Message "Push to GitHub failed."
            Throw $_
        }

        # Publish the new version to the PowerShell Gallery
        Try {
            # Build a splat containing the required details and make sure to Stop for errors which will trigger the catch
            $Params = @{
                Path        = $moduleParent
                NuGetApiKey = $env:NuGetApiKey
                ErrorAction = "Stop"
            }
            #==>Publish-Module @Params
            Write-Host "$module $newVersion published to the PowerShell Gallery." -ForegroundColor "Cyan"
        } Catch {
            # Sad panda; it broke
            Write-Warning -Message "Publishing $module $newVersion to the PowerShell Gallery failed."
            Throw $_
        }
    }
}

# Line break for readability in AppVeyor console
Write-Host ""