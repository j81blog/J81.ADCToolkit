function Invoke-ADCGetCacheStats {
    <#
    .SYNOPSIS
        Get Integrated Caching statistics object(s).
    .DESCRIPTION
        Statistics for cache.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all cache object(s).
    .PARAMETER Count
        If specified, the count of the cache object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCacheStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCacheStats -GetAll 
        Get all cache data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCacheStats -name <string>
        Get cache object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCacheStats -Filter @{ 'name'='<value>' }
        Get cache data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCacheStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cache/cache/
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
        Write-Verbose "Invoke-ADCGetCacheStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cache -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cache -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cache objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cache -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cache configuration for property ''"

            } else {
                Write-Verbose "Retrieving cache configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cache -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCacheStats: Ended"
    }
}

function Invoke-ADCGetCachecontentgroupStats {
    <#
    .SYNOPSIS
        Get Integrated Caching statistics object(s).
    .DESCRIPTION
        Statistics for Integrated Cache content group resource.
    .PARAMETER Name 
        Name of the cache contentgroup for which to display statistics. If you do not set this parameter, statistics are shown for all cache contentgroups. 
    .PARAMETER GetAll 
        Retrieve all cachecontentgroup object(s).
    .PARAMETER Count
        If specified, the count of the cachecontentgroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachecontentgroupStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCachecontentgroupStats -GetAll 
        Get all cachecontentgroup data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachecontentgroupStats -name <string>
        Get cachecontentgroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachecontentgroupStats -Filter @{ 'name'='<value>' }
        Get cachecontentgroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCachecontentgroupStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cache/cachecontentgroup/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachecontentgroupStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachecontentgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachecontentgroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachecontentgroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachecontentgroup configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachecontentgroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachecontentgroup -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachecontentgroupStats: Ended"
    }
}

function Invoke-ADCGetCachepolicyStats {
    <#
    .SYNOPSIS
        Get Integrated Caching statistics object(s).
    .DESCRIPTION
        Statistics for Integrated Cache policy resource.
    .PARAMETER Policyname 
        Name of the cache policy for which to display statistics. If you do not set this parameter, statistics are shown for all cache policies. 
    .PARAMETER GetAll 
        Retrieve all cachepolicy object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCachepolicyStats -GetAll 
        Get all cachepolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicyStats -name <string>
        Get cachepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicyStats -Filter @{ 'name'='<value>' }
        Get cachepolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCachepolicyStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cache/cachepolicy/
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
        Write-Verbose "Invoke-ADCGetCachepolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/stat -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicyStats: Ended"
    }
}

function Invoke-ADCGetCachepolicylabelStats {
    <#
    .SYNOPSIS
        Get Integrated Caching statistics object(s).
    .DESCRIPTION
        Statistics for cache policy label resource.
    .PARAMETER Labelname 
        Name of the cache-policy label for which to display statistics. If you do not set this parameter statistics are shown for all cache-policy labels. 
    .PARAMETER GetAll 
        Retrieve all cachepolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cachepolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicylabelStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCachepolicylabelStats -GetAll 
        Get all cachepolicylabel data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicylabelStats -name <string>
        Get cachepolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCachepolicylabelStats -Filter @{ 'name'='<value>' }
        Get cachepolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCachepolicylabelStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cache/cachepolicylabel/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCachepolicylabelStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cachepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cachepolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cachepolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cachepolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/stat -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cachepolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cachepolicylabel -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCachepolicylabelStats: Ended"
    }
}


