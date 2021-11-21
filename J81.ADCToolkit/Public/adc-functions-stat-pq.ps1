function Invoke-ADCGetPqStats {
    <#
    .SYNOPSIS
        Get Priority Queuing statistics object(s).
    .DESCRIPTION
        Statistics for pq.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all pq object(s).
    .PARAMETER Count
        If specified, the count of the pq object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPqStats -GetAll 
        Get all pq data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqStats -name <string>
        Get pq object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqStats -Filter @{ 'name'='<value>' }
        Get pq data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPqStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/pq/pq.md/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$Clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetPqStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all pq objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pq -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pq objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pq -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pq objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pq -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pq configuration for property ''"

            } else {
                Write-Verbose "Retrieving pq configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pq -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPqStats: Ended"
    }
}

function Invoke-ADCGetPqpolicyStats {
    <#
    .SYNOPSIS
        Get Priority Queuing statistics object(s).
    .DESCRIPTION
        Statistics for PQ policy resource.
    .PARAMETER Policyname 
        Name of the priority queuing policy whose statistics must be displayed. If a name is not provided, statistics of all priority queuing policies are shown. 
    .PARAMETER GetAll 
        Retrieve all pqpolicy object(s).
    .PARAMETER Count
        If specified, the count of the pqpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqpolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetPqpolicyStats -GetAll 
        Get all pqpolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqpolicyStats -name <string>
        Get pqpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetPqpolicyStats -Filter @{ 'name'='<value>' }
        Get pqpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetPqpolicyStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/pq/pqpolicy.md/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Policyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetPqpolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all pqpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for pqpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving pqpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving pqpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/stat -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving pqpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type pqpolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetPqpolicyStats: Ended"
    }
}


