function Invoke-ADCGetCSPolicy {
    <#
        .SYNOPSIS
            Get Content Switch Policy details
        .DESCRIPTION
            Get Content Switch Policy details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER PolicyName
            Content Switch Policy Name
        .PARAMETER Count
            If specified, the number of Content Switch Virtual Server Content Switch Policy bindings will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"action"="csa_domain.com_https"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetCSPolicy
        .EXAMPLE
            Invoke-ADCGetCSPolicy -Name "csp_domain.com_https"
        .EXAMPLE
            Invoke-ADCGetCSPolicy -Filter @{"action"="csa_domain.com_https"}
        .NOTES
            File Name : Invoke-ADCGetCSPolicy
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        [String]$PolicyName,
            
        [Parameter(ParameterSetName = "GetAll")]
        [Switch]$Count = $false,
			
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetCSPolicy: Starting"
    }
    process {
        try {
            $Query = @{ }
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('PolicyName')) {
                Write-Verbose "Retrieving CS Policy `"$PolicyName`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type cspolicy -Resource $PolicyName -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all CS Policy"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type cspolicy -Summary:$Summary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCSPolicy: Finished"
    }
}
