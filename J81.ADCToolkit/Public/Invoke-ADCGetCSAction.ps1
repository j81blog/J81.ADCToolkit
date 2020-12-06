function Invoke-ADCGetCSAction {
    <#
        .SYNOPSIS
            Get Content Switch Action details
        .DESCRIPTION
            Get Content Switch Action details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Content Switch Action Name
        .PARAMETER Count
            If specified, the number of Content Switch Virtual Server Content Switch Action bindings will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"name"="csa_domain.com_https"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetCSAction
        .EXAMPLE
            Invoke-ADCGetCSAction -Name "csa_domain.com_https"
        .EXAMPLE
            Invoke-ADCGetCSAction -Filter @{"name"="csa_domain.com_https"}
        .NOTES
            File Name : Invoke-ADCGetCSAction
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCGetCSAction: Starting"
    }
    process {
        try {
            $Query = @{ }
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('Name')) {
                Write-Verbose "Retrieving CS Action `"$Name`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type csaction -Resource $Name -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all CS Actions"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type csaction -Summary:$Summary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCSAction: Finished"
    }
}
