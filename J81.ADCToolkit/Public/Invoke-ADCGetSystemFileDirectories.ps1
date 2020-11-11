function Invoke-ADCGetSystemFileDirectories {
    <#
    .SYNOPSIS
        Return all (unique) directories within a given directory
    .DESCRIPTION
        Return all (unique) directories within a given directory
    .PARAMETER ADCSession
        Result from Connect-ADCNode
    .PARAMETER FileLocation
        Directory path
        Example: "/nsconfig/ssl"
    .EXAMPLE
        Invoke-ADCGetSystemFileDirectories -FileLocation "/nsconfig/ssl"
    .NOTES
        File Name : Invoke-ADCGetSystemFileDirectories
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [Parameter(Mandatory = $true)]
        [alias("FilePath")]
        [String]$FileLocation
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemFileDirectories: Starting"
    }
    process {
        Write-Output "$FileLocation"
        try {
            Write-Verbose "Checking `"$FileLocation`" for sub directories."
            $dirs = Invoke-ADCGetSystemFile -FileLocation $FileLocation -ADCSession $ADCSession | Expand-ADCResult | Where-Object { $_.filemode -eq "DIRECTORY" } | Foreach-Object { "$($_.filelocation)/$($_.filename)" }
        } catch { 
            $dirs = $null 
        }
        if ($dirs.count -gt 0) {
            Write-Output ($dirs | ForEach-Object { Invoke-ADCGetSystemFileDirectories -FileLocation $_ -ADCSession $ADCSession })
        }
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemFileDirectories: Finished"
    }
}
