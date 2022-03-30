function Invoke-ADCAddDnsaaaarec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsaaaarec -hostname <string> -ipv6address <string>
        An example how to add dnsaaaarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsaaaarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv6address,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaaaarec: Starting"
    }
    process {
        try {
            $payload = @{ hostname = $hostname
                ipv6address        = $ipv6address
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsaaaarec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaaaarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsaaaarec: Finished"
    }
}

function Invoke-ADCDeleteDnsaaaarec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached records need to be removed. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsaaaarec -Hostname <string>
        An example how to delete dnsaaaarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsaaaarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Hostname,

        [string]$Ecssubnet,

        [string]$Ipv6address 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaaaarec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Ipv6address') ) { $arguments.Add('ipv6address', $Ipv6address) }
            if ( $PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaaaarec -NitroPath nitro/v1/config -Resource $hostname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsaaaarec: Finished"
    }
}

function Invoke-ADCGetDnsaaaarec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for IPv6 address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipv6address 
        One or more IPv6 addresses to assign to the domain name. 
    .PARAMETER Type 
        Type of records to display. Available settings function as follows: 
        * ADNS - Display all authoritative address records. 
        * PROXY - Display all proxy address records. 
        * ALL - Display all address records. 
        Possible values = ALL, ADNS, PROXY 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all dnsaaaarec object(s).
    .PARAMETER Count
        If specified, the count of the dnsaaaarec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaaaarec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaaaarec -GetAll 
        Get all dnsaaaarec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaaaarec -Count 
        Get the number of dnsaaaarec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaaaarec -name <string>
        Get dnsaaaarec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaaaarec -Filter @{ 'name'='<value>' }
        Get dnsaaaarec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsaaaarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
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
        [string]$Hostname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv6address,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsaaaarec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaaaarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaaaarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaaaarec objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('hostname') ) { $arguments.Add('hostname', $hostname) } 
                if ( $PSBoundParameters.ContainsKey('ipv6address') ) { $arguments.Add('ipv6address', $ipv6address) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaaaarec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsaaaarec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsaaaarec: Ended"
    }
}

function Invoke-ADCAddDnsaction {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Actiontype 
        The type of DNS action that is being configured. 
        Possible values = ViewName, GslbPrefLoc, noop, Drop, Cache_Bypass, Rewrite_Response 
    .PARAMETER Ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type. 
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
    .PARAMETER Viewname 
        The view name that must be used for the given action. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given action. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen. 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsaction -actionname <string> -actiontype <string>
        An example how to add dnsaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [Parameter(Mandatory)]
        [ValidateSet('ViewName', 'GslbPrefLoc', 'noop', 'Drop', 'Cache_Bypass', 'Rewrite_Response')]
        [string]$Actiontype,

        [string[]]$Ipaddress,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [string]$Viewname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname
                actiontype           = $actiontype
            }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsaction", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsaction -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsaction: Finished"
    }
}

function Invoke-ADCDeleteDnsaction {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsaction -Actionname <string>
        An example how to delete dnsaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsaction: Finished"
    }
}

function Invoke-ADCUpdateDnsaction {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type. 
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
    .PARAMETER Viewname 
        The view name that must be used for the given action. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given action. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen. 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsaction -actionname <string>
        An example how to update dnsaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [string[]]$Ipaddress,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl,

        [string]$Viewname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsaction", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsaction -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsaction: Finished"
    }
}

function Invoke-ADCUnsetDnsaction {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER Ttl 
        Time to live, in seconds. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsaction -actionname <string>
        An example how to unset dnsaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Actionname,

        [Boolean]$ttl,

        [Boolean]$dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsaction: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsaction: Finished"
    }
}

function Invoke-ADCGetDnsaction {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS action resource.
    .PARAMETER Actionname 
        Name of the dns action. 
    .PARAMETER GetAll 
        Retrieve all dnsaction object(s).
    .PARAMETER Count
        If specified, the count of the dnsaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaction -GetAll 
        Get all dnsaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaction -Count 
        Get the number of dnsaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction -name <string>
        Get dnsaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction -Filter @{ 'name'='<value>' }
        Get dnsaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
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
        [string]$Actionname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction configuration for property 'actionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsaction: Ended"
    }
}

function Invoke-ADCAddDnsaction64 {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsaction64 -actionname <string> -prefix <string>
        An example how to add dnsaction64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsaction64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [Parameter(Mandatory)]
        [string]$Prefix,

        [string]$Mappedrule,

        [string]$Excluderule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname
                prefix               = $prefix
            }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("dnsaction64", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaction64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsaction64 -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsaction64: Finished"
    }
}

function Invoke-ADCDeleteDnsaction64 {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsaction64 -Actionname <string>
        An example how to delete dnsaction64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsaction64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaction64: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsaction64: Finished"
    }
}

function Invoke-ADCUpdateDnsaction64 {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsaction64 -actionname <string>
        An example how to update dnsaction64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsaction64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Actionname,

        [string]$Prefix,

        [string]$Mappedrule,

        [string]$Excluderule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('prefix') ) { $payload.Add('prefix', $prefix) }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("dnsaction64", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsaction64 -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsaction64: Finished"
    }
}

function Invoke-ADCUnsetDnsaction64 {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER Prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER Mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis. 
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix, 
        otherwise the A RR is discarded. 
    .PARAMETER Excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsaction64 -actionname <string>
        An example how to unset dnsaction64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsaction64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Actionname,

        [Boolean]$prefix,

        [Boolean]$mappedrule,

        [Boolean]$excluderule 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsaction64: Starting"
    }
    process {
        try {
            $payload = @{ actionname = $actionname }
            if ( $PSBoundParameters.ContainsKey('prefix') ) { $payload.Add('prefix', $prefix) }
            if ( $PSBoundParameters.ContainsKey('mappedrule') ) { $payload.Add('mappedrule', $mappedrule) }
            if ( $PSBoundParameters.ContainsKey('excluderule') ) { $payload.Add('excluderule', $excluderule) }
            if ( $PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsaction64 -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsaction64: Finished"
    }
}

function Invoke-ADCGetDnsaction64 {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for dns64 action resource.
    .PARAMETER Actionname 
        Name of the dns64 action. 
    .PARAMETER GetAll 
        Retrieve all dnsaction64 object(s).
    .PARAMETER Count
        If specified, the count of the dnsaction64 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction64
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaction64 -GetAll 
        Get all dnsaction64 data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaction64 -Count 
        Get the number of dnsaction64 objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction64 -name <string>
        Get dnsaction64 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaction64 -Filter @{ 'name'='<value>' }
        Get dnsaction64 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsaction64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
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
        [string]$Actionname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsaction64: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaction64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction64 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction64 configuration for property 'actionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction64 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsaction64: Ended"
    }
}

function Invoke-ADCAddDnsaddrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ipaddress 
        One or more IPv4 addresses to assign to the domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsaddrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsaddrec -hostname <string> -ipaddress <string>
        An example how to add dnsaddrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsaddrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Hostname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipaddress,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaddrec: Starting"
    }
    process {
        try {
            $payload = @{ hostname = $hostname
                ipaddress          = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsaddrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaddrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsaddrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsaddrec: Finished"
    }
}

function Invoke-ADCDeleteDnsaddrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached address records need to be removed. 
    .PARAMETER Ipaddress 
        One or more IPv4 addresses to assign to the domain name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsaddrec -Hostname <string>
        An example how to delete dnsaddrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsaddrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Hostname,

        [string]$Ecssubnet,

        [string]$Ipaddress 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaddrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Ipaddress') ) { $arguments.Add('ipaddress', $Ipaddress) }
            if ( $PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsaddrec: Finished"
    }
}

function Invoke-ADCGetDnsaddrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for address type record resource.
    .PARAMETER Hostname 
        Domain name. 
    .PARAMETER GetAll 
        Retrieve all dnsaddrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsaddrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaddrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaddrec -GetAll 
        Get all dnsaddrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsaddrec -Count 
        Get the number of dnsaddrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaddrec -name <string>
        Get dnsaddrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsaddrec -Filter @{ 'name'='<value>' }
        Get dnsaddrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsaddrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
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
        [string]$Hostname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsaddrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsaddrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaddrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaddrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaddrec configuration for property 'hostname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaddrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsaddrec: Ended"
    }
}

function Invoke-ADCAddDnscnamerec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER Canonicalname 
        Canonical domain name. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnscnamerec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnscnamerec -aliasname <string> -canonicalname <string>
        An example how to add dnscnamerec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnscnamerec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Aliasname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Canonicalname,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnscnamerec: Starting"
    }
    process {
        try {
            $payload = @{ aliasname = $aliasname
                canonicalname       = $canonicalname
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnscnamerec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnscnamerec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnscnamerec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnscnamerec: Finished"
    }
}

function Invoke-ADCDeleteDnscnamerec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached CNAME record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnscnamerec -Aliasname <string>
        An example how to delete dnscnamerec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnscnamerec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Aliasname,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnscnamerec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$aliasname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnscnamerec: Finished"
    }
}

function Invoke-ADCGetDnscnamerec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for CNAME record resource.
    .PARAMETER Aliasname 
        Alias for the canonical domain name. 
    .PARAMETER GetAll 
        Retrieve all dnscnamerec object(s).
    .PARAMETER Count
        If specified, the count of the dnscnamerec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnscnamerec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnscnamerec -GetAll 
        Get all dnscnamerec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnscnamerec -Count 
        Get the number of dnscnamerec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnscnamerec -name <string>
        Get dnscnamerec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnscnamerec -Filter @{ 'name'='<value>' }
        Get dnscnamerec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnscnamerec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
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
        [string]$Aliasname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnscnamerec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnscnamerec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnscnamerec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnscnamerec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnscnamerec configuration for property 'aliasname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnscnamerec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnscnamerec: Ended"
    }
}

function Invoke-ADCGetDnsglobalbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnsglobal.
    .PARAMETER GetAll 
        Retrieve all dnsglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsglobalbinding -GetAll 
        Get all dnsglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobalbinding -name <string>
        Get dnsglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobalbinding -Filter @{ 'name'='<value>' }
        Get dnsglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsglobalbinding: Ended"
    }
}

