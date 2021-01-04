function Invoke-ADCSyncGslbconfig {
<#
    .SYNOPSIS
        Sync Global Server Load Balancing configuration Object
    .DESCRIPTION
        Sync Global Server Load Balancing configuration Object 
    .PARAMETER preview 
        Do not synchronize the GSLB sites, but display the commands that would be applied on the slave node upon synchronization. Mutually exclusive with the Save Configuration option. 
    .PARAMETER debugoutput 
        Generate verbose output when synchronizing the GSLB sites. The Debug option generates more verbose output than the sync gslb config command in which the option is not used, and is useful for analyzing synchronization issues.  
        NOTE: The Nitro parameter "debug" cannot be used in PowerShell thus an alternative name was chosen. 
    .PARAMETER forcesync 
        Force synchronization of the specified site even if a dependent configuration on the remote site is preventing synchronization or if one or more GSLB entities on the remote site have the same name but are of a different type. You can specify either the name of the remote site that you want to synchronize with the local site, or you can specify All Sites in the configuration utility (the string all-sites in the CLI). If you specify All Sites, all the sites in the GSLB setup are synchronized with the site on the master node.  
        Note: If you select the Force Sync option, the synchronization starts without displaying the commands that are going to be executed. 
    .PARAMETER nowarn 
        Suppress the warning and the confirmation prompt that are displayed before site synchronization begins. This option can be used in automation scripts that must not be interrupted by a prompt. 
    .PARAMETER saveconfig 
        Save the configuration on all the nodes participating in the synchronization process, automatically. The master saves its configuration immediately before synchronization begins. Slave nodes save their configurations after the process of synchronization is complete. A slave node saves its configuration only if the configuration difference was successfully applied to it. Mutually exclusive with the Preview option. 
    .PARAMETER command 
        Run the specified command on the master node and then on all the slave nodes. You cannot use this option with the force sync and preview options.
    .EXAMPLE
        Invoke-ADCSyncGslbconfig 
    .NOTES
        File Name : Invoke-ADCSyncGslbconfig
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbconfig/
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

        [boolean]$preview ,

        [boolean]$debugoutput ,

        [string]$forcesync ,

        [boolean]$nowarn ,

        [boolean]$saveconfig ,

        [string]$command 

    )
    begin {
        Write-Verbose "Invoke-ADCSyncGslbconfig: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('preview')) { $Payload.Add('preview', $preview) }
            if ($PSBoundParameters.ContainsKey('debugoutput')) { $Payload.Add('debug', $debugoutput) }
            if ($PSBoundParameters.ContainsKey('forcesync')) { $Payload.Add('forcesync', $forcesync) }
            if ($PSBoundParameters.ContainsKey('nowarn')) { $Payload.Add('nowarn', $nowarn) }
            if ($PSBoundParameters.ContainsKey('saveconfig')) { $Payload.Add('saveconfig', $saveconfig) }
            if ($PSBoundParameters.ContainsKey('command')) { $Payload.Add('command', $command) }
            if ($PSCmdlet.ShouldProcess($Name, "Sync Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbconfig -Action sync -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCSyncGslbconfig: Finished"
    }
}

function Invoke-ADCGetGslbdomain {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomain
    .EXAMPLE 
        Invoke-ADCGetGslbdomain -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomain -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomain -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomain -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomain
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain/
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
        Write-Verbose "Invoke-ADCGetGslbdomain: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomain: Ended"
    }
}

function Invoke-ADCGetGslbdomainbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomainbinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomainbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbdomainbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomainbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_binding/
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
        Write-Verbose "Invoke-ADCGetGslbdomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomainbinding: Ended"
    }
}

function Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_gslbservicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCGetGslbdomaingslbservicegroupbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservicegroup_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetGslbdomaingslbservicebinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservice_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbservicebinding: Ended"
    }
}

function Invoke-ADCGetGslbdomaingslbvserverbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_gslbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomaingslbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomaingslbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbvserver_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomaingslbvserverbinding: Ended"
    }
}

function Invoke-ADCGetGslbdomainlbmonitorbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the Domain. 
    .PARAMETER GetAll 
        Retreive all gslbdomain_lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbdomain_lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbdomainlbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetGslbdomainlbmonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbdomainlbmonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbdomainlbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbdomainlbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbdomainlbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_lbmonitor_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbdomainlbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbdomain_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbdomainlbmonitorbinding: Ended"
    }
}

function Invoke-ADCClearGslbldnsentries {
<#
    .SYNOPSIS
        Clear Global Server Load Balancing configuration Object
    .DESCRIPTION
        Clear Global Server Load Balancing configuration Object 
    .EXAMPLE
        Invoke-ADCClearGslbldnsentries 
    .NOTES
        File Name : Invoke-ADCClearGslbldnsentries
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentries/
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCClearGslbldnsentries: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbldnsentries -Action clear -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearGslbldnsentries: Finished"
    }
}

function Invoke-ADCGetGslbldnsentries {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all gslbldnsentries object(s)
    .PARAMETER Count
        If specified, the count of the gslbldnsentries object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbldnsentries
    .EXAMPLE 
        Invoke-ADCGetGslbldnsentries -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbldnsentries -Count
    .EXAMPLE
        Invoke-ADCGetGslbldnsentries -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbldnsentries -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbldnsentries
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentries/
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
        Write-Verbose "Invoke-ADCGetGslbldnsentries: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbldnsentries objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbldnsentries objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbldnsentries objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbldnsentries configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbldnsentries configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbldnsentries: Ended"
    }
}

function Invoke-ADCDeleteGslbldnsentry {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
     .PARAMETER ipaddress 
       IP address of the LDNS server.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteGslbldnsentry 
    .NOTES
        File Name : Invoke-ADCDeleteGslbldnsentry
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentry/
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

        [string]$ipaddress 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbldnsentry: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Arguments.Add('ipaddress', $ipaddress) }
            if ($PSCmdlet.ShouldProcess("gslbldnsentry", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbldnsentry -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbldnsentry: Finished"
    }
}

