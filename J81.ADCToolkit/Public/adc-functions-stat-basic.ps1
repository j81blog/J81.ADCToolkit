function Invoke-ADCGetServiceStats {
    <#
    .SYNOPSIS
        Get Basic statistics object(s).
    .DESCRIPTION
        Statistics for service resource.
    .PARAMETER Name 
        Name of the service. 
    .PARAMETER GetAll 
        Retrieve all service object(s).
    .PARAMETER Count
        If specified, the count of the service object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServiceStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServiceStats -GetAll 
        Get all service data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServiceStats -name <string>
        Get service object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServiceStats -Filter @{ 'name'='<value>' }
        Get service data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServiceStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/basic/service/
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
        Write-Verbose "Invoke-ADCGetServiceStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for service objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving service objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving service configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving service configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type service -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServiceStats: Ended"
    }
}

function Invoke-ADCGetServicegroupStats {
    <#
    .SYNOPSIS
        Get Basic statistics object(s).
    .DESCRIPTION
        Statistics for service group resource.
    .PARAMETER Servicegroupname 
        Name of the service group for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all servicegroup object(s).
    .PARAMETER Count
        If specified, the count of the servicegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupStats -GetAll 
        Get all servicegroup data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupStats -name <string>
        Get servicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupStats -Filter @{ 'name'='<value>' }
        Get servicegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/basic/servicegroup/
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
        [string]$Servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/stat -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroup -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupStats: Ended"
    }
}

function Invoke-ADCGetServicegroupmemberStats {
    <#
    .SYNOPSIS
        Get Basic statistics object(s).
    .DESCRIPTION
        Statistics for service group entity resource.
    .PARAMETER Servicegroupname 
        Displays statistics for the specified service group.Name of the service group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my servicegroup" or 'my servicegroup'). 
    .PARAMETER GetAll 
        Retrieve all servicegroupmember object(s).
    .PARAMETER Count
        If specified, the count of the servicegroupmember object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupmemberStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetServicegroupmemberStats -GetAll 
        Get all servicegroupmember data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupmemberStats -name <string>
        Get servicegroupmember object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetServicegroupmemberStats -Filter @{ 'name'='<value>' }
        Get servicegroupmember data with a filter.
    .NOTES
        File Name : Invoke-ADCGetServicegroupmemberStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/basic/servicegroupmember/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetServicegroupmemberStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all servicegroupmember objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupmember -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for servicegroupmember objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupmember -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving servicegroupmember objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupmember -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving servicegroupmember configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupmember -NitroPath nitro/v1/stat -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving servicegroupmember configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type servicegroupmember -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetServicegroupmemberStats: Ended"
    }
}