function Invoke-ADCAddDnsglobaldnspolicybinding {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER Policyname 
        Name of the dns policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy with which it is bound. Maximum allowed priority should be less than 65535. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Type 
        Type of global bind point for which to show bound policies. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnsglobal_dnspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsglobaldnspolicybinding -policyname <string> -priority <double>
        An example how to add dnsglobal_dnspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsglobaldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsglobaldnspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsglobal_dnspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsglobaldnspolicybinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsglobaldnspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteDnsglobaldnspolicybinding {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER Policyname 
        Name of the dns policy. 
    .PARAMETER Type 
        Type of global bind point for which to show bound policies. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsglobaldnspolicybinding 
        An example how to delete dnsglobal_dnspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsglobaldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Policyname,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsglobaldnspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsglobaldnspolicybinding: Finished"
    }
}

function Invoke-ADCGetDnsglobaldnspolicybinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsglobal.
    .PARAMETER GetAll 
        Retrieve all dnsglobal_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsglobal_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobaldnspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsglobaldnspolicybinding -GetAll 
        Get all dnsglobal_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsglobaldnspolicybinding -Count 
        Get the number of dnsglobal_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobaldnspolicybinding -name <string>
        Get dnsglobal_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsglobaldnspolicybinding -Filter @{ 'name'='<value>' }
        Get dnsglobal_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsglobaldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsglobaldnspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsglobal_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsglobaldnspolicybinding: Ended"
    }
}

function Invoke-ADCAddDnskey {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Publickey 
        File name of the public key. 
    .PARAMETER Privatekey 
        File name of the private key. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
    .PARAMETER Units1 
        Units for the expiry period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
    .PARAMETER Units2 
        Units for the notification period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used. 
    .PARAMETER Password 
        Passphrase for reading the encrypted public/private DNS keys. 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnskey -keyname <string> -publickey <string> -privatekey <string>
        An example how to add dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Keyname,

        [Parameter(Mandatory)]
        [string]$Publickey,

        [Parameter(Mandatory)]
        [string]$Privatekey,

        [ValidateRange(1, 32767)]
        [double]$Expires = '120',

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units1 = 'DAYS',

        [ValidateRange(1, 32767)]
        [double]$Notificationperiod = '7',

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units2 = 'DAYS',

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname
                publickey         = $publickey
                privatekey        = $privatekey
            }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("dnskey", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnskey -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnskey: Finished"
    }
}

function Invoke-ADCCreateDnskey {
    <#
    .SYNOPSIS
        Create Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Zonename 
        Name of the zone for which to create a key. 
    .PARAMETER Keytype 
        Type of key to create. 
        Possible values = KSK, KeySigningKey, ZSK, ZoneSigningKey 
    .PARAMETER Algorithm 
        Algorithm to generate for zone signing. 
        Possible values = RSASHA1, RSASHA256, RSASHA512 
    .PARAMETER Keysize 
        Size of the key, in bits. 
    .PARAMETER Filenameprefix 
        Common prefix for the names of the generated public and private key files and the Delegation Signer (DS) resource record. During key generation, the .key, .private, and .ds suffixes are appended automatically to the file name prefix to produce the names of the public key, the private key, and the DS record, respectively. 
    .PARAMETER Password 
        Passphrase for reading the encrypted public/private DNS keys.
    .EXAMPLE
        PS C:\>Invoke-ADCCreateDnskey -zonename <string> -keytype <string> -algorithm <string> -keysize <double> -filenameprefix <string>
        An example how to create dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCreateDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [Parameter(Mandatory)]
        [ValidateSet('KSK', 'KeySigningKey', 'ZSK', 'ZoneSigningKey')]
        [string]$Keytype,

        [Parameter(Mandatory)]
        [ValidateSet('RSASHA1', 'RSASHA256', 'RSASHA512')]
        [string]$Algorithm,

        [Parameter(Mandatory)]
        [ValidateRange(1, 4096)]
        [double]$Keysize,

        [Parameter(Mandatory)]
        [string]$Filenameprefix,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateDnskey: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename
                keytype            = $keytype
                algorithm          = $algorithm
                keysize            = $keysize
                filenameprefix     = $filenameprefix
            }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess($Name, "Create Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action create -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCCreateDnskey: Finished"
    }
}

function Invoke-ADCUpdateDnskey {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
    .PARAMETER Units1 
        Units for the expiry period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
    .PARAMETER Units2 
        Units for the notification period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used. 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnskey -keyname <string>
        An example how to update dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Keyname,

        [ValidateRange(1, 32767)]
        [double]$Expires,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units1,

        [ValidateRange(1, 32767)]
        [double]$Notificationperiod,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$Units2,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnskey", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnskey -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnskey -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnskey: Finished"
    }
}

function Invoke-ADCUnsetDnskey {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Expires 
        Time period for which to consider the key valid, after the key is used to sign a zone. 
    .PARAMETER Units1 
        Units for the expiry period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
    .PARAMETER Units2 
        Units for the notification period. 
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnskey -keyname <string>
        An example how to unset dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Keyname,

        [Boolean]$expires,

        [Boolean]$units1,

        [Boolean]$notificationperiod,

        [Boolean]$units2,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname }
            if ( $PSBoundParameters.ContainsKey('expires') ) { $payload.Add('expires', $expires) }
            if ( $PSBoundParameters.ContainsKey('units1') ) { $payload.Add('units1', $units1) }
            if ( $PSBoundParameters.ContainsKey('notificationperiod') ) { $payload.Add('notificationperiod', $notificationperiod) }
            if ( $PSBoundParameters.ContainsKey('units2') ) { $payload.Add('units2', $units2) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$keyname", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnskey -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnskey: Finished"
    }
}

function Invoke-ADCDeleteDnskey {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnskey -Keyname <string>
        An example how to delete dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Keyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnskey: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$keyname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnskey: Finished"
    }
}

function Invoke-ADCImportDnskey {
    <#
    .SYNOPSIS
        Import Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER Src 
        URL (protocol, host, path, and file name) from where the DNS key file will be imported. NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. This is a mandatory argument.
    .EXAMPLE
        PS C:\>Invoke-ADCImportDnskey -keyname <string> -src <string>
        An example how to import dnskey configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Keyname,

        [Parameter(Mandatory)]
        [ValidateLength(1, 2047)]
        [string]$Src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportDnskey: Starting"
    }
    process {
        try {
            $payload = @{ keyname = $keyname
                src               = $src
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Import Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action import -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCImportDnskey: Finished"
    }
}

function Invoke-ADCGetDnskey {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for dns key resource.
    .PARAMETER Keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER GetAll 
        Retrieve all dnskey object(s).
    .PARAMETER Count
        If specified, the count of the dnskey object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnskey
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnskey -GetAll 
        Get all dnskey data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnskey -Count 
        Get the number of dnskey objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnskey -name <string>
        Get dnskey object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnskey -Filter @{ 'name'='<value>' }
        Get dnskey data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnskey
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
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
        [string]$Keyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnskey: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnskey objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnskey configuration for property 'keyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnskey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnskey: Ended"
    }
}

function Invoke-ADCAddDnsmxrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsmxrec -domain <string> -mx <string> -pref <double>
        An example how to add dnsmxrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsmxrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Pref,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
                pref             = $pref
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsmxrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsmxrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsmxrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsmxrec: Finished"
    }
}

function Invoke-ADCDeleteDnsmxrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached MX record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsmxrec -Domain <string>
        An example how to delete dnsmxrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsmxrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Mx,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsmxrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Mx') ) { $arguments.Add('mx', $Mx) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsmxrec: Finished"
    }
}

function Invoke-ADCUpdateDnsmxrec {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsmxrec -domain <string> -mx <string>
        An example how to update dnsmxrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsmxrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [ValidateRange(0, 65535)]
        [double]$Pref,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
            }
            if ( $PSBoundParameters.ContainsKey('pref') ) { $payload.Add('pref', $pref) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsmxrec", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsmxrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsmxrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsmxrec: Finished"
    }
}

function Invoke-ADCUnsetDnsmxrec {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER Mx 
        Host name of the mail exchange server. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsmxrec -domain <string> -mx <string>
        An example how to unset dnsmxrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsmxrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Mx,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsmxrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                mx               = $mx
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain mx", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsmxrec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsmxrec: Finished"
    }
}

function Invoke-ADCGetDnsmxrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for MX record resource.
    .PARAMETER Domain 
        Domain name for which to add the MX record. 
    .PARAMETER GetAll 
        Retrieve all dnsmxrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsmxrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsmxrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsmxrec -GetAll 
        Get all dnsmxrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsmxrec -Count 
        Get the number of dnsmxrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsmxrec -name <string>
        Get dnsmxrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsmxrec -Filter @{ 'name'='<value>' }
        Get dnsmxrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsmxrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsmxrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsmxrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsmxrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsmxrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsmxrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsmxrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsmxrec: Ended"
    }
}

function Invoke-ADCAddDnsnameserver {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Local 
        Mark the IP address as one that belongs to a local recursive DNS server on the Citrix ADC. The appliance recursively resolves queries received on an IP address that is marked as being local. For recursive resolution to work, the global DNS parameter, Recursion, must also be set. 
        If no name server is marked as being local, the appliance functions as a stub resolver and load balances the name servers. 
    .PARAMETER State 
        Administrative state of the name server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsnameserver 
        An example how to add dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [boolean]$Local,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type = 'UDP',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('local') ) { $payload.Add('local', $local) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSCmdlet.ShouldProcess("dnsnameserver", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsnameserver: Finished"
    }
}

function Invoke-ADCUpdateDnsnameserver {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsnameserver -ip <string>
        An example how to update dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsprofilename,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("dnsnameserver", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsnameserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsnameserver: Finished"
    }
}

function Invoke-ADCUnsetDnsnameserver {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the name server. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsnameserver -ip <string>
        An example how to unset dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [Boolean]$dnsprofilename,

        [Boolean]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ ip = $ip }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsnameserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsnameserver: Finished"
    }
}

function Invoke-ADCDeleteDnsnameserver {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsnameserver -Ip <string>
        An example how to delete dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Ip,

        [string]$Dnsvservername,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnameserver: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Dnsvservername') ) { $arguments.Add('dnsvservername', $Dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$ip", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnameserver -NitroPath nitro/v1/config -Resource $ip -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsnameserver: Finished"
    }
}

