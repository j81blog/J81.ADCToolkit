function Write-ADCText {
    <#
    .SYNOPSIS
        Write ADC Text
    .DESCRIPTION
        Write the result of a function to screen. E.g. if the function had an error or ran successfully.
    .PARAMETER Result
        Pass the result from any ADC function to write the result to the console
    .PARAMETER PassThru
        Return the input object as output
    .EXAMPLE
        $lbvserver = Invoke-ADCGetLBvServer | Write-ADCText -PassThru
    .NOTES
        File Name : Write-ADCText
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [object]$Result,
            
        [Switch]$PassThru
    )
    process {
        switch ($Result.severity) {
            "ERROR" { 
                Write-ConsoleText -ForeGroundColor Red "ERROR [$($Result.errorcode)] $($Result.message)"
                break
            }
            "NONE" { 
                Write-ConsoleText -ForeGroundColor Green "Done"
                break
            }
            "WARNING" { 
                Write-ConsoleText -ForeGroundColor Yellow "WARNING $($Result.message)"
                break
            }
            $null { 
                Write-ConsoleText -ForeGroundColor Yellow "N/A"
                break
            }
            default { 
                Write-Verbose "Something else happened `"$($Result.severity)`""
                break 
            }
        }
        if ($PassThru) { 
            Write-Output $Result
        }
    }
}