function Invoke-ADCUpdateGslbparameter {
<#
    .SYNOPSIS
        Update Global Server Load Balancing configuration Object
    .DESCRIPTION
        Update Global Server Load Balancing configuration Object 
    .PARAMETER ldnsentrytimeout 
        Time, in seconds, after which an inactive LDNS entry is removed.  
        Default value: 180  
        Minimum value = 30  
        Maximum value = 65534 
    .PARAMETER rtttolerance 
        Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible.  
        Default value: 5  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER ldnsmask 
        The IPv4 network mask with which to create LDNS entries.  
        Minimum length = 1 
    .PARAMETER v6ldnsmasklen 
        Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER ldnsprobeorder 
        Order in which monitors should be initiated to calculate RTT.  
        Possible values = PING, DNS, TCP 
    .PARAMETER dropldnsreq 
        Drop LDNS requests if round-trip time (RTT) information is not available.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER gslbsvcstatedelaytime 
        Amount of delay in updating the state of GSLB service to DOWN when MEP goes down.  
        This parameter is applicable only if monitors are not bound to GSLB services.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 3600 
    .PARAMETER automaticconfigsync 
        GSLB configuration will be synced automatically to remote gslb sites if enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateGslbparameter 
    .NOTES
        File Name : Invoke-ADCUpdateGslbparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter/
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

        [ValidateRange(30, 65534)]
        [double]$ldnsentrytimeout ,

        [ValidateRange(1, 100)]
        [double]$rtttolerance ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ldnsmask ,

        [ValidateRange(1, 128)]
        [double]$v6ldnsmasklen ,

        [ValidateSet('PING', 'DNS', 'TCP')]
        [string[]]$ldnsprobeorder ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dropldnsreq ,

        [ValidateRange(0, 3600)]
        [double]$gslbsvcstatedelaytime ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$automaticconfigsync 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ldnsentrytimeout')) { $Payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ($PSBoundParameters.ContainsKey('rtttolerance')) { $Payload.Add('rtttolerance', $rtttolerance) }
            if ($PSBoundParameters.ContainsKey('ldnsmask')) { $Payload.Add('ldnsmask', $ldnsmask) }
            if ($PSBoundParameters.ContainsKey('v6ldnsmasklen')) { $Payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ($PSBoundParameters.ContainsKey('ldnsprobeorder')) { $Payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ($PSBoundParameters.ContainsKey('dropldnsreq')) { $Payload.Add('dropldnsreq', $dropldnsreq) }
            if ($PSBoundParameters.ContainsKey('gslbsvcstatedelaytime')) { $Payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ($PSBoundParameters.ContainsKey('automaticconfigsync')) { $Payload.Add('automaticconfigsync', $automaticconfigsync) }
 
            if ($PSCmdlet.ShouldProcess("gslbparameter", "Update Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateGslbparameter: Finished"
    }
}

function Invoke-ADCUnsetGslbparameter {
<#
    .SYNOPSIS
        Unset Global Server Load Balancing configuration Object
    .DESCRIPTION
        Unset Global Server Load Balancing configuration Object 
   .PARAMETER ldnsentrytimeout 
       Time, in seconds, after which an inactive LDNS entry is removed. 
   .PARAMETER rtttolerance 
       Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible. 
   .PARAMETER ldnsmask 
       The IPv4 network mask with which to create LDNS entries. 
   .PARAMETER v6ldnsmasklen 
       Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry. 
   .PARAMETER ldnsprobeorder 
       Order in which monitors should be initiated to calculate RTT.  
       Possible values = PING, DNS, TCP 
   .PARAMETER dropldnsreq 
       Drop LDNS requests if round-trip time (RTT) information is not available.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER gslbsvcstatedelaytime 
       Amount of delay in updating the state of GSLB service to DOWN when MEP goes down.  
       This parameter is applicable only if monitors are not bound to GSLB services. 
   .PARAMETER automaticconfigsync 
       GSLB configuration will be synced automatically to remote gslb sites if enabled.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetGslbparameter 
    .NOTES
        File Name : Invoke-ADCUnsetGslbparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter
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

        [Boolean]$ldnsentrytimeout ,

        [Boolean]$rtttolerance ,

        [Boolean]$ldnsmask ,

        [Boolean]$v6ldnsmasklen ,

        [Boolean]$ldnsprobeorder ,

        [Boolean]$dropldnsreq ,

        [Boolean]$gslbsvcstatedelaytime ,

        [Boolean]$automaticconfigsync 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ldnsentrytimeout')) { $Payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ($PSBoundParameters.ContainsKey('rtttolerance')) { $Payload.Add('rtttolerance', $rtttolerance) }
            if ($PSBoundParameters.ContainsKey('ldnsmask')) { $Payload.Add('ldnsmask', $ldnsmask) }
            if ($PSBoundParameters.ContainsKey('v6ldnsmasklen')) { $Payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ($PSBoundParameters.ContainsKey('ldnsprobeorder')) { $Payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ($PSBoundParameters.ContainsKey('dropldnsreq')) { $Payload.Add('dropldnsreq', $dropldnsreq) }
            if ($PSBoundParameters.ContainsKey('gslbsvcstatedelaytime')) { $Payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ($PSBoundParameters.ContainsKey('automaticconfigsync')) { $Payload.Add('automaticconfigsync', $automaticconfigsync) }
            if ($PSCmdlet.ShouldProcess("gslbparameter", "Unset Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetGslbparameter: Finished"
    }
}

function Invoke-ADCGetGslbparameter {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all gslbparameter object(s)
    .PARAMETER Count
        If specified, the count of the gslbparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbparameter
    .EXAMPLE 
        Invoke-ADCGetGslbparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter/
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
        Write-Verbose "Invoke-ADCGetGslbparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbparameter: Ended"
    }
}

function Invoke-ADCGetGslbrunningconfig {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER GetAll 
        Retreive all gslbrunningconfig object(s)
    .PARAMETER Count
        If specified, the count of the gslbrunningconfig object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbrunningconfig
    .EXAMPLE 
        Invoke-ADCGetGslbrunningconfig -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbrunningconfig -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbrunningconfig -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbrunningconfig
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbrunningconfig/
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
        Write-Verbose "Invoke-ADCGetGslbrunningconfig: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbrunningconfig objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbrunningconfig objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbrunningconfig objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbrunningconfig configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbrunningconfig configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbrunningconfig: Ended"
    }
}

function Invoke-ADCAddGslbservice {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').  
        Minimum length = 1 
    .PARAMETER cnameentry 
        Canonical name of the GSLB service. Used in CNAME-based GSLB.  
        Minimum length = 1 
    .PARAMETER ip 
        IP address for the GSLB service. Should represent a load balancing, content switching, or VPN virtual server on the Citrix ADC, or the IP address of another load balancing device.  
        Minimum length = 1 
    .PARAMETER servername 
        Name of the server hosting the GSLB service.  
        Minimum length = 1 
    .PARAMETER servicetype 
        Type of service to create.  
        Default value: NSSVC_SERVICE_UNKNOWN  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER port 
        Port on which the load balancing entity represented by this GSLB service listens.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER healthmonitor 
        Monitor the health of the GSLB service.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER sitename 
        Name of the GSLB site to which the service belongs.  
        Minimum length = 1 
    .PARAMETER state 
        Enable or disable the service.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box.  
        Minimum length = 1 
    .PARAMETER sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services.  
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER cookietimeout 
        Timeout value, in minutes, for the cookie, when cookie based site persistence is enabled.  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER clttimeout 
        Idle time, in seconds, after which a client connection is terminated. Applicable if connection proxy based site persistence is used.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Idle time, in seconds, after which a server connection is terminated. Applicable if connection proxy based site persistence is used.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER naptrreplacement 
        The replacement domain name for this NAPTR.  
        Maximum length = 255 
    .PARAMETER naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER naptrservices 
        Service Parameters applicable to this delegation path.  
        Maximum length = 255 
    .PARAMETER naptrdomainttl 
        Modify the TTL of the internally created naptr domain.  
        Default value: 3600  
        Minimum value = 1 
    .PARAMETER naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        Invoke-ADCAddGslbservice -servicename <string> -sitename <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cnameentry ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$servicetype = 'NSSVC_SERVICE_UNKNOWN' ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [string]$publicip ,

        [int]$publicport ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor = 'YES' ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sitename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$sitepersistence ,

        [ValidateRange(0, 1440)]
        [double]$cookietimeout ,

        [string]$siteprefix ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [double]$maxbandwidth ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateRange(0, 65535)]
        [double]$maxaaausers ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [double]$hashid ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [string]$naptrreplacement ,

        [ValidateRange(1, 65535)]
        [double]$naptrorder = '1' ,

        [string]$naptrservices ,

        [double]$naptrdomainttl = '3600' ,

        [ValidateRange(1, 65535)]
        [double]$naptrpreference = '1' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
                sitename = $sitename
            }
            if ($PSBoundParameters.ContainsKey('cnameentry')) { $Payload.Add('cnameentry', $cnameentry) }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('servicetype')) { $Payload.Add('servicetype', $servicetype) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
            if ($PSBoundParameters.ContainsKey('cookietimeout')) { $Payload.Add('cookietimeout', $cookietimeout) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('maxaaausers')) { $Payload.Add('maxaaausers', $maxaaausers) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('naptrreplacement')) { $Payload.Add('naptrreplacement', $naptrreplacement) }
            if ($PSBoundParameters.ContainsKey('naptrorder')) { $Payload.Add('naptrorder', $naptrorder) }
            if ($PSBoundParameters.ContainsKey('naptrservices')) { $Payload.Add('naptrservices', $naptrservices) }
            if ($PSBoundParameters.ContainsKey('naptrdomainttl')) { $Payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ($PSBoundParameters.ContainsKey('naptrpreference')) { $Payload.Add('naptrpreference', $naptrpreference) }
 
            if ($PSCmdlet.ShouldProcess("gslbservice", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservice: Finished"
    }
}

function Invoke-ADCDeleteGslbservice {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicename 
       Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteGslbservice -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [string]$servicename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservice: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservice: Finished"
    }
}

function Invoke-ADCUpdateGslbservice {
<#
    .SYNOPSIS
        Update Global Server Load Balancing configuration Object
    .DESCRIPTION
        Update Global Server Load Balancing configuration Object 
    .PARAMETER servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').  
        Minimum length = 1 
    .PARAMETER ipaddress 
        The new IP address of the service. 
    .PARAMETER publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box.  
        Minimum length = 1 
    .PARAMETER sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services.  
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER healthmonitor 
        Monitor the health of the GSLB service.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy.  
        Minimum length = 1 
    .PARAMETER viewip 
        IP address to be used for the given view. 
    .PARAMETER monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER monitor_name_svc 
        Name of the monitor to bind to the service.  
        Minimum length = 1 
    .PARAMETER hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER naptrservices 
        Service Parameters applicable to this delegation path.  
        Maximum length = 255 
    .PARAMETER naptrreplacement 
        The replacement domain name for this NAPTR.  
        Maximum length = 255 
    .PARAMETER naptrdomainttl 
        Modify the TTL of the internally created naptr domain.  
        Default value: 3600  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        Invoke-ADCUpdateGslbservice -servicename <string>
    .NOTES
        File Name : Invoke-ADCUpdateGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicename ,

        [string]$ipaddress ,

        [string]$publicip ,

        [int]$publicport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$sitepersistence ,

        [string]$siteprefix ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor ,

        [double]$maxbandwidth ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateRange(0, 65535)]
        [double]$maxaaausers ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$viewname ,

        [string]$viewip ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$monitor_name_svc ,

        [double]$hashid ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateRange(1, 65535)]
        [double]$naptrorder ,

        [ValidateRange(1, 65535)]
        [double]$naptrpreference ,

        [string]$naptrservices ,

        [string]$naptrreplacement ,

        [double]$naptrdomainttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('maxaaausers')) { $Payload.Add('maxaaausers', $maxaaausers) }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('viewip')) { $Payload.Add('viewip', $viewip) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('naptrorder')) { $Payload.Add('naptrorder', $naptrorder) }
            if ($PSBoundParameters.ContainsKey('naptrpreference')) { $Payload.Add('naptrpreference', $naptrpreference) }
            if ($PSBoundParameters.ContainsKey('naptrservices')) { $Payload.Add('naptrservices', $naptrservices) }
            if ($PSBoundParameters.ContainsKey('naptrreplacement')) { $Payload.Add('naptrreplacement', $naptrreplacement) }
            if ($PSBoundParameters.ContainsKey('naptrdomainttl')) { $Payload.Add('naptrdomainttl', $naptrdomainttl) }
 
            if ($PSCmdlet.ShouldProcess("gslbservice", "Update Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateGslbservice: Finished"
    }
}

function Invoke-ADCUnsetGslbservice {
<#
    .SYNOPSIS
        Unset Global Server Load Balancing configuration Object
    .DESCRIPTION
        Unset Global Server Load Balancing configuration Object 
   .PARAMETER servicename 
       Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
   .PARAMETER publicip 
       The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
   .PARAMETER publicport 
       The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
   .PARAMETER cip 
       In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cipheader 
       Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
   .PARAMETER sitepersistence 
       Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services.  
       Possible values = ConnectionProxy, HTTPRedirect, NONE 
   .PARAMETER siteprefix 
       The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
   .PARAMETER maxclient 
       The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
   .PARAMETER healthmonitor 
       Monitor the health of the GSLB service.  
       Possible values = YES, NO 
   .PARAMETER maxbandwidth 
       Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
   .PARAMETER downstateflush 
       Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER maxaaausers 
       Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
   .PARAMETER monthreshold 
       Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
   .PARAMETER hashid 
       Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
   .PARAMETER comment 
       Any comments that you might want to associate with the GSLB service. 
   .PARAMETER appflowlog 
       Enable logging appflow flow information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER naptrorder 
       An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
   .PARAMETER naptrpreference 
       An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
   .PARAMETER naptrservices 
       Service Parameters applicable to this delegation path. 
   .PARAMETER naptrreplacement 
       The replacement domain name for this NAPTR. 
   .PARAMETER naptrdomainttl 
       Modify the TTL of the internally created naptr domain.
    .EXAMPLE
        Invoke-ADCUnsetGslbservice -servicename <string>
    .NOTES
        File Name : Invoke-ADCUnsetGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicename ,

        [Boolean]$publicip ,

        [Boolean]$publicport ,

        [Boolean]$cip ,

        [Boolean]$cipheader ,

        [Boolean]$sitepersistence ,

        [Boolean]$siteprefix ,

        [Boolean]$maxclient ,

        [Boolean]$healthmonitor ,

        [Boolean]$maxbandwidth ,

        [Boolean]$downstateflush ,

        [Boolean]$maxaaausers ,

        [Boolean]$monthreshold ,

        [Boolean]$hashid ,

        [Boolean]$comment ,

        [Boolean]$appflowlog ,

        [Boolean]$naptrorder ,

        [Boolean]$naptrpreference ,

        [Boolean]$naptrservices ,

        [Boolean]$naptrreplacement ,

        [Boolean]$naptrdomainttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('maxaaausers')) { $Payload.Add('maxaaausers', $maxaaausers) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('naptrorder')) { $Payload.Add('naptrorder', $naptrorder) }
            if ($PSBoundParameters.ContainsKey('naptrpreference')) { $Payload.Add('naptrpreference', $naptrpreference) }
            if ($PSBoundParameters.ContainsKey('naptrservices')) { $Payload.Add('naptrservices', $naptrservices) }
            if ($PSBoundParameters.ContainsKey('naptrreplacement')) { $Payload.Add('naptrreplacement', $naptrreplacement) }
            if ($PSBoundParameters.ContainsKey('naptrdomainttl')) { $Payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Unset Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbservice -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetGslbservice: Finished"
    }
}

function Invoke-ADCRenameGslbservice {
<#
    .SYNOPSIS
        Rename Global Server Load Balancing configuration Object
    .DESCRIPTION
        Rename Global Server Load Balancing configuration Object 
    .PARAMETER servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the GSLB service.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        Invoke-ADCRenameGslbservice -servicename <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicename ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbservice: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("gslbservice", "Rename Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameGslbservice: Finished"
    }
}

function Invoke-ADCGetGslbservice {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicename 
       Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER GetAll 
        Retreive all gslbservice object(s)
    .PARAMETER Count
        If specified, the count of the gslbservice object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservice
    .EXAMPLE 
        Invoke-ADCGetGslbservice -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservice -Count
    .EXAMPLE
        Invoke-ADCGetGslbservice -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservice -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservice
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicename,

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
        Write-Verbose "Invoke-ADCGetGslbservice: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservice: Ended"
    }
}