function Invoke-ADCEnableDnsnameserver {
    <#
    .SYNOPSIS
        Enable Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-ADCEnableDnsnameserver 
        An example how to enable dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action enable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCEnableDnsnameserver: Finished"
    }
}

function Invoke-ADCDisableDnsnameserver {
    <#
    .SYNOPSIS
        Disable Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER Ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER Dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER Type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance. 
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        PS C:\>Invoke-ADCDisableDnsnameserver 
        An example how to disable dnsnameserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$Type 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableDnsnameserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action disable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDisableDnsnameserver: Finished"
    }
}

function Invoke-ADCGetDnsnameserver {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for name server resource.
    .PARAMETER GetAll 
        Retrieve all dnsnameserver object(s).
    .PARAMETER Count
        If specified, the count of the dnsnameserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnameserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnameserver -GetAll 
        Get all dnsnameserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnameserver -Count 
        Get the number of dnsnameserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnameserver -name <string>
        Get dnsnameserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnameserver -Filter @{ 'name'='<value>' }
        Get dnsnameserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsnameserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsnameserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnameserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnameserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnameserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnameserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsnameserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsnameserver: Ended"
    }
}

function Invoke-ADCAddDnsnaptrrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER Order 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
    .PARAMETER Preference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
    .PARAMETER Flags 
        flags for this NAPTR. 
    .PARAMETER Services 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Regexp 
        The regular expression, that specifies the substitution expression for this NAPTR. 
    .PARAMETER Replacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsnaptrrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsnaptrrec -domain <string> -order <double> -preference <double>
        An example how to add dnsnaptrrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsnaptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Order,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Preference,

        [string]$Flags,

        [string]$Services,

        [string]$Regexp,

        [string]$Replacement,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnaptrrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                order            = $order
                preference       = $preference
            }
            if ( $PSBoundParameters.ContainsKey('flags') ) { $payload.Add('flags', $flags) }
            if ( $PSBoundParameters.ContainsKey('services') ) { $payload.Add('services', $services) }
            if ( $PSBoundParameters.ContainsKey('regexp') ) { $payload.Add('regexp', $regexp) }
            if ( $PSBoundParameters.ContainsKey('replacement') ) { $payload.Add('replacement', $replacement) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsnaptrrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnaptrrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsnaptrrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsnaptrrec: Finished"
    }
}

function Invoke-ADCDeleteDnsnaptrrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER Order 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
    .PARAMETER Recordid 
        Unique, internally generated record ID. View the details of the naptr record to obtain its record ID. Records can be removed by either specifying the domain name and record id OR by specifying 
        domain name and all other naptr record attributes as was supplied during the add command. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached NAPTR record need to be removed. 
    .PARAMETER Preference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
    .PARAMETER Flags 
        flags for this NAPTR. 
    .PARAMETER Services 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Regexp 
        The regular expression, that specifies the substitution expression for this NAPTR. 
    .PARAMETER Replacement 
        The replacement domain name for this NAPTR.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsnaptrrec -Domain <string>
        An example how to delete dnsnaptrrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsnaptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [double]$Order,

        [double]$Recordid,

        [string]$Ecssubnet,

        [double]$Preference,

        [string]$Flags,

        [string]$Services,

        [string]$Regexp,

        [string]$Replacement 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnaptrrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Order') ) { $arguments.Add('order', $Order) }
            if ( $PSBoundParameters.ContainsKey('Recordid') ) { $arguments.Add('recordid', $Recordid) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Preference') ) { $arguments.Add('preference', $Preference) }
            if ( $PSBoundParameters.ContainsKey('Flags') ) { $arguments.Add('flags', $Flags) }
            if ( $PSBoundParameters.ContainsKey('Services') ) { $arguments.Add('services', $Services) }
            if ( $PSBoundParameters.ContainsKey('Regexp') ) { $arguments.Add('regexp', $Regexp) }
            if ( $PSBoundParameters.ContainsKey('Replacement') ) { $arguments.Add('replacement', $Replacement) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsnaptrrec: Finished"
    }
}

function Invoke-ADCGetDnsnaptrrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for NAPTR record resource.
    .PARAMETER Domain 
        Name of the domain for the NAPTR record. 
    .PARAMETER GetAll 
        Retrieve all dnsnaptrrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnaptrrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnaptrrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnaptrrec -GetAll 
        Get all dnsnaptrrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnaptrrec -Count 
        Get the number of dnsnaptrrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnaptrrec -name <string>
        Get dnsnaptrrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnaptrrec -Filter @{ 'name'='<value>' }
        Get dnsnaptrrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsnaptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsnaptrrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnaptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnaptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnaptrrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnaptrrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnaptrrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsnaptrrec: Ended"
    }
}

function Invoke-ADCGetDnsnsecrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for 0 resource.
    .PARAMETER Hostname 
        Name of the domain. 
    .PARAMETER GetAll 
        Retrieve all dnsnsecrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnsecrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsecrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnsecrec -GetAll 
        Get all dnsnsecrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnsecrec -Count 
        Get the number of dnsnsecrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsecrec -name <string>
        Get dnsnsecrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsecrec -Filter @{ 'name'='<value>' }
        Get dnsnsecrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsnsecrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsecrec/
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
        [string]$Hostname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsnsecrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnsecrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsecrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsecrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsecrec configuration for property 'hostname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsecrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsnsecrec: Ended"
    }
}

function Invoke-ADCAddDnsnsrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER Nameserver 
        Host name of the name server to add to the domain. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsnsrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsnsrec -domain <string> -nameserver <string>
        An example how to add dnsnsrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsnsrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Nameserver,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnsrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                nameserver       = $nameserver
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsnsrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnsrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsnsrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsnsrec: Finished"
    }
}

function Invoke-ADCDeleteDnsnsrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER Nameserver 
        Host name of the name server to add to the domain. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached name server record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsnsrec -Domain <string>
        An example how to delete dnsnsrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsnsrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Nameserver,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnsrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Nameserver') ) { $arguments.Add('nameserver', $Nameserver) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsnsrec: Finished"
    }
}

function Invoke-ADCGetDnsnsrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for name server record resource.
    .PARAMETER Domain 
        Domain name. 
    .PARAMETER GetAll 
        Retrieve all dnsnsrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsnsrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnsrec -GetAll 
        Get all dnsnsrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsnsrec -Count 
        Get the number of dnsnsrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsrec -name <string>
        Get dnsnsrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsnsrec -Filter @{ 'name'='<value>' }
        Get dnsnsrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsnsrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsnsrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsnsrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsnsrec: Ended"
    }
}

