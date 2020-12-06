function Invoke-ADCDeleteSystemFile {
    <#
    .SYNOPSIS
        Delete an ADC system file
    .DESCRIPTION
        Delete an ADC system file
    .PARAMETER ADCSession
        Result from Connect-ADCNode
    .PARAMETER FileName
        Name of the file. It should not include filepath.
        Maximum length = 63
    .PARAMETER FileLocation
        location of the file on Citrix ADC.
        Maximum length = 127
    .EXAMPLE
        Invoke-ADCDeleteSystemFile -ADCSession $ADCSession -FileName "www.domain.com_2019.pfx" -FileLocation "/nsconfig/ssl"
    .NOTES
        File Name : Invoke-ADCDeleteSystemFile
        Version   : v0.3
        Author    : John Billekens
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [parameter(Mandatory = $true)]
        [String]$FileName,
            
        [parameter(Mandatory = $true)]
        [String]$FileLocation
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSystemFile: Starting"
    }
    process {
        if ($PSCmdlet.ShouldProcess($FileName, 'Delete File')) {
            try {
                $Arguments = @{
                    filelocation = $FileLocation
                }
                Write-Verbose "Deleting `"$FileName`" from `"$FileLocation`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type systemfile -Resource $FileName -Arguments $Arguments
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