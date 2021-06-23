function Invoke-ADCGetNsStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all ns object(s)
    .PARAMETER Count
        If specified, the count of the ns object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNsStats
    .EXAMPLE 
        Invoke-ADCGetNsStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNsStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNsStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNsStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/ns/
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
        Write-Verbose "Invoke-ADCGetNsStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ns objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ns configuration for property ''"

            } else {
                Write-Verbose "Retrieving ns configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNsStats: Ended"
    }
}

function Invoke-ADCGetNsaclStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER aclname 
       Name of the extended ACL rule whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retreive all nsacl object(s)
    .PARAMETER Count
        If specified, the count of the nsacl object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNsaclStats
    .EXAMPLE 
        Invoke-ADCGetNsaclStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNsaclStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNsaclStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNsaclStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsacl/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$aclname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsaclStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nsacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsacl objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsacl configuration for property 'aclname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Resource $aclname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsacl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNsaclStats: Ended"
    }
}

function Invoke-ADCGetNsacl6Stats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER acl6name 
       Name of the ACL6 rule whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retreive all nsacl6 object(s)
    .PARAMETER Count
        If specified, the count of the nsacl6 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNsacl6Stats
    .EXAMPLE 
        Invoke-ADCGetNsacl6Stats -GetAll
    .EXAMPLE
        Invoke-ADCGetNsacl6Stats -name <string>
    .EXAMPLE
        Invoke-ADCGetNsacl6Stats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNsacl6Stats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsacl6/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$acl6name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsacl6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nsacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsacl6 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsacl6 configuration for property 'acl6name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Resource $acl6name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsacl6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNsacl6Stats: Ended"
    }
}

function Invoke-ADCGetNslimitidentifierStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER name 
       The name of the identifier. 
    .PARAMETER GetAll 
        Retreive all nslimitidentifier object(s)
    .PARAMETER Count
        If specified, the count of the nslimitidentifier object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNslimitidentifierStats
    .EXAMPLE 
        Invoke-ADCGetNslimitidentifierStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNslimitidentifierStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNslimitidentifierStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNslimitidentifierStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nslimitidentifier/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNslimitidentifierStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nslimitidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nslimitidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nslimitidentifier objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nslimitidentifier configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nslimitidentifier configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNslimitidentifierStats: Ended"
    }
}

function Invoke-ADCGetNsmemoryStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER pool 
       Feature name for which to display memory statistics. 
    .PARAMETER GetAll 
        Retreive all nsmemory object(s)
    .PARAMETER Count
        If specified, the count of the nsmemory object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNsmemoryStats
    .EXAMPLE 
        Invoke-ADCGetNsmemoryStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNsmemoryStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNsmemoryStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNsmemoryStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsmemory/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pool,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsmemoryStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nsmemory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsmemory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsmemory objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsmemory configuration for property 'pool'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Resource $pool -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsmemory configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNsmemoryStats: Ended"
    }
}

function Invoke-ADCGetNspartitionStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER partitionname 
       Name of the partition. 
    .PARAMETER GetAll 
        Retreive all nspartition object(s)
    .PARAMETER Count
        If specified, the count of the nspartition object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNspartitionStats
    .EXAMPLE 
        Invoke-ADCGetNspartitionStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNspartitionStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNspartitionStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNspartitionStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspartition/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$partitionname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNspartitionStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nspartition objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspartition objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspartition objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspartition configuration for property 'partitionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Resource $partitionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspartition configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNspartitionStats: Ended"
    }
}

function Invoke-ADCGetNspbrStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER name 
       Name of the PBR whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retreive all nspbr object(s)
    .PARAMETER Count
        If specified, the count of the nspbr object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNspbrStats
    .EXAMPLE 
        Invoke-ADCGetNspbrStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNspbrStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNspbrStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNspbrStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspbr/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNspbrStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nspbr objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspbr objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspbr objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspbr configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspbr configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNspbrStats: Ended"
    }
}

function Invoke-ADCGetNspbr6Stats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER name 
       Name of the PBR6 whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retreive all nspbr6 object(s)
    .PARAMETER Count
        If specified, the count of the nspbr6 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNspbr6Stats
    .EXAMPLE 
        Invoke-ADCGetNspbr6Stats -GetAll
    .EXAMPLE
        Invoke-ADCGetNspbr6Stats -name <string>
    .EXAMPLE
        Invoke-ADCGetNspbr6Stats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNspbr6Stats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspbr6/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNspbr6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nspbr6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspbr6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspbr6 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspbr6 configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspbr6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNspbr6Stats: Ended"
    }
}

function Invoke-ADCGetNssimpleaclStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all nssimpleacl object(s)
    .PARAMETER Count
        If specified, the count of the nssimpleacl object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNssimpleaclStats
    .EXAMPLE 
        Invoke-ADCGetNssimpleaclStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNssimpleaclStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNssimpleaclStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNssimpleaclStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nssimpleacl/
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
        Write-Verbose "Invoke-ADCGetNssimpleaclStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nssimpleacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nssimpleacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nssimpleacl objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nssimpleacl configuration for property ''"

            } else {
                Write-Verbose "Retrieving nssimpleacl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNssimpleaclStats: Ended"
    }
}

function Invoke-ADCGetNssimpleacl6Stats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all nssimpleacl6 object(s)
    .PARAMETER Count
        If specified, the count of the nssimpleacl6 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNssimpleacl6Stats
    .EXAMPLE 
        Invoke-ADCGetNssimpleacl6Stats -GetAll
    .EXAMPLE
        Invoke-ADCGetNssimpleacl6Stats -name <string>
    .EXAMPLE
        Invoke-ADCGetNssimpleacl6Stats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNssimpleacl6Stats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nssimpleacl6/
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
        Write-Verbose "Invoke-ADCGetNssimpleacl6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nssimpleacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nssimpleacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nssimpleacl6 objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nssimpleacl6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving nssimpleacl6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNssimpleacl6Stats: Ended"
    }
}

function Invoke-ADCGetNstrafficdomainStats {
<#
    .SYNOPSIS
        Get NS statistics object(s)
    .DESCRIPTION
        Get NS statistics object(s)
    .PARAMETER td 
       An integer specifying the Traffic Domain ID. Possible values: 1 through 4094. 
    .PARAMETER GetAll 
        Retreive all nstrafficdomain object(s)
    .PARAMETER Count
        If specified, the count of the nstrafficdomain object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNstrafficdomainStats
    .EXAMPLE 
        Invoke-ADCGetNstrafficdomainStats -GetAll
    .EXAMPLE
        Invoke-ADCGetNstrafficdomainStats -name <string>
    .EXAMPLE
        Invoke-ADCGetNstrafficdomainStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNstrafficdomainStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nstrafficdomain/
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
        [ValidateRange(1, 4094)]
        [double]$td,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNstrafficdomainStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all nstrafficdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nstrafficdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nstrafficdomain objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nstrafficdomain configuration for property 'td'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Resource $td -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nstrafficdomain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNstrafficdomainStats: Ended"
    }
}


