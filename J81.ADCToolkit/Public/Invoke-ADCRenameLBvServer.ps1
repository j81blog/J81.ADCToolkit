function Invoke-ADCRenameLBvServer {
    <#
        .SYNOPSIS
            Rename Load Balance Virtual Server
        .DESCRIPTION
            Rename Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the load balance virtual server.
        .PARAMETER NewName
            The new name for the load balance virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters.
        .EXAMPLE
            Invoke-ADCRenameLBvServer
        .EXAMPLE
            Invoke-ADCRenameLBvServer -Name "lb_domain1.com_https" -NewName "lb_domain2.com_https"
        .NOTES
            File Name : Invoke-ADCRenameLBvServer
            Version   : v0.3
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][s]|[:]|[@]|[=]|[-])+)$', Options = 'None')]
        [String]$Name,
            
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][s]|[:]|[@]|[=]|[-])+)$', Options = 'None')]
        [String]$NewName
    )
    begin {
        Write-Verbose "Invoke-ADCRenameLBvServer: Starting"
    }
    process {
        $Payload = @{
            name    = $Name
            newname = $NewName
        }
        Write-Verbose "Renaming `"$Name`" to `"$NewName`""
        if ($PSCmdlet.ShouldProcess($Name, "Rename Load Balance Virtual Server")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Action rename -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCRenameLBvServer: Finished"
    }
}
