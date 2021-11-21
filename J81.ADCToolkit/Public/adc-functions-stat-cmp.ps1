function Invoke-ADCGetCmpStats {
    <#
    .SYNOPSIS
        Get Compression statistics object(s).
    .DESCRIPTION
        Statistics for cmp.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all cmp object(s).
    .PARAMETER Count
        If specified, the count of the cmp object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmpStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCmpStats -GetAll 
        Get all cmp data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmpStats -name <string>
        Get cmp object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmpStats -Filter @{ 'name'='<value>' }
        Get cmp data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCmpStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cmp/cmp/
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
        Write-Verbose "Invoke-ADCGetCmpStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmp -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmp -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmp objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmp -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmp configuration for property ''"

            } else {
                Write-Verbose "Retrieving cmp configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmp -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCmpStats: Ended"
    }
}

function Invoke-ADCGetCmppolicyStats {
    <#
    .SYNOPSIS
        Get Compression statistics object(s).
    .DESCRIPTION
        Statistics for compression policy resource.
    .PARAMETER Name 
        Name of the compression policy for which to display statistics. If no name is specified, statistics for all compression polices are shown. 
    .PARAMETER GetAll 
        Retrieve all cmppolicy object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCmppolicyStats -GetAll 
        Get all cmppolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicyStats -name <string>
        Get cmppolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicyStats -Filter @{ 'name'='<value>' }
        Get cmppolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCmppolicyStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cmp/cmppolicy/
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
        Write-Verbose "Invoke-ADCGetCmppolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCmppolicyStats: Ended"
    }
}

function Invoke-ADCGetCmppolicylabelStats {
    <#
    .SYNOPSIS
        Get Compression statistics object(s).
    .DESCRIPTION
        Statistics for compression policy label resource.
    .PARAMETER Labelname 
        Name of the compression policy label for which to display statistics. If not specified, statistics are displayed for all compression policy labels. 
    .PARAMETER GetAll 
        Retrieve all cmppolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cmppolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicylabelStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCmppolicylabelStats -GetAll 
        Get all cmppolicylabel data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicylabelStats -name <string>
        Get cmppolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCmppolicylabelStats -Filter @{ 'name'='<value>' }
        Get cmppolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCmppolicylabelStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/cmp/cmppolicylabel/
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
        Write-Verbose "Invoke-ADCGetCmppolicylabelStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cmppolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cmppolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cmppolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cmppolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/stat -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cmppolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cmppolicylabel -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCmppolicylabelStats: Ended"
    }
}


