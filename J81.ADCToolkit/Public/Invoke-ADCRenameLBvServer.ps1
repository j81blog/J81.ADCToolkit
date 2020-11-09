function Invoke-ADCRenameLBvServer {
    <#
        .SYNOPSIS
            Rename Load Balance Virtual Server
        .DESCRIPTION
            Rename Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify the "old" Load Balance Virtual Server Name
        .PARAMETER NewName
            Specify the "new" Load Balance Virtual Server Name
        .EXAMPLE
            Invoke-ADCRenameLBvServer
        .EXAMPLE
            Invoke-ADCRenameLBvServer -Name "lb_domain1.com_https" -NewName "lb_domain2.com_https"
        .NOTES
            File Name : Invoke-ADCRenameLBvServer
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
        [String]$Name,
            
        [Parameter(Mandatory = $true)]
        [String]$NewName
    )
    $Payload = @{
        name    = $Name
        newname = $NewName
    }
    if ($PSCmdlet.ShouldProcess($Name, "Rename Load Balance Virtual Server")) {
        $response = Invoke-ADCNitroApi -Session $ADCSession -Method POST -Type lbvserver -Action rename -Payload $Payload -GetWarning
        return $response
    }
}
