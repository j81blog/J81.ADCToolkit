function Invoke-ADCDeleteSystemFile {
    <#
    .SYNOPSIS
        Delete an ADC system file
    .DESCRIPTION
        Delete an ADC system file
    .PARAMETER Session
        Result from Connect-ADCNode
    .PARAMETER FileName
        A file name that needs to be deleted.
        Example: "www.domain.com_2019.pfx"
    .PARAMETER FileLocation
        Directory/Location where the file is located.
        Example "/nsconfig/ssl"
    .EXAMPLE
        Invoke-ADCDeleteSystemFile -ADCSession $ADCSession -FileName "www.domain.com_2019.pfx" -FileLocation "/nsconfig/ssl"
    .NOTES
        File Name : Invoke-ADCDeleteSystemFile
        Version   : v0.2
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [hashtable]$Session = (Invoke-ADCGetActiveSession),
            
        [String]$FileName,
            
        [String]$FileLocation
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemFile: Starting"
    }
    process {
        if ($PSCmdlet.ShouldProcess($FileName, 'Delete File')) {
            try {
                $Arguments = @{"filelocation" = "$FileLocation"; }
                Write-Verbose "Deleting `"$FileName`" from `"$FileLocation`""
                $response = Invoke-ADCNitroApi -ADCSession $Session -Method DELETE -Type systemfile -Resource $FileName -Arguments $Arguments
            } catch {
                Write-Verbose "ERROR: $($_.Exception.Message)"
                $response = $null
            }
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteSystemFile: Finished"
    }
}