function Invoke-ADCGetLBvServer {
    <#
        .SYNOPSIS
            Get Load Balance Virtual Server details
        .DESCRIPTION
            Get Load Balance Virtual Server details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify a Load Balance Virtual Server Name
        .PARAMETER Count
            If specified, the number of Load Balance Virtual Servers will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"curstate"="DOWN"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetLBvServer
        .EXAMPLE
            Invoke-ADCGetLBvServer -Name "lb_domain.com_https"
        .EXAMPLE
            Invoke-ADCGetLBvServer -Filter @{"curstate"="DOWN"}
        .NOTES
            File Name : Invoke-ADCGetLBvServer
            Version   : v0.1
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]  
    Param(
        
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(ParameterSetName = "GetResource", Mandatory = $true)]
        [String]$Name,
            
        [Parameter(ParameterSetName = "GetAll")]
        [Switch]$Count = $false,
			
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    $Query = @{ }
    try {
        if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

        if ($PSBoundParameters.ContainsKey('Name')) {
            $response = Invoke-ADCNitroApi -Session $ADCSession -Method Get -Type lbvserver -Resource $Name -Summary:$Summary -Filter $Filter -GetWarning
        } else {
            $response = Invoke-ADCNitroApi -Session $ADCSession -Method Get -Type lbvserver -Summary:$Summary -Filter $Filter -Query $Query -GetWarning
        }
    } catch {
        Write-Verbose "ERROR: $($_.Exception.Message)"
        $response = $null
    }
    return $response
}