function Invoke-ADCUpdateDnsparameter {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER Retries 
        Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations. 
    .PARAMETER Minttl 
        Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Maxttl 
        Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
        Possible values = YES, NO 
    .PARAMETER Namelookuppriority 
        Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature. 
        Possible values = WINS, DNS 
    .PARAMETER Recursion 
        Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Resolutionorder 
        Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows: 
        * OnlyAQuery. Send queries for IPv4 address records (A records) only. 
        * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records). 
        * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server. 
        * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server. 
        Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
    .PARAMETER Dnssec 
        Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxpipeline 
        Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
    .PARAMETER Dnsrootreferral 
        Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64timeout 
        While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query. 
    .PARAMETER Ecsmaxsubnets 
        Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero. 
    .PARAMETER Maxnegcachettl 
        Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Cachehitbypass 
        This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxcachesize 
        Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
    .PARAMETER Maxnegativecachesize 
        Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
    .PARAMETER Cachenoexpire 
        If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Splitpktqueryprocessing 
        Processing requests split across multiple packets. 
        Possible values = ALLOW, DROP 
    .PARAMETER Cacheecszeroprefix 
        Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxudppacketsize 
        Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced. 
    .PARAMETER Nxdomainratelimitthreshold 
        Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached, DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsparameter 
        An example how to update dnsparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateRange(1, 5)]
        [double]$Retries,

        [ValidateRange(0, 604800)]
        [double]$Minttl,

        [ValidateRange(1, 604800)]
        [double]$Maxttl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacherecords,

        [ValidateSet('WINS', 'DNS')]
        [string]$Namelookuppriority,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Recursion,

        [ValidateSet('OnlyAQuery', 'OnlyAAAAQuery', 'AThenAAAAQuery', 'AAAAThenAQuery')]
        [string]$Resolutionorder,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssec,

        [double]$Maxpipeline,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsrootreferral,

        [ValidateRange(0, 10000)]
        [double]$Dns64timeout,

        [ValidateRange(0, 1280)]
        [double]$Ecsmaxsubnets,

        [ValidateRange(1, 604800)]
        [double]$Maxnegcachettl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachehitbypass,

        [double]$Maxcachesize,

        [double]$Maxnegativecachesize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenoexpire,

        [ValidateSet('ALLOW', 'DROP')]
        [string]$Splitpktqueryprocessing,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecszeroprefix,

        [ValidateRange(512, 16384)]
        [double]$Maxudppacketsize,

        [double]$Nxdomainratelimitthreshold 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('minttl') ) { $payload.Add('minttl', $minttl) }
            if ( $PSBoundParameters.ContainsKey('maxttl') ) { $payload.Add('maxttl', $maxttl) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('namelookuppriority') ) { $payload.Add('namelookuppriority', $namelookuppriority) }
            if ( $PSBoundParameters.ContainsKey('recursion') ) { $payload.Add('recursion', $recursion) }
            if ( $PSBoundParameters.ContainsKey('resolutionorder') ) { $payload.Add('resolutionorder', $resolutionorder) }
            if ( $PSBoundParameters.ContainsKey('dnssec') ) { $payload.Add('dnssec', $dnssec) }
            if ( $PSBoundParameters.ContainsKey('maxpipeline') ) { $payload.Add('maxpipeline', $maxpipeline) }
            if ( $PSBoundParameters.ContainsKey('dnsrootreferral') ) { $payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ( $PSBoundParameters.ContainsKey('dns64timeout') ) { $payload.Add('dns64timeout', $dns64timeout) }
            if ( $PSBoundParameters.ContainsKey('ecsmaxsubnets') ) { $payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ( $PSBoundParameters.ContainsKey('maxnegcachettl') ) { $payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ( $PSBoundParameters.ContainsKey('cachehitbypass') ) { $payload.Add('cachehitbypass', $cachehitbypass) }
            if ( $PSBoundParameters.ContainsKey('maxcachesize') ) { $payload.Add('maxcachesize', $maxcachesize) }
            if ( $PSBoundParameters.ContainsKey('maxnegativecachesize') ) { $payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ( $PSBoundParameters.ContainsKey('cachenoexpire') ) { $payload.Add('cachenoexpire', $cachenoexpire) }
            if ( $PSBoundParameters.ContainsKey('splitpktqueryprocessing') ) { $payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ( $PSBoundParameters.ContainsKey('cacheecszeroprefix') ) { $payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ( $PSBoundParameters.ContainsKey('maxudppacketsize') ) { $payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ( $PSBoundParameters.ContainsKey('nxdomainratelimitthreshold') ) { $payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
            if ( $PSCmdlet.ShouldProcess("dnsparameter", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsparameter -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsparameter: Finished"
    }
}

function Invoke-ADCUnsetDnsparameter {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER Retries 
        Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations. 
    .PARAMETER Minttl 
        Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Maxttl 
        Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
        Possible values = YES, NO 
    .PARAMETER Namelookuppriority 
        Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature. 
        Possible values = WINS, DNS 
    .PARAMETER Recursion 
        Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Resolutionorder 
        Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows: 
        * OnlyAQuery. Send queries for IPv4 address records (A records) only. 
        * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records). 
        * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server. 
        * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server. 
        Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
    .PARAMETER Dnssec 
        Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxpipeline 
        Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
    .PARAMETER Dnsrootreferral 
        Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns64timeout 
        While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query. 
    .PARAMETER Ecsmaxsubnets 
        Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero. 
    .PARAMETER Maxnegcachettl 
        Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
    .PARAMETER Cachehitbypass 
        This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxcachesize 
        Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
    .PARAMETER Maxnegativecachesize 
        Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
    .PARAMETER Cachenoexpire 
        If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Splitpktqueryprocessing 
        Processing requests split across multiple packets. 
        Possible values = ALLOW, DROP 
    .PARAMETER Cacheecszeroprefix 
        Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxudppacketsize 
        Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced. 
    .PARAMETER Nxdomainratelimitthreshold 
        Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached, DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsparameter 
        An example how to unset dnsparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Boolean]$retries,

        [Boolean]$minttl,

        [Boolean]$maxttl,

        [Boolean]$cacherecords,

        [Boolean]$namelookuppriority,

        [Boolean]$recursion,

        [Boolean]$resolutionorder,

        [Boolean]$dnssec,

        [Boolean]$maxpipeline,

        [Boolean]$dnsrootreferral,

        [Boolean]$dns64timeout,

        [Boolean]$ecsmaxsubnets,

        [Boolean]$maxnegcachettl,

        [Boolean]$cachehitbypass,

        [Boolean]$maxcachesize,

        [Boolean]$maxnegativecachesize,

        [Boolean]$cachenoexpire,

        [Boolean]$splitpktqueryprocessing,

        [Boolean]$cacheecszeroprefix,

        [Boolean]$maxudppacketsize,

        [Boolean]$nxdomainratelimitthreshold 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('retries') ) { $payload.Add('retries', $retries) }
            if ( $PSBoundParameters.ContainsKey('minttl') ) { $payload.Add('minttl', $minttl) }
            if ( $PSBoundParameters.ContainsKey('maxttl') ) { $payload.Add('maxttl', $maxttl) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('namelookuppriority') ) { $payload.Add('namelookuppriority', $namelookuppriority) }
            if ( $PSBoundParameters.ContainsKey('recursion') ) { $payload.Add('recursion', $recursion) }
            if ( $PSBoundParameters.ContainsKey('resolutionorder') ) { $payload.Add('resolutionorder', $resolutionorder) }
            if ( $PSBoundParameters.ContainsKey('dnssec') ) { $payload.Add('dnssec', $dnssec) }
            if ( $PSBoundParameters.ContainsKey('maxpipeline') ) { $payload.Add('maxpipeline', $maxpipeline) }
            if ( $PSBoundParameters.ContainsKey('dnsrootreferral') ) { $payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ( $PSBoundParameters.ContainsKey('dns64timeout') ) { $payload.Add('dns64timeout', $dns64timeout) }
            if ( $PSBoundParameters.ContainsKey('ecsmaxsubnets') ) { $payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ( $PSBoundParameters.ContainsKey('maxnegcachettl') ) { $payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ( $PSBoundParameters.ContainsKey('cachehitbypass') ) { $payload.Add('cachehitbypass', $cachehitbypass) }
            if ( $PSBoundParameters.ContainsKey('maxcachesize') ) { $payload.Add('maxcachesize', $maxcachesize) }
            if ( $PSBoundParameters.ContainsKey('maxnegativecachesize') ) { $payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ( $PSBoundParameters.ContainsKey('cachenoexpire') ) { $payload.Add('cachenoexpire', $cachenoexpire) }
            if ( $PSBoundParameters.ContainsKey('splitpktqueryprocessing') ) { $payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ( $PSBoundParameters.ContainsKey('cacheecszeroprefix') ) { $payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ( $PSBoundParameters.ContainsKey('maxudppacketsize') ) { $payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ( $PSBoundParameters.ContainsKey('nxdomainratelimitthreshold') ) { $payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
            if ( $PSCmdlet.ShouldProcess("dnsparameter", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsparameter: Finished"
    }
}

function Invoke-ADCGetDnsparameter {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS parameter resource.
    .PARAMETER GetAll 
        Retrieve all dnsparameter object(s).
    .PARAMETER Count
        If specified, the count of the dnsparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsparameter -GetAll 
        Get all dnsparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsparameter -name <string>
        Get dnsparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsparameter -Filter @{ 'name'='<value>' }
        Get dnsparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsparameter: Ended"
    }
}

function Invoke-ADCAddDnspolicy {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER Viewname 
        The view name that must be used for the given policy. 
    .PARAMETER Preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given policy. 
    .PARAMETER Drop 
        The dns packet must be dropped. 
        Possible values = YES, NO 
    .PARAMETER Cachebypass 
        By pass dns cache for this. 
        Possible values = YES, NO 
    .PARAMETER Actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * dns_default_act_Drop. Drop the DNS request. 
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server. 
        You can create custom actions by using the add dns action command in the CLI or the DNS > Actions > Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnspolicy -name <string> -rule <string>
        An example how to add dnspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Rule,

        [string]$Viewname,

        [string]$Preferredlocation,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateSet('YES', 'NO')]
        [string]$Drop,

        [ValidateSet('YES', 'NO')]
        [string]$Cachebypass,

        [string]$Actionname,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredlocation') ) { $payload.Add('preferredlocation', $preferredlocation) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('drop') ) { $payload.Add('drop', $drop) }
            if ( $PSBoundParameters.ContainsKey('cachebypass') ) { $payload.Add('cachebypass', $cachebypass) }
            if ( $PSBoundParameters.ContainsKey('actionname') ) { $payload.Add('actionname', $actionname) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicy -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnspolicy: Finished"
    }
}

function Invoke-ADCDeleteDnspolicy {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnspolicy -Name <string>
        An example how to delete dnspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnspolicy: Finished"
    }
}

function Invoke-ADCUpdateDnspolicy {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER Viewname 
        The view name that must be used for the given policy. 
    .PARAMETER Preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER Preferredloclist 
        The location list in priority order used for the given policy. 
    .PARAMETER Drop 
        The dns packet must be dropped. 
        Possible values = YES, NO 
    .PARAMETER Cachebypass 
        By pass dns cache for this. 
        Possible values = YES, NO 
    .PARAMETER Actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * dns_default_act_Drop. Drop the DNS request. 
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server. 
        You can create custom actions by using the add dns action command in the CLI or the DNS > Actions > Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnspolicy -name <string>
        An example how to update dnspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Rule,

        [string]$Viewname,

        [string]$Preferredlocation,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Preferredloclist,

        [ValidateSet('YES', 'NO')]
        [string]$Drop,

        [ValidateSet('YES', 'NO')]
        [string]$Cachebypass,

        [string]$Actionname,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('preferredlocation') ) { $payload.Add('preferredlocation', $preferredlocation) }
            if ( $PSBoundParameters.ContainsKey('preferredloclist') ) { $payload.Add('preferredloclist', $preferredloclist) }
            if ( $PSBoundParameters.ContainsKey('drop') ) { $payload.Add('drop', $drop) }
            if ( $PSBoundParameters.ContainsKey('cachebypass') ) { $payload.Add('cachebypass', $cachebypass) }
            if ( $PSBoundParameters.ContainsKey('actionname') ) { $payload.Add('actionname', $actionname) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicy -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnspolicy: Finished"
    }
}

function Invoke-ADCUnsetDnspolicy {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnspolicy -name <string>
        An example how to unset dnspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Name,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnspolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnspolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnspolicy: Finished"
    }
}

function Invoke-ADCGetDnspolicy {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS policy resource.
    .PARAMETER Name 
        Name for the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy -GetAll 
        Get all dnspolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy -Count 
        Get the number of dnspolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy -name <string>
        Get dnspolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy -Filter @{ 'name'='<value>' }
        Get dnspolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicy: Ended"
    }
}

function Invoke-ADCAddDnspolicy64 {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER Action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * A default dns64 action with prefix <default prefix> and mapped and exclude are any 
        You can create custom actions by using the add dns action command in the CLI or the DNS64 > Actions > Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnspolicy64 -name <string> -rule <string>
        An example how to add dnspolicy64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnspolicy64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Rule,

        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicy64: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy64", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicy64 -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnspolicy64: Finished"
    }
}

function Invoke-ADCDeleteDnspolicy64 {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnspolicy64 -Name <string>
        An example how to delete dnspolicy64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicy64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicy64: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnspolicy64: Finished"
    }
}

function Invoke-ADCUpdateDnspolicy64 {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER Rule 
        Expression against which DNS traffic is evaluated. 
        Note: 
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER Action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows: 
        * A default dns64 action with prefix <default prefix> and mapped and exclude are any 
        You can create custom actions by using the add dns action command in the CLI or the DNS64 > Actions > Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnspolicy64 -name <string>
        An example how to update dnspolicy64 configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnspolicy64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Rule,

        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnspolicy64: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("dnspolicy64", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicy64 -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnspolicy64: Finished"
    }
}

function Invoke-ADCGetDnspolicy64 {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for dns64 policy resource.
    .PARAMETER Name 
        Name for the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64 object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64 object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy64 -GetAll 
        Get all dnspolicy64 data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy64 -Count 
        Get the number of dnspolicy64 objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64 -name <string>
        Get dnspolicy64 object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64 -Filter @{ 'name'='<value>' }
        Get dnspolicy64 data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicy64: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicy64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64 objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64 configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicy64: Ended"
    }
}

function Invoke-ADCGetDnspolicy64binding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicy64.
    .PARAMETER Name 
        Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy64binding -GetAll 
        Get all dnspolicy64_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64binding -name <string>
        Get dnspolicy64_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64binding -Filter @{ 'name'='<value>' }
        Get dnspolicy64_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicy64binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicy64binding: Ended"
    }
}

function Invoke-ADCGetDnspolicy64lbvserverbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to dnspolicy64.
    .PARAMETER Name 
        Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy64_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy64_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64lbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy64lbvserverbinding -GetAll 
        Get all dnspolicy64_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicy64lbvserverbinding -Count 
        Get the number of dnspolicy64_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64lbvserverbinding -name <string>
        Get dnspolicy64_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicy64lbvserverbinding -Filter @{ 'name'='<value>' }
        Get dnspolicy64_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64lbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64_lbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicy64lbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy64_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicy64lbvserverbinding: Ended"
    }
}

function Invoke-ADCAddDnspolicylabel {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Transform 
        The type of transformations allowed by the policies bound to the label. 
        Possible values = dns_req, dns_res 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnspolicylabel -labelname <string> -transform <string>
        An example how to add dnspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('dns_req', 'dns_res')]
        [string]$Transform,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                transform           = $transform
            }

            if ( $PSCmdlet.ShouldProcess("dnspolicylabel", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicylabel -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnspolicylabel: Finished"
    }
}

