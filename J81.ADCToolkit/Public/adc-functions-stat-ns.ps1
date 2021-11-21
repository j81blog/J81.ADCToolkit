function Invoke-ADCGetNsStats {
    <#
    .SYNOPSIS
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for ns.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all ns object(s).
    .PARAMETER Count
        If specified, the count of the ns object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNsStats -GetAll 
        Get all ns data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsStats -name <string>
        Get ns object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsStats -Filter @{ 'name'='<value>' }
        Get ns data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNsStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/ns/
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
        Write-Verbose "Invoke-ADCGetNsStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ns objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ns configuration for property ''"

            } else {
                Write-Verbose "Retrieving ns configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ns -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for ACL entry resource.
    .PARAMETER Aclname 
        Name of the extended ACL rule whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retrieve all nsacl object(s).
    .PARAMETER Count
        If specified, the count of the nsacl object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsaclStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNsaclStats -GetAll 
        Get all nsacl data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsaclStats -name <string>
        Get nsacl object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsaclStats -Filter @{ 'name'='<value>' }
        Get nsacl data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNsaclStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsacl/
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
        [string]$Aclname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsaclStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nsacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsacl objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsacl configuration for property 'aclname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Resource $aclname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsacl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for ACL6 entry resource.
    .PARAMETER Acl6name 
        Name of the ACL6 rule whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retrieve all nsacl6 object(s).
    .PARAMETER Count
        If specified, the count of the nsacl6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsacl6Stats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNsacl6Stats -GetAll 
        Get all nsacl6 data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsacl6Stats -name <string>
        Get nsacl6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsacl6Stats -Filter @{ 'name'='<value>' }
        Get nsacl6 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNsacl6Stats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsacl6/
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
        [string]$Acl6name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsacl6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nsacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsacl6 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsacl6 configuration for property 'acl6name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Resource $acl6name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsacl6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsacl6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for limit Indetifier resource.
    .PARAMETER Name 
        The name of the identifier. 
    .PARAMETER GetAll 
        Retrieve all nslimitidentifier object(s).
    .PARAMETER Count
        If specified, the count of the nslimitidentifier object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNslimitidentifierStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNslimitidentifierStats -GetAll 
        Get all nslimitidentifier data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNslimitidentifierStats -name <string>
        Get nslimitidentifier object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNslimitidentifierStats -Filter @{ 'name'='<value>' }
        Get nslimitidentifier data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNslimitidentifierStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nslimitidentifier/
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
        Write-Verbose "Invoke-ADCGetNslimitidentifierStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nslimitidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nslimitidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nslimitidentifier objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nslimitidentifier configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nslimitidentifier configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nslimitidentifier -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for resource.
    .PARAMETER Pool 
        Feature name for which to display memory statistics. 
    .PARAMETER GetAll 
        Retrieve all nsmemory object(s).
    .PARAMETER Count
        If specified, the count of the nsmemory object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsmemoryStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNsmemoryStats -GetAll 
        Get all nsmemory data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsmemoryStats -name <string>
        Get nsmemory object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNsmemoryStats -Filter @{ 'name'='<value>' }
        Get nsmemory data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNsmemoryStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nsmemory/
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
        [string]$Pool,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNsmemoryStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nsmemory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nsmemory objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nsmemory objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nsmemory configuration for property 'pool'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Resource $pool -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nsmemory configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nsmemory -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for admin partition resource.
    .PARAMETER Partitionname 
        Name of the partition. 
    .PARAMETER GetAll 
        Retrieve all nspartition object(s).
    .PARAMETER Count
        If specified, the count of the nspartition object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspartitionStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNspartitionStats -GetAll 
        Get all nspartition data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspartitionStats -name <string>
        Get nspartition object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspartitionStats -Filter @{ 'name'='<value>' }
        Get nspartition data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNspartitionStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspartition/
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
        [string]$Partitionname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNspartitionStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nspartition objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspartition objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspartition objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspartition configuration for property 'partitionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Resource $partitionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspartition configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspartition -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for Policy Based Routing(PBR) entry resource.
    .PARAMETER Name 
        Name of the PBR whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retrieve all nspbr object(s).
    .PARAMETER Count
        If specified, the count of the nspbr object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbrStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNspbrStats -GetAll 
        Get all nspbr data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbrStats -name <string>
        Get nspbr object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbrStats -Filter @{ 'name'='<value>' }
        Get nspbr data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNspbrStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspbr/
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
        Write-Verbose "Invoke-ADCGetNspbrStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nspbr objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspbr objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspbr objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspbr configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspbr configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for PBR6 entry resource.
    .PARAMETER Name 
        Name of the PBR6 whose statistics you want the Citrix ADC to display. 
    .PARAMETER GetAll 
        Retrieve all nspbr6 object(s).
    .PARAMETER Count
        If specified, the count of the nspbr6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbr6Stats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNspbr6Stats -GetAll 
        Get all nspbr6 data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbr6Stats -name <string>
        Get nspbr6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNspbr6Stats -Filter @{ 'name'='<value>' }
        Get nspbr6 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNspbr6Stats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nspbr6/
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
        Write-Verbose "Invoke-ADCGetNspbr6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nspbr6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nspbr6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nspbr6 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nspbr6 configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nspbr6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nspbr6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for simple ACL resource.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all nssimpleacl object(s).
    .PARAMETER Count
        If specified, the count of the nssimpleacl object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleaclStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNssimpleaclStats -GetAll 
        Get all nssimpleacl data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleaclStats -name <string>
        Get nssimpleacl object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleaclStats -Filter @{ 'name'='<value>' }
        Get nssimpleacl data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNssimpleaclStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nssimpleacl/
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
        Write-Verbose "Invoke-ADCGetNssimpleaclStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nssimpleacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nssimpleacl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nssimpleacl objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nssimpleacl configuration for property ''"

            } else {
                Write-Verbose "Retrieving nssimpleacl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for simple ACL6 resource.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all nssimpleacl6 object(s).
    .PARAMETER Count
        If specified, the count of the nssimpleacl6 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleacl6Stats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNssimpleacl6Stats -GetAll 
        Get all nssimpleacl6 data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleacl6Stats -name <string>
        Get nssimpleacl6 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNssimpleacl6Stats -Filter @{ 'name'='<value>' }
        Get nssimpleacl6 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNssimpleacl6Stats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nssimpleacl6/
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
        Write-Verbose "Invoke-ADCGetNssimpleacl6Stats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nssimpleacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nssimpleacl6 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nssimpleacl6 objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nssimpleacl6 configuration for property ''"

            } else {
                Write-Verbose "Retrieving nssimpleacl6 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nssimpleacl6 -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NS statistics object(s).
    .DESCRIPTION
        Statistics for Traffic Domain resource.
    .PARAMETER Td 
        An integer specifying the Traffic Domain ID. Possible values: 1 through 4094. 
    .PARAMETER GetAll 
        Retrieve all nstrafficdomain object(s).
    .PARAMETER Count
        If specified, the count of the nstrafficdomain object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrafficdomainStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNstrafficdomainStats -GetAll 
        Get all nstrafficdomain data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrafficdomainStats -name <string>
        Get nstrafficdomain object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNstrafficdomainStats -Filter @{ 'name'='<value>' }
        Get nstrafficdomain data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNstrafficdomainStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/ns/nstrafficdomain/
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
        [ValidateRange(1, 4094)]
        [double]$Td,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetNstrafficdomainStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all nstrafficdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for nstrafficdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving nstrafficdomain objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving nstrafficdomain configuration for property 'td'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Resource $td -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving nstrafficdomain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type nstrafficdomain -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


