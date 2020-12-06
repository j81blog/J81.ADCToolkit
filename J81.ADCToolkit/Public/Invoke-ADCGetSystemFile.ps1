function Invoke-ADCGetSystemFile {
    <#
        .SYNOPSIS
            Get SystemFile information
        .DESCRIPTION
            Get SystemFile information
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER FileLocation
            Specify a path, e.g. "/nsconfig/ssl/"
        .PARAMETER FileName
            Specify a filename
        .EXAMPLE
            Invoke-ADCGetSystemFile -FileLocation "/nsconfig/ssl/"
        .EXAMPLE
            Invoke-ADCGetSystemFile -FileLocation "/nsconfig" -FileName "ns.conf"
        .NOTES
            File Name : Invoke-ADCGetSystemFile
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/system/systemfile/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding()]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
            
        [Parameter(Mandatory = $true)]
        [alias("FilePath")]
        [String]$FileLocation,
			
        [hashtable]$Filter = @{ },
    
        [String]$FileName
    )
    begin {
        Write-Verbose "Invoke-ADCGetSystemFile: Starting"
    }
    process {
        $Arguments = @{ "filelocation" = $($FileLocation.Replace('\', '/').TrimEnd('/')) }
		
        if ($PSBoundParameters.ContainsKey('FileName')) {
            $Arguments += @{ "filename" = $FileName }
        }
        try {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type systemfile -Filter $Filter -Arguments $Arguments -GetWarning
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSystemFile: Finished"
    }
}
