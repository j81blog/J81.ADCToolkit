function Invoke-ADCGetCSvServerCSPolicyBinding {
    <#
        .SYNOPSIS
            Get Content Switch Virtual Server Content Switch Policy binding details
        .DESCRIPTION
            Get Content Switch Virtual Server Content Switch Policy binding details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify a Content Switch Virtual Server Name
        .PARAMETER Count
            If specified, the number of Content Switch Virtual Server Content Switch Policy bindings will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"curstate"="DOWN"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetCSvServerCSPolicyBinding
        .EXAMPLE
            Invoke-ADCGetCSvServerCSPolicyBinding -Name "cs_domain.com_https"
        .EXAMPLE
            Invoke-ADCGetCSvServerCSPolicyBinding -Filter @{"curstate"="DOWN"}
        .NOTES
            File Name : Invoke-ADCGetCSvServerCSPolicyBinding
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCSvServerCSPolicyBinding: Starting"
    }
    process {
        try {
            $Query = @{ }
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('Name')) {
                Write-Verbose "Retrieving CS vServer `"$Name`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type csvserver_cspolicy_binding -Resource $Name -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all CS vServer VIPs"
                $Query = @{ "bulkbindings" = "yes" }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type csvserver_cspolicy_binding -Summary:$Summary -Filter $Filter -Query $Query -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCSvServerCSPolicyBinding: Finished"
    }
}