function Invoke-ADCDeleteDnspolicylabel {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnspolicylabel -Labelname <string>
        An example how to delete dnspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabel: Finished"
    }
}

function Invoke-ADCRenameDnspolicylabel {
    <#
    .SYNOPSIS
        Rename Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Newname 
        The new name of the dns policylabel. 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameDnspolicylabel -labelname <string> -newname <string>
        An example how to rename dnspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameDnspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameDnspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("dnspolicylabel", "Rename Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicylabel -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCRenameDnspolicylabel: Finished"
    }
}

function Invoke-ADCGetDnspolicylabel {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for dns policy label resource.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabel -GetAll 
        Get all dnspolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabel -Count 
        Get the number of dnspolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabel -name <string>
        Get dnspolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabel -Filter @{ 'name'='<value>' }
        Get dnspolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicylabel: Ended"
    }
}

function Invoke-ADCGetDnspolicylabelbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabelbinding -GetAll 
        Get all dnspolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelbinding -name <string>
        Get dnspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelbinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddDnspolicylabeldnspolicybinding {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Policyname 
        The dns policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel_dnspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnspolicylabeldnspolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add dnspolicylabel_dnspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnspolicylabeldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicylabeldnspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("dnspolicylabel_dnspolicy_binding", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicylabel_dnspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnspolicylabeldnspolicybinding -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnspolicylabeldnspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteDnspolicylabeldnspolicybinding {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER Policyname 
        The dns policy name. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnspolicylabeldnspolicybinding -Labelname <string>
        An example how to delete dnspolicylabel_dnspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicylabeldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Labelname,

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabeldnspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabeldnspolicybinding: Finished"
    }
}

function Invoke-ADCGetDnspolicylabeldnspolicybinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabeldnspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabeldnspolicybinding -GetAll 
        Get all dnspolicylabel_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabeldnspolicybinding -Count 
        Get the number of dnspolicylabel_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabeldnspolicybinding -name <string>
        Get dnspolicylabel_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabeldnspolicybinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabeldnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabeldnspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicylabeldnspolicybinding: Ended"
    }
}

function Invoke-ADCGetDnspolicylabelpolicybindingbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to dnspolicylabel.
    .PARAMETER Labelname 
        Name of the dns policy label. 
    .PARAMETER GetAll 
        Retrieve all dnspolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabelpolicybindingbinding -GetAll 
        Get all dnspolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicylabelpolicybindingbinding -Count 
        Get the number of dnspolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelpolicybindingbinding -name <string>
        Get dnspolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get dnspolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabelpolicybindingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_policybinding_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCGetDnspolicybinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicybinding -GetAll 
        Get all dnspolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicybinding -name <string>
        Get dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicybinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicybinding: Ended"
    }
}

function Invoke-ADCGetDnspolicydnsglobalbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnsglobal that can be bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_dnsglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnsglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnsglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicydnsglobalbinding -GetAll 
        Get all dnspolicy_dnsglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicydnsglobalbinding -Count 
        Get the number of dnspolicy_dnsglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnsglobalbinding -name <string>
        Get dnspolicy_dnsglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnsglobalbinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_dnsglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicydnsglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_dnsglobal_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicydnsglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicydnsglobalbinding: Ended"
    }
}

function Invoke-ADCGetDnspolicydnspolicylabelbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnspolicylabel that can be bound to dnspolicy.
    .PARAMETER Name 
        Name of the DNS policy. 
    .PARAMETER GetAll 
        Retrieve all dnspolicy_dnspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnspolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicydnspolicylabelbinding -GetAll 
        Get all dnspolicy_dnspolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnspolicydnspolicylabelbinding -Count 
        Get the number of dnspolicy_dnspolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnspolicylabelbinding -name <string>
        Get dnspolicy_dnspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnspolicydnspolicylabelbinding -Filter @{ 'name'='<value>' }
        Get dnspolicy_dnspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnspolicydnspolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_dnspolicylabel_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicydnspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnspolicydnspolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddDnsprofile {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsprofile -dnsprofilename <string>
        An example how to add dnsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsquerylogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsanswerseclogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsextendedlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnserrorlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacherecords = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenegativeresponses = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropmultiqueryrequest = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecsresponses = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("dnsprofile", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsprofile -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsprofile: Finished"
    }
}

function Invoke-ADCUpdateDnsprofile {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnsprofile -dnsprofilename <string>
        An example how to update dnsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnsprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsquerylogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsanswerseclogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnsextendedlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnserrorlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacherecords,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cachenegativeresponses,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropmultiqueryrequest,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheecsresponses,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("dnsprofile", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsprofile -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnsprofile: Finished"
    }
}

function Invoke-ADCUnsetDnsprofile {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER Dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags, DNS domain name and DNS query type will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnsprofile -dnsprofilename <string>
        An example how to unset dnsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnsprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Boolean]$dnsquerylogging,

        [Boolean]$dnsanswerseclogging,

        [Boolean]$dnsextendedlogging,

        [Boolean]$dnserrorlogging,

        [Boolean]$cacherecords,

        [Boolean]$cachenegativeresponses,

        [Boolean]$dropmultiqueryrequest,

        [Boolean]$cacheecsresponses 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsprofile: Starting"
    }
    process {
        try {
            $payload = @{ dnsprofilename = $dnsprofilename }
            if ( $PSBoundParameters.ContainsKey('dnsquerylogging') ) { $payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ( $PSBoundParameters.ContainsKey('dnsanswerseclogging') ) { $payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ( $PSBoundParameters.ContainsKey('dnsextendedlogging') ) { $payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ( $PSBoundParameters.ContainsKey('dnserrorlogging') ) { $payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ( $PSBoundParameters.ContainsKey('cacherecords') ) { $payload.Add('cacherecords', $cacherecords) }
            if ( $PSBoundParameters.ContainsKey('cachenegativeresponses') ) { $payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ( $PSBoundParameters.ContainsKey('dropmultiqueryrequest') ) { $payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ( $PSBoundParameters.ContainsKey('cacheecsresponses') ) { $payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ( $PSCmdlet.ShouldProcess("$dnsprofilename", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnsprofile: Finished"
    }
}

function Invoke-ADCDeleteDnsprofile {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsprofile -Dnsprofilename <string>
        An example how to delete dnsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$dnsprofilename", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsprofile: Finished"
    }
}

function Invoke-ADCGetDnsprofile {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS profile resource.
    .PARAMETER Dnsprofilename 
        Name of the DNS profile. 
    .PARAMETER GetAll 
        Retrieve all dnsprofile object(s).
    .PARAMETER Count
        If specified, the count of the dnsprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsprofile -GetAll 
        Get all dnsprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsprofile -Count 
        Get the number of dnsprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsprofile -name <string>
        Get dnsprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsprofile -Filter @{ 'name'='<value>' }
        Get dnsprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
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
        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsprofile configuration for property 'dnsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsprofile: Ended"
    }
}

function Invoke-ADCFlushDnsproxyrecords {
    <#
    .SYNOPSIS
        Flush Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for proxy record resource.
    .PARAMETER Type 
        Filter the DNS records to be flushed.e.g flush dns proxyRecords -type A will flush only the A records from the cache. . 
        Possible values = A, NS, CNAME, SOA, MX, AAAA, SRV, RRSIG, NSEC, DNSKEY, PTR, TXT, NAPTR 
    .PARAMETER Negrectype 
        Filter the Negative DNS records i.e NXDOMAIN and NODATA entries to be flushed. e.g flush dns proxyRecords NXDOMAIN will flush only the NXDOMAIN entries from the cache. 
        Possible values = NXDOMAIN, NODATA
    .EXAMPLE
        PS C:\>Invoke-ADCFlushDnsproxyrecords 
        An example how to flush dnsproxyrecords configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushDnsproxyrecords
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsproxyrecords/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateSet('A', 'NS', 'CNAME', 'SOA', 'MX', 'AAAA', 'SRV', 'RRSIG', 'NSEC', 'DNSKEY', 'PTR', 'TXT', 'NAPTR')]
        [string]$Type,

        [ValidateSet('NXDOMAIN', 'NODATA')]
        [string]$Negrectype 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushDnsproxyrecords: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('negrectype') ) { $payload.Add('negrectype', $negrectype) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsproxyrecords -Action flush -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCFlushDnsproxyrecords: Finished"
    }
}

function Invoke-ADCAddDnsptrrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER Domain 
        Domain name for which to configure reverse mapping. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnsptrrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsptrrec -reversedomain <string> -domain <string>
        An example how to add dnsptrrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reversedomain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsptrrec: Starting"
    }
    process {
        try {
            $payload = @{ reversedomain = $reversedomain
                domain                  = $domain
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnsptrrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsptrrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsptrrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsptrrec: Finished"
    }
}

function Invoke-ADCDeleteDnsptrrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached PTR record need to be removed. 
    .PARAMETER Domain 
        Domain name for which to configure reverse mapping.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsptrrec -Reversedomain <string>
        An example how to delete dnsptrrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Reversedomain,

        [string]$Ecssubnet,

        [string]$Domain 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsptrrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('Domain') ) { $arguments.Add('domain', $Domain) }
            if ( $PSCmdlet.ShouldProcess("$reversedomain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsptrrec: Finished"
    }
}

function Invoke-ADCGetDnsptrrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for PTR record resource.
    .PARAMETER Reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER GetAll 
        Retrieve all dnsptrrec object(s).
    .PARAMETER Count
        If specified, the count of the dnsptrrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsptrrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsptrrec -GetAll 
        Get all dnsptrrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsptrrec -Count 
        Get the number of dnsptrrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsptrrec -name <string>
        Get dnsptrrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsptrrec -Filter @{ 'name'='<value>' }
        Get dnsptrrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsptrrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
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
        [string]$Reversedomain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsptrrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsptrrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsptrrec configuration for property 'reversedomain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsptrrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsptrrec: Ended"
    }
}

function Invoke-ADCAddDnssoarec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Originserver 
        Domain name of the name server that responds authoritatively for the domain. 
    .PARAMETER Contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnssoarec -domain <string> -originserver <string> -contact <string>
        An example how to add dnssoarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnssoarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originserver,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Contact,

        [ValidateRange(0, 4294967294)]
        [double]$Serial = '100',

        [ValidateRange(0, 4294967294)]
        [double]$Refresh = '3600',

        [ValidateRange(0, 4294967294)]
        [double]$Retry = '3',

        [ValidateRange(0, 4294967294)]
        [double]$Expire = '3600',

        [ValidateRange(0, 2147483647)]
        [double]$Minimum = '5',

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                originserver     = $originserver
                contact          = $contact
            }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssoarec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssoarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnssoarec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnssoarec: Finished"
    }
}

