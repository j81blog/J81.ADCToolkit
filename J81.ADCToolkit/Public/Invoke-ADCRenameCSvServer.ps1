function Invoke-ADCRenameCSvServer {
    <#
        .SYNOPSIS
            Rename Content Switch Virtual Server
        .DESCRIPTION
            Rename Content Switch Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the content switching virtual server.
        .PARAMETER NewName
            The new name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters.
        .EXAMPLE
            Invoke-ADCRenameCSvServer
        .EXAMPLE
            Invoke-ADCRenameCSvServer -Name "cs_domain1.com_https" -NewName "cs_domain2.com_https"
        .NOTES
            File Name : Invoke-ADCRenameCSvServer
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]  
    Param(
        
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^(([a-zA-Z0-9]|\_)+([\x00-\x7F]|_|\#|\.|\s|\:|@|=|-)+)$', Options = 'None')]
        [String]$Name,
            
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^(([a-zA-Z0-9]|\_)+([\x00-\x7F]|_|\#|\.|\s|\:|@|=|-)+)$', Options = 'None')]
        [String]$NewName
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCSvServer: Starting"
    }
    process {
        $Payload = @{
            name    = $Name
            newname = $NewName
        }
        Write-Verbose "Renaming `"$Name`" to `"$NewName`""
        if ($PSCmdlet.ShouldProcess($Name, "Rename Content Switch Virtual Server")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver -Action rename -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCRenameCSvServer: Finished"
    }
}
