function Invoke-ADCGetLsnStats {
<#
    .SYNOPSIS
        Get Lsn statistics object(s)
    .DESCRIPTION
        Get Lsn statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all lsn object(s)
    .PARAMETER Count
        If specified, the count of the lsn object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnStats
    .EXAMPLE 
        Invoke-ADCGetLsnStats -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnStats -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnStats
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lsn/lsn/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsn objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsn -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsn objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsn -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsn objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsn -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsn configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsn configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsn -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnStats: Ended"
    }
}

function Invoke-ADCGetLsndsliteStats {
<#
    .SYNOPSIS
        Get Lsn statistics object(s)
    .DESCRIPTION
        Get Lsn statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all lsndslite object(s)
    .PARAMETER Count
        If specified, the count of the lsndslite object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsndsliteStats
    .EXAMPLE 
        Invoke-ADCGetLsndsliteStats -GetAll
    .EXAMPLE
        Invoke-ADCGetLsndsliteStats -name <string>
    .EXAMPLE
        Invoke-ADCGetLsndsliteStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsndsliteStats
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lsn/lsndslite/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsndsliteStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsndslite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndslite -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsndslite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndslite -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsndslite objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndslite -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsndslite configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsndslite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndslite -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsndsliteStats: Ended"
    }
}

function Invoke-ADCGetLsngroupStats {
<#
    .SYNOPSIS
        Get Lsn statistics object(s)
    .DESCRIPTION
        Get Lsn statistics object(s)
    .PARAMETER groupname 
       Name of the LSN Group. 
    .PARAMETER GetAll 
        Retreive all lsngroup object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngroupStats
    .EXAMPLE 
        Invoke-ADCGetLsngroupStats -GetAll
    .EXAMPLE
        Invoke-ADCGetLsngroupStats -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngroupStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngroupStats
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lsn/lsngroup/
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
        [ValidateLength(1, 127)]
        [string]$groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngroupStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/stat -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngroupStats: Ended"
    }
}

function Invoke-ADCGetLsnnat64Stats {
<#
    .SYNOPSIS
        Get Lsn statistics object(s)
    .DESCRIPTION
        Get Lsn statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all lsnnat64 object(s)
    .PARAMETER Count
        If specified, the count of the lsnnat64 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnnat64Stats
    .EXAMPLE 
        Invoke-ADCGetLsnnat64Stats -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnnat64Stats -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnnat64Stats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnnat64Stats
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lsn/lsnnat64/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnnat64Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnnat64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnnat64 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnnat64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnnat64 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnnat64 objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnnat64 -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnnat64 configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnnat64 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnnat64 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnnat64Stats: Ended"
    }
}

function Invoke-ADCGetLsnpoolStats {
<#
    .SYNOPSIS
        Get Lsn statistics object(s)
    .DESCRIPTION
        Get Lsn statistics object(s)
    .PARAMETER poolname 
       Name of the LSN Pool. 
    .PARAMETER GetAll 
        Retreive all lsnpool object(s)
    .PARAMETER Count
        If specified, the count of the lsnpool object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnpoolStats
    .EXAMPLE 
        Invoke-ADCGetLsnpoolStats -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnpoolStats -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnpoolStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnpoolStats
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/lsn/lsnpool/
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
        [ValidateLength(1, 127)]
        [string]$poolname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnpoolStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/stat -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnpoolStats: Ended"
    }
}