function Invoke-ADCAddGslbservicegroup {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol used to exchange data with the GSLB service.  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections for the GSLB service group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER cip 
        Insert the Client IP header in requests forwarded to the GSLB service.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name.  
        Minimum length = 1 
    .PARAMETER healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows:  
        YES - Send probes to check the health of the GSLB service.  
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER state 
        Initial state of the GSLB service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER comment 
        Any information about the GSLB service group. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER autoscale 
        Auto scale option for a GSLB servicegroup.  
        Default value: DISABLED  
        Possible values = DISABLED, DNS 
    .PARAMETER sitename 
        Name of the GSLB site to which the service group belongs.  
        Minimum length = 1 
    .PARAMETER sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups.  
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        Invoke-ADCAddGslbservicegroup -servicegroupname <string> -servicetype <string> -sitename <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$servicetype ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor = 'YES' ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateSet('DISABLED', 'DNS')]
        [string]$autoscale = 'DISABLED' ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sitename ,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$sitepersistence ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
                servicetype = $servicetype
                sitename = $sitename
            }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('autoscale')) { $Payload.Add('autoscale', $autoscale) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
 
            if ($PSCmdlet.ShouldProcess("gslbservicegroup", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservicegroup: Finished"
    }
}

function Invoke-ADCDeleteGslbservicegroup {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicegroupname 
       Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteGslbservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservicegroup: Finished"
    }
}

function Invoke-ADCUpdateGslbservicegroup {
<#
    .SYNOPSIS
        Update Global Server Load Balancing configuration Object
    .DESCRIPTION
        Update Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER servername 
        Name of the server to which to bind the service group.  
        Minimum length = 1 
    .PARAMETER port 
        Server port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional.  
        Minimum length = 1 
    .PARAMETER publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional.  
        Minimum value = 1 
    .PARAMETER siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER monitor_name_svc 
        Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor.  
        Minimum length = 1 
    .PARAMETER dup_weight 
        weight of the monitor that is bound to GSLB servicegroup.  
        Minimum value = 1 
    .PARAMETER maxclient 
        Maximum number of simultaneous open connections for the GSLB service group.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows:  
        YES - Send probes to check the health of the GSLB service.  
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER cip 
        Insert the Client IP header in requests forwarded to the GSLB service.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name.  
        Minimum length = 1 
    .PARAMETER clttimeout 
        Time, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER svrtimeout 
        Time, in seconds, after which to terminate an idle server connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group.  
        Minimum value = 0  
        Maximum value = 4294967287 
    .PARAMETER monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER comment 
        Any information about the GSLB service group. 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups.  
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        Invoke-ADCUpdateGslbservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [double]$hashid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$publicip ,

        [int]$publicport ,

        [string]$siteprefix ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$monitor_name_svc ,

        [double]$dup_weight ,

        [ValidateRange(0, 4294967294)]
        [double]$maxclient ,

        [ValidateSet('YES', 'NO')]
        [string]$healthmonitor ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cipheader ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateRange(0, 31536000)]
        [double]$svrtimeout ,

        [ValidateRange(0, 4294967287)]
        [double]$maxbandwidth ,

        [ValidateRange(0, 65535)]
        [double]$monthreshold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$sitepersistence ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
 
            if ($PSCmdlet.ShouldProcess("gslbservicegroup", "Update Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateGslbservicegroup: Finished"
    }
}

