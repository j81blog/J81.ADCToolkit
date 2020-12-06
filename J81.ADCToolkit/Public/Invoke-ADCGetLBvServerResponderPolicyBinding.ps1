function Invoke-ADCGetLBvServerResponderPolicyBinding {
    <#
        .SYNOPSIS
            Get Load Balance Virtual Server Responder Policy binding details
        .DESCRIPTION
            Get Load Balance Virtual Server Responder Policy binding details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify a Load Balance Virtual Server Name
        .PARAMETER Count
            If specified, the number of Load Balance Virtual Server Responder Policy bindings will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"invoke"="true"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetLBvServerResponderPolicyBinding
        .EXAMPLE
            Invoke-ADCGetLBvServerResponderPolicyBinding -Name "lb_domain.com_https"
        .EXAMPLE
            Invoke-ADCGetLBvServerResponderPolicyBinding -Filter @{"invoke"="true"}
        .NOTES
            File Name : Invoke-ADCGetLBvServerResponderPolicyBinding
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver_responderpolicy_binding/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]  
    Param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(ParameterSetName = "GetResource", Mandatory = $true)]
        [String]$Name,
            
        [Parameter(ParameterSetName = "GetAll")]
        [Switch]$Count = $false,
			
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetLBvServerResponderPolicyBinding: Starting"
    }
    process {
        $Query = @{ }
        try {
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('Name')) {
                Write-Verbose "Retrieving LB vServer `"$Name`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type lbvserver_responderpolicy_binding -Resource $Name -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all LB vServer VIPs"
                $Query = @{ "bulkbindings" = "yes" }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type lbvserver_responderpolicy_binding -Summary:$Summary -Filter $Filter -Query $Query -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLBvServerResponderPolicyBinding: Finished"
    }
}
