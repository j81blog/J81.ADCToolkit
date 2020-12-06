function Invoke-ADCDeleteLBvServer {
    <#
    .SYNOPSIS
        Delete Load Balance Virtual Server
    .DESCRIPTION
        Delete Load Balance Virtual Server
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Specify the Load Balance Virtual Server Name
    .EXAMPLE
        Invoke-ADCDeleteLBvServer
    .EXAMPLE
        Invoke-ADCDeleteLBvServer -Name "lb_domain.com_https"
    .NOTES
        File Name : Invoke-ADCDeleteLBvServer
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
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
        Write-Verbose "Invoke-ADCDeleteLBvServer: Starting"
    }
    process {
        Write-Verbose "Deleting `"$Name`""
        if ($PSCmdlet.ShouldProcess($Name, "Delete Load Balance Virtual Server")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lbvserver -Resource $Name -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteLBvServer: Finished"
    }
}