function Invoke-ADCUnsetGslbservicegroup {
<#
    .SYNOPSIS
        Unset Global Server Load Balancing configuration Object
    .DESCRIPTION
        Unset Global Server Load Balancing configuration Object 
   .PARAMETER servicegroupname 
       Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
   .PARAMETER servername 
       Name of the server to which to bind the service group. 
   .PARAMETER port 
       Server port number.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER weight 
       Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
   .PARAMETER hashid 
       The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
   .PARAMETER publicip 
       The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
   .PARAMETER publicport 
       The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
   .PARAMETER siteprefix 
       The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
   .PARAMETER maxclient 
       Maximum number of simultaneous open connections for the GSLB service group. 
   .PARAMETER cip 
       Insert the Client IP header in requests forwarded to the GSLB service.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER clttimeout 
       Time, in seconds, after which to terminate an idle client connection. 
   .PARAMETER svrtimeout 
       Time, in seconds, after which to terminate an idle server connection. 
   .PARAMETER maxbandwidth 
       Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
   .PARAMETER monthreshold 
       Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
   .PARAMETER appflowlog 
       Enable logging of AppFlow information for the specified GSLB service group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sitepersistence 
       Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups.  
       Possible values = ConnectionProxy, HTTPRedirect, NONE 
   .PARAMETER monitor_name_svc 
       Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor. 
   .PARAMETER dup_weight 
       weight of the monitor that is bound to GSLB servicegroup. 
   .PARAMETER healthmonitor 
       Monitor the health of this GSLB service.Available settings function are as follows:  
       YES - Send probes to check the health of the GSLB service.  
       NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times.  
       Possible values = YES, NO 
   .PARAMETER cipheader 
       Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
   .PARAMETER downstateflush 
       Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER comment 
       Any information about the GSLB service group.
    .EXAMPLE
        Invoke-ADCUnsetGslbservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Boolean]$servername ,

        [Boolean]$port ,

        [Boolean]$weight ,

        [Boolean]$hashid ,

        [Boolean]$publicip ,

        [Boolean]$publicport ,

        [Boolean]$siteprefix ,

        [Boolean]$maxclient ,

        [Boolean]$cip ,

        [Boolean]$clttimeout ,

        [Boolean]$svrtimeout ,

        [Boolean]$maxbandwidth ,

        [Boolean]$monthreshold ,

        [Boolean]$appflowlog ,

        [Boolean]$sitepersistence ,

        [Boolean]$monitor_name_svc ,

        [Boolean]$dup_weight ,

        [Boolean]$healthmonitor ,

        [Boolean]$cipheader ,

        [Boolean]$downstateflush ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
            if ($PSBoundParameters.ContainsKey('maxclient')) { $Payload.Add('maxclient', $maxclient) }
            if ($PSBoundParameters.ContainsKey('cip')) { $Payload.Add('cip', $cip) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('svrtimeout')) { $Payload.Add('svrtimeout', $svrtimeout) }
            if ($PSBoundParameters.ContainsKey('maxbandwidth')) { $Payload.Add('maxbandwidth', $maxbandwidth) }
            if ($PSBoundParameters.ContainsKey('monthreshold')) { $Payload.Add('monthreshold', $monthreshold) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('sitepersistence')) { $Payload.Add('sitepersistence', $sitepersistence) }
            if ($PSBoundParameters.ContainsKey('monitor_name_svc')) { $Payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ($PSBoundParameters.ContainsKey('dup_weight')) { $Payload.Add('dup_weight', $dup_weight) }
            if ($PSBoundParameters.ContainsKey('healthmonitor')) { $Payload.Add('healthmonitor', $healthmonitor) }
            if ($PSBoundParameters.ContainsKey('cipheader')) { $Payload.Add('cipheader', $cipheader) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Unset Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbservicegroup -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetGslbservicegroup: Finished"
    }
}

function Invoke-ADCEnableGslbservicegroup {
<#
    .SYNOPSIS
        Enable Global Server Load Balancing configuration Object
    .DESCRIPTION
        Enable Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER servername 
        Name of the server to which to bind the service group. 
    .PARAMETER port 
        Server port number.  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCEnableGslbservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCEnableGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableGslbservicegroup: Finished"
    }
}

function Invoke-ADCDisableGslbservicegroup {
<#
    .SYNOPSIS
        Disable Global Server Load Balancing configuration Object
    .DESCRIPTION
        Disable Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER servername 
        Name of the server to which to bind the service group. 
    .PARAMETER port 
        Server port number.  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER delay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER graceful 
        Wait for all existing connections to the service to terminate before shutting down the service.  
        Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCDisableGslbservicegroup -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDisableGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [double]$delay ,

        [ValidateSet('YES', 'NO')]
        [string]$graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('graceful')) { $Payload.Add('graceful', $graceful) }
            if ($PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableGslbservicegroup: Finished"
    }
}

function Invoke-ADCRenameGslbservicegroup {
<#
    .SYNOPSIS
        Rename Global Server Load Balancing configuration Object
    .DESCRIPTION
        Rename Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the GSLB service group.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        Invoke-ADCRenameGslbservicegroup -servicegroupname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbservicegroup: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("gslbservicegroup", "Rename Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameGslbservicegroup: Finished"
    }
}

function Invoke-ADCGetGslbservicegroup {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicegroupname 
       Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER GetAll 
        Retreive all gslbservicegroup object(s)
    .PARAMETER Count
        If specified, the count of the gslbservicegroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicegroup
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroup -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicegroup -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicegroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$servicegroupname,

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
        Write-Verbose "Invoke-ADCGetGslbservicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroup: Ended"
    }
}

function Invoke-ADCGetGslbservicegroupbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicegroupname 
       Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retreive all gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_binding/
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
        [string]$servicegroupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group.  
        Minimum length = 1 
    .PARAMETER ip 
        IP Address. 
    .PARAMETER servername 
        Name of the server to which to bind the service group.  
        Minimum length = 1 
    .PARAMETER port 
        Server port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER state 
        Initial state of the GSLB service group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods.  
        Minimum value = 1 
    .PARAMETER publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional.  
        Minimum length = 1 
    .PARAMETER publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional.  
        Minimum value = 1 
    .PARAMETER siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_gslbservicegroupmember_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$servicegroupname ,

        [string]$ip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servername ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [double]$hashid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$publicip ,

        [int]$publicport ,

        [string]$siteprefix ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Payload.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
 
            if ($PSCmdlet.ShouldProcess("gslbservicegroup_gslbservicegroupmember_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_gslbservicegroupmember_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicegroupname 
       Name of the GSLB service group.  
       Minimum length = 1    .PARAMETER ip 
       IP Address.    .PARAMETER servername 
       Name of the server to which to bind the service group.  
       Minimum length = 1    .PARAMETER port 
       Server port number.  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$servicegroupname ,

        [string]$ip ,

        [string]$servername ,

        [int]$port 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ip')) { $Arguments.Add('ip', $ip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Arguments.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding: Finished"
    }
}

function Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicegroupname 
       Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retreive all gslbservicegroup_gslbservicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_gslbservicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCAddGslbservicegrouplbmonitorbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicegroupname 
        Name of the GSLB service group.  
        Minimum length = 1 
    .PARAMETER port 
        Port number of the GSLB service. Each service must have a unique port number.  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER monitor_name 
        Monitor name. 
    .PARAMETER monstate 
        Monitor state.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER state 
        Initial state of the service after binding.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service.  
        Minimum value = 1 
    .PARAMETER publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_lbmonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbservicegrouplbmonitorbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservicegrouplbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$servicegroupname ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [string]$monitor_name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$monstate ,

        [boolean]$passive ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [double]$hashid ,

        [string]$publicip ,

        [int]$publicport ,

        [string]$siteprefix ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicegroupname = $servicegroupname
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Payload.Add('monitor_name', $monitor_name) }
            if ($PSBoundParameters.ContainsKey('monstate')) { $Payload.Add('monstate', $monstate) }
            if ($PSBoundParameters.ContainsKey('passive')) { $Payload.Add('passive', $passive) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('hashid')) { $Payload.Add('hashid', $hashid) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('publicport')) { $Payload.Add('publicport', $publicport) }
            if ($PSBoundParameters.ContainsKey('siteprefix')) { $Payload.Add('siteprefix', $siteprefix) }
 
            if ($PSCmdlet.ShouldProcess("gslbservicegroup_lbmonitor_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_lbmonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicegrouplbmonitorbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservicegrouplbmonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbservicegrouplbmonitorbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicegroupname 
       Name of the GSLB service group.  
       Minimum length = 1    .PARAMETER port 
       Port number of the GSLB service. Each service must have a unique port number.  
       Range 1 - 65535  
       * in CLI is represented as 65535 in NITRO API    .PARAMETER monitor_name 
       Monitor name.
    .EXAMPLE
        Invoke-ADCDeleteGslbservicegrouplbmonitorbinding -servicegroupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegrouplbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$servicegroupname ,

        [int]$port ,

        [string]$monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Arguments.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Arguments.Add('monitor_name', $monitor_name) }
            if ($PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservicegrouplbmonitorbinding: Finished"
    }
}

function Invoke-ADCGetGslbservicegrouplbmonitorbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicegroupname 
       Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retreive all gslbservicegroup_lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicegrouplbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicegrouplbmonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicegrouplbmonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicegrouplbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicegrouplbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicegrouplbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicegrouplbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegrouplbmonitorbinding: Ended"
    }
}

function Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicegroupname 
       Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retreive all gslbservicegroup_servicegroupentitymonbindings_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_servicegroupentitymonbindings_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_servicegroupentitymonbindings_binding/
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
        [string]$servicegroupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding: Ended"
    }
}

