function Invoke-ADCEnableLBvServer {
    <#
        .SYNOPSIS
            Enable Load Balance Virtual Server
        .DESCRIPTION
            Enable Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify the Load Balance Virtual Server Name
        .EXAMPLE
            Invoke-ADCEnableLBvServer
        .EXAMPLE
            Invoke-ADCEnableLBvServer -Name "lb_domain1.com_https"
        .NOTES
            File Name : Invoke-ADCEnableLBvServer
            Version   : v0.1
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
    $Payload = @{
        name = $Name
    }
    if ($PSCmdlet.ShouldProcess($Name, "Enable Load Balance Virtual Server")) {
        $response = Invoke-ADCNitroApi -Session $ADCSession -Method POST -Type lbvserver -Action enable -Payload $Payload -GetWarning
        return $response
    }
}