function Invoke-ADCDeleteDnssoarec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached SOA record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnssoarec -Domain <string>
        An example how to delete dnssoarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnssoarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssoarec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnssoarec: Finished"
    }
}

function Invoke-ADCUpdateDnssoarec {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Originserver 
        Domain name of the name server that responds authoritatively for the domain. 
    .PARAMETER Contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnssoarec -domain <string>
        An example how to update dnssoarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnssoarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Originserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Contact,

        [ValidateRange(0, 4294967294)]
        [double]$Serial,

        [ValidateRange(0, 4294967294)]
        [double]$Refresh,

        [ValidateRange(0, 4294967294)]
        [double]$Retry,

        [ValidateRange(0, 4294967294)]
        [double]$Expire,

        [ValidateRange(0, 2147483647)]
        [double]$Minimum,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain }
            if ( $PSBoundParameters.ContainsKey('originserver') ) { $payload.Add('originserver', $originserver) }
            if ( $PSBoundParameters.ContainsKey('contact') ) { $payload.Add('contact', $contact) }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssoarec", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnssoarec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnssoarec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnssoarec: Finished"
    }
}

function Invoke-ADCUnsetDnssoarec {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER Serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
    .PARAMETER Refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
    .PARAMETER Retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
    .PARAMETER Expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
    .PARAMETER Minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnssoarec -domain <string>
        An example how to unset dnssoarec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnssoarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Boolean]$serial,

        [Boolean]$refresh,

        [Boolean]$retry,

        [Boolean]$expire,

        [Boolean]$minimum,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnssoarec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain }
            if ( $PSBoundParameters.ContainsKey('serial') ) { $payload.Add('serial', $serial) }
            if ( $PSBoundParameters.ContainsKey('refresh') ) { $payload.Add('refresh', $refresh) }
            if ( $PSBoundParameters.ContainsKey('retry') ) { $payload.Add('retry', $retry) }
            if ( $PSBoundParameters.ContainsKey('expire') ) { $payload.Add('expire', $expire) }
            if ( $PSBoundParameters.ContainsKey('minimum') ) { $payload.Add('minimum', $minimum) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnssoarec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnssoarec: Finished"
    }
}

function Invoke-ADCGetDnssoarec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for SOA record resource.
    .PARAMETER Domain 
        Domain name for which to add the SOA record. 
    .PARAMETER GetAll 
        Retrieve all dnssoarec object(s).
    .PARAMETER Count
        If specified, the count of the dnssoarec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssoarec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssoarec -GetAll 
        Get all dnssoarec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssoarec -Count 
        Get the number of dnssoarec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssoarec -name <string>
        Get dnssoarec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssoarec -Filter @{ 'name'='<value>' }
        Get dnssoarec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnssoarec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnssoarec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssoarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssoarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssoarec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssoarec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssoarec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnssoarec: Ended"
    }
}

function Invoke-ADCAddDnssrvrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter. 
    .PARAMETER Weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight. 
    .PARAMETER Port 
        Port on which the target host listens for client requests. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnssrvrec -domain <string> -target <string> -priority <double> -weight <double> -port <double>
        An example how to add dnssrvrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnssrvrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [string]$Target,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Priority,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Weight,

        [Parameter(Mandatory)]
        [ValidateRange(0, 65535)]
        [double]$Port,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
                priority         = $priority
                weight           = $weight
                port             = $port
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssrvrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssrvrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnssrvrec: Finished"
    }
}

function Invoke-ADCDeleteDnssrvrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached SRV record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnssrvrec -Domain <string>
        An example how to delete dnssrvrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnssrvrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string]$Target,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssrvrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Target') ) { $arguments.Add('target', $Target) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssrvrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnssrvrec: Finished"
    }
}

function Invoke-ADCUpdateDnssrvrec {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter. 
    .PARAMETER Weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight. 
    .PARAMETER Port 
        Port on which the target host listens for client requests. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnssrvrec -domain <string> -target <string>
        An example how to update dnssrvrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnssrvrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [string]$Target,

        [ValidateRange(0, 65535)]
        [double]$Priority,

        [ValidateRange(0, 65535)]
        [double]$Weight,

        [ValidateRange(0, 65535)]
        [double]$Port,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
            }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnssrvrec", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnssrvrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnssrvrec: Finished"
    }
}

function Invoke-ADCUnsetDnssrvrec {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnssrvrec -domain <string> -target <string>
        An example how to unset dnssrvrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnssrvrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [string]$Target,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnssrvrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                target           = $target
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("$domain target", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnssrvrec -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnssrvrec: Finished"
    }
}

function Invoke-ADCGetDnssrvrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for server record resource.
    .PARAMETER Domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER Target 
        Target host for the specified service. 
    .PARAMETER Type 
        Type of records to display. Available settings function as follows: 
        * ADNS - Display all authoritative address records. 
        * PROXY - Display all proxy address records. 
        * ALL - Display all address records. 
        Possible values = ALL, ADNS, PROXY 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all dnssrvrec object(s).
    .PARAMETER Count
        If specified, the count of the dnssrvrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssrvrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssrvrec -GetAll 
        Get all dnssrvrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssrvrec -Count 
        Get the number of dnssrvrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssrvrec -name <string>
        Get dnssrvrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssrvrec -Filter @{ 'name'='<value>' }
        Get dnssrvrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnssrvrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Target,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnssrvrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssrvrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssrvrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssrvrec objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('domain') ) { $arguments.Add('domain', $domain) } 
                if ( $PSBoundParameters.ContainsKey('target') ) { $arguments.Add('target', $target) } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssrvrec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnssrvrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnssrvrec: Ended"
    }
}

function Invoke-ADCFlushDnssubnetcache {
    <#
    .SYNOPSIS
        Flush Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for subnet cache resource.
    .PARAMETER Ecssubnet 
        ECS Subnet. 
    .PARAMETER All 
        Flush all the ECS subnets from the DNS cache.
    .EXAMPLE
        PS C:\>Invoke-ADCFlushDnssubnetcache 
        An example how to flush dnssubnetcache configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushDnssubnetcache
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssubnetcache/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [string]$Ecssubnet,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushDnssubnetcache: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ecssubnet') ) { $payload.Add('ecssubnet', $ecssubnet) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssubnetcache -Action flush -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCFlushDnssubnetcache: Finished"
    }
}

function Invoke-ADCGetDnssubnetcache {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for subnet cache resource.
    .PARAMETER Ecssubnet 
        ECS Subnet. 
    .PARAMETER GetAll 
        Retrieve all dnssubnetcache object(s).
    .PARAMETER Count
        If specified, the count of the dnssubnetcache object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssubnetcache
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssubnetcache -GetAll 
        Get all dnssubnetcache data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssubnetcache -Count 
        Get the number of dnssubnetcache objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssubnetcache -name <string>
        Get dnssubnetcache object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssubnetcache -Filter @{ 'name'='<value>' }
        Get dnssubnetcache data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnssubnetcache
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssubnetcache/
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
        [string]$Ecssubnet,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnssubnetcache: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssubnetcache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssubnetcache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssubnetcache objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssubnetcache configuration for property 'ecssubnet'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Resource $ecssubnet -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssubnetcache configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnssubnetcache: Ended"
    }
}

