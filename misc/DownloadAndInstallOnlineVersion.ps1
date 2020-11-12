#Requires -Version 5.1

#Source https://github.com/rmbolger/Posh-ACME/blob/master/instdev.ps1

# set the user module path based on edition and platform
if ('PSEdition' -notin $PSVersionTable.Keys -or $PSVersionTable.PSEdition -eq 'Desktop') {
    $installpath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'WindowsPowerShell\Modules'
} else {
    if ($IsWindows) {
        $installpath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'PowerShell\Modules'
    } else {
        $installpath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) '.local/share/powershell/Modules'
    }
}

# deal with execution policy on Windows
if (('PSEdition' -notin $PSVersionTable.Keys -or
     $PSVersionTable.PSEdition -eq 'Desktop' -or
     $IsWindows) -and
     (Get-ExecutionPolicy) -notin 'Unrestricted','RemoteSigned','Bypass')
{
    Write-Verbose "Setting user execution policy to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
}

# create user-specific modules folder if it doesn't exist
New-Item -ItemType Directory -Force -Path $installpath | out-null

if ([String]::IsNullOrWhiteSpace($PSScriptRoot)) {

    # GitHub now requires TLS 1.2
    # https://blog.github.com/2018-02-23-weak-cryptographic-standards-removed/
    $currentMaxTls = [Math]::Max([Net.ServicePointManager]::SecurityProtocol.value__,[Net.SecurityProtocolType]::Tls.value__)
    $newTlsTypes = [enum]::GetValues('Net.SecurityProtocolType') | Where-Object { $_ -gt $currentMaxTls }
    $newTlsTypes | ForEach-Object {
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor $_
    }

    # likely running from online, so download
    $url = 'https://github.com/j81blog/J81.ADCToolkit/archive/main.zip'
    Write-Verbose "Downloading latest version of J81.ADCToolkit from $url"
    $file = Join-Path ([system.io.path]::GetTempPath()) 'J81.ADCToolkit.zip'
    $webclient = New-Object System.Net.WebClient
    try { $webclient.DownloadFile($url,$file) }
    catch { throw }
    Write-Verbose "File saved to $file"

    # extract the zip
    Write-Verbose "Decompressing the Zip file to $($installpath)"
    Expand-Archive $file -DestinationPath $installpath

    Write-Verbose "Removing any old copy"
    Remove-Item "$installpath\J81.ADCToolkit" -Recurse -Force -ErrorAction Ignore
    Write-Verbose "Renaming folder"
    Copy-Item "$installpath\J81.ADCToolkit-main\J81.ADCToolkit" $installpath -Recurse -Force -ErrorAction Continue
    Remove-Item "$installpath\J81.ADCToolkit-main" -recurse -confirm:$false
    Import-Module -Name J81.ADCToolkit -Force
} else {
    # running locally
    Remove-Item "$installpath\J81.ADCToolkit" -Recurse -Force -ErrorAction Ignore
    Copy-Item "$PSScriptRoot\J81.ADCToolkit" $installpath -Recurse -Force -EErrorActionA Continue
    # force re-load the module (assuming you're editing locally and want to see changes)
    Import-Module -Name J81.ADCToolkit -Force
}
Write-Verbose 'Module has been installed'

Get-Command -Module J81.ADCToolkit