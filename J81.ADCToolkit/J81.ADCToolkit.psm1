[CmdletBinding()]
Param()

# Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction Ignore )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction Ignore )

# Dot source the files
Foreach ($import in @($Public + $Private)) {
    Try { 
        $import | Unblock-File
        . $import.fullname 
    } Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# setup some module wide variables
$Global:LogLevel = "Info"

# Export the public modules and aliases
Export-ModuleMember -Function $public.Basename -Alias *