function Invoke-ADCAddDnssuffix {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified. 
    .PARAMETER PassThru 
        Return details about the created dnssuffix item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnssuffix -Dnssuffix <string>
        An example how to add dnssuffix configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnssuffix
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnssuffix,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssuffix: Starting"
    }
    process {
        try {
            $payload = @{ Dnssuffix = $Dnssuffix }

            if ( $PSCmdlet.ShouldProcess("dnssuffix", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssuffix -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnssuffix -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnssuffix: Finished"
    }
}

function Invoke-ADCDeleteDnssuffix {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnssuffix -Dnssuffix <string>
        An example how to delete dnssuffix configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnssuffix
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Dnssuffix 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssuffix: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$Dnssuffix", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnssuffix: Finished"
    }
}

function Invoke-ADCGetDnssuffix {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS suffix resource.
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified. 
    .PARAMETER GetAll 
        Retrieve all dnssuffix object(s).
    .PARAMETER Count
        If specified, the count of the dnssuffix object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssuffix
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssuffix -GetAll 
        Get all dnssuffix data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnssuffix -Count 
        Get the number of dnssuffix objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssuffix -name <string>
        Get dnssuffix object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnssuffix -Filter @{ 'name'='<value>' }
        Get dnssuffix data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnssuffix
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
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
        [string]$Dnssuffix,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnssuffix: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnssuffix objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssuffix objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssuffix objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssuffix configuration for property 'Dnssuffix'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssuffix configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnssuffix: Ended"
    }
}

function Invoke-ADCAddDnstxtrec {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER String 
        Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you. 
    .PARAMETER Ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600. 
    .PARAMETER PassThru 
        Return details about the created dnstxtrec item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnstxtrec -domain <string> -String <string[]>
        An example how to add dnstxtrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnstxtrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [Parameter(Mandatory)]
        [string[]]$String,

        [ValidateRange(0, 2147483647)]
        [double]$Ttl = '3600',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnstxtrec: Starting"
    }
    process {
        try {
            $payload = @{ domain = $domain
                String           = $String
            }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSCmdlet.ShouldProcess("dnstxtrec", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnstxtrec -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnstxtrec -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnstxtrec: Finished"
    }
}

function Invoke-ADCDeleteDnstxtrec {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER String 
        Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you. 
    .PARAMETER Recordid 
        Unique, internally generated record ID. View the details of the TXT record to obtain its record ID. Mutually exclusive with the string parameter. 
    .PARAMETER Ecssubnet 
        Subnet for which the cached TXT record need to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnstxtrec -Domain <string>
        An example how to delete dnstxtrec configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnstxtrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Domain,

        [string[]]$String,

        [double]$Recordid,

        [string]$Ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnstxtrec: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('String') ) { $arguments.Add('String', $String) }
            if ( $PSBoundParameters.ContainsKey('Recordid') ) { $arguments.Add('recordid', $Recordid) }
            if ( $PSBoundParameters.ContainsKey('Ecssubnet') ) { $arguments.Add('ecssubnet', $Ecssubnet) }
            if ( $PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnstxtrec: Finished"
    }
}

function Invoke-ADCGetDnstxtrec {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for TXT record resource.
    .PARAMETER Domain 
        Name of the domain for the TXT record. 
    .PARAMETER GetAll 
        Retrieve all dnstxtrec object(s).
    .PARAMETER Count
        If specified, the count of the dnstxtrec object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnstxtrec
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnstxtrec -GetAll 
        Get all dnstxtrec data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnstxtrec -Count 
        Get the number of dnstxtrec objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnstxtrec -name <string>
        Get dnstxtrec object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnstxtrec -Filter @{ 'name'='<value>' }
        Get dnstxtrec data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnstxtrec
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
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
        [string]$Domain,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnstxtrec: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnstxtrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnstxtrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnstxtrec objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnstxtrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnstxtrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnstxtrec: Ended"
    }
}

function Invoke-ADCAddDnsview {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view. 
    .PARAMETER PassThru 
        Return details about the created dnsview item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnsview -viewname <string>
        An example how to add dnsview configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnsview
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Viewname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsview: Starting"
    }
    process {
        try {
            $payload = @{ viewname = $viewname }

            if ( $PSCmdlet.ShouldProcess("dnsview", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsview -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnsview -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnsview: Finished"
    }
}

function Invoke-ADCDeleteDnsview {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnsview -Viewname <string>
        An example how to delete dnsview configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnsview
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Viewname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsview: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$viewname", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnsview: Finished"
    }
}

function Invoke-ADCGetDnsview {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS view resource.
    .PARAMETER Viewname 
        Name for the DNS view. 
    .PARAMETER GetAll 
        Retrieve all dnsview object(s).
    .PARAMETER Count
        If specified, the count of the dnsview object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsview
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsview -GetAll 
        Get all dnsview data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsview -Count 
        Get the number of dnsview objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsview -name <string>
        Get dnsview object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsview -Filter @{ 'name'='<value>' }
        Get dnsview data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsview
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
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
        [string]$Viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsview: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnsview objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsview: Ended"
    }
}

function Invoke-ADCGetDnsviewbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsviewbinding -GetAll 
        Get all dnsview_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewbinding -name <string>
        Get dnsview_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewbinding -Filter @{ 'name'='<value>' }
        Get dnsview_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsviewbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_binding/
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
        [string]$Viewname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsviewbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsviewbinding: Ended"
    }
}

function Invoke-ADCGetDnsviewdnspolicybinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnspolicy that can be bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_dnspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_dnspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewdnspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsviewdnspolicybinding -GetAll 
        Get all dnsview_dnspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsviewdnspolicybinding -Count 
        Get the number of dnsview_dnspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewdnspolicybinding -name <string>
        Get dnsview_dnspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewdnspolicybinding -Filter @{ 'name'='<value>' }
        Get dnsview_dnspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsviewdnspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_dnspolicy_binding/
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
        [string]$Viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsviewdnspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsviewdnspolicybinding: Ended"
    }
}

function Invoke-ADCGetDnsviewgslbservicebinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to dnsview.
    .PARAMETER Viewname 
        Name of the view to display. 
    .PARAMETER GetAll 
        Retrieve all dnsview_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnsview_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewgslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsviewgslbservicebinding -GetAll 
        Get all dnsview_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnsviewgslbservicebinding -Count 
        Get the number of dnsview_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewgslbservicebinding -name <string>
        Get dnsview_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnsviewgslbservicebinding -Filter @{ 'name'='<value>' }
        Get dnsview_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnsviewgslbservicebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_gslbservice_binding/
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
        [string]$Viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsviewgslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnsview_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnsviewgslbservicebinding: Ended"
    }
}

function Invoke-ADCAddDnszone {
    <#
    .SYNOPSIS
        Add Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddDnszone -zonename <string> -proxymode <string>
        An example how to add dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [Parameter(Mandatory)]
        [ValidateSet('YES', 'NO')]
        [string]$Proxymode = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssecoffload = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nsec = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename
                proxymode          = $proxymode
            }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("dnszone", "Add Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnszone -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddDnszone: Finished"
    }
}

function Invoke-ADCUpdateDnszone {
    <#
    .SYNOPSIS
        Update Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateDnszone -zonename <string>
        An example how to update dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [ValidateSet('YES', 'NO')]
        [string]$Proxymode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dnssecoffload,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nsec,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("dnszone", "Update Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnszone -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetDnszone -Filter $payload)
                } else {
                    Write-Output $result
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateDnszone: Finished"
    }
}

function Invoke-ADCUnsetDnszone {
    <#
    .SYNOPSIS
        Unset Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios: 
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone. 
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers. 
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance. 
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone. 
        Possible values = YES, NO 
    .PARAMETER Dnssecoffload 
        Enable dnssec offload for this zone. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nsec 
        Enable nsec generation for dnssec offload. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetDnszone -zonename <string>
        An example how to unset dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [Boolean]$proxymode,

        [Boolean]$dnssecoffload,

        [Boolean]$nsec 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('proxymode') ) { $payload.Add('proxymode', $proxymode) }
            if ( $PSBoundParameters.ContainsKey('dnssecoffload') ) { $payload.Add('dnssecoffload', $dnssecoffload) }
            if ( $PSBoundParameters.ContainsKey('nsec') ) { $payload.Add('nsec', $nsec) }
            if ( $PSCmdlet.ShouldProcess("$zonename", "Unset Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnszone -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetDnszone: Finished"
    }
}

function Invoke-ADCDeleteDnszone {
    <#
    .SYNOPSIS
        Delete Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteDnszone -Zonename <string>
        An example how to delete dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [string]$Zonename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnszone: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$zonename", "Delete Domain Name Service configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Arguments $arguments
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteDnszone: Finished"
    }
}

function Invoke-ADCSignDnszone {
    <#
    .SYNOPSIS
        Sign Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        PS C:\>Invoke-ADCSignDnszone -zonename <string>
        An example how to sign dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCSignDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Keyname 

    )
    begin {
        Write-Verbose "Invoke-ADCSignDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('keyname') ) { $payload.Add('keyname', $keyname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sign Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action sign -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCSignDnszone: Finished"
    }
}

function Invoke-ADCUnsignDnszone {
    <#
    .SYNOPSIS
        Unsign Domain Name Service configuration Object.
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER Keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsignDnszone -zonename <string>
        An example how to unsign dnszone configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsignDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Zonename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Keyname 

    )
    begin {
        Write-Verbose "Invoke-ADCUnsignDnszone: Starting"
    }
    process {
        try {
            $payload = @{ zonename = $zonename }
            if ( $PSBoundParameters.ContainsKey('keyname') ) { $payload.Add('keyname', $keyname) }
            if ( $PSCmdlet.ShouldProcess($Name, "Unsign Domain Name Service configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action unsign -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsignDnszone: Finished"
    }
}

function Invoke-ADCGetDnszone {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Configuration for DNS zone resource.
    .PARAMETER Zonename 
        Name of the zone to create. 
    .PARAMETER GetAll 
        Retrieve all dnszone object(s).
    .PARAMETER Count
        If specified, the count of the dnszone object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszone
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszone -GetAll 
        Get all dnszone data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszone -Count 
        Get the number of dnszone objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszone -name <string>
        Get dnszone object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszone -Filter @{ 'name'='<value>' }
        Get dnszone data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnszone
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
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
        [string]$Zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetDnszone: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all dnszone objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnszone: Ended"
    }
}

function Invoke-ADCGetDnszonebinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszonebinding -GetAll 
        Get all dnszone_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonebinding -name <string>
        Get dnszone_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonebinding -Filter @{ 'name'='<value>' }
        Get dnszone_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnszonebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_binding/
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
        [string]$Zonename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnszonebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnszonebinding: Ended"
    }
}

function Invoke-ADCGetDnszonednskeybinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the dnskey that can be bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_dnskey_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_dnskey_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonednskeybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszonednskeybinding -GetAll 
        Get all dnszone_dnskey_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszonednskeybinding -Count 
        Get the number of dnszone_dnskey_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonednskeybinding -name <string>
        Get dnszone_dnskey_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonednskeybinding -Filter @{ 'name'='<value>' }
        Get dnszone_dnskey_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnszonednskeybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_dnskey_binding/
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
        [string]$Zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnszonednskeybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_dnskey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_dnskey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnszonednskeybinding: Ended"
    }
}

function Invoke-ADCGetDnszonedomainbinding {
    <#
    .SYNOPSIS
        Get Domain Name Service configuration object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to dnszone.
    .PARAMETER Zonename 
        Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retrieve all dnszone_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the dnszone_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonedomainbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszonedomainbinding -GetAll 
        Get all dnszone_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetDnszonedomainbinding -Count 
        Get the number of dnszone_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonedomainbinding -name <string>
        Get dnszone_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetDnszonedomainbinding -Filter @{ 'name'='<value>' }
        Get dnszone_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetDnszonedomainbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_domain_binding/
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
        [string]$Zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnszonedomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all dnszone_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_domain_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetDnszonedomainbinding: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCvTUdL7qun0Hdb
# rDWaiCxitW6UcVG+vVYrI6vg+KAM/KCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
# i/247uUvWN5TMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAkdCMRswGQYDVQQI
# ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoT
# D1NlY3RpZ28gTGltaXRlZDEkMCIGA1UEAxMbU2VjdGlnbyBSU0EgQ29kZSBTaWdu
# aW5nIENBMB4XDTIxMDUwNTAwMDAwMFoXDTI0MDUwNDIzNTk1OVowWzELMAkGA1UE
# BhMCTkwxEjAQBgNVBAcMCVZlbGRob3ZlbjEbMBkGA1UECgwSSm9oYW5uZXMgQmls
# bGVrZW5zMRswGQYDVQQDDBJKb2hhbm5lcyBCaWxsZWtlbnMwggEiMA0GCSqGSIb3
# DQEBAQUAA4IBDwAwggEKAoIBAQCsfgRG81keOHalHfCUgxOa1Qy4VNOnGxB8SL8e
# rjP9SfcF13McP7F1HGka5Be495pTZ+duGbaQMNozwg/5Dg9IRJEeBabeSSJJCbZo
# SNpmUu7NNRRfidQxlPC81LxTVHxJ7In0MEfCVm7rWcri28MRCAuafqOfSE+hyb1Z
# /tKyCyQ5RUq3kjs/CF+VfMHsJn6ZT63YqewRkwHuc7UogTTZKjhPJ9prGLTer8UX
# UgvsGRbvhYZXIEuy+bmx/iJ1yRl1kX4nj6gUYzlhemOnlSDD66YOrkLDhXPMXLym
# AN7h0/W5Bo//R5itgvdGBkXkWCKRASnq/9PTcoxW6mwtgU8xAgMBAAGjggGQMIIB
# jDAfBgNVHSMEGDAWgBQO4TqoUzox1Yq+wbutZxoDha00DjAdBgNVHQ4EFgQUZWMy
# gC0i1u2NZ1msk2Mm5nJm5AswDgYDVR0PAQH/BAQDAgeAMAwGA1UdEwEB/wQCMAAw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEQYJYIZIAYb4QgEBBAQDAgQQMEoGA1UdIARD
# MEEwNQYMKwYBBAGyMQECAQMCMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
# by5jb20vQ1BTMAgGBmeBDAEEATBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
# LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDb2RlU2lnbmluZ0NBLmNybDBzBggrBgEF
# BQcBAQRnMGUwPgYIKwYBBQUHMAKGMmh0dHA6Ly9jcnQuc2VjdGlnby5jb20vU2Vj
# dGlnb1JTQUNvZGVTaWduaW5nQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
# cC5zZWN0aWdvLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEARjv9ieRocb1DXRWm3XtY
# jjuSRjlvkoPd9wS6DNfsGlSU42BFd9LCKSyRREZVu8FDq7dN0PhD4bBTT+k6AgrY
# KG6f/8yUponOdxskv850SjN2S2FeVuR20pqActMrpd1+GCylG8mj8RGjdrLQ3QuX
# qYKS68WJ39WWYdVB/8Ftajir5p6sAfwHErLhbJS6WwmYjGI/9SekossvU8mZjZwo
# Gbu+fjZhPc4PhjbEh0ABSsPMfGjQQsg5zLFjg/P+cS6hgYI7qctToo0TexGe32DY
# fFWHrHuBErW2qXEJvzSqM5OtLRD06a4lH5ZkhojhMOX9S8xDs/ArDKgX1j1Xm4Tu
# DjCCBYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAw
# ezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNV
# BAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0y
# ODEyMzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNl
# eTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1Qg
# TmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1
# dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPb
# CLPQrFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5
# xrw6GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhq
# kCI8vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn
# 2yFmsdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1ya
# tLcgPcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPe
# xMcM3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRj
# VYnEDcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+k
# OQ/ZAp7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnY
# SVgaf5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBl
# CeZYQi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupc
# xigIBCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAU
# oBEKIz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKy
# A2bLMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgw
# BgYEVR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNv
# bS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYI
# KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
# AAOCAQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNK
# fq70jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNk
# fv3M0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuY
# AAoiAxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgN
# Rc2ThZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpM
# gLxqeM+4f452cpkMnf7XkQgWoaNflTCCBfUwggPdoAMCAQICEB2iSDBvmyYY0ILg
# ln0z02owDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpO
# ZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVT
# RVJUUlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmlj
# YXRpb24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVow
# fDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
# A1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQD
# ExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQCGIo0yhXoYn0nwli9jCB4t3HyfFM/jJrYlZilAhlRGdDFi
# xRDtsocnppnLlTDAVvWkdcapDlBipVGREGrgS2Ku/fD4GKyn/+4uMyD6DBmJqGx7
# rQDDYaHcaWVtH24nlteXUYam9CflfGqLlR5bYNV+1xaSnAAvaPeX7Wpyvjg7Y96P
# v25MQV0SIAhZ6DnNj9LWzwa0VwW2TqE+V2sfmLzEYtYbC43HZhtKn52BxHJAteJf
# 7wtF/6POF6YtVbC3sLxUap28jVZTxvC6eVBJLPcDuf4vZTXyIuosB69G2flGHNyM
# fHEo8/6nxhTdVZFuihEN3wYklX0Pp6F8OtqGNWHTAgMBAAGjggFkMIIBYDAfBgNV
# HSMEGDAWgBRTeb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUDuE6qFM6MdWK
# vsG7rWcaA4WtNA4wDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
# HQYDVR0lBBYwFAYIKwYBBQUHAwMGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAE1jUO1HNEphpNveaiqMm/EA
# AB4dYns61zLC9rPgY7P7YQCImhttEAcET7646ol4IusPRuzzRl5ARokS9At3Wpwq
# QTr81vTr5/cVlTPDoYMot94v5JT3hTODLUpASL+awk9KsY8k9LOBN9O3ZLCmI2pZ
# aFJCX/8E6+F0ZXkI9amT3mtxQJmWunjxucjiwwgWsatjWsgVgG10Xkp1fqW4w2y1
# z99KeYdcx0BNYzX2MNPPtQoOCwR/oEuuu6Ol0IQAkz5TXTSlADVpbL6fICUQDRn7
# UJBhvjmPeo5N9p8OHv4HURJmgyYZSJXOSsnBf/M6BZv5b9+If8AjntIeQ3pFMcGc
# TanwWbJZGehqjSkEAnd8S0vNcL46slVaeD68u28DECV3FTSK+TbMQ5Lkuk/xYpMo
# JVcp+1EZx6ElQGqEV8aynbG8HArafGd+fS7pKEwYfsR7MUFxmksp7As9V1DSyt39
# ngVR5UR43QHesXWYDVQk/fBO4+L4g71yuss9Ou7wXheSaG3IYfmm8SoKC6W59J7u
# mDIFhZ7r+YMp08Ysfb06dy6LN0KgaoLtO0qqlBCk4Q34F8W2WnkzGJLjtXX4oemO
# CiUe5B7xn1qHI/+fpFGe+zmAEc3btcSnqIBv5VPU4OOiwtJbGvoyJi1qV3AcPKRY
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgZb1S3VGg9zdXBYzQUxBpwg+qaPMUVDzZF5UqXFZBLaIwDQYJKoZIhvcNAQEB
# BQAEggEAnSyoHlt95AtD4XBGRDYl8rYgnHsUMcKpgO8q6wTmW9qCY9irkMvWdnRs
# jDePqt007EGlrKqkG4QVTNCbFoni15vba1vSorICRaMLwvXvUM3qiE6UOjIKwRTg
# X2yBRO02+pKPCwuZ5SSFRORquIrB0HKmr7kgFhE4T6/oSCuwWqkE15GrfBaGzDXr
# oAqJLu4rOEwNXSO+zoUOYjSMiKtVgWegKVnYcJTRFTbwx/15IYfKXzEm2wYrX3fK
# TyXLZXrDrLT3+rvyDN9dcpH1K6J4iLymHseuYtuq1Gzk7luJd0qaFoYmxXrvMRB/
# +2AWrsshdWr+MgjUJ3nG4cxT0DEkVg==
# SIG # End signature block
