function ConvertFrom-ADCVersion {
    <#
    .SYNOPSIS
        Extract and convert version info from Connect-ADCNode result
    .DESCRIPTION
        Extract and convert version info from Connect-ADCNode result
    .PARAMETER ADCSession
        Result from Connect-ADCNode
    .EXAMPLE
        $ADCSession = Connect-ADCNode -ManagementURL https://citrixacd.domain.local -Credential (Get-Credential)
        $version = $ADCSession | ConvertFrom-ADCVersion
    .NOTES
        File Name : ConvertFrom-ADCVersion
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [OutputType([Version])]
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [Alias('Version')]
        [object]$ADCSession
    )
    begin {
        Write-Verbose "ConvertFrom-ADCVersion: Starting"
    }
    Process {
        try {
            if (-Not ($ADCSession.Version -is [Version])) {
                $RawVersion = Select-String -InputObject $ADCSession.Version -Pattern '[0-9]+\.[0-9]+' -AllMatches
                Write-Output ([Version]"$($RawVersion.Matches[0].Value).$($RawVersion.Matches[1].Value)")
            } else {
                Write-Output ($ADCSession.Version)
            }
        } catch {
            Write-Verbose "Could not convert version, $($_.Exception.Message)"
            Write-Output ([Version]"0.0.0.0")
        }
    }
    end {
        Write-Verbose "ConvertFrom-ADCVersion: Finished"
    }
}