function Invoke-ADCGetGslbservicebinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicename 
       Name of the GSLB service. 
    .PARAMETER GetAll 
        Retreive all gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_binding/
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
        [string]$servicename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicebinding: Ended"
    }
}

function Invoke-ADCAddGslbservicednsviewbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicename 
        Name of the GSLB service.  
        Minimum length = 1 
    .PARAMETER viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy.  
        Minimum length = 1 
    .PARAMETER viewip 
        IP address to be used for the given view. 
    .PARAMETER PassThru 
        Return details about the created gslbservice_dnsview_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbservicednsviewbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservicednsviewbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$viewname ,

        [string]$viewip ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicednsviewbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Payload.Add('viewname', $viewname) }
            if ($PSBoundParameters.ContainsKey('viewip')) { $Payload.Add('viewip', $viewip) }
 
            if ($PSCmdlet.ShouldProcess("gslbservice_dnsview_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_dnsview_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicednsviewbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservicednsviewbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbservicednsviewbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicename 
       Name of the GSLB service.  
       Minimum length = 1    .PARAMETER viewname 
       Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteGslbservicednsviewbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicednsviewbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$servicename ,

        [string]$viewname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicednsviewbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('viewname')) { $Arguments.Add('viewname', $viewname) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservicednsviewbinding: Finished"
    }
}

function Invoke-ADCGetGslbservicednsviewbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicename 
       Name of the GSLB service. 
    .PARAMETER GetAll 
        Retreive all gslbservice_dnsview_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservice_dnsview_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicednsviewbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicednsviewbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicednsviewbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicednsviewbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicednsviewbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicednsviewbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicednsviewbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservice_dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicednsviewbinding: Ended"
    }
}

function Invoke-ADCAddGslbservicelbmonitorbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER servicename 
        Name of the GSLB service.  
        Minimum length = 1 
    .PARAMETER monitor_name 
        Monitor name. 
    .PARAMETER monstate 
        State of the monitor bound to gslb service.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER PassThru 
        Return details about the created gslbservice_lbmonitor_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbservicelbmonitorbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCAddGslbservicelbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$servicename ,

        [string]$monitor_name ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$monstate ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicelbmonitorbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                servicename = $servicename
            }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Payload.Add('monitor_name', $monitor_name) }
            if ($PSBoundParameters.ContainsKey('monstate')) { $Payload.Add('monstate', $monstate) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
 
            if ($PSCmdlet.ShouldProcess("gslbservice_lbmonitor_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_lbmonitor_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbservicelbmonitorbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbservicelbmonitorbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbservicelbmonitorbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER servicename 
       Name of the GSLB service.  
       Minimum length = 1    .PARAMETER monitor_name 
       Monitor name.
    .EXAMPLE
        Invoke-ADCDeleteGslbservicelbmonitorbinding -servicename <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicelbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$servicename ,

        [string]$monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicelbmonitorbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('monitor_name')) { $Arguments.Add('monitor_name', $monitor_name) }
            if ($PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbservicelbmonitorbinding: Finished"
    }
}

function Invoke-ADCGetGslbservicelbmonitorbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER servicename 
       Name of the GSLB service. 
    .PARAMETER GetAll 
        Retreive all gslbservice_lbmonitor_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbservice_lbmonitor_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbservicelbmonitorbinding
    .EXAMPLE 
        Invoke-ADCGetGslbservicelbmonitorbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbservicelbmonitorbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbservicelbmonitorbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbservicelbmonitorbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbservicelbmonitorbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$servicename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbservicelbmonitorbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbservice_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbservicelbmonitorbinding: Ended"
    }
}

