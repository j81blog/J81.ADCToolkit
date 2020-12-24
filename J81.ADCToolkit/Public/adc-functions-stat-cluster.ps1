function Invoke-ADCGetClusterinstanceStats {
<#
    .SYNOPSIS
        Get Cluster statistics object(s)
    .DESCRIPTION
        Get Cluster statistics object(s)
    .PARAMETER clid 
       ID of the cluster instance for which to display statistics. 
    .PARAMETER GetAll 
        Retreive all clusterinstance object(s)
    .PARAMETER Count
        If specified, the count of the clusterinstance object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusterinstanceStats
    .EXAMPLE 
        Invoke-ADCGetClusterinstanceStats -GetAll
    .EXAMPLE
        Invoke-ADCGetClusterinstanceStats -name <string>
    .EXAMPLE
        Invoke-ADCGetClusterinstanceStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusterinstanceStats
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cluster/clusterinstance/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(DefaultParameterSetName = "Getall")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateRange(1, 16)]
        [double]$clid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterinstanceStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusterinstanceStats: Ended"
    }
}

function Invoke-ADCGetClusternodeStats {
<#
    .SYNOPSIS
        Get Cluster statistics object(s)
    .DESCRIPTION
        Get Cluster statistics object(s)
    .PARAMETER nodeid 
       ID of the cluster node for which to display statistics. If an ID is not provided, statistics are shown for all nodes. 
    .PARAMETER GetAll 
        Retreive all clusternode object(s)
    .PARAMETER Count
        If specified, the count of the clusternode object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetClusternodeStats
    .EXAMPLE 
        Invoke-ADCGetClusternodeStats -GetAll
    .EXAMPLE
        Invoke-ADCGetClusternodeStats -name <string>
    .EXAMPLE
        Invoke-ADCGetClusternodeStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetClusternodeStats
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cluster/clusternode/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(DefaultParameterSetName = "Getall")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateRange(0, 31)]
        [double]$nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodeStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetClusternodeStats: Ended"
    }
}


