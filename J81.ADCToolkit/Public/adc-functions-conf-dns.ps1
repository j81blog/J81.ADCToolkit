function Invoke-ADCAddDnsaaaarec {
<#
    .SYNOPSIS
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER hostname 
        Domain name.  
        Minimum length = 1 
    .PARAMETER ipv6address 
        One or more IPv6 addresses to assign to the domain name.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647
    .EXAMPLE
        Invoke-ADCAddDnsaaaarec -hostname <string> -ipv6address <string>
    .NOTES
        File Name : Invoke-ADCAddDnsaaaarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipv6address ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaaaarec: Starting"
    }
    process {
        try {
            $Payload = @{
                hostname = $hostname
                ipv6address = $ipv6address
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsaaaarec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaaaarec -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER hostname 
       Domain name.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached records need to be removed.    .PARAMETER ipv6address 
       One or more IPv6 addresses to assign to the domain name.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteDnsaaaarec -hostname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsaaaarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$hostname ,

        [string]$ecssubnet ,

        [string]$ipv6address 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaaaarec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSBoundParameters.ContainsKey('ipv6address')) { $Arguments.Add('ipv6address', $ipv6address) }
            if ($PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaaaarec -NitroPath nitro/v1/config -Resource $hostname -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER hostname 
       Domain name. 
    .PARAMETER ipv6address 
       One or more IPv6 addresses to assign to the domain name. 
    .PARAMETER type 
       Type of records to display. Available settings function as follows:  
       * ADNS - Display all authoritative address records.  
       * PROXY - Display all proxy address records.  
       * ALL - Display all address records.  
       Possible values = ALL, ADNS, PROXY 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all dnsaaaarec object(s)
    .PARAMETER Count
        If specified, the count of the dnsaaaarec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsaaaarec
    .EXAMPLE 
        Invoke-ADCGetDnsaaaarec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsaaaarec -Count
    .EXAMPLE
        Invoke-ADCGetDnsaaaarec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsaaaarec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsaaaarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaaaarec/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipv6address ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsaaaarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaaaarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaaaarec objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('hostname')) { $Arguments.Add('hostname', $hostname) } 
                if ($PSBoundParameters.ContainsKey('ipv6address')) { $Arguments.Add('ipv6address', $ipv6address) } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaaaarec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsaaaarec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaaaarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER actionname 
        Name of the dns action. 
    .PARAMETER actiontype 
        The type of DNS action that is being configured.  
        Possible values = ViewName, GslbPrefLoc, noop, Drop, Cache_Bypass, Rewrite_Response 
    .PARAMETER ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type.  
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER ttl 
        Time to live, in seconds.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER viewname 
        The view name that must be used for the given action. 
    .PARAMETER preferredloclist 
        The location list in priority order used for the given action.  
        Minimum length = 1 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        Invoke-ADCAddDnsaction -actionname <string> -actiontype <string>
    .NOTES
        File Name : Invoke-ADCAddDnsaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ViewName', 'GslbPrefLoc', 'noop', 'Drop', 'Cache_Bypass', 'Rewrite_Response')]
        [string]$actiontype ,

        [string[]]$ipaddress ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [string]$viewname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$preferredloclist ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
                actiontype = $actiontype
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('preferredloclist')) { $Payload.Add('preferredloclist', $preferredloclist) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
 
            if ($PSCmdlet.ShouldProcess("dnsaction", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsaction -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER actionname 
       Name of the dns action. 
    .EXAMPLE
        Invoke-ADCDeleteDnsaction -actionname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER actionname 
        Name of the dns action. 
    .PARAMETER ipaddress 
        List of IP address to be returned in case of rewrite_response actiontype. They can be of IPV4 or IPV6 type.  
        In case of set command We will remove all the IP address previously present in the action and will add new once given in set dns action command. 
    .PARAMETER ttl 
        Time to live, in seconds.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER viewname 
        The view name that must be used for the given action. 
    .PARAMETER preferredloclist 
        The location list in priority order used for the given action.  
        Minimum length = 1 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the transaction for which the action is chosen.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created dnsaction item.
    .EXAMPLE
        Invoke-ADCUpdateDnsaction -actionname <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnsaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [string[]]$ipaddress ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl ,

        [string]$viewname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$preferredloclist ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('preferredloclist')) { $Payload.Add('preferredloclist', $preferredloclist) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
 
            if ($PSCmdlet.ShouldProcess("dnsaction", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsaction -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER actionname 
       Name of the dns action. 
   .PARAMETER ttl 
       Time to live, in seconds. 
   .PARAMETER dnsprofilename 
       Name of the DNS profile to be associated with the transaction for which the action is chosen.
    .EXAMPLE
        Invoke-ADCUnsetDnsaction -actionname <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnsaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [Boolean]$ttl ,

        [Boolean]$dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER actionname 
       Name of the dns action. 
    .PARAMETER GetAll 
        Retreive all dnsaction object(s)
    .PARAMETER Count
        If specified, the count of the dnsaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsaction
    .EXAMPLE 
        Invoke-ADCGetDnsaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsaction -Count
    .EXAMPLE
        Invoke-ADCGetDnsaction -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction/
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
        [string]$actionname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction configuration for property 'actionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER actionname 
        Name of the dns64 action. 
    .PARAMETER prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis.  
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix,  
        otherwise the A RR is discarded. 
    .PARAMETER excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        Invoke-ADCAddDnsaction64 -actionname <string> -prefix <string>
    .NOTES
        File Name : Invoke-ADCAddDnsaction64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [Parameter(Mandatory = $true)]
        [string]$prefix ,

        [string]$mappedrule ,

        [string]$excluderule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaction64: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
                prefix = $prefix
            }
            if ($PSBoundParameters.ContainsKey('mappedrule')) { $Payload.Add('mappedrule', $mappedrule) }
            if ($PSBoundParameters.ContainsKey('excluderule')) { $Payload.Add('excluderule', $excluderule) }
 
            if ($PSCmdlet.ShouldProcess("dnsaction64", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaction64 -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsaction64 -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER actionname 
       Name of the dns64 action. 
    .EXAMPLE
        Invoke-ADCDeleteDnsaction64 -actionname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsaction64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaction64: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$actionname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER actionname 
        Name of the dns64 action. 
    .PARAMETER prefix 
        The dns64 prefix to be used if the after evaluating the rules. 
    .PARAMETER mappedrule 
        The expression to select the criteria for ipv4 addresses to be used for synthesis.  
        Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix,  
        otherwise the A RR is discarded. 
    .PARAMETER excluderule 
        The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response. 
    .PARAMETER PassThru 
        Return details about the created dnsaction64 item.
    .EXAMPLE
        Invoke-ADCUpdateDnsaction64 -actionname <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnsaction64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [string]$prefix ,

        [string]$mappedrule ,

        [string]$excluderule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsaction64: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
            }
            if ($PSBoundParameters.ContainsKey('prefix')) { $Payload.Add('prefix', $prefix) }
            if ($PSBoundParameters.ContainsKey('mappedrule')) { $Payload.Add('mappedrule', $mappedrule) }
            if ($PSBoundParameters.ContainsKey('excluderule')) { $Payload.Add('excluderule', $excluderule) }
 
            if ($PSCmdlet.ShouldProcess("dnsaction64", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsaction64 -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsaction64 -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER actionname 
       Name of the dns64 action. 
   .PARAMETER prefix 
       The dns64 prefix to be used if the after evaluating the rules. 
   .PARAMETER mappedrule 
       The expression to select the criteria for ipv4 addresses to be used for synthesis.  
       Only if the mappedrule is evaluated to true the corresponding ipv4 address is used for synthesis using respective prefix,  
       otherwise the A RR is discarded. 
   .PARAMETER excluderule 
       The expression to select the criteria for eliminating the corresponding ipv6 addresses from the response.
    .EXAMPLE
        Invoke-ADCUnsetDnsaction64 -actionname <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnsaction64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$actionname ,

        [Boolean]$prefix ,

        [Boolean]$mappedrule ,

        [Boolean]$excluderule 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsaction64: Starting"
    }
    process {
        try {
            $Payload = @{
                actionname = $actionname
            }
            if ($PSBoundParameters.ContainsKey('prefix')) { $Payload.Add('prefix', $prefix) }
            if ($PSBoundParameters.ContainsKey('mappedrule')) { $Payload.Add('mappedrule', $mappedrule) }
            if ($PSBoundParameters.ContainsKey('excluderule')) { $Payload.Add('excluderule', $excluderule) }
            if ($PSCmdlet.ShouldProcess("$actionname", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsaction64 -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER actionname 
       Name of the dns64 action. 
    .PARAMETER GetAll 
        Retreive all dnsaction64 object(s)
    .PARAMETER Count
        If specified, the count of the dnsaction64 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsaction64
    .EXAMPLE 
        Invoke-ADCGetDnsaction64 -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsaction64 -Count
    .EXAMPLE
        Invoke-ADCGetDnsaction64 -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsaction64 -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsaction64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaction64/
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
        [string]$actionname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsaction64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaction64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaction64 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaction64 configuration for property 'actionname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Resource $actionname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaction64 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaction64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER hostname 
        Domain name.  
        Minimum length = 1 
    .PARAMETER ipaddress 
        One or more IPv4 addresses to assign to the domain name.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsaddrec item.
    .EXAMPLE
        Invoke-ADCAddDnsaddrec -hostname <string> -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddDnsaddrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$hostname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipaddress ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsaddrec: Starting"
    }
    process {
        try {
            $Payload = @{
                hostname = $hostname
                ipaddress = $ipaddress
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsaddrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsaddrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsaddrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER hostname 
       Domain name.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached address records need to be removed.    .PARAMETER ipaddress 
       One or more IPv4 addresses to assign to the domain name.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteDnsaddrec -hostname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsaddrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$hostname ,

        [string]$ecssubnet ,

        [string]$ipaddress 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsaddrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Arguments.Add('ipaddress', $ipaddress) }
            if ($PSCmdlet.ShouldProcess("$hostname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER hostname 
       Domain name. 
    .PARAMETER GetAll 
        Retreive all dnsaddrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsaddrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsaddrec
    .EXAMPLE 
        Invoke-ADCGetDnsaddrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsaddrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsaddrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsaddrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsaddrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsaddrec/
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
        [string]$hostname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsaddrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsaddrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsaddrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsaddrec configuration for property 'hostname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsaddrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsaddrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER aliasname 
        Alias for the canonical domain name.  
        Minimum length = 1 
    .PARAMETER canonicalname 
        Canonical domain name.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnscnamerec item.
    .EXAMPLE
        Invoke-ADCAddDnscnamerec -aliasname <string> -canonicalname <string>
    .NOTES
        File Name : Invoke-ADCAddDnscnamerec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$aliasname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$canonicalname ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnscnamerec: Starting"
    }
    process {
        try {
            $Payload = @{
                aliasname = $aliasname
                canonicalname = $canonicalname
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnscnamerec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnscnamerec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnscnamerec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER aliasname 
       Alias for the canonical domain name.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached CNAME record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnscnamerec -aliasname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnscnamerec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$aliasname ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnscnamerec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$aliasname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER aliasname 
       Alias for the canonical domain name. 
    .PARAMETER GetAll 
        Retreive all dnscnamerec object(s)
    .PARAMETER Count
        If specified, the count of the dnscnamerec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnscnamerec
    .EXAMPLE 
        Invoke-ADCGetDnscnamerec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnscnamerec -Count
    .EXAMPLE
        Invoke-ADCGetDnscnamerec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnscnamerec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnscnamerec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnscnamerec/
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
        [string]$aliasname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnscnamerec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnscnamerec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnscnamerec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnscnamerec configuration for property 'aliasname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Resource $aliasname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnscnamerec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnscnamerec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER GetAll 
        Retreive all dnsglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnsglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsglobalbinding
    .EXAMPLE 
        Invoke-ADCGetDnsglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnsglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_binding/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER policyname 
        Name of the dns policy. 
    .PARAMETER priority 
        Specifies the priority of the policy with which it is bound. Maximum allowed priority should be less than 65535. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label.  
        Minimum length = 1 
    .PARAMETER type 
        Type of global bind point for which to show bound policies.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = policylabel 
    .PARAMETER labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnsglobal_dnspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddDnsglobaldnspolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddDnsglobaldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsglobaldnspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsglobal_dnspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsglobaldnspolicybinding -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
     .PARAMETER policyname 
       Name of the dns policy.    .PARAMETER type 
       Type of global bind point for which to show bound policies.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT
    .EXAMPLE
        Invoke-ADCDeleteDnsglobaldnspolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteDnsglobaldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [string]$policyname ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsglobaldnspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("dnsglobal_dnspolicy_binding", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER GetAll 
        Retreive all dnsglobal_dnspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnsglobal_dnspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsglobaldnspolicybinding
    .EXAMPLE 
        Invoke-ADCGetDnsglobaldnspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsglobaldnspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetDnsglobaldnspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsglobaldnspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsglobaldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsglobal_dnspolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnsglobal_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsglobal_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsglobal_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsglobal_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER keyname 
        Name of the public-private key pair to publish in the zone.  
        Minimum length = 1 
    .PARAMETER publickey 
        File name of the public key. 
    .PARAMETER privatekey 
        File name of the private key. 
    .PARAMETER expires 
        Time period for which to consider the key valid, after the key is used to sign a zone.  
        Default value: 120  
        Minimum value = 1  
        Maximum value = 32767 
    .PARAMETER units1 
        Units for the expiry period.  
        Default value: DAYS  
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm.  
        Default value: 7  
        Minimum value = 1  
        Maximum value = 32767 
    .PARAMETER units2 
        Units for the notification period.  
        Default value: DAYS  
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER password 
        Passphrase for reading the encrypted public/private DNS keys.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        Invoke-ADCAddDnskey -keyname <string> -publickey <string> -privatekey <string>
    .NOTES
        File Name : Invoke-ADCAddDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keyname ,

        [Parameter(Mandatory = $true)]
        [string]$publickey ,

        [Parameter(Mandatory = $true)]
        [string]$privatekey ,

        [ValidateRange(1, 32767)]
        [double]$expires = '120' ,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$units1 = 'DAYS' ,

        [ValidateRange(1, 32767)]
        [double]$notificationperiod = '7' ,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$units2 = 'DAYS' ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnskey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyname = $keyname
                publickey = $publickey
                privatekey = $privatekey
            }
            if ($PSBoundParameters.ContainsKey('expires')) { $Payload.Add('expires', $expires) }
            if ($PSBoundParameters.ContainsKey('units1')) { $Payload.Add('units1', $units1) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
            if ($PSBoundParameters.ContainsKey('units2')) { $Payload.Add('units2', $units2) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("dnskey", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnskey -Filter $Payload)
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
        Create Domain Name Service configuration Object
    .DESCRIPTION
        Create Domain Name Service configuration Object 
    .PARAMETER zonename 
        Name of the zone for which to create a key. 
    .PARAMETER keytype 
        Type of key to create.  
        Possible values = KSK, KeySigningKey, ZSK, ZoneSigningKey 
    .PARAMETER algorithm 
        Algorithm to generate for zone signing.  
        Possible values = RSASHA1, RSASHA256, RSASHA512 
    .PARAMETER keysize 
        Size of the key, in bits. 
    .PARAMETER filenameprefix 
        Common prefix for the names of the generated public and private key files and the Delegation Signer (DS) resource record. During key generation, the .key, .private, and .ds suffixes are appended automatically to the file name prefix to produce the names of the public key, the private key, and the DS record, respectively. 
    .PARAMETER password 
        Passphrase for reading the encrypted public/private DNS keys.
    .EXAMPLE
        Invoke-ADCCreateDnskey -zonename <string> -keytype <string> -algorithm <string> -keysize <double> -filenameprefix <string>
    .NOTES
        File Name : Invoke-ADCCreateDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('KSK', 'KeySigningKey', 'ZSK', 'ZoneSigningKey')]
        [string]$keytype ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('RSASHA1', 'RSASHA256', 'RSASHA512')]
        [string]$algorithm ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 4096)]
        [double]$keysize ,

        [Parameter(Mandatory = $true)]
        [string]$filenameprefix ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password 

    )
    begin {
        Write-Verbose "Invoke-ADCCreateDnskey: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
                keytype = $keytype
                algorithm = $algorithm
                keysize = $keysize
                filenameprefix = $filenameprefix
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
            if ($PSCmdlet.ShouldProcess($Name, "Create Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action create -Payload $Payload -GetWarning
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER keyname 
        Name of the public-private key pair to publish in the zone.  
        Minimum length = 1 
    .PARAMETER expires 
        Time period for which to consider the key valid, after the key is used to sign a zone.  
        Default value: 120  
        Minimum value = 1  
        Maximum value = 32767 
    .PARAMETER units1 
        Units for the expiry period.  
        Default value: DAYS  
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER notificationperiod 
        Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm.  
        Default value: 7  
        Minimum value = 1  
        Maximum value = 32767 
    .PARAMETER units2 
        Units for the notification period.  
        Default value: DAYS  
        Possible values = MINUTES, HOURS, DAYS 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnskey item.
    .EXAMPLE
        Invoke-ADCUpdateDnskey -keyname <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keyname ,

        [ValidateRange(1, 32767)]
        [double]$expires ,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$units1 ,

        [ValidateRange(1, 32767)]
        [double]$notificationperiod ,

        [ValidateSet('MINUTES', 'HOURS', 'DAYS')]
        [string]$units2 ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnskey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyname = $keyname
            }
            if ($PSBoundParameters.ContainsKey('expires')) { $Payload.Add('expires', $expires) }
            if ($PSBoundParameters.ContainsKey('units1')) { $Payload.Add('units1', $units1) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
            if ($PSBoundParameters.ContainsKey('units2')) { $Payload.Add('units2', $units2) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnskey", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnskey -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnskey -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER keyname 
       Name of the public-private key pair to publish in the zone. 
   .PARAMETER expires 
       Time period for which to consider the key valid, after the key is used to sign a zone. 
   .PARAMETER units1 
       Units for the expiry period.  
       Possible values = MINUTES, HOURS, DAYS 
   .PARAMETER notificationperiod 
       Time at which to generate notification of key expiration, specified as number of days, hours, or minutes before expiry. Must be less than the expiry period. The notification is an SNMP trap sent to an SNMP manager. To enable the appliance to send the trap, enable the DNSKEY-EXPIRY SNMP alarm. 
   .PARAMETER units2 
       Units for the notification period.  
       Possible values = MINUTES, HOURS, DAYS 
   .PARAMETER ttl 
       Time to Live (TTL), in seconds, for the DNSKEY resource record created in the zone. TTL is the time for which the record must be cached by the DNS proxies. If the TTL is not specified, either the DNS zone's minimum TTL or the default value of 3600 is used.
    .EXAMPLE
        Invoke-ADCUnsetDnskey -keyname <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keyname ,

        [Boolean]$expires ,

        [Boolean]$units1 ,

        [Boolean]$notificationperiod ,

        [Boolean]$units2 ,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnskey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyname = $keyname
            }
            if ($PSBoundParameters.ContainsKey('expires')) { $Payload.Add('expires', $expires) }
            if ($PSBoundParameters.ContainsKey('units1')) { $Payload.Add('units1', $units1) }
            if ($PSBoundParameters.ContainsKey('notificationperiod')) { $Payload.Add('notificationperiod', $notificationperiod) }
            if ($PSBoundParameters.ContainsKey('units2')) { $Payload.Add('units2', $units2) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSCmdlet.ShouldProcess("$keyname", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnskey -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER keyname 
       Name of the public-private key pair to publish in the zone.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteDnskey -keyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$keyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnskey: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$keyname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Arguments $Arguments
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
        Import Domain Name Service configuration Object
    .DESCRIPTION
        Import Domain Name Service configuration Object 
    .PARAMETER keyname 
        Name of the public-private key pair to publish in the zone. 
    .PARAMETER src 
        URL (protocol, host, path, and file name) from where the DNS key file will be imported. NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. This is a mandatory argument.
    .EXAMPLE
        Invoke-ADCImportDnskey -keyname <string> -src <string>
    .NOTES
        File Name : Invoke-ADCImportDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$keyname ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$src 

    )
    begin {
        Write-Verbose "Invoke-ADCImportDnskey: Starting"
    }
    process {
        try {
            $Payload = @{
                keyname = $keyname
                src = $src
            }

            if ($PSCmdlet.ShouldProcess($Name, "Import Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnskey -Action import -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER keyname 
       Name of the public-private key pair to publish in the zone. 
    .PARAMETER GetAll 
        Retreive all dnskey object(s)
    .PARAMETER Count
        If specified, the count of the dnskey object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnskey
    .EXAMPLE 
        Invoke-ADCGetDnskey -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnskey -Count
    .EXAMPLE
        Invoke-ADCGetDnskey -name <string>
    .EXAMPLE
        Invoke-ADCGetDnskey -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnskey
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnskey/
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
        [string]$keyname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnskey objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnskey objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnskey configuration for property 'keyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Resource $keyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnskey configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnskey -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name for which to add the MX record.  
        Minimum length = 1 
    .PARAMETER mx 
        Host name of the mail exchange server.  
        Minimum length = 1 
    .PARAMETER pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        Invoke-ADCAddDnsmxrec -domain <string> -mx <string> -pref <double>
    .NOTES
        File Name : Invoke-ADCAddDnsmxrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$mx ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$pref ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsmxrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                mx = $mx
                pref = $pref
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsmxrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsmxrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsmxrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Domain name for which to add the MX record.  
       Minimum length = 1    .PARAMETER mx 
       Host name of the mail exchange server.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached MX record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnsmxrec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsmxrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [string]$mx ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsmxrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('mx')) { $Arguments.Add('mx', $mx) }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name for which to add the MX record.  
        Minimum length = 1 
    .PARAMETER mx 
        Host name of the mail exchange server.  
        Minimum length = 1 
    .PARAMETER pref 
        Priority number to assign to the mail exchange server. A domain name can have multiple mail servers, with a priority number assigned to each server. The lower the priority number, the higher the mail server's priority. When other mail servers have to deliver mail to the specified domain, they begin with the mail server with the lowest priority number, and use other configured mail servers, in priority order, as backups.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsmxrec item.
    .EXAMPLE
        Invoke-ADCUpdateDnsmxrec -domain <string> -mx <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnsmxrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$mx ,

        [ValidateRange(0, 65535)]
        [double]$pref ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsmxrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                mx = $mx
            }
            if ($PSBoundParameters.ContainsKey('pref')) { $Payload.Add('pref', $pref) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsmxrec", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsmxrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsmxrec -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER domain 
       Domain name for which to add the MX record. 
   .PARAMETER mx 
       Host name of the mail exchange server. 
   .PARAMETER ttl 
       Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        Invoke-ADCUnsetDnsmxrec -domain <string> -mx <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnsmxrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$mx ,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsmxrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                mx = $mx
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSCmdlet.ShouldProcess("$domain mx", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsmxrec -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Domain name for which to add the MX record. 
    .PARAMETER GetAll 
        Retreive all dnsmxrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsmxrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsmxrec
    .EXAMPLE 
        Invoke-ADCGetDnsmxrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsmxrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsmxrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsmxrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsmxrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsmxrec/
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
        [string]$domain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsmxrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsmxrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsmxrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsmxrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsmxrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsmxrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS).  
        Minimum length = 1 
    .PARAMETER dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC.  
        Minimum length = 1 
    .PARAMETER local 
        Mark the IP address as one that belongs to a local recursive DNS server on the Citrix ADC. The appliance recursively resolves queries received on an IP address that is marked as being local. For recursive resolution to work, the global DNS parameter, Recursion, must also be set.  
        If no name server is marked as being local, the appliance functions as a stub resolver and load balances the name servers. 
    .PARAMETER state 
        Administrative state of the name server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
        Default value: UDP  
        Possible values = UDP, TCP, UDP_TCP 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the name server.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCAddDnsnameserver 
    .NOTES
        File Name : Invoke-ADCAddDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsvservername ,

        [boolean]$local ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$type = 'UDP' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsprofilename 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnameserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('local')) { $Payload.Add('local', $local) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
 
            if ($PSCmdlet.ShouldProcess("dnsnameserver", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Payload $Payload -GetWarning
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS).  
        Minimum length = 1 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the name server.  
        Minimum length = 1 
    .PARAMETER type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
        Default value: UDP  
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        Invoke-ADCUpdateDnsnameserver -ip <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsprofilename ,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$type 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsnameserver: Starting"
    }
    process {
        try {
            $Payload = @{
                ip = $ip
            }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
 
            if ($PSCmdlet.ShouldProcess("dnsnameserver", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsnameserver -Payload $Payload -GetWarning
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER ip 
       IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
   .PARAMETER dnsprofilename 
       Name of the DNS profile to be associated with the name server. 
   .PARAMETER type 
       Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
       Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        Invoke-ADCUnsetDnsnameserver -ip <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [Boolean]$dnsprofilename ,

        [Boolean]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsnameserver: Starting"
    }
    process {
        try {
            $Payload = @{
                ip = $ip
            }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$ip", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsnameserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER ip 
       IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS).  
       Minimum length = 1    .PARAMETER dnsvservername 
       Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC.  
       Minimum length = 1    .PARAMETER type 
       Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
       Default value: UDP  
       Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        Invoke-ADCDeleteDnsnameserver -ip <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$ip ,

        [string]$dnsvservername ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnameserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Arguments.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$ip", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnameserver -NitroPath nitro/v1/config -Resource $ip -Arguments $Arguments
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
        Enable Domain Name Service configuration Object
    .DESCRIPTION
        Enable Domain Name Service configuration Object 
    .PARAMETER ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        Invoke-ADCEnableDnsnameserver 
    .NOTES
        File Name : Invoke-ADCEnableDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsvservername ,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$type 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableDnsnameserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess($Name, "Enable Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action enable -Payload $Payload -GetWarning
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
        Disable Domain Name Service configuration Object
    .DESCRIPTION
        Disable Domain Name Service configuration Object 
    .PARAMETER ip 
        IP address of an external name server or, if the Local parameter is set, IP address of a local DNS server (LDNS). 
    .PARAMETER dnsvservername 
        Name of a DNS virtual server. Overrides any IP address-based name servers configured on the Citrix ADC. 
    .PARAMETER type 
        Protocol used by the name server. UDP_TCP is not valid if the name server is a DNS virtual server configured on the appliance.  
        Possible values = UDP, TCP, UDP_TCP
    .EXAMPLE
        Invoke-ADCDisableDnsnameserver 
    .NOTES
        File Name : Invoke-ADCDisableDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsvservername ,

        [ValidateSet('UDP', 'TCP', 'UDP_TCP')]
        [string]$type 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableDnsnameserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnameserver -Action disable -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER GetAll 
        Retreive all dnsnameserver object(s)
    .PARAMETER Count
        If specified, the count of the dnsnameserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsnameserver
    .EXAMPLE 
        Invoke-ADCGetDnsnameserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsnameserver -Count
    .EXAMPLE
        Invoke-ADCGetDnsnameserver -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsnameserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsnameserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnameserver/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsnameserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnameserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnameserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnameserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsnameserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnameserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Name of the domain for the NAPTR record.  
        Minimum length = 1 
    .PARAMETER order 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER preference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER flags 
        flags for this NAPTR.  
        Maximum length = 255 
    .PARAMETER services 
        Service Parameters applicable to this delegation path.  
        Maximum length = 255 
    .PARAMETER regexp 
        The regular expression, that specifies the substitution expression for this NAPTR.  
        Maximum length = 255 
    .PARAMETER replacement 
        The replacement domain name for this NAPTR.  
        Maximum length = 255 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsnaptrrec item.
    .EXAMPLE
        Invoke-ADCAddDnsnaptrrec -domain <string> -order <double> -preference <double>
    .NOTES
        File Name : Invoke-ADCAddDnsnaptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$order ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$preference ,

        [string]$flags ,

        [string]$services ,

        [string]$regexp ,

        [string]$replacement ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnaptrrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                order = $order
                preference = $preference
            }
            if ($PSBoundParameters.ContainsKey('flags')) { $Payload.Add('flags', $flags) }
            if ($PSBoundParameters.ContainsKey('services')) { $Payload.Add('services', $services) }
            if ($PSBoundParameters.ContainsKey('regexp')) { $Payload.Add('regexp', $regexp) }
            if ($PSBoundParameters.ContainsKey('replacement')) { $Payload.Add('replacement', $replacement) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsnaptrrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnaptrrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsnaptrrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Name of the domain for the NAPTR record.  
       Minimum length = 1    .PARAMETER order 
       An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest.  
       Minimum value = 0  
       Maximum value = 65535    .PARAMETER recordid 
       Unique, internally generated record ID. View the details of the naptr record to obtain its record ID. Records can be removed by either specifying the domain name and record id OR by specifying  
       domain name and all other naptr record attributes as was supplied during the add command.  
       Minimum value = 1  
       Maximum value = 65535    .PARAMETER ecssubnet 
       Subnet for which the cached NAPTR record need to be removed.    .PARAMETER preference 
       An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference.  
       Minimum value = 0  
       Maximum value = 65535    .PARAMETER flags 
       flags for this NAPTR.  
       Maximum length = 255    .PARAMETER services 
       Service Parameters applicable to this delegation path.  
       Maximum length = 255    .PARAMETER regexp 
       The regular expression, that specifies the substitution expression for this NAPTR.  
       Maximum length = 255    .PARAMETER replacement 
       The replacement domain name for this NAPTR.  
       Maximum length = 255
    .EXAMPLE
        Invoke-ADCDeleteDnsnaptrrec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsnaptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [double]$order ,

        [double]$recordid ,

        [string]$ecssubnet ,

        [double]$preference ,

        [string]$flags ,

        [string]$services ,

        [string]$regexp ,

        [string]$replacement 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnaptrrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('order')) { $Arguments.Add('order', $order) }
            if ($PSBoundParameters.ContainsKey('recordid')) { $Arguments.Add('recordid', $recordid) }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSBoundParameters.ContainsKey('preference')) { $Arguments.Add('preference', $preference) }
            if ($PSBoundParameters.ContainsKey('flags')) { $Arguments.Add('flags', $flags) }
            if ($PSBoundParameters.ContainsKey('services')) { $Arguments.Add('services', $services) }
            if ($PSBoundParameters.ContainsKey('regexp')) { $Arguments.Add('regexp', $regexp) }
            if ($PSBoundParameters.ContainsKey('replacement')) { $Arguments.Add('replacement', $replacement) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Name of the domain for the NAPTR record. 
    .PARAMETER GetAll 
        Retreive all dnsnaptrrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsnaptrrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsnaptrrec
    .EXAMPLE 
        Invoke-ADCGetDnsnaptrrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsnaptrrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsnaptrrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsnaptrrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsnaptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnaptrrec/
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
        [string]$domain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsnaptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnaptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnaptrrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnaptrrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnaptrrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnaptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER hostname 
       Name of the domain. 
    .PARAMETER GetAll 
        Retreive all dnsnsecrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsnsecrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsnsecrec
    .EXAMPLE 
        Invoke-ADCGetDnsnsecrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsnsecrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsnsecrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsnsecrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsnsecrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsecrec/
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
        [string]$hostname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsnsecrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsecrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsecrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsecrec configuration for property 'hostname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Resource $hostname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsecrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsecrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name.  
        Minimum length = 1 
    .PARAMETER nameserver 
        Host name of the name server to add to the domain.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsnsrec item.
    .EXAMPLE
        Invoke-ADCAddDnsnsrec -domain <string> -nameserver <string>
    .NOTES
        File Name : Invoke-ADCAddDnsnsrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$nameserver ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsnsrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                nameserver = $nameserver
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsnsrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsnsrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsnsrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Domain name.  
       Minimum length = 1    .PARAMETER nameserver 
       Host name of the name server to add to the domain.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached name server record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnsnsrec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsnsrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [string]$nameserver ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsnsrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('nameserver')) { $Arguments.Add('nameserver', $nameserver) }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Domain name. 
    .PARAMETER GetAll 
        Retreive all dnsnsrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsnsrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsnsrec
    .EXAMPLE 
        Invoke-ADCGetDnsnsrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsnsrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsnsrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsnsrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsnsrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsnsrec/
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
        [string]$domain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsnsrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsnsrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsnsrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsnsrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsnsrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsnsrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER retries 
        Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 5 
    .PARAMETER minttl 
        Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed.  
        Minimum value = 0  
        Maximum value = 604800 
    .PARAMETER maxttl 
        Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed.  
        Default value: 604800  
        Minimum value = 1  
        Maximum value = 604800 
    .PARAMETER cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER namelookuppriority 
        Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature.  
        Default value: WINS  
        Possible values = WINS, DNS 
    .PARAMETER recursion 
        Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER resolutionorder 
        Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows:  
        * OnlyAQuery. Send queries for IPv4 address records (A records) only.  
        * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records).  
        * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server.  
        * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server.  
        Default value: OnlyAQuery  
        Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
    .PARAMETER dnssec 
        Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxpipeline 
        Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
    .PARAMETER dnsrootreferral 
        Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dns64timeout 
        While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query.  
        Minimum value = 0  
        Maximum value = 10000 
    .PARAMETER ecsmaxsubnets 
        Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 1280 
    .PARAMETER maxnegcachettl 
        Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed.  
        Default value: 604800  
        Minimum value = 1  
        Maximum value = 604800 
    .PARAMETER cachehitbypass 
        This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxcachesize 
        Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
    .PARAMETER maxnegativecachesize 
        Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
    .PARAMETER cachenoexpire 
        If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER splitpktqueryprocessing 
        Processing requests split across multiple packets.  
        Default value: ALLOW  
        Possible values = ALLOW, DROP 
    .PARAMETER cacheecszeroprefix 
        Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxudppacketsize 
        Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced.  
        Default value: 1280  
        Minimum value = 512  
        Maximum value = 16384 
    .PARAMETER nxdomainratelimitthreshold 
        Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached , DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        Invoke-ADCUpdateDnsparameter 
    .NOTES
        File Name : Invoke-ADCUpdateDnsparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateRange(1, 5)]
        [double]$retries ,

        [ValidateRange(0, 604800)]
        [double]$minttl ,

        [ValidateRange(1, 604800)]
        [double]$maxttl ,

        [ValidateSet('YES', 'NO')]
        [string]$cacherecords ,

        [ValidateSet('WINS', 'DNS')]
        [string]$namelookuppriority ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$recursion ,

        [ValidateSet('OnlyAQuery', 'OnlyAAAAQuery', 'AThenAAAAQuery', 'AAAAThenAQuery')]
        [string]$resolutionorder ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnssec ,

        [double]$maxpipeline ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsrootreferral ,

        [ValidateRange(0, 10000)]
        [double]$dns64timeout ,

        [ValidateRange(0, 1280)]
        [double]$ecsmaxsubnets ,

        [ValidateRange(1, 604800)]
        [double]$maxnegcachettl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cachehitbypass ,

        [double]$maxcachesize ,

        [double]$maxnegativecachesize ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cachenoexpire ,

        [ValidateSet('ALLOW', 'DROP')]
        [string]$splitpktqueryprocessing ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacheecszeroprefix ,

        [ValidateRange(512, 16384)]
        [double]$maxudppacketsize ,

        [double]$nxdomainratelimitthreshold 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('retries')) { $Payload.Add('retries', $retries) }
            if ($PSBoundParameters.ContainsKey('minttl')) { $Payload.Add('minttl', $minttl) }
            if ($PSBoundParameters.ContainsKey('maxttl')) { $Payload.Add('maxttl', $maxttl) }
            if ($PSBoundParameters.ContainsKey('cacherecords')) { $Payload.Add('cacherecords', $cacherecords) }
            if ($PSBoundParameters.ContainsKey('namelookuppriority')) { $Payload.Add('namelookuppriority', $namelookuppriority) }
            if ($PSBoundParameters.ContainsKey('recursion')) { $Payload.Add('recursion', $recursion) }
            if ($PSBoundParameters.ContainsKey('resolutionorder')) { $Payload.Add('resolutionorder', $resolutionorder) }
            if ($PSBoundParameters.ContainsKey('dnssec')) { $Payload.Add('dnssec', $dnssec) }
            if ($PSBoundParameters.ContainsKey('maxpipeline')) { $Payload.Add('maxpipeline', $maxpipeline) }
            if ($PSBoundParameters.ContainsKey('dnsrootreferral')) { $Payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ($PSBoundParameters.ContainsKey('dns64timeout')) { $Payload.Add('dns64timeout', $dns64timeout) }
            if ($PSBoundParameters.ContainsKey('ecsmaxsubnets')) { $Payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ($PSBoundParameters.ContainsKey('maxnegcachettl')) { $Payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ($PSBoundParameters.ContainsKey('cachehitbypass')) { $Payload.Add('cachehitbypass', $cachehitbypass) }
            if ($PSBoundParameters.ContainsKey('maxcachesize')) { $Payload.Add('maxcachesize', $maxcachesize) }
            if ($PSBoundParameters.ContainsKey('maxnegativecachesize')) { $Payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ($PSBoundParameters.ContainsKey('cachenoexpire')) { $Payload.Add('cachenoexpire', $cachenoexpire) }
            if ($PSBoundParameters.ContainsKey('splitpktqueryprocessing')) { $Payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ($PSBoundParameters.ContainsKey('cacheecszeroprefix')) { $Payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ($PSBoundParameters.ContainsKey('maxudppacketsize')) { $Payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ($PSBoundParameters.ContainsKey('nxdomainratelimitthreshold')) { $Payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
 
            if ($PSCmdlet.ShouldProcess("dnsparameter", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsparameter -Payload $Payload -GetWarning
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER retries 
       Maximum number of retry attempts when no response is received for a query sent to a name server. Applies to end resolver and forwarder configurations. 
   .PARAMETER minttl 
       Minimum permissible time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is lower than the value configured for minTTL, the TTL of the record is set to the value of minTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
   .PARAMETER maxttl 
       Maximum time to live (TTL) for all records cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxTTL, the TTL of the record is set to the value of maxTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
   .PARAMETER cacherecords 
       Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again.  
       Possible values = YES, NO 
   .PARAMETER namelookuppriority 
       Type of lookup (DNS or WINS) to attempt first. If the first-priority lookup fails, the second-priority lookup is attempted. Used only by the SSL VPN feature.  
       Possible values = WINS, DNS 
   .PARAMETER recursion 
       Function as an end resolver and recursively resolve queries for domains that are not hosted on the Citrix ADC. Also resolve queries recursively when the external name servers configured on the appliance (for a forwarder configuration) are unavailable. When external name servers are unavailable, the appliance queries a root server and resolves the request recursively, as it does for an end resolver configuration.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER resolutionorder 
       Type of DNS queries (A, AAAA, or both) to generate during the routine functioning of certain Citrix ADC features, such as SSL VPN, cache redirection, and the integrated cache. The queries are sent to the external name servers that are configured for the forwarder function. If you specify both query types, you can also specify the order. Available settings function as follows:  
       * OnlyAQuery. Send queries for IPv4 address records (A records) only.  
       * OnlyAAAAQuery. Send queries for IPv6 address records (AAAA records) instead of queries for IPv4 address records (A records).  
       * AThenAAAAQuery. Send a query for an A record, and then send a query for an AAAA record if the query for the A record results in a NODATA response from the name server.  
       * AAAAThenAQuery. Send a query for an AAAA record, and then send a query for an A record if the query for the AAAA record results in a NODATA response from the name server.  
       Possible values = OnlyAQuery, OnlyAAAAQuery, AThenAAAAQuery, AAAAThenAQuery 
   .PARAMETER dnssec 
       Enable or disable the Domain Name System Security Extensions (DNSSEC) feature on the appliance. Note: Even when the DNSSEC feature is enabled, forwarder configurations (used by internal Citrix ADC features such as SSL VPN and Cache Redirection for name resolution) do not support the DNSSEC OK (DO) bit in the EDNS0 OPT header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxpipeline 
       Maximum number of concurrent DNS requests to allow on a single client connection, which is identified by the <clientip:port>-<vserver ip:port> tuple. A value of 0 (zero) applies no limit to the number of concurrent DNS requests allowed on a single client connection. 
   .PARAMETER dnsrootreferral 
       Send a root referral if a client queries a domain name that is unrelated to the domains configured/cached on the Citrix ADC. If the setting is disabled, the appliance sends a blank response instead of a root referral. Applicable to domains for which the appliance is authoritative. Disable the parameter when the appliance is under attack from a client that is sending a flood of queries for unrelated domains.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dns64timeout 
       While doing DNS64 resolution, this parameter specifies the time to wait before sending an A query if no response is received from backend DNS server for AAAA query. 
   .PARAMETER ecsmaxsubnets 
       Maximum number of subnets that can be cached corresponding to a single domain. Subnet caching will occur for responses with EDNS Client Subnet (ECS) option. Caching of such responses can be disabled using DNS profile settings. A value of zero indicates that the number of subnets cached is limited only by existing memory constraints. The default value is zero. 
   .PARAMETER maxnegcachettl 
       Maximum time to live (TTL) for all negative records ( NXDONAIN and NODATA ) cached in the DNS cache by DNS proxy, end resolver, and forwarder configurations. If the TTL of a record that is to be cached is higher than the value configured for maxnegcacheTTL, the TTL of the record is set to the value of maxnegcacheTTL before caching. When you modify this setting, the new value is applied only to those records that are cached after the modification. The TTL values of existing records are not changed. 
   .PARAMETER cachehitbypass 
       This parameter is applicable only in proxy mode and if this parameter is enabled we will forward all the client requests to the backend DNS server and the response served will be cached on Citrix ADC.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxcachesize 
       Maximum memory, in megabytes, that can be used for dns caching per Packet Engine. 
   .PARAMETER maxnegativecachesize 
       Maximum memory, in megabytes, that can be used for caching of negative DNS responses per packet engine. 
   .PARAMETER cachenoexpire 
       If this flag is set to YES, the existing entries in cache do not age out. On reaching the max limit the cache records are frozen.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER splitpktqueryprocessing 
       Processing requests split across multiple packets.  
       Possible values = ALLOW, DROP 
   .PARAMETER cacheecszeroprefix 
       Cache ECS responses with a Scope Prefix length of zero. Such a cached response will be used for all queries with this domain name and any subnet. When disabled, ECS responses with Scope Prefix length of zero will be cached, but not tied to any subnet. This option has no effect if caching of ECS responses is disabled in the corresponding DNS profile.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxudppacketsize 
       Maximum UDP packet size that can be handled by Citrix ADC. This is the value advertised by Citrix ADC when responding as an authoritative server and it is also used when Citrix ADC queries other name servers as a forwarder. When acting as a proxy, requests from clients are limited by this parameter - if a request contains a size greater than this value in the OPT record, it will be replaced. 
   .PARAMETER nxdomainratelimitthreshold 
       Rate limit threshold for Non-Existant domain (NXDOMAIN) responses generated from Citrix ADC. Once the threshold is breached , DNS queries leading to NXDOMAIN response will be dropped. This threshold will not be applied for NXDOMAIN responses got from the backend. The threshold will be applied per packet engine and per second.
    .EXAMPLE
        Invoke-ADCUnsetDnsparameter 
    .NOTES
        File Name : Invoke-ADCUnsetDnsparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Boolean]$retries ,

        [Boolean]$minttl ,

        [Boolean]$maxttl ,

        [Boolean]$cacherecords ,

        [Boolean]$namelookuppriority ,

        [Boolean]$recursion ,

        [Boolean]$resolutionorder ,

        [Boolean]$dnssec ,

        [Boolean]$maxpipeline ,

        [Boolean]$dnsrootreferral ,

        [Boolean]$dns64timeout ,

        [Boolean]$ecsmaxsubnets ,

        [Boolean]$maxnegcachettl ,

        [Boolean]$cachehitbypass ,

        [Boolean]$maxcachesize ,

        [Boolean]$maxnegativecachesize ,

        [Boolean]$cachenoexpire ,

        [Boolean]$splitpktqueryprocessing ,

        [Boolean]$cacheecszeroprefix ,

        [Boolean]$maxudppacketsize ,

        [Boolean]$nxdomainratelimitthreshold 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('retries')) { $Payload.Add('retries', $retries) }
            if ($PSBoundParameters.ContainsKey('minttl')) { $Payload.Add('minttl', $minttl) }
            if ($PSBoundParameters.ContainsKey('maxttl')) { $Payload.Add('maxttl', $maxttl) }
            if ($PSBoundParameters.ContainsKey('cacherecords')) { $Payload.Add('cacherecords', $cacherecords) }
            if ($PSBoundParameters.ContainsKey('namelookuppriority')) { $Payload.Add('namelookuppriority', $namelookuppriority) }
            if ($PSBoundParameters.ContainsKey('recursion')) { $Payload.Add('recursion', $recursion) }
            if ($PSBoundParameters.ContainsKey('resolutionorder')) { $Payload.Add('resolutionorder', $resolutionorder) }
            if ($PSBoundParameters.ContainsKey('dnssec')) { $Payload.Add('dnssec', $dnssec) }
            if ($PSBoundParameters.ContainsKey('maxpipeline')) { $Payload.Add('maxpipeline', $maxpipeline) }
            if ($PSBoundParameters.ContainsKey('dnsrootreferral')) { $Payload.Add('dnsrootreferral', $dnsrootreferral) }
            if ($PSBoundParameters.ContainsKey('dns64timeout')) { $Payload.Add('dns64timeout', $dns64timeout) }
            if ($PSBoundParameters.ContainsKey('ecsmaxsubnets')) { $Payload.Add('ecsmaxsubnets', $ecsmaxsubnets) }
            if ($PSBoundParameters.ContainsKey('maxnegcachettl')) { $Payload.Add('maxnegcachettl', $maxnegcachettl) }
            if ($PSBoundParameters.ContainsKey('cachehitbypass')) { $Payload.Add('cachehitbypass', $cachehitbypass) }
            if ($PSBoundParameters.ContainsKey('maxcachesize')) { $Payload.Add('maxcachesize', $maxcachesize) }
            if ($PSBoundParameters.ContainsKey('maxnegativecachesize')) { $Payload.Add('maxnegativecachesize', $maxnegativecachesize) }
            if ($PSBoundParameters.ContainsKey('cachenoexpire')) { $Payload.Add('cachenoexpire', $cachenoexpire) }
            if ($PSBoundParameters.ContainsKey('splitpktqueryprocessing')) { $Payload.Add('splitpktqueryprocessing', $splitpktqueryprocessing) }
            if ($PSBoundParameters.ContainsKey('cacheecszeroprefix')) { $Payload.Add('cacheecszeroprefix', $cacheecszeroprefix) }
            if ($PSBoundParameters.ContainsKey('maxudppacketsize')) { $Payload.Add('maxudppacketsize', $maxudppacketsize) }
            if ($PSBoundParameters.ContainsKey('nxdomainratelimitthreshold')) { $Payload.Add('nxdomainratelimitthreshold', $nxdomainratelimitthreshold) }
            if ($PSCmdlet.ShouldProcess("dnsparameter", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER GetAll 
        Retreive all dnsparameter object(s)
    .PARAMETER Count
        If specified, the count of the dnsparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsparameter
    .EXAMPLE 
        Invoke-ADCGetDnsparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetDnsparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsparameter/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnsparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER name 
        Name for the DNS policy. 
    .PARAMETER rule 
        Expression against which DNS traffic is evaluated.  
        Note:  
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks.  
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER viewname 
        The view name that must be used for the given policy. 
    .PARAMETER preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER preferredloclist 
        The location list in priority order used for the given policy.  
        Minimum length = 1 
    .PARAMETER drop 
        The dns packet must be dropped.  
        Possible values = YES, NO 
    .PARAMETER cachebypass 
        By pass dns cache for this.  
        Possible values = YES, NO 
    .PARAMETER actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows:  
        * dns_default_act_Drop. Drop the DNS request.  
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server.  
        You can create custom actions by using the add dns action command in the CLI or the DNS > Actions > Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        Invoke-ADCAddDnspolicy -name <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddDnspolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [string]$viewname ,

        [string]$preferredlocation ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$preferredloclist ,

        [ValidateSet('YES', 'NO')]
        [string]$drop ,

        [ValidateSet('YES', 'NO')]
        [string]$cachebypass ,

        [string]$actionname ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('preferredlocation')) { $Payload.Add('preferredlocation', $preferredlocation) }
            if ($PSBoundParameters.ContainsKey('preferredloclist')) { $Payload.Add('preferredloclist', $preferredloclist) }
            if ($PSBoundParameters.ContainsKey('drop')) { $Payload.Add('drop', $drop) }
            if ($PSBoundParameters.ContainsKey('cachebypass')) { $Payload.Add('cachebypass', $cachebypass) }
            if ($PSBoundParameters.ContainsKey('actionname')) { $Payload.Add('actionname', $actionname) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("dnspolicy", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicy -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER name 
       Name for the DNS policy. 
    .EXAMPLE
        Invoke-ADCDeleteDnspolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER name 
        Name for the DNS policy. 
    .PARAMETER rule 
        Expression against which DNS traffic is evaluated.  
        Note:  
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks.  
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Example: CLIENT.UDP.DNS.DOMAIN.EQ("domainname"). 
    .PARAMETER viewname 
        The view name that must be used for the given policy. 
    .PARAMETER preferredlocation 
        The location used for the given policy. This is deprecated attribute. Please use -prefLocList. 
    .PARAMETER preferredloclist 
        The location list in priority order used for the given policy.  
        Minimum length = 1 
    .PARAMETER drop 
        The dns packet must be dropped.  
        Possible values = YES, NO 
    .PARAMETER cachebypass 
        By pass dns cache for this.  
        Possible values = YES, NO 
    .PARAMETER actionname 
        Name of the DNS action to perform when the rule evaluates to TRUE. The built in actions function as follows:  
        * dns_default_act_Drop. Drop the DNS request.  
        * dns_default_act_Cachebypass. Bypass the DNS cache and forward the request to the name server.  
        You can create custom actions by using the add dns action command in the CLI or the DNS > Actions > Create DNS Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy item.
    .EXAMPLE
        Invoke-ADCUpdateDnspolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnspolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name ,

        [string]$rule ,

        [string]$viewname ,

        [string]$preferredlocation ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$preferredloclist ,

        [ValidateSet('YES', 'NO')]
        [string]$drop ,

        [ValidateSet('YES', 'NO')]
        [string]$cachebypass ,

        [string]$actionname ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('preferredlocation')) { $Payload.Add('preferredlocation', $preferredlocation) }
            if ($PSBoundParameters.ContainsKey('preferredloclist')) { $Payload.Add('preferredloclist', $preferredloclist) }
            if ($PSBoundParameters.ContainsKey('drop')) { $Payload.Add('drop', $drop) }
            if ($PSBoundParameters.ContainsKey('cachebypass')) { $Payload.Add('cachebypass', $cachebypass) }
            if ($PSBoundParameters.ContainsKey('actionname')) { $Payload.Add('actionname', $actionname) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("dnspolicy", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicy -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER name 
       Name for the DNS policy. 
   .PARAMETER logaction 
       Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetDnspolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnspolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnspolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name for the DNS policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicy
    .EXAMPLE 
        Invoke-ADCGetDnspolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicy -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER name 
        Name for the DNS64 policy. 
    .PARAMETER rule 
        Expression against which DNS traffic is evaluated.  
        Note:  
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks.  
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows:  
        * A default dns64 action with prefix <default prefix> and mapped and exclude are any  
        You can create custom actions by using the add dns action command in the CLI or the DNS64 > Actions > Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        Invoke-ADCAddDnspolicy64 -name <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddDnspolicy64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicy64: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("dnspolicy64", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicy64 -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER name 
       Name for the DNS64 policy. 
    .EXAMPLE
        Invoke-ADCDeleteDnspolicy64 -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicy64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicy64: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER name 
        Name for the DNS64 policy. 
    .PARAMETER rule 
        Expression against which DNS traffic is evaluated.  
        Note:  
        * On the command line interface, if the expression includes blank spaces, the entire expression must be enclosed in double quotation marks.  
        * If the expression itself includes double quotation marks, you must escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Example: CLIENT.IP.SRC.IN_SUBENT(23.34.0.0/16). 
    .PARAMETER action 
        Name of the DNS64 action to perform when the rule evaluates to TRUE. The built in actions function as follows:  
        * A default dns64 action with prefix <default prefix> and mapped and exclude are any  
        You can create custom actions by using the add dns action command in the CLI or the DNS64 > Actions > Create DNS64 Action dialog box in the Citrix ADC configuration utility. 
    .PARAMETER PassThru 
        Return details about the created dnspolicy64 item.
    .EXAMPLE
        Invoke-ADCUpdateDnspolicy64 -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnspolicy64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$name ,

        [string]$rule ,

        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnspolicy64: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("dnspolicy64", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicy64 -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicy64 -Filter $Payload)
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name for the DNS64 policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy64 object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy64 object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicy64
    .EXAMPLE 
        Invoke-ADCGetDnspolicy64 -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicy64 -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicy64 -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicy64 -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnspolicy64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64 objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64 objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64 configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64 configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64 -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy64_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy64_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicy64binding
    .EXAMPLE 
        Invoke-ADCGetDnspolicy64binding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnspolicy64binding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicy64binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64binding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicy64binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name of the DNS64 policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy64_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy64_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicy64lbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicy64lbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicy64lbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicy64lbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicy64lbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicy64lbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy64_lbvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicy64_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy64_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy64_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy64_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER labelname 
        Name of the dns policy label. 
    .PARAMETER transform 
        The type of transformations allowed by the policies bound to the label.  
        Possible values = dns_req, dns_res 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        Invoke-ADCAddDnspolicylabel -labelname <string> -transform <string>
    .NOTES
        File Name : Invoke-ADCAddDnspolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('dns_req', 'dns_res')]
        [string]$transform ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                transform = $transform
            }

 
            if ($PSCmdlet.ShouldProcess("dnspolicylabel", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicylabel -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER labelname 
       Name of the dns policy label. 
    .EXAMPLE
        Invoke-ADCDeleteDnspolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Rename Domain Name Service configuration Object
    .DESCRIPTION
        Rename Domain Name Service configuration Object 
    .PARAMETER labelname 
        Name of the dns policy label. 
    .PARAMETER newname 
        The new name of the dns policylabel.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameDnspolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameDnspolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameDnspolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("dnspolicylabel", "Rename Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnspolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicylabel -Filter $Payload)
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER labelname 
       Name of the dns policy label. 
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
        Invoke-ADCGetDnspolicylabel
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER labelname 
       Name of the dns policy label. 
    .PARAMETER GetAll 
        Retreive all dnspolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER labelname 
        Name of the dns policy label. 
    .PARAMETER policyname 
        The dns policy name. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = policylabel 
    .PARAMETER invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created dnspolicylabel_dnspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddDnspolicylabeldnspolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddDnspolicylabeldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnspolicylabeldnspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('invoke_labelname')) { $Payload.Add('invoke_labelname', $invoke_labelname) }
 
            if ($PSCmdlet.ShouldProcess("dnspolicylabel_dnspolicy_binding", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnspolicylabel_dnspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnspolicylabeldnspolicybinding -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER labelname 
       Name of the dns policy label.    .PARAMETER policyname 
       The dns policy name.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteDnspolicylabeldnspolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnspolicylabeldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$labelname ,

        [string]$policyname ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnspolicylabeldnspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER labelname 
       Name of the dns policy label. 
    .PARAMETER GetAll 
        Retreive all dnspolicylabel_dnspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_dnspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicylabeldnspolicybinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabeldnspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabeldnspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicylabeldnspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicylabeldnspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabeldnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_dnspolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER labelname 
       Name of the dns policy label. 
    .PARAMETER GetAll 
        Retreive all dnspolicylabel_policybinding_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicylabel_policybinding_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelpolicybindingbinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabelpolicybindingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicylabelpolicybindingbinding -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelpolicybindingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicylabelpolicybindingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicylabel_policybinding_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name of the DNS policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicybinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name of the DNS policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy_dnsglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnsglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicydnsglobalbinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicydnsglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicydnsglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicydnsglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicydnsglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicydnsglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_dnsglobal_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicy_dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER name 
       Name of the DNS policy. 
    .PARAMETER GetAll 
        Retreive all dnspolicy_dnspolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnspolicy_dnspolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnspolicydnspolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetDnspolicydnspolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnspolicydnspolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetDnspolicydnspolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnspolicydnspolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnspolicydnspolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnspolicy_dnspolicylabel_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnspolicy_dnspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnspolicy_dnspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnspolicy_dnspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER dnsprofilename 
        Name of the DNS profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags , DNS domain name and DNS query type will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        Invoke-ADCAddDnsprofile -dnsprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddDnsprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsquerylogging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsanswerseclogging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsextendedlogging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnserrorlogging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacherecords = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cachenegativeresponses = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dropmultiqueryrequest = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacheecsresponses = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                dnsprofilename = $dnsprofilename
            }
            if ($PSBoundParameters.ContainsKey('dnsquerylogging')) { $Payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ($PSBoundParameters.ContainsKey('dnsanswerseclogging')) { $Payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ($PSBoundParameters.ContainsKey('dnsextendedlogging')) { $Payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ($PSBoundParameters.ContainsKey('dnserrorlogging')) { $Payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ($PSBoundParameters.ContainsKey('cacherecords')) { $Payload.Add('cacherecords', $cacherecords) }
            if ($PSBoundParameters.ContainsKey('cachenegativeresponses')) { $Payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ($PSBoundParameters.ContainsKey('dropmultiqueryrequest')) { $Payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ($PSBoundParameters.ContainsKey('cacheecsresponses')) { $Payload.Add('cacheecsresponses', $cacheecsresponses) }
 
            if ($PSCmdlet.ShouldProcess("dnsprofile", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsprofile -Filter $Payload)
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER dnsprofilename 
        Name of the DNS profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dnsquerylogging 
        DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags , DNS domain name and DNS query type will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsanswerseclogging 
        DNS answer section; if enabled, answer section in the response will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnsextendedlogging 
        DNS extended logging; if enabled, authority and additional section in the response will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dnserrorlogging 
        DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacherecords 
        Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cachenegativeresponses 
        Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dropmultiqueryrequest 
        Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacheecsresponses 
        Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnsprofile item.
    .EXAMPLE
        Invoke-ADCUpdateDnsprofile -dnsprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnsprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsquerylogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsanswerseclogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnsextendedlogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnserrorlogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacherecords ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cachenegativeresponses ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dropmultiqueryrequest ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacheecsresponses ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                dnsprofilename = $dnsprofilename
            }
            if ($PSBoundParameters.ContainsKey('dnsquerylogging')) { $Payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ($PSBoundParameters.ContainsKey('dnsanswerseclogging')) { $Payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ($PSBoundParameters.ContainsKey('dnsextendedlogging')) { $Payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ($PSBoundParameters.ContainsKey('dnserrorlogging')) { $Payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ($PSBoundParameters.ContainsKey('cacherecords')) { $Payload.Add('cacherecords', $cacherecords) }
            if ($PSBoundParameters.ContainsKey('cachenegativeresponses')) { $Payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ($PSBoundParameters.ContainsKey('dropmultiqueryrequest')) { $Payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ($PSBoundParameters.ContainsKey('cacheecsresponses')) { $Payload.Add('cacheecsresponses', $cacheecsresponses) }
 
            if ($PSCmdlet.ShouldProcess("dnsprofile", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsprofile -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER dnsprofilename 
       Name of the DNS profile. 
   .PARAMETER dnsquerylogging 
       DNS query logging; if enabled, DNS query information such as DNS query id, DNS query flags , DNS domain name and DNS query type will be logged.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dnsanswerseclogging 
       DNS answer section; if enabled, answer section in the response will be logged.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dnsextendedlogging 
       DNS extended logging; if enabled, authority and additional section in the response will be logged.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dnserrorlogging 
       DNS error logging; if enabled, whenever error is encountered in DNS module reason for the error will be logged.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cacherecords 
       Cache resource records in the DNS cache. Applies to resource records obtained through proxy configurations only. End resolver and forwarder configurations always cache records in the DNS cache, and you cannot disable this behavior. When you disable record caching, the appliance stops caching server responses. However, cached records are not flushed. The appliance does not serve requests from the cache until record caching is enabled again.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cachenegativeresponses 
       Cache negative responses in the DNS cache. When disabled, the appliance stops caching negative responses except referral records. This applies to all configurations - proxy, end resolver, and forwarder. However, cached responses are not flushed. The appliance does not serve negative responses from the cache until this parameter is enabled again.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dropmultiqueryrequest 
       Drop the DNS requests containing multiple queries. When enabled, DNS requests containing multiple queries will be dropped. In case of proxy configuration by default the DNS request containing multiple queries is forwarded to the backend and in case of ADNS and Resolver configuration NOCODE error response will be sent to the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cacheecsresponses 
       Cache DNS responses with EDNS Client Subnet(ECS) option in the DNS cache. When disabled, the appliance stops caching responses with ECS option. This is relevant to proxy configuration. Enabling/disabling support of ECS option when Citrix ADC is authoritative for a GSLB domain is supported using a knob in GSLB vserver. In all other modes, ECS option is ignored.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetDnsprofile -dnsprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnsprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [Boolean]$dnsquerylogging ,

        [Boolean]$dnsanswerseclogging ,

        [Boolean]$dnsextendedlogging ,

        [Boolean]$dnserrorlogging ,

        [Boolean]$cacherecords ,

        [Boolean]$cachenegativeresponses ,

        [Boolean]$dropmultiqueryrequest ,

        [Boolean]$cacheecsresponses 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                dnsprofilename = $dnsprofilename
            }
            if ($PSBoundParameters.ContainsKey('dnsquerylogging')) { $Payload.Add('dnsquerylogging', $dnsquerylogging) }
            if ($PSBoundParameters.ContainsKey('dnsanswerseclogging')) { $Payload.Add('dnsanswerseclogging', $dnsanswerseclogging) }
            if ($PSBoundParameters.ContainsKey('dnsextendedlogging')) { $Payload.Add('dnsextendedlogging', $dnsextendedlogging) }
            if ($PSBoundParameters.ContainsKey('dnserrorlogging')) { $Payload.Add('dnserrorlogging', $dnserrorlogging) }
            if ($PSBoundParameters.ContainsKey('cacherecords')) { $Payload.Add('cacherecords', $cacherecords) }
            if ($PSBoundParameters.ContainsKey('cachenegativeresponses')) { $Payload.Add('cachenegativeresponses', $cachenegativeresponses) }
            if ($PSBoundParameters.ContainsKey('dropmultiqueryrequest')) { $Payload.Add('dropmultiqueryrequest', $dropmultiqueryrequest) }
            if ($PSBoundParameters.ContainsKey('cacheecsresponses')) { $Payload.Add('cacheecsresponses', $cacheecsresponses) }
            if ($PSCmdlet.ShouldProcess("$dnsprofilename", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnsprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER dnsprofilename 
       Name of the DNS profile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteDnsprofile -dnsprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$dnsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$dnsprofilename", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER dnsprofilename 
       Name of the DNS profile. 
    .PARAMETER GetAll 
        Retreive all dnsprofile object(s)
    .PARAMETER Count
        If specified, the count of the dnsprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsprofile
    .EXAMPLE 
        Invoke-ADCGetDnsprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsprofile -Count
    .EXAMPLE
        Invoke-ADCGetDnsprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsprofile/
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
        [string]$dnsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsprofile configuration for property 'dnsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Resource $dnsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Domain Name Service configuration Object
    .DESCRIPTION
        Flush Domain Name Service configuration Object 
    .PARAMETER type 
        Filter the DNS records to be flushed.e.g flush dns proxyRecords -type A will flush only the A records from the cache. .  
        Possible values = A, NS, CNAME, SOA, MX, AAAA, SRV, RRSIG, NSEC, DNSKEY, PTR, TXT, NAPTR 
    .PARAMETER negrectype 
        Filter the Negative DNS records i.e NXDOMAIN and NODATA entries to be flushed. e.g flush dns proxyRecords NXDOMAIN will flush only the NXDOMAIN entries from the cache.  
        Possible values = NXDOMAIN, NODATA
    .EXAMPLE
        Invoke-ADCFlushDnsproxyrecords 
    .NOTES
        File Name : Invoke-ADCFlushDnsproxyrecords
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsproxyrecords/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateSet('A', 'NS', 'CNAME', 'SOA', 'MX', 'AAAA', 'SRV', 'RRSIG', 'NSEC', 'DNSKEY', 'PTR', 'TXT', 'NAPTR')]
        [string]$type ,

        [ValidateSet('NXDOMAIN', 'NODATA')]
        [string]$negrectype 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushDnsproxyrecords: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('negrectype')) { $Payload.Add('negrectype', $negrectype) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsproxyrecords -Action flush -Payload $Payload -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER reversedomain 
        Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses.  
        Minimum length = 1 
    .PARAMETER domain 
        Domain name for which to configure reverse mapping.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnsptrrec item.
    .EXAMPLE
        Invoke-ADCAddDnsptrrec -reversedomain <string> -domain <string>
    .NOTES
        File Name : Invoke-ADCAddDnsptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reversedomain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsptrrec: Starting"
    }
    process {
        try {
            $Payload = @{
                reversedomain = $reversedomain
                domain = $domain
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnsptrrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsptrrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsptrrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER reversedomain 
       Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached PTR record need to be removed.    .PARAMETER domain 
       Domain name for which to configure reverse mapping.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteDnsptrrec -reversedomain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$reversedomain ,

        [string]$ecssubnet ,

        [string]$domain 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsptrrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Arguments.Add('domain', $domain) }
            if ($PSCmdlet.ShouldProcess("$reversedomain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER reversedomain 
       Reversed domain name representation of the IPv4 or IPv6 address for which to create the PTR record. Use the "in-addr.arpa." suffix for IPv4 addresses and the "ip6.arpa." suffix for IPv6 addresses. 
    .PARAMETER GetAll 
        Retreive all dnsptrrec object(s)
    .PARAMETER Count
        If specified, the count of the dnsptrrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsptrrec
    .EXAMPLE 
        Invoke-ADCGetDnsptrrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsptrrec -Count
    .EXAMPLE
        Invoke-ADCGetDnsptrrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsptrrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsptrrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsptrrec/
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
        [string]$reversedomain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsptrrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsptrrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsptrrec configuration for property 'reversedomain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Resource $reversedomain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsptrrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsptrrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name for which to add the SOA record.  
        Minimum length = 1 
    .PARAMETER originserver 
        Domain name of the name server that responds authoritatively for the domain.  
        Minimum length = 1 
    .PARAMETER contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com.  
        Minimum length = 1 
    .PARAMETER serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server.  
        Default value: 100  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails.  
        Default value: 3  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records.  
        Default value: 5  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        Invoke-ADCAddDnssoarec -domain <string> -originserver <string> -contact <string>
    .NOTES
        File Name : Invoke-ADCAddDnssoarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originserver ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$contact ,

        [ValidateRange(0, 4294967294)]
        [double]$serial = '100' ,

        [ValidateRange(0, 4294967294)]
        [double]$refresh = '3600' ,

        [ValidateRange(0, 4294967294)]
        [double]$retry = '3' ,

        [ValidateRange(0, 4294967294)]
        [double]$expire = '3600' ,

        [ValidateRange(0, 2147483647)]
        [double]$minimum = '5' ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssoarec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                originserver = $originserver
                contact = $contact
            }
            if ($PSBoundParameters.ContainsKey('serial')) { $Payload.Add('serial', $serial) }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('retry')) { $Payload.Add('retry', $retry) }
            if ($PSBoundParameters.ContainsKey('expire')) { $Payload.Add('expire', $expire) }
            if ($PSBoundParameters.ContainsKey('minimum')) { $Payload.Add('minimum', $minimum) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnssoarec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssoarec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnssoarec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Domain name for which to add the SOA record.  
       Minimum length = 1    .PARAMETER ecssubnet 
       Subnet for which the cached SOA record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnssoarec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnssoarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssoarec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name for which to add the SOA record.  
        Minimum length = 1 
    .PARAMETER originserver 
        Domain name of the name server that responds authoritatively for the domain.  
        Minimum length = 1 
    .PARAMETER contact 
        Email address of the contact to whom domain issues can be addressed. In the email address, replace the @ sign with a period (.). For example, enter domainadmin.example.com instead of domainadmin@example.com.  
        Minimum length = 1 
    .PARAMETER serial 
        The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server.  
        Default value: 100  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER refresh 
        Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER retry 
        Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails.  
        Default value: 3  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER expire 
        Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER minimum 
        Default time to live (TTL) for all records in the zone. Can be overridden for individual records.  
        Default value: 5  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnssoarec item.
    .EXAMPLE
        Invoke-ADCUpdateDnssoarec -domain <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnssoarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$originserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$contact ,

        [ValidateRange(0, 4294967294)]
        [double]$serial ,

        [ValidateRange(0, 4294967294)]
        [double]$refresh ,

        [ValidateRange(0, 4294967294)]
        [double]$retry ,

        [ValidateRange(0, 4294967294)]
        [double]$expire ,

        [ValidateRange(0, 2147483647)]
        [double]$minimum ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnssoarec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
            }
            if ($PSBoundParameters.ContainsKey('originserver')) { $Payload.Add('originserver', $originserver) }
            if ($PSBoundParameters.ContainsKey('contact')) { $Payload.Add('contact', $contact) }
            if ($PSBoundParameters.ContainsKey('serial')) { $Payload.Add('serial', $serial) }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('retry')) { $Payload.Add('retry', $retry) }
            if ($PSBoundParameters.ContainsKey('expire')) { $Payload.Add('expire', $expire) }
            if ($PSBoundParameters.ContainsKey('minimum')) { $Payload.Add('minimum', $minimum) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnssoarec", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnssoarec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnssoarec -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER domain 
       Domain name for which to add the SOA record. 
   .PARAMETER serial 
       The secondary server uses this parameter to determine whether it requires a zone transfer from the primary server. 
   .PARAMETER refresh 
       Time, in seconds, for which a secondary server must wait between successive checks on the value of the serial number. 
   .PARAMETER retry 
       Time, in seconds, between retries if a secondary server's attempt to contact the primary server for a zone refresh fails. 
   .PARAMETER expire 
       Time, in seconds, after which the zone data on a secondary name server can no longer be considered authoritative because all refresh and retry attempts made during the period have failed. After the expiry period, the secondary server stops serving the zone. Typically one week. Not used by the primary server. 
   .PARAMETER minimum 
       Default time to live (TTL) for all records in the zone. Can be overridden for individual records. 
   .PARAMETER ttl 
       Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        Invoke-ADCUnsetDnssoarec -domain <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnssoarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Boolean]$serial ,

        [Boolean]$refresh ,

        [Boolean]$retry ,

        [Boolean]$expire ,

        [Boolean]$minimum ,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnssoarec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
            }
            if ($PSBoundParameters.ContainsKey('serial')) { $Payload.Add('serial', $serial) }
            if ($PSBoundParameters.ContainsKey('refresh')) { $Payload.Add('refresh', $refresh) }
            if ($PSBoundParameters.ContainsKey('retry')) { $Payload.Add('retry', $retry) }
            if ($PSBoundParameters.ContainsKey('expire')) { $Payload.Add('expire', $expire) }
            if ($PSBoundParameters.ContainsKey('minimum')) { $Payload.Add('minimum', $minimum) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSCmdlet.ShouldProcess("$domain", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnssoarec -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Domain name for which to add the SOA record. 
    .PARAMETER GetAll 
        Retreive all dnssoarec object(s)
    .PARAMETER Count
        If specified, the count of the dnssoarec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnssoarec
    .EXAMPLE 
        Invoke-ADCGetDnssoarec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnssoarec -Count
    .EXAMPLE
        Invoke-ADCGetDnssoarec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnssoarec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnssoarec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssoarec/
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
        [string]$domain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnssoarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssoarec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssoarec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssoarec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssoarec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssoarec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com.  
        Minimum length = 1 
    .PARAMETER target 
        Target host for the specified service. 
    .PARAMETER priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER port 
        Port on which the target host listens for client requests.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647
    .EXAMPLE
        Invoke-ADCAddDnssrvrec -domain <string> -target <string> -priority <double> -weight <double> -port <double>
    .NOTES
        File Name : Invoke-ADCAddDnssrvrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [string]$target ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$priority ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$weight ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 65535)]
        [double]$port ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssrvrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                target = $target
                priority = $priority
                weight = $weight
                port = $port
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnssrvrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssrvrec -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com.  
       Minimum length = 1    .PARAMETER target 
       Target host for the specified service.    .PARAMETER ecssubnet 
       Subnet for which the cached SRV record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnssrvrec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnssrvrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [string]$target ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssrvrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('target')) { $Arguments.Add('target', $target) }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssrvrec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER domain 
        Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com.  
        Minimum length = 1 
    .PARAMETER target 
        Target host for the specified service. 
    .PARAMETER priority 
        Integer specifying the priority of the target host. The lower the number, the higher the priority. If multiple target hosts have the same priority, selection is based on the Weight parameter.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER weight 
        Weight for the target host. Aids host selection when two or more hosts have the same priority. A larger number indicates greater weight.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER port 
        Port on which the target host listens for client requests.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647
    .EXAMPLE
        Invoke-ADCUpdateDnssrvrec -domain <string> -target <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnssrvrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [string]$target ,

        [ValidateRange(0, 65535)]
        [double]$priority ,

        [ValidateRange(0, 65535)]
        [double]$weight ,

        [ValidateRange(0, 65535)]
        [double]$port ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnssrvrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                target = $target
            }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnssrvrec", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnssrvrec -Payload $Payload -GetWarning
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER domain 
       Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
   .PARAMETER target 
       Target host for the specified service. 
   .PARAMETER ttl 
       Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.
    .EXAMPLE
        Invoke-ADCUnsetDnssrvrec -domain <string> -target <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnssrvrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [string]$target ,

        [Boolean]$ttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnssrvrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                target = $target
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSCmdlet.ShouldProcess("$domain target", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnssrvrec -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Domain name, which, by convention, is prefixed by the symbolic name of the desired service and the symbolic name of the desired protocol, each with an underscore (_) prepended. For example, if an SRV-aware client wants to discover a SIP service that is provided over UDP, in the domain example.com, the client performs a lookup for _sip._udp.example.com. 
    .PARAMETER target 
       Target host for the specified service. 
    .PARAMETER type 
       Type of records to display. Available settings function as follows:  
       * ADNS - Display all authoritative address records.  
       * PROXY - Display all proxy address records.  
       * ALL - Display all address records.  
       Possible values = ALL, ADNS, PROXY 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all dnssrvrec object(s)
    .PARAMETER Count
        If specified, the count of the dnssrvrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnssrvrec
    .EXAMPLE 
        Invoke-ADCGetDnssrvrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnssrvrec -Count
    .EXAMPLE
        Invoke-ADCGetDnssrvrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnssrvrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnssrvrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssrvrec/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$target ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'ADNS', 'PROXY')]
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnssrvrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssrvrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssrvrec objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('domain')) { $Arguments.Add('domain', $domain) } 
                if ($PSBoundParameters.ContainsKey('target')) { $Arguments.Add('target', $target) } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssrvrec configuration for property ''"

            } else {
                Write-Verbose "Retrieving dnssrvrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssrvrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Domain Name Service configuration Object
    .DESCRIPTION
        Flush Domain Name Service configuration Object 
    .PARAMETER ecssubnet 
        ECS Subnet. 
    .PARAMETER all 
        Flush all the ECS subnets from the DNS cache.
    .EXAMPLE
        Invoke-ADCFlushDnssubnetcache 
    .NOTES
        File Name : Invoke-ADCFlushDnssubnetcache
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssubnetcache/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [string]$ecssubnet ,

        [boolean]$all 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushDnssubnetcache: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Payload.Add('ecssubnet', $ecssubnet) }
            if ($PSBoundParameters.ContainsKey('all')) { $Payload.Add('all', $all) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssubnetcache -Action flush -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER ecssubnet 
       ECS Subnet. 
    .PARAMETER GetAll 
        Retreive all dnssubnetcache object(s)
    .PARAMETER Count
        If specified, the count of the dnssubnetcache object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnssubnetcache
    .EXAMPLE 
        Invoke-ADCGetDnssubnetcache -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnssubnetcache -Count
    .EXAMPLE
        Invoke-ADCGetDnssubnetcache -name <string>
    .EXAMPLE
        Invoke-ADCGetDnssubnetcache -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnssubnetcache
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssubnetcache/
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
        [string]$ecssubnet,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnssubnetcache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssubnetcache objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssubnetcache objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssubnetcache configuration for property 'ecssubnet'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Resource $ecssubnet -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssubnetcache configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssubnetcache -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER Dnssuffix 
        Suffix to be appended when resolving domain names that are not fully qualified.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dnssuffix item.
    .EXAMPLE
        Invoke-ADCAddDnssuffix -Dnssuffix <string>
    .NOTES
        File Name : Invoke-ADCAddDnssuffix
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnssuffix ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnssuffix: Starting"
    }
    process {
        try {
            $Payload = @{
                Dnssuffix = $Dnssuffix
            }

 
            if ($PSCmdlet.ShouldProcess("dnssuffix", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnssuffix -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnssuffix -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER Dnssuffix 
       Suffix to be appended when resolving domain names that are not fully qualified.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteDnssuffix -Dnssuffix <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnssuffix
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$Dnssuffix 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnssuffix: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$Dnssuffix", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER Dnssuffix 
       Suffix to be appended when resolving domain names that are not fully qualified. 
    .PARAMETER GetAll 
        Retreive all dnssuffix object(s)
    .PARAMETER Count
        If specified, the count of the dnssuffix object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnssuffix
    .EXAMPLE 
        Invoke-ADCGetDnssuffix -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnssuffix -Count
    .EXAMPLE
        Invoke-ADCGetDnssuffix -name <string>
    .EXAMPLE
        Invoke-ADCGetDnssuffix -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnssuffix
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnssuffix/
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
        [string]$Dnssuffix,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnssuffix objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnssuffix objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnssuffix objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnssuffix configuration for property 'Dnssuffix'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Resource $Dnssuffix -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnssuffix configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnssuffix -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER domain 
        Name of the domain for the TXT record.  
        Minimum length = 1 
    .PARAMETER String 
        Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you.  
        Maximum length = 255 
    .PARAMETER ttl 
        Time to Live (TTL), in seconds, for the record. TTL is the time for which the record must be cached by DNS proxies. The specified TTL is applied to all the resource records that are of the same record type and belong to the specified domain name. For example, if you add an address record, with a TTL of 36000, to the domain name example.com, the TTLs of all the address records of example.com are changed to 36000. If the TTL is not specified, the Citrix ADC uses either the DNS zone's minimum TTL or, if the SOA record is not available on the appliance, the default value of 3600.  
        Default value: 3600  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER PassThru 
        Return details about the created dnstxtrec item.
    .EXAMPLE
        Invoke-ADCAddDnstxtrec -domain <string> -String <string[]>
    .NOTES
        File Name : Invoke-ADCAddDnstxtrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [Parameter(Mandatory = $true)]
        [string[]]$String ,

        [ValidateRange(0, 2147483647)]
        [double]$ttl = '3600' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnstxtrec: Starting"
    }
    process {
        try {
            $Payload = @{
                domain = $domain
                String = $String
            }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
 
            if ($PSCmdlet.ShouldProcess("dnstxtrec", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnstxtrec -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnstxtrec -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER domain 
       Name of the domain for the TXT record.  
       Minimum length = 1    .PARAMETER String 
       Information to store in the TXT resource record. Enclose the string in single or double quotation marks. A TXT resource record can contain up to six strings, each of which can contain up to 255 characters. If you want to add a string of more than 255 characters, evaluate whether splitting it into two or more smaller strings, subject to the six-string limit, works for you.  
       Maximum length = 255    .PARAMETER recordid 
       Unique, internally generated record ID. View the details of the TXT record to obtain its record ID. Mutually exclusive with the string parameter.  
       Minimum value = 1  
       Maximum value = 65535    .PARAMETER ecssubnet 
       Subnet for which the cached TXT record need to be removed.
    .EXAMPLE
        Invoke-ADCDeleteDnstxtrec -domain <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnstxtrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$domain ,

        [string[]]$String ,

        [double]$recordid ,

        [string]$ecssubnet 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnstxtrec: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('String')) { $Arguments.Add('String', $String) }
            if ($PSBoundParameters.ContainsKey('recordid')) { $Arguments.Add('recordid', $recordid) }
            if ($PSBoundParameters.ContainsKey('ecssubnet')) { $Arguments.Add('ecssubnet', $ecssubnet) }
            if ($PSCmdlet.ShouldProcess("$domain", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER domain 
       Name of the domain for the TXT record. 
    .PARAMETER GetAll 
        Retreive all dnstxtrec object(s)
    .PARAMETER Count
        If specified, the count of the dnstxtrec object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnstxtrec
    .EXAMPLE 
        Invoke-ADCGetDnstxtrec -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnstxtrec -Count
    .EXAMPLE
        Invoke-ADCGetDnstxtrec -name <string>
    .EXAMPLE
        Invoke-ADCGetDnstxtrec -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnstxtrec
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnstxtrec/
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
        [string]$domain,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnstxtrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnstxtrec objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnstxtrec objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnstxtrec configuration for property 'domain'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Resource $domain -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnstxtrec configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnstxtrec -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER viewname 
        Name for the DNS view.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created dnsview item.
    .EXAMPLE
        Invoke-ADCAddDnsview -viewname <string>
    .NOTES
        File Name : Invoke-ADCAddDnsview
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$viewname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnsview: Starting"
    }
    process {
        try {
            $Payload = @{
                viewname = $viewname
            }

 
            if ($PSCmdlet.ShouldProcess("dnsview", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnsview -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnsview -Filter $Payload)
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER viewname 
       Name for the DNS view.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteDnsview -viewname <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnsview
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$viewname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnsview: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$viewname", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Arguments $Arguments
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER viewname 
       Name for the DNS view. 
    .PARAMETER GetAll 
        Retreive all dnsview object(s)
    .PARAMETER Count
        If specified, the count of the dnsview object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsview
    .EXAMPLE 
        Invoke-ADCGetDnsview -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsview -Count
    .EXAMPLE
        Invoke-ADCGetDnsview -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsview -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsview
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview/
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
        [string]$viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnsview objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER viewname 
       Name of the view to display. 
    .PARAMETER GetAll 
        Retreive all dnsview_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnsview_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsviewbinding
    .EXAMPLE 
        Invoke-ADCGetDnsviewbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnsviewbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsviewbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsviewbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_binding/
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
        [string]$viewname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnsviewbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER viewname 
       Name of the view to display. 
    .PARAMETER GetAll 
        Retreive all dnsview_dnspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnsview_dnspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsviewdnspolicybinding
    .EXAMPLE 
        Invoke-ADCGetDnsviewdnspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsviewdnspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetDnsviewdnspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsviewdnspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsviewdnspolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_dnspolicy_binding/
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
        [string]$viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnsview_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_dnspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_dnspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_dnspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER viewname 
       Name of the view to display. 
    .PARAMETER GetAll 
        Retreive all dnsview_gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnsview_gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnsviewgslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetDnsviewgslbservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnsviewgslbservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetDnsviewgslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnsviewgslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnsviewgslbservicebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnsview_gslbservice_binding/
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
        [string]$viewname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnsview_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnsview_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration for property 'viewname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Resource $viewname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnsview_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnsview_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Domain Name Service configuration Object
    .DESCRIPTION
        Add Domain Name Service configuration Object 
    .PARAMETER zonename 
        Name of the zone to create.  
        Minimum length = 1 
    .PARAMETER proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios:  
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone.  
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers.  
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance.  
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone.  
        Default value: ENABLED  
        Possible values = YES, NO 
    .PARAMETER dnssecoffload 
        Enable dnssec offload for this zone.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nsec 
        Enable nsec generation for dnssec offload.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        Invoke-ADCAddDnszone -zonename <string> -proxymode <string>
    .NOTES
        File Name : Invoke-ADCAddDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('YES', 'NO')]
        [string]$proxymode = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnssecoffload = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$nsec = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddDnszone: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
                proxymode = $proxymode
            }
            if ($PSBoundParameters.ContainsKey('dnssecoffload')) { $Payload.Add('dnssecoffload', $dnssecoffload) }
            if ($PSBoundParameters.ContainsKey('nsec')) { $Payload.Add('nsec', $nsec) }
 
            if ($PSCmdlet.ShouldProcess("dnszone", "Add Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnszone -Filter $Payload)
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
        Update Domain Name Service configuration Object
    .DESCRIPTION
        Update Domain Name Service configuration Object 
    .PARAMETER zonename 
        Name of the zone to create.  
        Minimum length = 1 
    .PARAMETER proxymode 
        Deploy the zone in proxy mode. Enable in the following scenarios:  
        * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone.  
        * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers.  
        In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance.  
        Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone.  
        Default value: ENABLED  
        Possible values = YES, NO 
    .PARAMETER dnssecoffload 
        Enable dnssec offload for this zone.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nsec 
        Enable nsec generation for dnssec offload.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created dnszone item.
    .EXAMPLE
        Invoke-ADCUpdateDnszone -zonename <string>
    .NOTES
        File Name : Invoke-ADCUpdateDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [ValidateSet('YES', 'NO')]
        [string]$proxymode ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dnssecoffload ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$nsec ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateDnszone: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
            }
            if ($PSBoundParameters.ContainsKey('proxymode')) { $Payload.Add('proxymode', $proxymode) }
            if ($PSBoundParameters.ContainsKey('dnssecoffload')) { $Payload.Add('dnssecoffload', $dnssecoffload) }
            if ($PSBoundParameters.ContainsKey('nsec')) { $Payload.Add('nsec', $nsec) }
 
            if ($PSCmdlet.ShouldProcess("dnszone", "Update Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type dnszone -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetDnszone -Filter $Payload)
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
        Unset Domain Name Service configuration Object
    .DESCRIPTION
        Unset Domain Name Service configuration Object 
   .PARAMETER zonename 
       Name of the zone to create. 
   .PARAMETER proxymode 
       Deploy the zone in proxy mode. Enable in the following scenarios:  
       * The load balanced DNS servers are authoritative for the zone and all resource records that are part of the zone.  
       * The load balanced DNS servers are authoritative for the zone, but the Citrix ADC owns a subset of the resource records that belong to the zone (partial zone ownership configuration). Typically seen in global server load balancing (GSLB) configurations, in which the appliance responds authoritatively to queries for GSLB domain names but forwards queries for other domain names in the zone to the load balanced servers.  
       In either scenario, do not create the zone's Start of Authority (SOA) and name server (NS) resource records on the appliance.  
       Disable if the appliance is authoritative for the zone, but make sure that you have created the SOA and NS records on the appliance before you create the zone.  
       Possible values = YES, NO 
   .PARAMETER dnssecoffload 
       Enable dnssec offload for this zone.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER nsec 
       Enable nsec generation for dnssec offload.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetDnszone -zonename <string>
    .NOTES
        File Name : Invoke-ADCUnsetDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [Boolean]$proxymode ,

        [Boolean]$dnssecoffload ,

        [Boolean]$nsec 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetDnszone: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
            }
            if ($PSBoundParameters.ContainsKey('proxymode')) { $Payload.Add('proxymode', $proxymode) }
            if ($PSBoundParameters.ContainsKey('dnssecoffload')) { $Payload.Add('dnssecoffload', $dnssecoffload) }
            if ($PSBoundParameters.ContainsKey('nsec')) { $Payload.Add('nsec', $nsec) }
            if ($PSCmdlet.ShouldProcess("$zonename", "Unset Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type dnszone -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Domain Name Service configuration Object
    .DESCRIPTION
        Delete Domain Name Service configuration Object
    .PARAMETER zonename 
       Name of the zone to create.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteDnszone -zonename <string>
    .NOTES
        File Name : Invoke-ADCDeleteDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [string]$zonename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteDnszone: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$zonename", "Delete Domain Name Service configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Arguments $Arguments
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
        Sign Domain Name Service configuration Object
    .DESCRIPTION
        Sign Domain Name Service configuration Object 
    .PARAMETER zonename 
        Name of the zone to create. 
    .PARAMETER keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        Invoke-ADCSignDnszone -zonename <string>
    .NOTES
        File Name : Invoke-ADCSignDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$keyname 

    )
    begin {
        Write-Verbose "Invoke-ADCSignDnszone: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
            }
            if ($PSBoundParameters.ContainsKey('keyname')) { $Payload.Add('keyname', $keyname) }
            if ($PSCmdlet.ShouldProcess($Name, "Sign Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action sign -Payload $Payload -GetWarning
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
        Unsign Domain Name Service configuration Object
    .DESCRIPTION
        Unsign Domain Name Service configuration Object 
    .PARAMETER zonename 
        Name of the zone to create. 
    .PARAMETER keyname 
        Name of the public/private DNS key pair with which to sign the zone. You can sign a zone with up to four keys.
    .EXAMPLE
        Invoke-ADCUnsignDnszone -zonename <string>
    .NOTES
        File Name : Invoke-ADCUnsignDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$zonename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$keyname 

    )
    begin {
        Write-Verbose "Invoke-ADCUnsignDnszone: Starting"
    }
    process {
        try {
            $Payload = @{
                zonename = $zonename
            }
            if ($PSBoundParameters.ContainsKey('keyname')) { $Payload.Add('keyname', $keyname) }
            if ($PSCmdlet.ShouldProcess($Name, "Unsign Domain Name Service configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type dnszone -Action unsign -Payload $Payload -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER zonename 
       Name of the zone to create. 
    .PARAMETER GetAll 
        Retreive all dnszone object(s)
    .PARAMETER Count
        If specified, the count of the dnszone object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnszone
    .EXAMPLE 
        Invoke-ADCGetDnszone -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnszone -Count
    .EXAMPLE
        Invoke-ADCGetDnszone -name <string>
    .EXAMPLE
        Invoke-ADCGetDnszone -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnszone
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone/
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
        [string]$zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all dnszone objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER zonename 
       Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retreive all dnszone_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnszone_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnszonebinding
    .EXAMPLE 
        Invoke-ADCGetDnszonebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetDnszonebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnszonebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnszonebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_binding/
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
        [string]$zonename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetDnszonebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnszone_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER zonename 
       Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retreive all dnszone_dnskey_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnszone_dnskey_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnszonednskeybinding
    .EXAMPLE 
        Invoke-ADCGetDnszonednskeybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnszonednskeybinding -Count
    .EXAMPLE
        Invoke-ADCGetDnszonednskeybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnszonednskeybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnszonednskeybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_dnskey_binding/
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
        [string]$zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnszone_dnskey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_dnskey_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_dnskey_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_dnskey_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Domain Name Service configuration object(s)
    .DESCRIPTION
        Get Domain Name Service configuration object(s)
    .PARAMETER zonename 
       Name of the zone. Mutually exclusive with the type parameter. 
    .PARAMETER GetAll 
        Retreive all dnszone_domain_binding object(s)
    .PARAMETER Count
        If specified, the count of the dnszone_domain_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetDnszonedomainbinding
    .EXAMPLE 
        Invoke-ADCGetDnszonedomainbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetDnszonedomainbinding -Count
    .EXAMPLE
        Invoke-ADCGetDnszonedomainbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetDnszonedomainbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetDnszonedomainbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/dns/dnszone_domain_binding/
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
        [string]$zonename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all dnszone_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for dnszone_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving dnszone_domain_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving dnszone_domain_binding configuration for property 'zonename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Resource $zonename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving dnszone_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type dnszone_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


