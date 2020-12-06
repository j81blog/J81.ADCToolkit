function Invoke-ADCAddSystemFile {
    <#
    .SYNOPSIS
        Add a new Certificate (and Key) to the ADC
    .DESCRIPTION
        Add a new Certificate (and Key) to the ADC
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER FileName
        Name of the file. It should not include filepath.
        Maximum length = 63
    .PARAMETER FileContent
        File content in Base64 format.
    .PARAMETER SourceFilePath
        Path to Sourcefile, this will be converted to a Base64 String.
    .PARAMETER FileLocation
        location of the file on Citrix ADC.
        Maximum length = 127
    .EXAMPLE
        Invoke-ADCAddSystemFile -FileName "wildcard_domain.com_2022.pfx" -SourceFilePath "C:\Certificate\wildcard_domain.com_2022.pfx" -FileLocation "/nsconfig/ssl/"
    .NOTES
        File Name : Invoke-ADCAddSystemFile
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ssl/sslcertkey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low', DefaultParameterSetName = "FileContent")]
    param(
        [Parameter(DontShow, ParameterSetName = "SourceFilePath")]
        [Parameter(DontShow, ParameterSetName = "FileContent")]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true, ParameterSetName = "SourceFilePath")]
        [Parameter(Mandatory = $true, ParameterSetName = "FileContent")]
        [ValidateLength(1, 63)]
        [String]$FileName,
        
        [Parameter(Mandatory = $true, ParameterSetName = "FileContent")]
        [ValidatePattern('^(?:[a-zA-Z0-9+\/]{4})*(?:|(?:[a-zA-Z0-9+\/]{3}=)|(?:[a-zA-Z0-9+\/]{2}==)|(?:[a-zA-Z0-9+\/]{1}===))$', Options = 'None')]
        [String]$FileContent,

        [Parameter(Mandatory = $true, ParameterSetName = "SourceFilePath")]
        [ValidateScript( {
                if ( -Not ($_ | Test-Path) ) {
                    throw "File does not exist"
                }
                return $true
            })][String]$SourceFilePath,
        
        [Parameter(Mandatory = $true, ParameterSetName = "SourceFilePath")]
        [Parameter(Mandatory = $true, ParameterSetName = "FileContent")]
        [ValidateLength(1, 127)]
        [String]$FileLocation
    )
    begin {
        Write-Verbose "Invoke-ADCAddSystemFile: Starting"
    }
    process {
        try {
            if ($PSBoundParameters.ContainsKey('SourceFilePath')) { $FileContent = [System.Convert]::ToBase64String((Get-Content -Path $SourceFilePath -Encoding "Byte")) }
            $Payload = @{
                filename     = $FileName
                filecontent  = $FileContent
                filelocation = $FileLocation
                fileencoding = "BASE64"
            }
            if ($PSCmdlet.ShouldProcess("$($FileLocation) $($FileName)", 'Post SystemFile')) {
                $response = Invoke-ADCNitroApi -Session $ADCSession -Method POST -Type systemfile -Payload $payload
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCAddSystemFile: Finished"
    }
}
