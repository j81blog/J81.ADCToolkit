function Invoke-ADCGetClusterinstanceStats {
    <#
    .SYNOPSIS
        Get Cluster statistics object(s).
    .DESCRIPTION
        Statistics for cluster instance resource.
    .PARAMETER Clid 
        ID of the cluster instance for which to display statistics. 
    .PARAMETER GetAll 
        Retrieve all clusterinstance object(s).
    .PARAMETER Count
        If specified, the count of the clusterinstance object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusterinstanceStats -GetAll 
        Get all clusterinstance data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceStats -name <string>
        Get clusterinstance object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusterinstanceStats -Filter @{ 'name'='<value>' }
        Get clusterinstance data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusterinstanceStats
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cluster/clusterinstance/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateRange(1, 16)]
        [double]$Clid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusterinstanceStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusterinstance objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusterinstance objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusterinstance configuration for property 'clid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/stat -Resource $clid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusterinstance configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusterinstance -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Cluster statistics object(s).
    .DESCRIPTION
        Statistics for cluster node resource.
    .PARAMETER Nodeid 
        ID of the cluster node for which to display statistics. If an ID is not provided, statistics are shown for all nodes. 
    .PARAMETER GetAll 
        Retrieve all clusternode object(s).
    .PARAMETER Count
        If specified, the count of the clusternode object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodeStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetClusternodeStats -GetAll 
        Get all clusternode data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodeStats -name <string>
        Get clusternode object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetClusternodeStats -Filter @{ 'name'='<value>' }
        Get clusternode data with a filter.
    .NOTES
        File Name : Invoke-ADCGetClusternodeStats
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cluster/clusternode/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetClusternodeStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for clusternode objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving clusternode objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving clusternode configuration for property 'nodeid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/stat -Resource $nodeid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving clusternode configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type clusternode -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