function Invoke-ADCAddGslbsite {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite').  
        Minimum length = 1 
    .PARAMETER sitetype 
        Type of site to create. If the type is not specified, the appliance automatically detects and sets the type on the basis of the IP address being assigned to the site. If the specified site IP address is owned by the appliance (for example, a MIP address or SNIP address), the site is a local site. Otherwise, it is a remote site.  
        Default value: NONE  
        Possible values = REMOTE, LOCAL 
    .PARAMETER siteipaddress 
        IP address for the GSLB site. The GSLB site uses this IP address to communicate with other GSLB sites. For a local site, use any IP address that is owned by the appliance (for example, a SNIP or MIP address, or the IP address of the ADNS service).  
        Minimum length = 1 
    .PARAMETER publicip 
        Public IP address for the local site. Required only if the appliance is deployed in a private address space and the site has a public IP address hosted on an external firewall or a NAT device.  
        Minimum length = 1 
    .PARAMETER metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second.  
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows:  
        * ALWAYS - Monitor the GSLB service at all times.  
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled.  
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations:  
        * The exchange of metrics through MEP is disabled.  
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN.  
        Default value: ALWAYS  
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER parentsite 
        Parent site of the GSLB site, in a parent-child topology. 
    .PARAMETER clip 
        Cluster IP address. Specify this parameter to connect to the remote cluster site for GSLB auto-sync. Note: The cluster IP address is defined when creating the cluster. 
    .PARAMETER publicclip 
        IP address to be used to globally access the remote cluster when it is deployed behind a NAT. It can be same as the normal cluster IP address. 
    .PARAMETER naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record.  
        Minimum length = 1 
    .PARAMETER backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites.  
        Default value: "None" 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        Invoke-ADCAddGslbsite -sitename <string> -siteipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddGslbsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$sitename ,

        [ValidateSet('REMOTE', 'LOCAL')]
        [string]$sitetype = 'NONE' ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$siteipaddress ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$publicip ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$metricexchange = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$nwmetricexchange = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionexchange = 'ENABLED' ,

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$triggermonitor = 'ALWAYS' ,

        [string]$parentsite ,

        [string]$clip ,

        [string]$publicclip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$naptrreplacementsuffix ,

        [string[]]$backupparentlist = '"None"' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbsite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitename = $sitename
                siteipaddress = $siteipaddress
            }
            if ($PSBoundParameters.ContainsKey('sitetype')) { $Payload.Add('sitetype', $sitetype) }
            if ($PSBoundParameters.ContainsKey('publicip')) { $Payload.Add('publicip', $publicip) }
            if ($PSBoundParameters.ContainsKey('metricexchange')) { $Payload.Add('metricexchange', $metricexchange) }
            if ($PSBoundParameters.ContainsKey('nwmetricexchange')) { $Payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ($PSBoundParameters.ContainsKey('sessionexchange')) { $Payload.Add('sessionexchange', $sessionexchange) }
            if ($PSBoundParameters.ContainsKey('triggermonitor')) { $Payload.Add('triggermonitor', $triggermonitor) }
            if ($PSBoundParameters.ContainsKey('parentsite')) { $Payload.Add('parentsite', $parentsite) }
            if ($PSBoundParameters.ContainsKey('clip')) { $Payload.Add('clip', $clip) }
            if ($PSBoundParameters.ContainsKey('publicclip')) { $Payload.Add('publicclip', $publicclip) }
            if ($PSBoundParameters.ContainsKey('naptrreplacementsuffix')) { $Payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ($PSBoundParameters.ContainsKey('backupparentlist')) { $Payload.Add('backupparentlist', $backupparentlist) }
 
            if ($PSCmdlet.ShouldProcess("gslbsite", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbsite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbsite -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbsite: Finished"
    }
}

function Invoke-ADCDeleteGslbsite {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER sitename 
       Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteGslbsite -sitename <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [string]$sitename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbsite: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$sitename", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbsite: Finished"
    }
}

function Invoke-ADCUpdateGslbsite {
<#
    .SYNOPSIS
        Update Global Server Load Balancing configuration Object
    .DESCRIPTION
        Update Global Server Load Balancing configuration Object 
    .PARAMETER sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite').  
        Minimum length = 1 
    .PARAMETER metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second.  
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows:  
        * ALWAYS - Monitor the GSLB service at all times.  
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled.  
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations:  
        * The exchange of metrics through MEP is disabled.  
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN.  
        Default value: ALWAYS  
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record.  
        Minimum length = 1 
    .PARAMETER backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites.  
        Default value: "None" 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        Invoke-ADCUpdateGslbsite -sitename <string>
    .NOTES
        File Name : Invoke-ADCUpdateGslbsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$sitename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$metricexchange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$nwmetricexchange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionexchange ,

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$triggermonitor ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$naptrreplacementsuffix ,

        [string[]]$backupparentlist ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbsite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitename = $sitename
            }
            if ($PSBoundParameters.ContainsKey('metricexchange')) { $Payload.Add('metricexchange', $metricexchange) }
            if ($PSBoundParameters.ContainsKey('nwmetricexchange')) { $Payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ($PSBoundParameters.ContainsKey('sessionexchange')) { $Payload.Add('sessionexchange', $sessionexchange) }
            if ($PSBoundParameters.ContainsKey('triggermonitor')) { $Payload.Add('triggermonitor', $triggermonitor) }
            if ($PSBoundParameters.ContainsKey('naptrreplacementsuffix')) { $Payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ($PSBoundParameters.ContainsKey('backupparentlist')) { $Payload.Add('backupparentlist', $backupparentlist) }
 
            if ($PSCmdlet.ShouldProcess("gslbsite", "Update Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbsite -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbsite -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateGslbsite: Finished"
    }
}

function Invoke-ADCUnsetGslbsite {
<#
    .SYNOPSIS
        Unset Global Server Load Balancing configuration Object
    .DESCRIPTION
        Unset Global Server Load Balancing configuration Object 
   .PARAMETER sitename 
       Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
   .PARAMETER metricexchange 
       Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second.  
       If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER nwmetricexchange 
       Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sessionexchange 
       Exchange persistent session entries with other GSLB sites every five seconds.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER triggermonitor 
       Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows:  
       * ALWAYS - Monitor the GSLB service at all times.  
       * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled.  
       MEPDOWN_SVCDOWN - Monitor the service in either of the following situations:  
       * The exchange of metrics through MEP is disabled.  
       * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN.  
       Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
   .PARAMETER naptrreplacementsuffix 
       The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
   .PARAMETER backupparentlist 
       The list of backup gslb sites configured in preferred order. Need to be parent gsb sites.
    .EXAMPLE
        Invoke-ADCUnsetGslbsite -sitename <string>
    .NOTES
        File Name : Invoke-ADCUnsetGslbsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$sitename ,

        [Boolean]$metricexchange ,

        [Boolean]$nwmetricexchange ,

        [Boolean]$sessionexchange ,

        [Boolean]$triggermonitor ,

        [Boolean]$naptrreplacementsuffix ,

        [Boolean]$backupparentlist 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbsite: Starting"
    }
    process {
        try {
            $Payload = @{
                sitename = $sitename
            }
            if ($PSBoundParameters.ContainsKey('metricexchange')) { $Payload.Add('metricexchange', $metricexchange) }
            if ($PSBoundParameters.ContainsKey('nwmetricexchange')) { $Payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ($PSBoundParameters.ContainsKey('sessionexchange')) { $Payload.Add('sessionexchange', $sessionexchange) }
            if ($PSBoundParameters.ContainsKey('triggermonitor')) { $Payload.Add('triggermonitor', $triggermonitor) }
            if ($PSBoundParameters.ContainsKey('naptrreplacementsuffix')) { $Payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ($PSBoundParameters.ContainsKey('backupparentlist')) { $Payload.Add('backupparentlist', $backupparentlist) }
            if ($PSCmdlet.ShouldProcess("$sitename", "Unset Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbsite -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetGslbsite: Finished"
    }
}

function Invoke-ADCGetGslbsite {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER sitename 
       Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER GetAll 
        Retreive all gslbsite object(s)
    .PARAMETER Count
        If specified, the count of the gslbsite object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsite
    .EXAMPLE 
        Invoke-ADCGetGslbsite -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbsite -Count
    .EXAMPLE
        Invoke-ADCGetGslbsite -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsite -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsite
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$sitename,

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
        Write-Verbose "Invoke-ADCGetGslbsite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsite: Ended"
    }
}

function Invoke-ADCGetGslbsitebinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER sitename 
       Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retreive all gslbsite_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbsite_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsitebinding
    .EXAMPLE 
        Invoke-ADCGetGslbsitebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbsitebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsitebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsitebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_binding/
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
        [string]$sitename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsitebinding: Ended"
    }
}

function Invoke-ADCGetGslbsitegslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER sitename 
       Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retreive all gslbsite_gslbservicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservicegroupmember_binding/
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
        [string]$sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCGetGslbsitegslbservicegroupbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER sitename 
       Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retreive all gslbsite_gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservicegroup_binding/
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
        [string]$sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCGetGslbsitegslbservicebinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER sitename 
       Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retreive all gslbsite_gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbsitegslbservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsitegslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservice_binding/
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
        [string]$sitename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbsite_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsitegslbservicebinding: Ended"
    }
}

function Invoke-ADCGetGslbsyncstatus {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER summary 
       sync status summary to be displayed in one line (Success/Failure), in case of Failure stating reason for failure. 
    .PARAMETER GetAll 
        Retreive all gslbsyncstatus object(s)
    .PARAMETER Count
        If specified, the count of the gslbsyncstatus object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbsyncstatus
    .EXAMPLE 
        Invoke-ADCGetGslbsyncstatus -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbsyncstatus -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbsyncstatus -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbsyncstatus
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsyncstatus/
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
        [boolean]$summary,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsyncstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbsyncstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsyncstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsyncstatus objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('summary')) { $Arguments.Add('summary', $summary) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsyncstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbsyncstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbsyncstatus: Ended"
    }
}

function Invoke-ADCAddGslbvserver {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').  
        Minimum length = 1 
    .PARAMETER servicetype 
        Protocol used by services bound to the virtual server.  
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER iptype 
        The IP type for this GSLB vserver.  
        Default value: IPV4  
        Possible values = IPV4, IPV6 
    .PARAMETER dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name.  
        Default value: A  
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER lbmethod 
        Load balancing method for the GSLB virtual server.  
        Default value: LEASTCONNECTION  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain.  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity.  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method.  
        Minimum length = 1 
    .PARAMETER v6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        This field is applicable only if gslb method or gslb backup method are set to API.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "none" 
    .PARAMETER tolerance 
        Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER persistencetype 
        Use source IP address based persistence for the virtual server.  
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER timeout 
        Idle time, in minutes, after which a persistence entry is cleared.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER mir 
        Include multiple IP addresses in the DNS responses sent to clients.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service.  
        Default value: DISABLED  
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER state 
        State of the GSLB virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE.  
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state.  
        Default value: NONE  
        Possible values = NONE, STATE_ONLY 
    .PARAMETER comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services.  
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold.  
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN.  
        * NONE - Spillover does not occur.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Timeout for spillover persistence, in minutes.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol).  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        Invoke-ADCAddGslbvserver -name <string> -servicetype <string>
    .NOTES
        File Name : Invoke-ADCAddGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$servicetype ,

        [ValidateSet('IPV4', 'IPV6')]
        [string]$iptype = 'IPV4' ,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$dnsrecordtype = 'A' ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$lbmethod = 'LEASTCONNECTION' ,

        [ValidateRange(0, 1440)]
        [double]$backupsessiontimeout ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$backuplbmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [ValidateRange(1, 128)]
        [double]$v6netmasklen = '128' ,

        [string]$rule = '"none"' ,

        [ValidateRange(0, 100)]
        [double]$tolerance ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencetype ,

        [ValidateRange(0, 65535)]
        [double]$persistenceid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen = '128' ,

        [ValidateRange(2, 1440)]
        [double]$timeout = '2' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$edr = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ecs = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ecsaddrvalidation = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$mir = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown = 'DISABLED' ,

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$dynamicweight = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$considereffectivestate = 'NONE' ,

        [string]$comment ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence = 'DISABLED' ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout = '2' ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                servicetype = $servicetype
            }
            if ($PSBoundParameters.ContainsKey('iptype')) { $Payload.Add('iptype', $iptype) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('backupsessiontimeout')) { $Payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('tolerance')) { $Payload.Add('tolerance', $tolerance) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('edr')) { $Payload.Add('edr', $edr) }
            if ($PSBoundParameters.ContainsKey('ecs')) { $Payload.Add('ecs', $ecs) }
            if ($PSBoundParameters.ContainsKey('ecsaddrvalidation')) { $Payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ($PSBoundParameters.ContainsKey('mir')) { $Payload.Add('mir', $mir) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('dynamicweight')) { $Payload.Add('dynamicweight', $dynamicweight) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('considereffectivestate')) { $Payload.Add('considereffectivestate', $considereffectivestate) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbvserver: Finished"
    }
}

function Invoke-ADCDeleteGslbvserver {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER name 
       Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users:  
       If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteGslbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        Write-Verbose "Invoke-ADCDeleteGslbvserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbvserver: Finished"
    }
}

