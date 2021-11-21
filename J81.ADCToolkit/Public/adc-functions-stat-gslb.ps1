function Invoke-ADCGetGslbdomainStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for GSLB domain resource.
    .PARAMETER Name 
        Name of the GSLB domain for which to display statistics. If you do not specify a name, statistics are shown for all configured GSLB 
        domains. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomainStats -GetAll 
        Get all gslbdomain data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainStats -name <string>
        Get gslbdomain object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainStats -Filter @{ 'name'='<value>' }
        Get gslbdomain data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomainStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbdomain/
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
        Write-Verbose "Invoke-ADCGetGslbdomainStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomainStats: Ended"
    }
}

function Invoke-ADCGetGslbserviceStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for GSLB service resource.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbserviceStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbserviceStats -GetAll 
        Get all gslbservice data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbserviceStats -name <string>
        Get gslbservice object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbserviceStats -Filter @{ 'name'='<value>' }
        Get gslbservice data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbserviceStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbservice/
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
        [string]$Servicename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbserviceStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/stat -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbserviceStats: Ended"
    }
}

function Invoke-ADCGetGslbservicegroupStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupStats -GetAll 
        Get all gslbservicegroup data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupStats -name <string>
        Get gslbservicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupStats -Filter @{ 'name'='<value>' }
        Get gslbservicegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbservicegroup/
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
        Write-Verbose "Invoke-ADCGetGslbservicegroupStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/stat -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroupStats: Ended"
    }
}

function Invoke-ADCGetGslbservicegroupmemberStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for GSLB service group entity resource.
    .PARAMETER Servicegroupname 
        Displays statistics for the specified GSLB service group.Name of the GSLB service group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my servicegroup" or 'my servicegroup'). 
    .PARAMETER Ip 
        IP address of the GSLB service group. Mutually exclusive with the server name parameter. 
    .PARAMETER Servername 
        Name of the server. Mutually exclusive with the IP address parameter. 
    .PARAMETER Port 
        Port number of the service group member. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroupmember object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroupmember object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupmemberStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupmemberStats -GetAll 
        Get all gslbservicegroupmember data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupmemberStats -name <string>
        Get gslbservicegroupmember object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupmemberStats -Filter @{ 'name'='<value>' }
        Get gslbservicegroupmember data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupmemberStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbservicegroupmember/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Servicegroupname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Ip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(1, 65535)]
        [int]$Port,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('basic', 'full')]
        [string]$Clearstats,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicegroupmemberStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservicegroupmember objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroupmember -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroupmember objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroupmember -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroupmember objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $arguments.Add('servicegroupname', $servicegroupname) } 
                if ( $PSBoundParameters.ContainsKey('ip') ) { $arguments.Add('ip', $ip) } 
                if ( $PSBoundParameters.ContainsKey('servername') ) { $arguments.Add('servername', $servername) } 
                if ( $PSBoundParameters.ContainsKey('port') ) { $arguments.Add('port', $port) } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroupmember -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroupmember configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbservicegroupmember configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroupmember -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroupmemberStats: Ended"
    }
}

function Invoke-ADCGetGslbsiteStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for GSLB site resource.
    .PARAMETER Sitename 
        Name of the GSLB site for which to display detailed statistics. If a name is not specified, basic information about all GSLB sites is displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsiteStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsiteStats -GetAll 
        Get all gslbsite data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsiteStats -name <string>
        Get gslbsite object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsiteStats -Filter @{ 'name'='<value>' }
        Get gslbsite data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsiteStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbsite/
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
        [string]$Sitename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsiteStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/stat -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsiteStats: Ended"
    }
}

function Invoke-ADCGetGslbvserverStats {
    <#
    .SYNOPSIS
        Get Global Server Load Balancing statistics object(s).
    .DESCRIPTION
        Statistics for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name of the GSLB virtual server for which to display statistics. If you do not specify a name, statistics are displayed for all GSLB virtual servers. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverStats -GetAll 
        Get all gslbvserver data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverStats -name <string>
        Get gslbvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverStats -Filter @{ 'name'='<value>' }
        Get gslbvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvserverStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/gslb/gslbvserver/
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
        Write-Verbose "Invoke-ADCGetGslbvserverStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvserverStats: Ended"
    }
}


