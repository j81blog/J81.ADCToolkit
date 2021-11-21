function Invoke-ADCGetVpnStats {
    <#
    .SYNOPSIS
        Get SSL VPN statistics object(s).
    .DESCRIPTION
        Statistics for vpn.
    .PARAMETER Clearstats 
        Clear the statsistics / counters. 
        Possible values = basic, full 
    .PARAMETER GetAll 
        Retrieve all vpn object(s).
    .PARAMETER Count
        If specified, the count of the vpn object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVpnStats -GetAll 
        Get all vpn data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnStats -name <string>
        Get vpn object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnStats -Filter @{ 'name'='<value>' }
        Get vpn data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVpnStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/vpn/vpn/
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
        Write-Verbose "Invoke-ADCGetVpnStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all vpn objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpn -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for vpn objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpn -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving vpn objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('detail') ) { $arguments.Add('detail', $detail) } 
                if ( $PSBoundParameters.ContainsKey('fullvalues') ) { $arguments.Add('fullvalues', $fullvalues) } 
                if ( $PSBoundParameters.ContainsKey('ntimes') ) { $arguments.Add('ntimes', $ntimes) } 
                if ( $PSBoundParameters.ContainsKey('logfile') ) { $arguments.Add('logfile', $logfile) } 
                if ( $PSBoundParameters.ContainsKey('clearstats') ) { $arguments.Add('clearstats', $clearstats) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpn -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving vpn configuration for property ''"

            } else {
                Write-Verbose "Retrieving vpn configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpn -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVpnStats: Ended"
    }
}

function Invoke-ADCGetVpnurlpolicyStats {
    <#
    .SYNOPSIS
        Get SSL VPN statistics object(s).
    .DESCRIPTION
        Statistics for VPN url policy resource.
    .PARAMETER Name 
        The name of the vpn urlPolicy for which statistics will be displayed. If not given statistics are shown for all policies. 
    .PARAMETER GetAll 
        Retrieve all vpnurlpolicy object(s).
    .PARAMETER Count
        If specified, the count of the vpnurlpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnurlpolicyStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVpnurlpolicyStats -GetAll 
        Get all vpnurlpolicy data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnurlpolicyStats -name <string>
        Get vpnurlpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnurlpolicyStats -Filter @{ 'name'='<value>' }
        Get vpnurlpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVpnurlpolicyStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/vpn/vpnurlpolicy/
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
        Write-Verbose "Invoke-ADCGetVpnurlpolicyStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all vpnurlpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnurlpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for vpnurlpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnurlpolicy -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving vpnurlpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnurlpolicy -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving vpnurlpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnurlpolicy -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving vpnurlpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnurlpolicy -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVpnurlpolicyStats: Ended"
    }
}

function Invoke-ADCGetVpnvserverStats {
    <#
    .SYNOPSIS
        Get SSL VPN statistics object(s).
    .DESCRIPTION
        Statistics for VPN virtual server resource.
    .PARAMETER Name 
        Name of the virtual server for which to show detailed statistics. 
    .PARAMETER GetAll 
        Retrieve all vpnvserver object(s).
    .PARAMETER Count
        If specified, the count of the vpnvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnvserverStats
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVpnvserverStats -GetAll 
        Get all vpnvserver data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnvserverStats -name <string>
        Get vpnvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVpnvserverStats -Filter @{ 'name'='<value>' }
        Get vpnvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVpnvserverStats
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/statistics/vpn/vpnvserver/
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
        Write-Verbose "Invoke-ADCGetVpnvserverStats: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all vpnvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for vpnvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnvserver -NitroPath nitro/v1/stat -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving vpnvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnvserver -NitroPath nitro/v1/stat -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving vpnvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnvserver -NitroPath nitro/v1/stat -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving vpnvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type vpnvserver -NitroPath nitro/v1/stat -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVpnvserverStats: Ended"
    }
}