function Invoke-ADCUpdateGslbvserver {
<#
    .SYNOPSIS
        Update Global Server Load Balancing configuration Object
    .DESCRIPTION
        Update Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').  
        Minimum length = 1 
    .PARAMETER iptype 
        The IP type for this GSLB vserver.  
        Default value: IPV4  
        Possible values = IPV4, IPV6 
    .PARAMETER dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name.  
        Default value: A  
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER backupvserver 
        Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold.  
        Minimum length = 1 
    .PARAMETER backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain.  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER lbmethod 
        Load balancing method for the GSLB virtual server.  
        Default value: LEASTCONNECTION  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity.  
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method.  
        Minimum length = 1 
    .PARAMETER v6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER tolerance 
        Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT.  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER persistencetype 
        Use source IP address based persistence for the virtual server.  
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server.  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER timeout 
        Idle time, in minutes, after which a persistence entry is cleared.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER mir 
        Include multiple IP addresses in the DNS responses sent to clients.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service.  
        Default value: DISABLED  
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE.  
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state.  
        Default value: NONE  
        Possible values = NONE, STATE_ONLY 
    .PARAMETER somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services.  
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold.  
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN.  
        * NONE - Spillover does not occur.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Timeout for spillover persistence, in minutes.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol).  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER servicename 
        Name of the GSLB service for which to change the weight.  
        Minimum length = 1 
    .PARAMETER weight 
        Weight to assign to the GSLB service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to live (TTL) for the domain.  
        Minimum value = 1 
    .PARAMETER backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down.  
        Minimum length = 1 
    .PARAMETER cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response.  
        Minimum length = 1 
    .PARAMETER cookietimeout 
        Timeout, in minutes, for the GSLB site cookie.  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server.  
        Minimum value = 1 
    .PARAMETER comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        This field is applicable only if gslb method or gslb backup method are set to API.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Default value: "none" 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        Invoke-ADCUpdateGslbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateSet('IPV4', 'IPV6')]
        [string]$iptype ,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$dnsrecordtype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateRange(0, 1440)]
        [double]$backupsessiontimeout ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$lbmethod ,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$backuplbmethod ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [ValidateRange(1, 128)]
        [double]$v6netmasklen ,

        [ValidateRange(0, 100)]
        [double]$tolerance ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencetype ,

        [ValidateRange(0, 65535)]
        [double]$persistenceid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen ,

        [ValidateRange(2, 1440)]
        [double]$timeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$edr ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ecs ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ecsaddrvalidation ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$mir ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown ,

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$dynamicweight ,

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$considereffectivestate ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domainname ,

        [double]$ttl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookie_domain ,

        [ValidateRange(0, 1440)]
        [double]$cookietimeout ,

        [double]$sitedomainttl ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [string]$rule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('iptype')) { $Payload.Add('iptype', $iptype) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('backupsessiontimeout')) { $Payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('tolerance')) { $Payload.Add('tolerance', $tolerance) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('edr')) { $Payload.Add('edr', $edr) }
            if ($PSBoundParameters.ContainsKey('ecs')) { $Payload.Add('ecs', $ecs) }
            if ($PSBoundParameters.ContainsKey('ecsaddrvalidation')) { $Payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ($PSBoundParameters.ContainsKey('mir')) { $Payload.Add('mir', $mir) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('dynamicweight')) { $Payload.Add('dynamicweight', $dynamicweight) }
            if ($PSBoundParameters.ContainsKey('considereffectivestate')) { $Payload.Add('considereffectivestate', $considereffectivestate) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Payload.Add('domainname', $domainname) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('backupip')) { $Payload.Add('backupip', $backupip) }
            if ($PSBoundParameters.ContainsKey('cookie_domain')) { $Payload.Add('cookie_domain', $cookie_domain) }
            if ($PSBoundParameters.ContainsKey('cookietimeout')) { $Payload.Add('cookietimeout', $cookietimeout) }
            if ($PSBoundParameters.ContainsKey('sitedomainttl')) { $Payload.Add('sitedomainttl', $sitedomainttl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver", "Update Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateGslbvserver: Finished"
    }
}

function Invoke-ADCUnsetGslbvserver {
<#
    .SYNOPSIS
        Unset Global Server Load Balancing configuration Object
    .DESCRIPTION
        Unset Global Server Load Balancing configuration Object 
   .PARAMETER name 
       Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users:  
       If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
   .PARAMETER backupvserver 
       Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold. 
   .PARAMETER sothreshold 
       Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
   .PARAMETER iptype 
       The IP type for this GSLB vserver.  
       Possible values = IPV4, IPV6 
   .PARAMETER dnsrecordtype 
       DNS record type to associate with the GSLB virtual server's domain name.  
       Possible values = A, AAAA, CNAME, NAPTR 
   .PARAMETER backupsessiontimeout 
       A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
   .PARAMETER lbmethod 
       Load balancing method for the GSLB virtual server.  
       Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
   .PARAMETER backuplbmethod 
       Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity.  
       Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
   .PARAMETER netmask 
       IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
   .PARAMETER v6netmasklen 
       Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
   .PARAMETER tolerance 
       Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT. 
   .PARAMETER persistencetype 
       Use source IP address based persistence for the virtual server.  
       After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client.  
       Possible values = SOURCEIP, NONE 
   .PARAMETER persistenceid 
       The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
   .PARAMETER persistmask 
       The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
   .PARAMETER v6persistmasklen 
       Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
   .PARAMETER timeout 
       Idle time, in minutes, after which a persistence entry is cleared. 
   .PARAMETER edr 
       Send clients an empty DNS response when the GSLB virtual server is DOWN.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ecs 
       If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ecsaddrvalidation 
       Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER mir 
       Include multiple IP addresses in the DNS responses sent to clients.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER disableprimaryondown 
       Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dynamicweight 
       Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service.  
       Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
   .PARAMETER considereffectivestate 
       If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE.  
       The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state.  
       Possible values = NONE, STATE_ONLY 
   .PARAMETER somethod 
       Type of threshold that, when exceeded, triggers spillover. Available settings function as follows:  
       * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold.  
       * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services.  
       * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold.  
       * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN.  
       * NONE - Spillover does not occur.  
       Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
   .PARAMETER sopersistence 
       If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sopersistencetimeout 
       Timeout for spillover persistence, in minutes. 
   .PARAMETER sobackupaction 
       Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
       Possible values = DROP, ACCEPT, REDIRECT 
   .PARAMETER servicename 
       Name of the GSLB service for which to change the weight. 
   .PARAMETER weight 
       Weight to assign to the GSLB service. 
   .PARAMETER comment 
       Any comments that you might want to associate with the GSLB virtual server. 
   .PARAMETER appflowlog 
       Enable logging appflow flow information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER rule 
       Expression, or name of a named expression, against which traffic is evaluated.  
       This field is applicable only if gslb method or gslb backup method are set to API.  
       The following requirements apply only to the Citrix ADC CLI:  
       * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
       * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
       * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.
    .EXAMPLE
        Invoke-ADCUnsetGslbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$backupvserver ,

        [Boolean]$sothreshold ,

        [Boolean]$iptype ,

        [Boolean]$dnsrecordtype ,

        [Boolean]$backupsessiontimeout ,

        [Boolean]$lbmethod ,

        [Boolean]$backuplbmethod ,

        [Boolean]$netmask ,

        [Boolean]$v6netmasklen ,

        [Boolean]$tolerance ,

        [Boolean]$persistencetype ,

        [Boolean]$persistenceid ,

        [Boolean]$persistmask ,

        [Boolean]$v6persistmasklen ,

        [Boolean]$timeout ,

        [Boolean]$edr ,

        [Boolean]$ecs ,

        [Boolean]$ecsaddrvalidation ,

        [Boolean]$mir ,

        [Boolean]$disableprimaryondown ,

        [Boolean]$dynamicweight ,

        [Boolean]$considereffectivestate ,

        [Boolean]$somethod ,

        [Boolean]$sopersistence ,

        [Boolean]$sopersistencetimeout ,

        [Boolean]$sobackupaction ,

        [Boolean]$servicename ,

        [Boolean]$weight ,

        [Boolean]$comment ,

        [Boolean]$appflowlog ,

        [Boolean]$rule 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('iptype')) { $Payload.Add('iptype', $iptype) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('backupsessiontimeout')) { $Payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('lbmethod')) { $Payload.Add('lbmethod', $lbmethod) }
            if ($PSBoundParameters.ContainsKey('backuplbmethod')) { $Payload.Add('backuplbmethod', $backuplbmethod) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('v6netmasklen')) { $Payload.Add('v6netmasklen', $v6netmasklen) }
            if ($PSBoundParameters.ContainsKey('tolerance')) { $Payload.Add('tolerance', $tolerance) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('edr')) { $Payload.Add('edr', $edr) }
            if ($PSBoundParameters.ContainsKey('ecs')) { $Payload.Add('ecs', $ecs) }
            if ($PSBoundParameters.ContainsKey('ecsaddrvalidation')) { $Payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ($PSBoundParameters.ContainsKey('mir')) { $Payload.Add('mir', $mir) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('dynamicweight')) { $Payload.Add('dynamicweight', $dynamicweight) }
            if ($PSBoundParameters.ContainsKey('considereffectivestate')) { $Payload.Add('considereffectivestate', $considereffectivestate) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbvserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetGslbvserver: Finished"
    }
}

function Invoke-ADCEnableGslbvserver {
<#
    .SYNOPSIS
        Enable Global Server Load Balancing configuration Object
    .DESCRIPTION
        Enable Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        Invoke-ADCEnableGslbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableGslbvserver: Finished"
    }
}

function Invoke-ADCDisableGslbvserver {
<#
    .SYNOPSIS
        Disable Global Server Load Balancing configuration Object
    .DESCRIPTION
        Disable Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        Invoke-ADCDisableGslbvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableGslbvserver: Finished"
    }
}

