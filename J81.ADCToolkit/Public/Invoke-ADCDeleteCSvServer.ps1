function Invoke-ADCDeleteCSvServer {
    <#
    .SYNOPSIS
        Delete Content Switch Virtual Server
    .DESCRIPTION
        Delete Content Switch Virtual Server
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Specify the Content Switch Virtual Server Name
    .EXAMPLE
        Invoke-ADCDeleteCSvServer
    .EXAMPLE
        Invoke-ADCDeleteCSvServer -Name "cs_domain1.com_https"
    .NOTES
        File Name : Invoke-ADCDeleteCSvServer
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
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCSvServer: Starting"
    }
    process {
        Write-Verbose "Deleting `"$Name`""
        if ($PSCmdlet.ShouldProcess($Name, "Delete Content Switch Virtual Server")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver -Resource $Name -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteCSvServer: Finished"
    }
}
