function Expand-ADCResult {
    <#
    .SYNOPSIS
        Cleans the result from an ADC function to return only the values
    .DESCRIPTION
        Cleans the result from an ADC function to return only the values
    .PARAMETER Result
        Result from a ADC function
    .EXAMPLE
        Invoke-ADCGetLBvServer | Expand-ADCResult
    .NOTES
        File Name : Expand-ADCResult
        Version   : v2101.0322
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [object]$Result
    )
    begin {
        Write-Verbose "Expand-ADCResult: Starting"
    }
    Process {
        try {
            if ($Result | Get-Member -Name $Result.type -ErrorAction SilentlyContinue) {
                Write-Output ($Result | Select-Object -ExpandProperty $($Result.type) -ErrorAction Stop)
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            Write-Output $Result
        }
    }
    end {
        Write-Verbose "Expand-ADCResult: Finished"
    }
}