function Invoke-ADCRenameGslbvserver {
<#
    .SYNOPSIS
        Rename Global Server Load Balancing configuration Object
    .DESCRIPTION
        Rename Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
        CLI Users:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').  
        Minimum length = 1 
    .PARAMETER newname 
        New name for the GSLB virtual server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        Invoke-ADCRenameGslbvserver -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("gslbvserver", "Rename Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameGslbvserver: Finished"
    }
}

function Invoke-ADCGetGslbvserver {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created.  
       CLI Users:  
       If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER GetAll 
        Retreive all gslbvserver object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvserver
    .EXAMPLE 
        Invoke-ADCGetGslbvserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvserver -Count
    .EXAMPLE
        Invoke-ADCGetGslbvserver -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetGslbvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvserver: Ended"
    }
}

function Invoke-ADCGetGslbvserverbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the GSLB virtual server. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetGslbvserverbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetGslbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetGslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvserverbinding: Ended"
    }
}

function Invoke-ADCAddGslbvserverdomainbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name of the virtual server on which to perform the binding operation.  
        Minimum length = 1 
    .PARAMETER domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.  
        Minimum length = 1 
    .PARAMETER ttl 
        Time to live (TTL) for the domain.  
        Minimum value = 1 
    .PARAMETER backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down.  
        Minimum length = 1 
    .PARAMETER cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response.  
        Minimum length = 1 
    .PARAMETER cookietimeout 
        Timeout, in minutes, for the GSLB site cookie.  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server.  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_domain_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbvserverdomainbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddGslbvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domainname ,

        [double]$ttl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookie_domain ,

        [ValidateRange(0, 1440)]
        [double]$cookietimeout ,

        [double]$sitedomainttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserverdomainbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Payload.Add('domainname', $domainname) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('backupip')) { $Payload.Add('backupip', $backupip) }
            if ($PSBoundParameters.ContainsKey('cookie_domain')) { $Payload.Add('cookie_domain', $cookie_domain) }
            if ($PSBoundParameters.ContainsKey('cookietimeout')) { $Payload.Add('cookietimeout', $cookietimeout) }
            if ($PSBoundParameters.ContainsKey('sitedomainttl')) { $Payload.Add('sitedomainttl', $sitedomainttl) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver_domain_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_domain_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvserverdomainbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbvserverdomainbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbvserverdomainbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation.  
       Minimum length = 1    .PARAMETER domainname 
       Domain name for which to change the time to live (TTL) and/or backup service IP address.  
       Minimum length = 1    .PARAMETER backupipflag 
       The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down.    .PARAMETER cookie_domainflag 
       The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response.
    .EXAMPLE
        Invoke-ADCDeleteGslbvserverdomainbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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

        [string]$domainname ,

        [boolean]$backupipflag ,

        [boolean]$cookie_domainflag 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvserverdomainbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Arguments.Add('domainname', $domainname) }
            if ($PSBoundParameters.ContainsKey('backupipflag')) { $Arguments.Add('backupipflag', $backupipflag) }
            if ($PSBoundParameters.ContainsKey('cookie_domainflag')) { $Arguments.Add('cookie_domainflag', $cookie_domainflag) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbvserverdomainbinding: Finished"
    }
}

function Invoke-ADCGetGslbvserverdomainbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_domain_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_domain_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvserverdomainbinding
    .EXAMPLE 
        Invoke-ADCGetGslbvserverdomainbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvserverdomainbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbvserverdomainbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvserverdomainbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbvserverdomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvserverdomainbinding: Ended"
    }
}

function Invoke-ADCGetGslbvservergslbservicegroupmemberbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_gslbservicegroupmember_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroupmember_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupmemberbinding
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicegroupmemberbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicegroupmemberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicegroupmemberbinding: Ended"
    }
}

function Invoke-ADCAddGslbvservergslbservicegroupbinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name of the virtual server on which to perform the binding operation.  
        Minimum length = 1 
    .PARAMETER servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservicegroup_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbvservergslbservicegroupbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddGslbvservergslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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
        [string]$name ,

        [string]$servicegroupname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicegroupbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Payload.Add('servicegroupname', $servicegroupname) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver_gslbservicegroup_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservicegroup_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvservergslbservicegroupbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicegroupbinding: Finished"
    }
}

function Invoke-ADCDeleteGslbvservergslbservicegroupbinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation.  
       Minimum length = 1    .PARAMETER servicegroupname 
       The GSLB service group name bound to the selected GSLB virtual server.
    .EXAMPLE
        Invoke-ADCDeleteGslbvservergslbservicegroupbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbvservergslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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

        [string]$servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicegroupbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicegroupname')) { $Arguments.Add('servicegroupname', $servicegroupname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicegroupbinding: Finished"
    }
}

function Invoke-ADCGetGslbvservergslbservicegroupbinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_gslbservicegroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupbinding
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicegroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicegroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicegroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicegroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicegroupbinding: Ended"
    }
}

function Invoke-ADCAddGslbvservergslbservicebinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name of the virtual server on which to perform the binding operation.  
        Minimum length = 1 
    .PARAMETER servicename 
        Name of the GSLB service for which to change the weight.  
        Minimum length = 1 
    .PARAMETER weight 
        Weight to assign to the GSLB service.  
        Minimum value = 1  
        Maximum value = 100 
    .PARAMETER domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservice_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbvservergslbservicebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddGslbvservergslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateRange(1, 100)]
        [double]$weight ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domainname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Payload.Add('domainname', $domainname) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver_gslbservice_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservice_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvservergslbservicebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicebinding: Finished"
    }
}

function Invoke-ADCDeleteGslbvservergslbservicebinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation.  
       Minimum length = 1    .PARAMETER servicename 
       Name of the GSLB service for which to change the weight.  
       Minimum length = 1    .PARAMETER domainname 
       Domain name for which to change the time to live (TTL) and/or backup service IP address.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteGslbvservergslbservicebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbvservergslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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

        [string]$servicename ,

        [string]$domainname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Arguments.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Arguments.Add('domainname', $domainname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicebinding: Finished"
    }
}

function Invoke-ADCGetGslbvservergslbservicebinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_gslbservice_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservice_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicebinding
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvservergslbservicebinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvservergslbservicebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvservergslbservicebinding: Ended"
    }
}

function Invoke-ADCAddGslbvserverspilloverpolicybinding {
<#
    .SYNOPSIS
        Add Global Server Load Balancing configuration Object
    .DESCRIPTION
        Add Global Server Load Balancing configuration Object 
    .PARAMETER name 
        Name of the virtual server on which to perform the binding operation.  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the policy bound to the GSLB vserver. 
    .PARAMETER priority 
        Priority.  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. o If gotoPriorityExpression is not present or if it is equal to END then the policy bank evaluation ends here o Else if the gotoPriorityExpression is equal to NEXT then the next policy in the priority order is evaluated. o Else gotoPriorityExpression is evaluated. The result of gotoPriorityExpression (which has to be a number) is processed as follows: - An UNDEF event is triggered if . gotoPriorityExpression cannot be evaluated . gotoPriorityExpression evaluates to number which is smaller than the maximum priority in the policy bank but is not same as any policy's priority . gotoPriorityExpression evaluates to a priority that is smaller than the current policy's priority - If the gotoPriorityExpression evaluates to the priority of the current policy then the next policy in the priority order is evaluated. - If the gotoPriorityExpression evaluates to the priority of a policy further ahead in the list then that policy will be evaluated next. This field is applicable only to rewrite and responder policies. 
    .PARAMETER type 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_spilloverpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddGslbvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddGslbvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateRange(1, 2147483647)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$type ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
 
            if ($PSCmdlet.ShouldProcess("gslbvserver_spilloverpolicy_binding", "Add Global Server Load Balancing configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_spilloverpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetGslbvserverspilloverpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddGslbvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteGslbvserverspilloverpolicybinding {
<#
    .SYNOPSIS
        Delete Global Server Load Balancing configuration Object
    .DESCRIPTION
        Delete Global Server Load Balancing configuration Object
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation.  
       Minimum length = 1    .PARAMETER policyname 
       Name of the policy bound to the GSLB vserver.
    .EXAMPLE
        Invoke-ADCDeleteGslbvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteGslbvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCGetGslbvserverspilloverpolicybinding {
<#
    .SYNOPSIS
        Get Global Server Load Balancing configuration object(s)
    .DESCRIPTION
        Get Global Server Load Balancing configuration object(s)
    .PARAMETER name 
       Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retreive all gslbvserver_spilloverpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the gslbvserver_spilloverpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetGslbvserverspilloverpolicybinding
    .EXAMPLE 
        Invoke-ADCGetGslbvserverspilloverpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetGslbvserverspilloverpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetGslbvserverspilloverpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetGslbvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetGslbvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetGslbvserverspilloverpolicybinding: Ended"
    }
}


