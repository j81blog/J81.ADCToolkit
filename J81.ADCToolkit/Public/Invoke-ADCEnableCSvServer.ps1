function Invoke-ADCEnableCSvServer {
    <#
        .SYNOPSIS
            Enable Content Switch Virtual Server
        .DESCRIPTION
            Enable Content Switch Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify the Content Switch Virtual Server Name
        .EXAMPLE
            Invoke-ADCEnableCSvServer
        .EXAMPLE
            Invoke-ADCEnableCSvServer -Name "cs_domain.com_https"
        .NOTES
            File Name : Invoke-ADCEnableCSvServer
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
        [String]$Name
    )
    begin {
        Write-Verbose "Invoke-ADCEnableCSvServer: Starting"
    }
    process {
        $Payload = @{
            name = $Name
        }
        if ($PSCmdlet.ShouldProcess($Name, "Enable Content Switch Virtual Server")) {
            Write-Verbose "Enable CS vServer: `"$Name`""
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver -Action enable -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCEnableCSvServer: Finished"
    }
}
