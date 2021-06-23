function Invoke-ADCGetDnsStats {
<#
    .SYNOPSIS
        Get Domain Name Service statistics object(s)
    .DESCRIPTION
        Get Domain Name Service statistics object(s)
    .PARAMETER clearstats 
       Clear the statsistics / counters.  
       Possible values = basic, full 
    .PARAMETER GetAll 
        Retreive all dns object(s)
    .PARAMETER Count
        If specified, the count of the dns object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsStats
    .EXAMPLE 
        Invoke-ADCGetDnsStats -GetAll
    .EXAMPLE
        Invoke-ADCGetDnsStats -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/dns/dns/
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
        Write-Verbose "Invoke-ADCGetDnsStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dns -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dns objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dns -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dns objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('detail')) { $Arguments.Add('detail', $detail) } 
                if ($PSBoundParameters.ContainsKey('fullvalues')) { $Arguments.Add('fullvalues', $fullvalues) } 
                if ($PSBoundParameters.ContainsKey('ntimes')) { $Arguments.Add('ntimes', $ntimes) } 
                if ($PSBoundParameters.ContainsKey('logfile')) { $Arguments.Add('logfile', $logfile) } 
                if ($PSBoundParameters.ContainsKey('clearstats')) { $Arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dns -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dns configuration for property ''"

            } else {
                Write-Verbose "Retrieving dns configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dns -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsStats: Ended"
    }
}

function Invoke-ADCGetDnspolicylabelStats {
<#
    .SYNOPSIS
        Get Domain Name Service statistics object(s)
    .DESCRIPTION
        Get Domain Name Service statistics object(s)
    .PARAMETER labelname 
       The name of the dns policy label for which statistics will be displayed. If not given statistics are shown for all dns policylabels. 
    .PARAMETER GetAll 
        Retreive all dnspolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelStats
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabelStats -GetAll
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelStats -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabelStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/dns/dnspolicylabel/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabelStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/stat -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicylabelStats: Ended"
    }
}

function Invoke-ADCGetDnsrecordsStats {
<#
    .SYNOPSIS
        Get Domain Name Service statistics object(s)
    .DESCRIPTION
        Get Domain Name Service statistics object(s)
    .PARAMETER dnsrecordtype 
       Display statistics for the specified DNS record or query type or, if a record or query type is not specified, statistics for all record types supported on the Citrix ADC. 
    .PARAMETER GetAll 
        Retreive all dnsrecords object(s)
    .PARAMETER Count
        If specified, the count of the dnsrecords object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsrecordsStats
    .EXAMPLE 
        Invoke-ADCGetDnsrecordsStats -GetAll
    .EXAMPLE
        Invoke-ADCGetDnsrecordsStats -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsrecordsStats -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsrecordsStats
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/dns/dnsrecords/
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
        [string]$dnsrecordtype,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsrecordsStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsrecords -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsrecords -NitroPath nitro/v1/stat -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsrecords objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsrecords -NitroPath nitro/v1/stat -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsrecords configuration for property 'dnsrecordtype'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsrecords -NitroPath nitro/v1/stat -Resource $dnsrecordtype -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsrecords configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsrecords -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsrecordsStats: Ended"
    }
}


