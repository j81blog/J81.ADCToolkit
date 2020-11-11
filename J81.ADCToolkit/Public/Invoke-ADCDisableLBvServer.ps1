function Invoke-ADCDisableLBvServer {
    <#
        .SYNOPSIS
            Disable Load Balance Virtual Server
        .DESCRIPTION
            Disable Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify the Load Balance Virtual Server Name
        .EXAMPLE
            Invoke-ADCDisableLBvServer
        .EXAMPLE
            Invoke-ADCDisableLBvServer -Name "lb_domain1.com_https"
        .NOTES
            File Name : Invoke-ADCDisableLBvServer
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
        
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    begin {
        Write-Verbose "Invoke-ADCDisableLBvServer: Starting"
    }
    process {
        $Payload = @{ name = $Name }
        if ($PSCmdlet.ShouldProcess($Name, "Disable Load Balance Virtual Server")) {
            Write-Verbose "Disable LB vServer: `"$Name`""
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action disable -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDisableLBvServer: Finished"
    }
}
