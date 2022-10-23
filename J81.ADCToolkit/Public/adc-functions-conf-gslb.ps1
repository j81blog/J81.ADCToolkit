function Invoke-ADCSyncGslbconfig {
    <#
    .SYNOPSIS
        Sync Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for gslb config resource.
    .PARAMETER Preview 
        Do not synchronize the GSLB sites, but display the commands that would be applied on the slave node upon synchronization. Mutually exclusive with the Save Configuration option. 
    .PARAMETER Debugoutput 
        Generate verbose output when synchronizing the GSLB sites. The Debug option generates more verbose output than the sync gslb config command in which the option is not used, and is useful for analyzing synchronization issues. 
        NOTE: The Nitro parameter 'debug' cannot be used as a PowerShell parameter, therefore an alternative Parameter name was chosen. 
    .PARAMETER Forcesync 
        Force synchronization of the specified site even if a dependent configuration on the remote site is preventing synchronization or if one or more GSLB entities on the remote site have the same name but are of a different type. You can specify either the name of the remote site that you want to synchronize with the local site, or you can specify All Sites in the configuration utility (the string all-sites in the CLI). If you specify All Sites, all the sites in the GSLB setup are synchronized with the site on the master node. 
        Note: If you select the Force Sync option, the synchronization starts without displaying the commands that are going to be executed. 
    .PARAMETER Nowarn 
        Suppress the warning and the confirmation prompt that are displayed before site synchronization begins. This option can be used in automation scripts that must not be interrupted by a prompt. 
    .PARAMETER Saveconfig 
        Save the configuration on all the nodes participating in the synchronization process, automatically. The master saves its configuration immediately before synchronization begins. Slave nodes save their configurations after the process of synchronization is complete. A slave node saves its configuration only if the configuration difference was successfully applied to it. Mutually exclusive with the Preview option. 
    .PARAMETER Command 
        Run the specified command on the master node and then on all the slave nodes. You cannot use this option with the force sync and preview options.
    .EXAMPLE
        PS C:\>Invoke-ADCSyncGslbconfig 
        An example how to sync gslbconfig configuration Object(s).
    .NOTES
        File Name : Invoke-ADCSyncGslbconfig
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbconfig/
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

        [boolean]$Preview,

        [boolean]$Debugoutput,

        [string]$Forcesync,

        [boolean]$Nowarn,

        [boolean]$Saveconfig,

        [string]$Command 

    )
    begin {
        Write-Verbose "Invoke-ADCSyncGslbconfig: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('preview') ) { $payload.Add('preview', $preview) }
            if ( $PSBoundParameters.ContainsKey('debugoutput') ) { $payload.Add('debug', $debugoutput) }
            if ( $PSBoundParameters.ContainsKey('forcesync') ) { $payload.Add('forcesync', $forcesync) }
            if ( $PSBoundParameters.ContainsKey('nowarn') ) { $payload.Add('nowarn', $nowarn) }
            if ( $PSBoundParameters.ContainsKey('saveconfig') ) { $payload.Add('saveconfig', $saveconfig) }
            if ( $PSBoundParameters.ContainsKey('command') ) { $payload.Add('command', $command) }
            if ( $PSCmdlet.ShouldProcess($Name, "Sync Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbconfig -Action sync -Payload $payload -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for GSLB domain resource.
    .PARAMETER Name 
        Name of the Domain. 
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
        PS C:\>Invoke-ADCGetGslbdomain
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomain -GetAll 
        Get all gslbdomain data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomain -Count 
        Get the number of gslbdomain objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomain -name <string>
        Get gslbdomain object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomain -Filter @{ 'name'='<value>' }
        Get gslbdomain data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomain
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain/
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
        Write-Verbose "Invoke-ADCGetGslbdomain: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomainbinding -GetAll 
        Get all gslbdomain_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainbinding -name <string>
        Get gslbdomain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainbinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomainbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_binding/
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
        Write-Verbose "Invoke-ADCGetGslbdomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -GetAll 
        Get all gslbdomain_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -Count 
        Get the number of gslbdomain_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -name <string>
        Get gslbdomain_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupbinding -GetAll 
        Get all gslbdomain_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupbinding -Count 
        Get the number of gslbdomain_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupbinding -name <string>
        Get gslbdomain_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservicegroup_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicebinding -GetAll 
        Get all gslbdomain_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbservicebinding -Count 
        Get the number of gslbdomain_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicebinding -name <string>
        Get gslbdomain_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbservicebinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbservice_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbvserverbinding -GetAll 
        Get all gslbdomain_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomaingslbvserverbinding -Count 
        Get the number of gslbdomain_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbvserverbinding -name <string>
        Get gslbdomain_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomaingslbvserverbinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomaingslbvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_gslbvserver_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbdomain.
    .PARAMETER Name 
        Name of the Domain. 
    .PARAMETER GetAll 
        Retrieve all gslbdomain_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbdomain_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainlbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomainlbmonitorbinding -GetAll 
        Get all gslbdomain_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbdomainlbmonitorbinding -Count 
        Get the number of gslbdomain_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainlbmonitorbinding -name <string>
        Get gslbdomain_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbdomainlbmonitorbinding -Filter @{ 'name'='<value>' }
        Get gslbdomain_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbdomainlbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbdomain_lbmonitor_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbdomain_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbdomain_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbdomain_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbdomain_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Clear Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .EXAMPLE
        PS C:\>Invoke-ADCClearGslbldnsentries 
        An example how to clear gslbldnsentries configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearGslbldnsentries
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentries/
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
        [Object]$ADCSession = (Get-ADCSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCClearGslbldnsentries: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbldnsentries -Action clear -Payload $payload -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all gslbldnsentries object(s).
    .PARAMETER Count
        If specified, the count of the gslbldnsentries object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbldnsentries
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbldnsentries -GetAll 
        Get all gslbldnsentries data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbldnsentries -Count 
        Get the number of gslbldnsentries objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbldnsentries -name <string>
        Get gslbldnsentries object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbldnsentries -Filter @{ 'name'='<value>' }
        Get gslbldnsentries data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbldnsentries
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentries/
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
        Write-Verbose "Invoke-ADCGetGslbldnsentries: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbldnsentries objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbldnsentries objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbldnsentries objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbldnsentries configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbldnsentries configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbldnsentries -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for LDNS entry resource.
    .PARAMETER Ipaddress 
        IP address of the LDNS server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbldnsentry 
        An example how to delete gslbldnsentry configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbldnsentry
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbldnsentry/
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

        [string]$Ipaddress 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbldnsentry: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipaddress') ) { $arguments.Add('ipaddress', $Ipaddress) }
            if ( $PSCmdlet.ShouldProcess("gslbldnsentry", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbldnsentry -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Update Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER Ldnsentrytimeout 
        Time, in seconds, after which an inactive LDNS entry is removed. 
    .PARAMETER Rtttolerance 
        Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible. 
    .PARAMETER Ldnsmask 
        The IPv4 network mask with which to create LDNS entries. 
    .PARAMETER V6ldnsmasklen 
        Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry. 
    .PARAMETER Ldnsprobeorder 
        Order in which monitors should be initiated to calculate RTT. 
        Possible values = PING, DNS, TCP 
    .PARAMETER Dropldnsreq 
        Drop LDNS requests if round-trip time (RTT) information is not available. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsvcstatedelaytime 
        Amount of delay in updating the state of GSLB service to DOWN when MEP goes down. 
        This parameter is applicable only if monitors are not bound to GSLB services. 
    .PARAMETER Svcstatelearningtime 
        Time (in seconds) within which local or child site services remain in learning phase. GSLB site will enter the learning phase after reboot, HA failover, Cluster GSLB owner node changes or MEP being enabled on local node. Backup parent (if configured) will selectively move the adopted children's GSLB services to learning phase when primary parent goes down. While a service is in learning period, remote site will not honour the state and stats got through MEP for that service. State can be learnt from health monitor if bound explicitly. 
    .PARAMETER Automaticconfigsync 
        GSLB configuration will be synced automatically to remote gslb sites if enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mepkeepalivetimeout 
        Time duartion (in seconds) during which if no new packets received by Local gslb site from Remote gslb site then mark the MEP connection DOWN. 
    .PARAMETER Gslbsyncinterval 
        Time duartion (in seconds) for which the gslb sync process will wait before checking for config changes. 
    .PARAMETER Gslbsyncmode 
        Mode in which configuration will be synced from master site to remote sites. 
        Possible values = IncrementalSync, FullSync 
    .PARAMETER Gslbsynclocfiles 
        If disabled, Location files will not be synced to the remote sites as part of automatic sync. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbconfigsyncmonitor 
        If enabled, remote gslb site's rsync port will be monitored and site is considered for configuration sync only when the monitor is successful. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsyncsaveconfigcommand 
        If enabled, 'save ns config' command will be treated as other GSLB commands and synced to GSLB nodes when auto gslb sync option is enabled. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateGslbparameter 
        An example how to update gslbparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateGslbparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter/
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

        [ValidateRange(30, 65534)]
        [double]$Ldnsentrytimeout,

        [ValidateRange(1, 100)]
        [double]$Rtttolerance,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ldnsmask,

        [ValidateRange(1, 128)]
        [double]$V6ldnsmasklen,

        [ValidateSet('PING', 'DNS', 'TCP')]
        [string[]]$Ldnsprobeorder,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dropldnsreq,

        [ValidateRange(0, 3600)]
        [double]$Gslbsvcstatedelaytime,

        [ValidateRange(0, 3600)]
        [double]$Svcstatelearningtime,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Automaticconfigsync,

        [double]$Mepkeepalivetimeout,

        [double]$Gslbsyncinterval,

        [ValidateSet('IncrementalSync', 'FullSync')]
        [string]$Gslbsyncmode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbsynclocfiles,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbconfigsyncmonitor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gslbsyncsaveconfigcommand 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ldnsentrytimeout') ) { $payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ( $PSBoundParameters.ContainsKey('rtttolerance') ) { $payload.Add('rtttolerance', $rtttolerance) }
            if ( $PSBoundParameters.ContainsKey('ldnsmask') ) { $payload.Add('ldnsmask', $ldnsmask) }
            if ( $PSBoundParameters.ContainsKey('v6ldnsmasklen') ) { $payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ( $PSBoundParameters.ContainsKey('ldnsprobeorder') ) { $payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ( $PSBoundParameters.ContainsKey('dropldnsreq') ) { $payload.Add('dropldnsreq', $dropldnsreq) }
            if ( $PSBoundParameters.ContainsKey('gslbsvcstatedelaytime') ) { $payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ( $PSBoundParameters.ContainsKey('svcstatelearningtime') ) { $payload.Add('svcstatelearningtime', $svcstatelearningtime) }
            if ( $PSBoundParameters.ContainsKey('automaticconfigsync') ) { $payload.Add('automaticconfigsync', $automaticconfigsync) }
            if ( $PSBoundParameters.ContainsKey('mepkeepalivetimeout') ) { $payload.Add('mepkeepalivetimeout', $mepkeepalivetimeout) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncinterval') ) { $payload.Add('gslbsyncinterval', $gslbsyncinterval) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncmode') ) { $payload.Add('gslbsyncmode', $gslbsyncmode) }
            if ( $PSBoundParameters.ContainsKey('gslbsynclocfiles') ) { $payload.Add('gslbsynclocfiles', $gslbsynclocfiles) }
            if ( $PSBoundParameters.ContainsKey('gslbconfigsyncmonitor') ) { $payload.Add('gslbconfigsyncmonitor', $gslbconfigsyncmonitor) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncsaveconfigcommand') ) { $payload.Add('gslbsyncsaveconfigcommand', $gslbsyncsaveconfigcommand) }
            if ( $PSCmdlet.ShouldProcess("gslbparameter", "Update Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbparameter -Payload $payload -GetWarning
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
        Unset Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER Ldnsentrytimeout 
        Time, in seconds, after which an inactive LDNS entry is removed. 
    .PARAMETER Rtttolerance 
        Tolerance, in milliseconds, for newly learned round-trip time (RTT) values. If the difference between the old RTT value and the newly computed RTT value is less than or equal to the specified tolerance value, the LDNS entry in the network metric table is not updated with the new RTT value. Prevents the exchange of metrics when variations in RTT values are negligible. 
    .PARAMETER Ldnsmask 
        The IPv4 network mask with which to create LDNS entries. 
    .PARAMETER V6ldnsmasklen 
        Mask for creating LDNS entries for IPv6 source addresses. The mask is defined as the number of leading bits to consider, in the source IP address, when creating an LDNS entry. 
    .PARAMETER Ldnsprobeorder 
        Order in which monitors should be initiated to calculate RTT. 
        Possible values = PING, DNS, TCP 
    .PARAMETER Dropldnsreq 
        Drop LDNS requests if round-trip time (RTT) information is not available. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsvcstatedelaytime 
        Amount of delay in updating the state of GSLB service to DOWN when MEP goes down. 
        This parameter is applicable only if monitors are not bound to GSLB services. 
    .PARAMETER Svcstatelearningtime 
        Time (in seconds) within which local or child site services remain in learning phase. GSLB site will enter the learning phase after reboot, HA failover, Cluster GSLB owner node changes or MEP being enabled on local node. Backup parent (if configured) will selectively move the adopted children's GSLB services to learning phase when primary parent goes down. While a service is in learning period, remote site will not honour the state and stats got through MEP for that service. State can be learnt from health monitor if bound explicitly. 
    .PARAMETER Automaticconfigsync 
        GSLB configuration will be synced automatically to remote gslb sites if enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mepkeepalivetimeout 
        Time duartion (in seconds) during which if no new packets received by Local gslb site from Remote gslb site then mark the MEP connection DOWN. 
    .PARAMETER Gslbsyncinterval 
        Time duartion (in seconds) for which the gslb sync process will wait before checking for config changes. 
    .PARAMETER Gslbsyncmode 
        Mode in which configuration will be synced from master site to remote sites. 
        Possible values = IncrementalSync, FullSync 
    .PARAMETER Gslbsynclocfiles 
        If disabled, Location files will not be synced to the remote sites as part of automatic sync. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbconfigsyncmonitor 
        If enabled, remote gslb site's rsync port will be monitored and site is considered for configuration sync only when the monitor is successful. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gslbsyncsaveconfigcommand 
        If enabled, 'save ns config' command will be treated as other GSLB commands and synced to GSLB nodes when auto gslb sync option is enabled. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetGslbparameter 
        An example how to unset gslbparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetGslbparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter
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

        [Boolean]$ldnsentrytimeout,

        [Boolean]$rtttolerance,

        [Boolean]$ldnsmask,

        [Boolean]$v6ldnsmasklen,

        [Boolean]$ldnsprobeorder,

        [Boolean]$dropldnsreq,

        [Boolean]$gslbsvcstatedelaytime,

        [Boolean]$svcstatelearningtime,

        [Boolean]$automaticconfigsync,

        [Boolean]$mepkeepalivetimeout,

        [Boolean]$gslbsyncinterval,

        [Boolean]$gslbsyncmode,

        [Boolean]$gslbsynclocfiles,

        [Boolean]$gslbconfigsyncmonitor,

        [Boolean]$gslbsyncsaveconfigcommand 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ldnsentrytimeout') ) { $payload.Add('ldnsentrytimeout', $ldnsentrytimeout) }
            if ( $PSBoundParameters.ContainsKey('rtttolerance') ) { $payload.Add('rtttolerance', $rtttolerance) }
            if ( $PSBoundParameters.ContainsKey('ldnsmask') ) { $payload.Add('ldnsmask', $ldnsmask) }
            if ( $PSBoundParameters.ContainsKey('v6ldnsmasklen') ) { $payload.Add('v6ldnsmasklen', $v6ldnsmasklen) }
            if ( $PSBoundParameters.ContainsKey('ldnsprobeorder') ) { $payload.Add('ldnsprobeorder', $ldnsprobeorder) }
            if ( $PSBoundParameters.ContainsKey('dropldnsreq') ) { $payload.Add('dropldnsreq', $dropldnsreq) }
            if ( $PSBoundParameters.ContainsKey('gslbsvcstatedelaytime') ) { $payload.Add('gslbsvcstatedelaytime', $gslbsvcstatedelaytime) }
            if ( $PSBoundParameters.ContainsKey('svcstatelearningtime') ) { $payload.Add('svcstatelearningtime', $svcstatelearningtime) }
            if ( $PSBoundParameters.ContainsKey('automaticconfigsync') ) { $payload.Add('automaticconfigsync', $automaticconfigsync) }
            if ( $PSBoundParameters.ContainsKey('mepkeepalivetimeout') ) { $payload.Add('mepkeepalivetimeout', $mepkeepalivetimeout) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncinterval') ) { $payload.Add('gslbsyncinterval', $gslbsyncinterval) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncmode') ) { $payload.Add('gslbsyncmode', $gslbsyncmode) }
            if ( $PSBoundParameters.ContainsKey('gslbsynclocfiles') ) { $payload.Add('gslbsynclocfiles', $gslbsynclocfiles) }
            if ( $PSBoundParameters.ContainsKey('gslbconfigsyncmonitor') ) { $payload.Add('gslbconfigsyncmonitor', $gslbconfigsyncmonitor) }
            if ( $PSBoundParameters.ContainsKey('gslbsyncsaveconfigcommand') ) { $payload.Add('gslbsyncsaveconfigcommand', $gslbsyncsaveconfigcommand) }
            if ( $PSCmdlet.ShouldProcess("gslbparameter", "Unset Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for GSLB parameter resource.
    .PARAMETER GetAll 
        Retrieve all gslbparameter object(s).
    .PARAMETER Count
        If specified, the count of the gslbparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbparameter -GetAll 
        Get all gslbparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbparameter -name <string>
        Get gslbparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbparameter -Filter @{ 'name'='<value>' }
        Get gslbparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbparameter/
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
        Write-Verbose "Invoke-ADCGetGslbparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for running GSLB configuration resource.
    .PARAMETER GetAll 
        Retrieve all gslbrunningconfig object(s).
    .PARAMETER Count
        If specified, the count of the gslbrunningconfig object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbrunningconfig
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbrunningconfig -GetAll 
        Get all gslbrunningconfig data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbrunningconfig -name <string>
        Get gslbrunningconfig object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbrunningconfig -Filter @{ 'name'='<value>' }
        Get gslbrunningconfig data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbrunningconfig
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbrunningconfig/
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
        Write-Verbose "Invoke-ADCGetGslbrunningconfig: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbrunningconfig objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbrunningconfig objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbrunningconfig objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbrunningconfig configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbrunningconfig configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbrunningconfig -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Cnameentry 
        Canonical name of the GSLB service. Used in CNAME-based GSLB. 
    .PARAMETER Ip 
        IP address for the GSLB service. Should represent a load balancing, content switching, or VPN virtual server on the Citrix ADC, or the IP address of another load balancing device. 
    .PARAMETER Servername 
        Name of the server hosting the GSLB service. 
    .PARAMETER Servicetype 
        Type of service to create. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Port 
        Port on which the load balancing entity represented by this GSLB service listens. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
        Possible values = YES, NO 
    .PARAMETER Sitename 
        Name of the GSLB site to which the service belongs. 
    .PARAMETER State 
        Enable or disable the service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Cookietimeout 
        Timeout value, in minutes, for the cookie, when cookie based site persistence is enabled. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which a client connection is terminated. Applicable if connection proxy based site persistence is used. 
    .PARAMETER Svrtimeout 
        Idle time, in seconds, after which a server connection is terminated. Applicable if connection proxy based site persistence is used. 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain. 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservice -servicename <string> -sitename <string>
        An example how to add gslbservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cnameentry,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype = 'NSSVC_SERVICE_UNKNOWN',

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Publicip,

        [int]$Publicport,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [ValidateRange(0, 1440)]
        [double]$Cookietimeout,

        [string]$Siteprefix,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [double]$Maxbandwidth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateRange(0, 65535)]
        [double]$Maxaaausers,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [string]$Naptrreplacement,

        [ValidateRange(1, 65535)]
        [double]$Naptrorder = '1',

        [string]$Naptrservices,

        [double]$Naptrdomainttl = '3600',

        [ValidateRange(1, 65535)]
        [double]$Naptrpreference = '1',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename
                sitename              = $sitename
            }
            if ( $PSBoundParameters.ContainsKey('cnameentry') ) { $payload.Add('cnameentry', $cnameentry) }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('servicetype') ) { $payload.Add('servicetype', $servicetype) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSCmdlet.ShouldProcess("gslbservice", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservice -Servicename <string>
        An example how to delete gslbservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [string]$Servicename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservice: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Update Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Ipaddress 
        The new IP address of the service. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy. 
    .PARAMETER Viewip 
        IP address to be used for the given view. 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor to bind to the service. 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain. 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateGslbservice -servicename <string>
        An example how to update gslbservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicename,

        [string]$Ipaddress,

        [string]$Publicip,

        [int]$Publicport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [string]$Siteprefix,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [double]$Maxbandwidth,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateRange(0, 65535)]
        [double]$Maxaaausers,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Viewname,

        [string]$Viewip,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Hashid,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateRange(1, 65535)]
        [double]$Naptrorder,

        [ValidateRange(1, 65535)]
        [double]$Naptrpreference,

        [string]$Naptrservices,

        [string]$Naptrreplacement,

        [double]$Naptrdomainttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('viewip') ) { $payload.Add('viewip', $viewip) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSCmdlet.ShouldProcess("gslbservice", "Update Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $payload)
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
        Unset Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Cip 
        In the request that is forwarded to the GSLB service, insert a header that stores the client's IP address. Client IP header insertion is used in connection-proxy based site persistence. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name for the HTTP header that stores the client's IP address. Used with the Client IP option. If client IP header insertion is enabled on the service and a name is not specified for the header, the Citrix ADC uses the name specified by the cipHeader parameter in the set ns param command or, in the GUI, the Client IP Header parameter in the Configure HTTP Parameters dialog box. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL GSLB services. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Siteprefix 
        The site's prefix string. When the service is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound service-domain pair by concatenating the site prefix of the service and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Maxclient 
        The maximum number of open connections that the service can support at any given time. A GSLB service whose connection count reaches the maximum is not considered when a GSLB decision is made, until the connection count drops below the maximum. 
    .PARAMETER Healthmonitor 
        Monitor the health of the GSLB service. 
        Possible values = YES, NO 
    .PARAMETER Maxbandwidth 
        Integer specifying the maximum bandwidth allowed for the service. A GSLB service whose bandwidth reaches the maximum is not considered when a GSLB decision is made, until its bandwidth consumption drops below the maximum. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with the GSLB service when its state transitions from UP to DOWN. Do not enable this option for services that must complete their transactions. Applicable if connection proxy based site persistence is used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Maxaaausers 
        Maximum number of SSL VPN users that can be logged on concurrently to the VPN virtual server that is represented by this GSLB service. A GSLB service whose user count reaches the maximum is not considered when a GSLB decision is made, until the count drops below the maximum. 
    .PARAMETER Monthreshold 
        Monitoring threshold value for the GSLB service. If the sum of the weights of the monitors that are bound to this GSLB service and are in the UP state is not equal to or greater than this threshold value, the service is marked as DOWN. 
    .PARAMETER Hashid 
        Unique hash identifier for the GSLB service, used by hash based load balancing methods. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB service. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Naptrorder 
        An integer specifying the order in which the NAPTR records MUST be processed in order to accurately represent the ordered list of Rules. The ordering is from lowest to highest. 
    .PARAMETER Naptrpreference 
        An integer specifying the preference of this NAPTR among NAPTR records having same order. lower the number, higher the preference. 
    .PARAMETER Naptrservices 
        Service Parameters applicable to this delegation path. 
    .PARAMETER Naptrreplacement 
        The replacement domain name for this NAPTR. 
    .PARAMETER Naptrdomainttl 
        Modify the TTL of the internally created naptr domain.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetGslbservice -servicename <string>
        An example how to unset gslbservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicename,

        [Boolean]$publicip,

        [Boolean]$publicport,

        [Boolean]$cip,

        [Boolean]$cipheader,

        [Boolean]$sitepersistence,

        [Boolean]$siteprefix,

        [Boolean]$maxclient,

        [Boolean]$healthmonitor,

        [Boolean]$maxbandwidth,

        [Boolean]$downstateflush,

        [Boolean]$maxaaausers,

        [Boolean]$monthreshold,

        [Boolean]$hashid,

        [Boolean]$comment,

        [Boolean]$appflowlog,

        [Boolean]$naptrorder,

        [Boolean]$naptrpreference,

        [Boolean]$naptrservices,

        [Boolean]$naptrreplacement,

        [Boolean]$naptrdomainttl 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('naptrorder') ) { $payload.Add('naptrorder', $naptrorder) }
            if ( $PSBoundParameters.ContainsKey('naptrpreference') ) { $payload.Add('naptrpreference', $naptrpreference) }
            if ( $PSBoundParameters.ContainsKey('naptrservices') ) { $payload.Add('naptrservices', $naptrservices) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacement') ) { $payload.Add('naptrreplacement', $naptrreplacement) }
            if ( $PSBoundParameters.ContainsKey('naptrdomainttl') ) { $payload.Add('naptrdomainttl', $naptrdomainttl) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Unset Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbservice -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
    .PARAMETER Newname 
        New name for the GSLB service. 
    .PARAMETER PassThru 
        Return details about the created gslbservice item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameGslbservice -servicename <string> -newname <string>
        An example how to rename gslbservice configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicename,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbservice: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename
                newname               = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbservice", "Rename Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservice -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservice -Filter $payload)
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for GSLB service resource.
    .PARAMETER Servicename 
        Name for the GSLB service. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the GSLB service is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsvc" or 'my gslbsvc'). 
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
        PS C:\>Invoke-ADCGetGslbservice
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservice -GetAll 
        Get all gslbservice data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservice -Count 
        Get the number of gslbservice objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservice -name <string>
        Get gslbservice object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservice -Filter @{ 'name'='<value>' }
        Get gslbservice data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservice
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicename,

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
        Write-Verbose "Invoke-ADCGetGslbservice: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servicetype 
        Protocol used to exchange data with the GSLB service. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
    .PARAMETER State 
        Initial state of the GSLB service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Autoscale 
        Auto scale option for a GSLB servicegroup. 
        Possible values = DISABLED, DNS 
    .PARAMETER Sitename 
        Name of the GSLB site to which the service group belongs. 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservicegroup -servicegroupname <string> -servicetype <string> -sitename <string>
        An example how to add gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor = 'YES',

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateSet('DISABLED', 'DNS')]
        [string]$Autoscale = 'DISABLED',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sitename,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                servicetype                = $servicetype
                sitename                   = $sitename
            }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('autoscale') ) { $payload.Add('autoscale', $autoscale) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservicegroup -Servicegroupname <string>
        An example how to delete gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Update Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to GSLB servicegroup. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateGslbservicegroup -servicegroupname <string>
        An example how to update gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [double]$Hashid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Monitor_name_svc,

        [double]$Dup_weight,

        [ValidateRange(0, 4294967294)]
        [double]$Maxclient,

        [ValidateSet('YES', 'NO')]
        [string]$Healthmonitor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cipheader,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateRange(0, 31536000)]
        [double]$Svrtimeout,

        [ValidateRange(0, 4294967287)]
        [double]$Maxbandwidth,

        [ValidateRange(0, 65535)]
        [double]$Monthreshold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('ConnectionProxy', 'HTTPRedirect', 'NONE')]
        [string]$Sitepersistence,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Update Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $payload)
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
        Unset Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER Maxclient 
        Maximum number of simultaneous open connections for the GSLB service group. 
    .PARAMETER Cip 
        Insert the Client IP header in requests forwarded to the GSLB service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clttimeout 
        Time, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Svrtimeout 
        Time, in seconds, after which to terminate an idle server connection. 
    .PARAMETER Maxbandwidth 
        Maximum bandwidth, in Kbps, allocated for all the services in the GSLB service group. 
    .PARAMETER Monthreshold 
        Minimum sum of weights of the monitors that are bound to this GSLB service. Used to determine whether to mark a GSLB service as UP or DOWN. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information for the specified GSLB service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sitepersistence 
        Use cookie-based site persistence. Applicable only to HTTP and SSL non-autoscale enabled GSLB servicegroups. 
        Possible values = ConnectionProxy, HTTPRedirect, NONE 
    .PARAMETER Monitor_name_svc 
        Name of the monitor bound to the GSLB service group. Used to assign a weight to the monitor. 
    .PARAMETER Dup_weight 
        weight of the monitor that is bound to GSLB servicegroup. 
    .PARAMETER Healthmonitor 
        Monitor the health of this GSLB service.Available settings function are as follows: 
        YES - Send probes to check the health of the GSLB service. 
        NO - Do not send probes to check the health of the GSLB service. With the NO option, the appliance shows the service as UP at all times. 
        Possible values = YES, NO 
    .PARAMETER Cipheader 
        Name of the HTTP header whose value must be set to the IP address of the client. Used with the Client IP parameter. If client IP insertion is enabled, and the client IP header is not specified, the value of Client IP Header parameter or the value set by the set ns config command is used as client's IP header name. 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with all the services in the GSLB service group whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any information about the GSLB service group.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetGslbservicegroup -servicegroupname <string>
        An example how to unset gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [Boolean]$servername,

        [Boolean]$port,

        [Boolean]$weight,

        [Boolean]$hashid,

        [Boolean]$publicip,

        [Boolean]$publicport,

        [Boolean]$siteprefix,

        [Boolean]$maxclient,

        [Boolean]$cip,

        [Boolean]$clttimeout,

        [Boolean]$svrtimeout,

        [Boolean]$maxbandwidth,

        [Boolean]$monthreshold,

        [Boolean]$appflowlog,

        [Boolean]$sitepersistence,

        [Boolean]$monitor_name_svc,

        [Boolean]$dup_weight,

        [Boolean]$healthmonitor,

        [Boolean]$cipheader,

        [Boolean]$downstateflush,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSBoundParameters.ContainsKey('maxclient') ) { $payload.Add('maxclient', $maxclient) }
            if ( $PSBoundParameters.ContainsKey('cip') ) { $payload.Add('cip', $cip) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('svrtimeout') ) { $payload.Add('svrtimeout', $svrtimeout) }
            if ( $PSBoundParameters.ContainsKey('maxbandwidth') ) { $payload.Add('maxbandwidth', $maxbandwidth) }
            if ( $PSBoundParameters.ContainsKey('monthreshold') ) { $payload.Add('monthreshold', $monthreshold) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('sitepersistence') ) { $payload.Add('sitepersistence', $sitepersistence) }
            if ( $PSBoundParameters.ContainsKey('monitor_name_svc') ) { $payload.Add('monitor_name_svc', $monitor_name_svc) }
            if ( $PSBoundParameters.ContainsKey('dup_weight') ) { $payload.Add('dup_weight', $dup_weight) }
            if ( $PSBoundParameters.ContainsKey('healthmonitor') ) { $payload.Add('healthmonitor', $healthmonitor) }
            if ( $PSBoundParameters.ContainsKey('cipheader') ) { $payload.Add('cipheader', $cipheader) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Unset Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbservicegroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Enable Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCEnableGslbservicegroup -servicegroupname <string>
        An example how to enable gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action enable -Payload $payload -GetWarning
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
        Disable Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Delay 
        The time allowed (in seconds) for a graceful shutdown. During this period, new connections or requests will continue to be sent to this service for clients who already have a persistent session on the system. Connections or requests from fresh or new clients who do not yet have a persistence sessions on the system will not be sent to the service. Instead, they will be load balanced among other available services. After the delay time expires, no new requests or connections will be sent to the service. 
    .PARAMETER Graceful 
        Wait for all existing connections to the service to terminate before shutting down the service. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCDisableGslbservicegroup -servicegroupname <string>
        An example how to disable gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [double]$Delay,

        [ValidateSet('YES', 'NO')]
        [string]$Graceful 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('graceful') ) { $payload.Add('graceful', $graceful) }
            if ( $PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action disable -Payload $payload -GetWarning
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
        Rename Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
    .PARAMETER Newname 
        New name for the GSLB service group. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameGslbservicegroup -servicegroupname <string> -newname <string>
        An example how to rename gslbservicegroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbservicegroup: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname
                newname                    = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbservicegroup", "Rename Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbservicegroup -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicegroup -Filter $payload)
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for GSLB service group resource.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the name is created. 
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
        PS C:\>Invoke-ADCGetGslbservicegroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroup -GetAll 
        Get all gslbservicegroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroup -Count 
        Get the number of gslbservicegroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroup -name <string>
        Get gslbservicegroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroup -Filter @{ 'name'='<value>' }
        Get gslbservicegroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroup
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Servicegroupname,

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
        Write-Verbose "Invoke-ADCGetGslbservicegroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupbinding -GetAll 
        Get all gslbservicegroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupbinding -name <string>
        Get gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_binding/
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
        Write-Verbose "Invoke-ADCGetGslbservicegroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER State 
        Initial state of the GSLB service group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        The hash identifier for the service. This must be unique for each service. This parameter is used by hash based load balancing methods. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_gslbservicegroupmember_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding -servicegroupname <string>
        An example how to add gslbservicegroup_gslbservicegroupmember_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$Servicegroupname,

        [string]$Ip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servername,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegroupgslbservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('ip') ) { $payload.Add('ip', $ip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup_gslbservicegroupmember_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_gslbservicegroupmember_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Ip 
        IP Address. 
    .PARAMETER Servername 
        Name of the server to which to bind the service group. 
    .PARAMETER Port 
        Server port number. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding -Servicegroupname <string>
        An example how to delete gslbservicegroup_gslbservicegroupmember_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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
        [string]$Servicegroupname,

        [string]$Ip,

        [string]$Servername,

        [int]$Port 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegroupgslbservicegroupmemberbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ip') ) { $arguments.Add('ip', $Ip) }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -GetAll 
        Get all gslbservicegroup_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Count 
        Get the number of gslbservicegroup_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -name <string>
        Get gslbservicegroup_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupgslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Port 
        Port number of the GSLB service. Each service must have a unique port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Monitor_name 
        Monitor name. 
    .PARAMETER Monstate 
        Monitor state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Passive 
        Indicates if load monitor is passive. A passive load monitor does not remove service from LB decision when threshold is breached. 
    .PARAMETER Weight 
        Weight to assign to the servers in the service group. Specifies the capacity of the servers relative to the other servers in the load balancing configuration. The higher the weight, the higher the percentage of requests sent to the service. 
    .PARAMETER State 
        Initial state of the service after binding. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Hashid 
        Unique numerical identifier used by hash based load balancing methods to identify a service. 
    .PARAMETER Publicip 
        The public IP address that a NAT device translates to the GSLB service's private IP address. Optional. 
    .PARAMETER Publicport 
        The public port associated with the GSLB service's public IP address. The port is mapped to the service's private port number. Applicable to the local GSLB service. Optional. 
    .PARAMETER Siteprefix 
        The site's prefix string. When the GSLB service group is bound to a GSLB virtual server, a GSLB site domain is generated internally for each bound serviceitem-domain pair by concatenating the site prefix of the service item and the name of the domain. If the special string NONE is specified, the site-prefix string is unset. When implementing HTTP redirect site persistence, the Citrix ADC redirects GSLB requests to GSLB services by using their site domains. 
    .PARAMETER PassThru 
        Return details about the created gslbservicegroup_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservicegrouplbmonitorbinding -servicegroupname <string>
        An example how to add gslbservicegroup_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservicegrouplbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [ValidateRange(1, 65535)]
        [int]$Port,

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [boolean]$Passive,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [double]$Hashid,

        [string]$Publicip,

        [int]$Publicport,

        [string]$Siteprefix,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicegroupname = $servicegroupname }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('passive') ) { $payload.Add('passive', $passive) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('hashid') ) { $payload.Add('hashid', $hashid) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('publicport') ) { $payload.Add('publicport', $publicport) }
            if ( $PSBoundParameters.ContainsKey('siteprefix') ) { $payload.Add('siteprefix', $siteprefix) }
            if ( $PSCmdlet.ShouldProcess("gslbservicegroup_lbmonitor_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservicegroup_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicegrouplbmonitorbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER Port 
        Port number of the GSLB service. Each service must have a unique port number. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservicegrouplbmonitorbinding -Servicegroupname <string>
        An example how to delete gslbservicegroup_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicegrouplbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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
        [string]$Servicegroupname,

        [int]$Port,

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicegrouplbmonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Port') ) { $arguments.Add('port', $Port) }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicegroupname", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegrouplbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegrouplbmonitorbinding -GetAll 
        Get all gslbservicegroup_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegrouplbmonitorbinding -Count 
        Get the number of gslbservicegroup_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegrouplbmonitorbinding -name <string>
        Get gslbservicegroup_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegrouplbmonitorbinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegrouplbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_lbmonitor_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the servicegroupentitymonbindings that can be bound to gslbservicegroup.
    .PARAMETER Servicegroupname 
        Name of the GSLB service group. 
    .PARAMETER GetAll 
        Retrieve all gslbservicegroup_servicegroupentitymonbindings_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservicegroup_servicegroupentitymonbindings_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -GetAll 
        Get all gslbservicegroup_servicegroupentitymonbindings_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -Count 
        Get the number of gslbservicegroup_servicegroupentitymonbindings_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -name <string>
        Get gslbservicegroup_servicegroupentitymonbindings_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding -Filter @{ 'name'='<value>' }
        Get gslbservicegroup_servicegroupentitymonbindings_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicegroupservicegroupentitymonbindingsbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservicegroup_servicegroupentitymonbindings_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservicegroup_servicegroupentitymonbindings_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration for property 'servicegroupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Resource $servicegroupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservicegroup_servicegroupentitymonbindings_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservicegroup_servicegroupentitymonbindings_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicebinding -GetAll 
        Get all gslbservice_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicebinding -name <string>
        Get gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicebinding -Filter @{ 'name'='<value>' }
        Get gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_binding/
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
        Write-Verbose "Invoke-ADCGetGslbservicebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy. 
    .PARAMETER Viewip 
        IP address to be used for the given view. 
    .PARAMETER PassThru 
        Return details about the created gslbservice_dnsview_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservicednsviewbinding -servicename <string>
        An example how to add gslbservice_dnsview_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservicednsviewbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Viewname,

        [string]$Viewip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicednsviewbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('viewname') ) { $payload.Add('viewname', $viewname) }
            if ( $PSBoundParameters.ContainsKey('viewip') ) { $payload.Add('viewip', $viewip) }
            if ( $PSCmdlet.ShouldProcess("gslbservice_dnsview_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_dnsview_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicednsviewbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Viewname 
        Name of the DNS view of the service. A DNS view is used in global server load balancing (GSLB) to return a predetermined IP address to a specific group of clients, which are identified by using a DNS policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservicednsviewbinding -Servicename <string>
        An example how to delete gslbservice_dnsview_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicednsviewbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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
        [string]$Servicename,

        [string]$Viewname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicednsviewbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Viewname') ) { $arguments.Add('viewname', $Viewname) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the dnsview that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_dnsview_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_dnsview_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicednsviewbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicednsviewbinding -GetAll 
        Get all gslbservice_dnsview_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicednsviewbinding -Count 
        Get the number of gslbservice_dnsview_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicednsviewbinding -name <string>
        Get gslbservice_dnsview_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicednsviewbinding -Filter @{ 'name'='<value>' }
        Get gslbservice_dnsview_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicednsviewbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_dnsview_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_dnsview_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_dnsview_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_dnsview_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Monitor_name 
        Monitor name. 
    .PARAMETER Monstate 
        State of the monitor bound to gslb service. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Weight 
        Weight to assign to the monitor-service binding. A larger number specifies a greater weight. Contributes to the monitoring threshold, which determines the state of the service. 
    .PARAMETER PassThru 
        Return details about the created gslbservice_lbmonitor_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbservicelbmonitorbinding -servicename <string>
        An example how to add gslbservice_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbservicelbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$Servicename,

        [string]$Monitor_name,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Monstate,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbservicelbmonitorbinding: Starting"
    }
    process {
        try {
            $payload = @{ servicename = $servicename }
            if ( $PSBoundParameters.ContainsKey('monitor_name') ) { $payload.Add('monitor_name', $monitor_name) }
            if ( $PSBoundParameters.ContainsKey('monstate') ) { $payload.Add('monstate', $monstate) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("gslbservice_lbmonitor_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbservice_lbmonitor_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbservicelbmonitorbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER Monitor_name 
        Monitor name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbservicelbmonitorbinding -Servicename <string>
        An example how to delete gslbservice_lbmonitor_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbservicelbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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
        [string]$Servicename,

        [string]$Monitor_name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbservicelbmonitorbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Monitor_name') ) { $arguments.Add('monitor_name', $Monitor_name) }
            if ( $PSCmdlet.ShouldProcess("$servicename", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the lbmonitor that can be bound to gslbservice.
    .PARAMETER Servicename 
        Name of the GSLB service. 
    .PARAMETER GetAll 
        Retrieve all gslbservice_lbmonitor_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbservice_lbmonitor_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicelbmonitorbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicelbmonitorbinding -GetAll 
        Get all gslbservice_lbmonitor_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbservicelbmonitorbinding -Count 
        Get the number of gslbservice_lbmonitor_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicelbmonitorbinding -name <string>
        Get gslbservice_lbmonitor_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbservicelbmonitorbinding -Filter @{ 'name'='<value>' }
        Get gslbservice_lbmonitor_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbservicelbmonitorbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbservice_lbmonitor_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbservice_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbservice_lbmonitor_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration for property 'servicename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Resource $servicename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbservice_lbmonitor_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbservice_lbmonitor_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Sitetype 
        Type of site to create. If the type is not specified, the appliance automatically detects and sets the type on the basis of the IP address being assigned to the site. If the specified site IP address is owned by the appliance (for example, a MIP address or SNIP address), the site is a local site. Otherwise, it is a remote site. 
        Possible values = REMOTE, LOCAL 
    .PARAMETER Siteipaddress 
        IP address for the GSLB site. The GSLB site uses this IP address to communicate with other GSLB sites. For a local site, use any IP address that is owned by the appliance (for example, a SNIP or MIP address, or the IP address of the ADNS service). 
    .PARAMETER Publicip 
        Public IP address for the local site. Required only if the appliance is deployed in a private address space and the site has a public IP address hosted on an external firewall or a NAT device. 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Parentsite 
        Parent site of the GSLB site, in a parent-child topology. 
    .PARAMETER Clip 
        Cluster IP address. Specify this parameter to connect to the remote cluster site for GSLB auto-sync. Note: The cluster IP address is defined when creating the cluster. 
    .PARAMETER Publicclip 
        IP address to be used to globally access the remote cluster when it is deployed behind a NAT. It can be same as the normal cluster IP address. 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites. 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbsite -sitename <string> -siteipaddress <string>
        An example how to add gslbsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Sitename,

        [ValidateSet('REMOTE', 'LOCAL')]
        [string]$Sitetype = 'NONE',

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Siteipaddress,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Publicip,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metricexchange = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nwmetricexchange = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionexchange = 'ENABLED',

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$Triggermonitor = 'ALWAYS',

        [string]$Parentsite,

        [string]$Clip,

        [string]$Publicclip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Naptrreplacementsuffix,

        [string[]]$Backupparentlist = '"None"',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename
                siteipaddress      = $siteipaddress
            }
            if ( $PSBoundParameters.ContainsKey('sitetype') ) { $payload.Add('sitetype', $sitetype) }
            if ( $PSBoundParameters.ContainsKey('publicip') ) { $payload.Add('publicip', $publicip) }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('parentsite') ) { $payload.Add('parentsite', $parentsite) }
            if ( $PSBoundParameters.ContainsKey('clip') ) { $payload.Add('clip', $clip) }
            if ( $PSBoundParameters.ContainsKey('publicclip') ) { $payload.Add('publicclip', $publicclip) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("gslbsite", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbsite -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbsite -Sitename <string>
        An example how to delete gslbsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [string]$Sitename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbsite: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sitename", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Arguments $arguments
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
        Update Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites. 
    .PARAMETER PassThru 
        Return details about the created gslbsite item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateGslbsite -sitename <string>
        An example how to update gslbsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateGslbsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Sitename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metricexchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Nwmetricexchange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionexchange,

        [ValidateSet('ALWAYS', 'MEPDOWN', 'MEPDOWN_SVCDOWN')]
        [string]$Triggermonitor,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Naptrreplacementsuffix,

        [string[]]$Backupparentlist,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("gslbsite", "Update Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbsite -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbsite -Filter $payload)
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
        Unset Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
    .PARAMETER Metricexchange 
        Exchange metrics with other sites. Metrics are exchanged by using Metric Exchange Protocol (MEP). The appliances in the GSLB setup exchange health information once every second. 
        If you disable metrics exchange, you can use only static load balancing methods (such as round robin, static proximity, or the hash-based methods), and if you disable metrics exchange when a dynamic load balancing method (such as least connection) is in operation, the appliance falls back to round robin. Also, if you disable metrics exchange, you must use a monitor to determine the state of GSLB services. Otherwise, the service is marked as DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nwmetricexchange 
        Exchange, with other GSLB sites, network metrics such as round-trip time (RTT), learned from communications with various local DNS (LDNS) servers used by clients. RTT information is used in the dynamic RTT load balancing method, and is exchanged every 5 seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionexchange 
        Exchange persistent session entries with other GSLB sites every five seconds. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Triggermonitor 
        Specify the conditions under which the GSLB service must be monitored by a monitor, if one is bound. Available settings function as follows: 
        * ALWAYS - Monitor the GSLB service at all times. 
        * MEPDOWN - Monitor the GSLB service only when the exchange of metrics through the Metrics Exchange Protocol (MEP) is disabled. 
        MEPDOWN_SVCDOWN - Monitor the service in either of the following situations: 
        * The exchange of metrics through MEP is disabled. 
        * The exchange of metrics through MEP is enabled but the status of the service, learned through metrics exchange, is DOWN. 
        Possible values = ALWAYS, MEPDOWN, MEPDOWN_SVCDOWN 
    .PARAMETER Naptrreplacementsuffix 
        The naptr replacement suffix configured here will be used to construct the naptr replacement field in NAPTR record. 
    .PARAMETER Backupparentlist 
        The list of backup gslb sites configured in preferred order. Need to be parent gsb sites.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetGslbsite -sitename <string>
        An example how to unset gslbsite configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetGslbsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Sitename,

        [Boolean]$metricexchange,

        [Boolean]$nwmetricexchange,

        [Boolean]$sessionexchange,

        [Boolean]$triggermonitor,

        [Boolean]$naptrreplacementsuffix,

        [Boolean]$backupparentlist 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbsite: Starting"
    }
    process {
        try {
            $payload = @{ sitename = $sitename }
            if ( $PSBoundParameters.ContainsKey('metricexchange') ) { $payload.Add('metricexchange', $metricexchange) }
            if ( $PSBoundParameters.ContainsKey('nwmetricexchange') ) { $payload.Add('nwmetricexchange', $nwmetricexchange) }
            if ( $PSBoundParameters.ContainsKey('sessionexchange') ) { $payload.Add('sessionexchange', $sessionexchange) }
            if ( $PSBoundParameters.ContainsKey('triggermonitor') ) { $payload.Add('triggermonitor', $triggermonitor) }
            if ( $PSBoundParameters.ContainsKey('naptrreplacementsuffix') ) { $payload.Add('naptrreplacementsuffix', $naptrreplacementsuffix) }
            if ( $PSBoundParameters.ContainsKey('backupparentlist') ) { $payload.Add('backupparentlist', $backupparentlist) }
            if ( $PSCmdlet.ShouldProcess("$sitename", "Unset Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbsite -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for GSLB site resource.
    .PARAMETER Sitename 
        Name for the GSLB site. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the virtual server is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my gslbsite" or 'my gslbsite'). 
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
        PS C:\>Invoke-ADCGetGslbsite
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsite -GetAll 
        Get all gslbsite data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsite -Count 
        Get the number of gslbsite objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsite -name <string>
        Get gslbsite object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsite -Filter @{ 'name'='<value>' }
        Get gslbsite data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsite
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Sitename,

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
        Write-Verbose "Invoke-ADCGetGslbsite: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitebinding -GetAll 
        Get all gslbsite_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitebinding -name <string>
        Get gslbsite_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitebinding -Filter @{ 'name'='<value>' }
        Get gslbsite_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsitebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_binding/
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
        Write-Verbose "Invoke-ADCGetGslbsitebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -GetAll 
        Get all gslbsite_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -Count 
        Get the number of gslbsite_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -name <string>
        Get gslbsite_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupbinding -GetAll 
        Get all gslbsite_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupbinding -Count 
        Get the number of gslbsite_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupbinding -name <string>
        Get gslbsite_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservicegroup_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbsite.
    .PARAMETER Sitename 
        Name of the GSLB site. If you specify a site name, details of all the site's constituent services are also displayed. 
    .PARAMETER GetAll 
        Retrieve all gslbsite_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbsite_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicebinding -GetAll 
        Get all gslbsite_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsitegslbservicebinding -Count 
        Get the number of gslbsite_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicebinding -name <string>
        Get gslbsite_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsitegslbservicebinding -Filter @{ 'name'='<value>' }
        Get gslbsite_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsitegslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsite_gslbservice_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbsite_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsite_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration for property 'sitename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Resource $sitename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbsite_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsite_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for sync status resource.
    .PARAMETER Summary 
        sync status summary to be displayed in one line (Success/Failure), in case of Failure stating reason for failure. 
    .PARAMETER GetAll 
        Retrieve all gslbsyncstatus object(s).
    .PARAMETER Count
        If specified, the count of the gslbsyncstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsyncstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbsyncstatus -GetAll 
        Get all gslbsyncstatus data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsyncstatus -name <string>
        Get gslbsyncstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbsyncstatus -Filter @{ 'name'='<value>' }
        Get gslbsyncstatus data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbsyncstatus
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbsyncstatus/
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
        [boolean]$Summary,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetGslbsyncstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbsyncstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbsyncstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbsyncstatus objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('summary') ) { $arguments.Add('summary', $summary) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbsyncstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving gslbsyncstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbsyncstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Servicetype 
        Protocol used by services bound to the virtual server. 
        Possible values = HTTP, FTP, TCP, UDP, SSL, SSL_BRIDGE, SSL_TCP, NNTP, ANY, SIP_UDP, SIP_TCP, SIP_SSL, RADIUS, RDP, RTSP, MYSQL, MSSQL, ORACLE 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Tolerance 
        Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT. 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER State 
        State of the GSLB virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbvserver -name <string> -servicetype <string>
        An example how to add gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'FTP', 'TCP', 'UDP', 'SSL', 'SSL_BRIDGE', 'SSL_TCP', 'NNTP', 'ANY', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'RADIUS', 'RDP', 'RTSP', 'MYSQL', 'MSSQL', 'ORACLE')]
        [string]$Servicetype,

        [ValidateSet('IPV4', 'IPV6')]
        [string]$Iptype = 'IPV4',

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype = 'A',

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Lbmethod = 'LEASTCONNECTION',

        [ValidateRange(0, 1440)]
        [double]$Backupsessiontimeout,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Backuplbmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateRange(1, 128)]
        [double]$V6netmasklen = '128',

        [string]$Rule = '"none"',

        [ValidateRange(0, 100)]
        [double]$Tolerance,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencetype,

        [ValidateRange(0, 65535)]
        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen = '128',

        [ValidateRange(2, 1440)]
        [double]$Timeout = '2',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Edr = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecs = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecsaddrvalidation = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mir = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$Dynamicweight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$Considereffectivestate = 'NONE',

        [string]$Comment,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence = 'DISABLED',

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout = '2',

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbvserver -Name <string>
        An example how to delete gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        Write-Verbose "Invoke-ADCDeleteGslbvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Backupvserver 
        Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold. 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
    .PARAMETER Tolerance 
        Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT. 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Weight 
        Weight to assign to the GSLB service. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        Time to live (TTL) for the domain. 
    .PARAMETER Backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response. 
    .PARAMETER Cookietimeout 
        Timeout, in minutes, for the GSLB site cookie. 
    .PARAMETER Sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateGslbvserver -name <string>
        An example how to update gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name,

        [ValidateSet('IPV4', 'IPV6')]
        [string]$Iptype,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateRange(0, 1440)]
        [double]$Backupsessiontimeout,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Lbmethod,

        [ValidateSet('ROUNDROBIN', 'LEASTCONNECTION', 'LEASTRESPONSETIME', 'SOURCEIPHASH', 'LEASTBANDWIDTH', 'LEASTPACKETS', 'STATICPROXIMITY', 'RTT', 'CUSTOMLOAD', 'API')]
        [string]$Backuplbmethod,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateRange(1, 128)]
        [double]$V6netmasklen,

        [ValidateRange(0, 100)]
        [double]$Tolerance,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencetype,

        [ValidateRange(0, 65535)]
        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen,

        [ValidateRange(2, 1440)]
        [double]$Timeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Edr,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecs,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ecsaddrvalidation,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Mir,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateSet('SERVICECOUNT', 'SERVICEWEIGHT', 'DISABLED')]
        [string]$Dynamicweight,

        [ValidateSet('NONE', 'STATE_ONLY')]
        [string]$Considereffectivestate,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout,

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookie_domain,

        [ValidateRange(0, 1440)]
        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [string]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookie_domain') ) { $payload.Add('cookie_domain', $cookie_domain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Update Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $payload)
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
        Unset Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Backupvserver 
        Name of the backup GSLB virtual server to which the appliance should to forward requests if the status of the primary GSLB virtual server is down or exceeds its spillover threshold. 
    .PARAMETER Sothreshold 
        Threshold at which spillover occurs. Specify an integer for the CONNECTION spillover method, a bandwidth value in kilobits per second for the BANDWIDTH method (do not enter the units), or a percentage for the HEALTH method (do not enter the percentage symbol). 
    .PARAMETER Iptype 
        The IP type for this GSLB vserver. 
        Possible values = IPV4, IPV6 
    .PARAMETER Dnsrecordtype 
        DNS record type to associate with the GSLB virtual server's domain name. 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Backupsessiontimeout 
        A non zero value enables the feature whose minimum value is 2 minutes. The feature can be disabled by setting the value to zero. The created session is in effect for a specific client per domain. 
    .PARAMETER Lbmethod 
        Load balancing method for the GSLB virtual server. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Backuplbmethod 
        Backup load balancing method. Becomes operational if the primary load balancing method fails or cannot be used. Valid only if the primary method is based on either round-trip time (RTT) or static proximity. 
        Possible values = ROUNDROBIN, LEASTCONNECTION, LEASTRESPONSETIME, SOURCEIPHASH, LEASTBANDWIDTH, LEASTPACKETS, STATICPROXIMITY, RTT, CUSTOMLOAD, API 
    .PARAMETER Netmask 
        IPv4 network mask for use in the SOURCEIPHASH load balancing method. 
    .PARAMETER V6netmasklen 
        Number of bits to consider, in an IPv6 source IP address, for creating the hash that is required by the SOURCEIPHASH load balancing method. 
    .PARAMETER Tolerance 
        Site selection tolerance, in milliseconds, for implementing the RTT load balancing method. If a site's RTT deviates from the lowest RTT by more than the specified tolerance, the site is not considered when the Citrix ADC makes a GSLB decision. The appliance implements the round robin method of global server load balancing between sites whose RTT values are within the specified tolerance. If the tolerance is 0 (zero), the appliance always sends clients the IP address of the site with the lowest RTT. 
    .PARAMETER Persistencetype 
        Use source IP address based persistence for the virtual server. 
        After the load balancing method selects a service for the first packet, the IP address received in response to the DNS query is used for subsequent requests from the same client. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Persistenceid 
        The persistence ID for the GSLB virtual server. The ID is a positive integer that enables GSLB sites to identify the GSLB virtual server, and is required if source IP address based or spill over based persistence is enabled on the virtual server. 
    .PARAMETER Persistmask 
        The optional IPv4 network mask applied to IPv4 addresses to establish source IP address based persistence. 
    .PARAMETER V6persistmasklen 
        Number of bits to consider in an IPv6 source IP address when creating source IP address based persistence sessions. 
    .PARAMETER Timeout 
        Idle time, in minutes, after which a persistence entry is cleared. 
    .PARAMETER Edr 
        Send clients an empty DNS response when the GSLB virtual server is DOWN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecs 
        If enabled, respond with EDNS Client Subnet (ECS) option in the response for a DNS query with ECS. The ECS address will be used for persistence and spillover persistence (if enabled) instead of the LDNS address. Persistence mask is ignored if ECS is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ecsaddrvalidation 
        Validate if ECS address is a private or unroutable address and in such cases, use the LDNS IP. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Mir 
        Include multiple IP addresses in the DNS responses sent to clients. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue to direct traffic to the backup chain even after the primary GSLB virtual server returns to the UP state. Used when spillover is configured for the virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dynamicweight 
        Specify if the appliance should consider the service count, service weights, or ignore both when using weight-based load balancing methods. The state of the number of services bound to the virtual server help the appliance to select the service. 
        Possible values = SERVICECOUNT, SERVICEWEIGHT, DISABLED 
    .PARAMETER Considereffectivestate 
        If the primary state of all bound GSLB services is DOWN, consider the effective states of all the GSLB services, obtained through the Metrics Exchange Protocol (MEP), when determining the state of the GSLB virtual server. To consider the effective state, set the parameter to STATE_ONLY. To disregard the effective state, set the parameter to NONE. 
        The effective state of a GSLB service is the ability of the corresponding virtual server to serve traffic. The effective state of the load balancing virtual server, which is transferred to the GSLB service, is UP even if only one virtual server in the backup chain of virtual servers is in the UP state. 
        Possible values = NONE, STATE_ONLY 
    .PARAMETER Somethod 
        Type of threshold that, when exceeded, triggers spillover. Available settings function as follows: 
        * CONNECTION - Spillover occurs when the number of client connections exceeds the threshold. 
        * DYNAMICCONNECTION - Spillover occurs when the number of client connections at the GSLB virtual server exceeds the sum of the maximum client (Max Clients) settings for bound GSLB services. Do not specify a spillover threshold for this setting, because the threshold is implied by the Max Clients settings of the bound GSLB services. 
        * BANDWIDTH - Spillover occurs when the bandwidth consumed by the GSLB virtual server's incoming and outgoing traffic exceeds the threshold. 
        * HEALTH - Spillover occurs when the percentage of weights of the GSLB services that are UP drops below the threshold. For example, if services gslbSvc1, gslbSvc2, and gslbSvc3 are bound to a virtual server, with weights 1, 2, and 3, and the spillover threshold is 50%, spillover occurs if gslbSvc1 and gslbSvc3 or gslbSvc2 and gslbSvc3 transition to DOWN. 
        * NONE - Spillover does not occur. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        If spillover occurs, maintain source IP address based persistence for both primary and backup GSLB virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Timeout for spillover persistence, in minutes. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Weight 
        Weight to assign to the GSLB service. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the GSLB virtual server. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        This field is applicable only if gslb method or gslb backup method are set to API. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetGslbvserver -name <string>
        An example how to unset gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name,

        [Boolean]$backupvserver,

        [Boolean]$sothreshold,

        [Boolean]$iptype,

        [Boolean]$dnsrecordtype,

        [Boolean]$backupsessiontimeout,

        [Boolean]$lbmethod,

        [Boolean]$backuplbmethod,

        [Boolean]$netmask,

        [Boolean]$v6netmasklen,

        [Boolean]$tolerance,

        [Boolean]$persistencetype,

        [Boolean]$persistenceid,

        [Boolean]$persistmask,

        [Boolean]$v6persistmasklen,

        [Boolean]$timeout,

        [Boolean]$edr,

        [Boolean]$ecs,

        [Boolean]$ecsaddrvalidation,

        [Boolean]$mir,

        [Boolean]$disableprimaryondown,

        [Boolean]$dynamicweight,

        [Boolean]$considereffectivestate,

        [Boolean]$somethod,

        [Boolean]$sopersistence,

        [Boolean]$sopersistencetimeout,

        [Boolean]$sobackupaction,

        [Boolean]$servicename,

        [Boolean]$weight,

        [Boolean]$comment,

        [Boolean]$appflowlog,

        [Boolean]$rule 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('iptype') ) { $payload.Add('iptype', $iptype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('backupsessiontimeout') ) { $payload.Add('backupsessiontimeout', $backupsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('lbmethod') ) { $payload.Add('lbmethod', $lbmethod) }
            if ( $PSBoundParameters.ContainsKey('backuplbmethod') ) { $payload.Add('backuplbmethod', $backuplbmethod) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('v6netmasklen') ) { $payload.Add('v6netmasklen', $v6netmasklen) }
            if ( $PSBoundParameters.ContainsKey('tolerance') ) { $payload.Add('tolerance', $tolerance) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('edr') ) { $payload.Add('edr', $edr) }
            if ( $PSBoundParameters.ContainsKey('ecs') ) { $payload.Add('ecs', $ecs) }
            if ( $PSBoundParameters.ContainsKey('ecsaddrvalidation') ) { $payload.Add('ecsaddrvalidation', $ecsaddrvalidation) }
            if ( $PSBoundParameters.ContainsKey('mir') ) { $payload.Add('mir', $mir) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('dynamicweight') ) { $payload.Add('dynamicweight', $dynamicweight) }
            if ( $PSBoundParameters.ContainsKey('considereffectivestate') ) { $payload.Add('considereffectivestate', $considereffectivestate) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type gslbvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Enable Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-ADCEnableGslbvserver -name <string>
        An example how to enable gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action enable -Payload $payload -GetWarning
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
        Disable Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver').
    .EXAMPLE
        PS C:\>Invoke-ADCDisableGslbvserver -name <string>
        An example how to disable gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action disable -Payload $payload -GetWarning
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
        Rename Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
    .PARAMETER Newname 
        New name for the GSLB virtual server. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameGslbvserver -name <string> -newname <string>
        An example how to rename gslbvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameGslbvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("gslbvserver", "Rename Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type gslbvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvserver -Filter $payload)
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Configuration for Global Server Load Balancing Virtual Server resource.
    .PARAMETER Name 
        Name for the GSLB virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Can be changed after the virtual server is created. 
        CLI Users: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my vserver" or 'my vserver'). 
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
        PS C:\>Invoke-ADCGetGslbvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserver -GetAll 
        Get all gslbvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserver -Count 
        Get the number of gslbvserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserver -name <string>
        Get gslbvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserver -Filter @{ 'name'='<value>' }
        Get gslbvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Write-Verbose "Invoke-ADCGetGslbvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to gslbvserver.
    .PARAMETER Name 
        Name of the GSLB virtual server. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverbinding -GetAll 
        Get all gslbvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverbinding -name <string>
        Get gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverbinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetGslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        Time to live (TTL) for the domain. 
    .PARAMETER Backupip 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domain 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response. 
    .PARAMETER Cookietimeout 
        Timeout, in minutes, for the GSLB site cookie. 
    .PARAMETER Sitedomainttl 
        TTL, in seconds, for all internally created site domains (created when a site prefix is configured on a GSLB service) that are associated with this virtual server. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_domain_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbvserverdomainbinding -name <string>
        An example how to add gslbvserver_domain_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbvserverdomainbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookie_domain,

        [ValidateRange(0, 1440)]
        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserverdomainbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookie_domain') ) { $payload.Add('cookie_domain', $cookie_domain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_domain_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_domain_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvserverdomainbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Backupipflag 
        The IP address of the backup service for the specified domain name. Used when all the services bound to the domain are down, or when the backup chain of virtual servers is down. 
    .PARAMETER Cookie_domainflag 
        The cookie domain for the GSLB site. Used when inserting the GSLB site cookie in the HTTP response.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbvserverdomainbinding -Name <string>
        An example how to delete gslbvserver_domain_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserverdomainbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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

        [string]$Domainname,

        [boolean]$Backupipflag,

        [boolean]$Cookie_domainflag 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvserverdomainbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSBoundParameters.ContainsKey('Backupipflag') ) { $arguments.Add('backupipflag', $Backupipflag) }
            if ( $PSBoundParameters.ContainsKey('Cookie_domainflag') ) { $arguments.Add('cookie_domainflag', $Cookie_domainflag) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverdomainbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverdomainbinding -GetAll 
        Get all gslbvserver_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverdomainbinding -Count 
        Get the number of gslbvserver_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverdomainbinding -name <string>
        Get gslbvserver_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverdomainbinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvserverdomainbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_domain_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroupmember that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservicegroupmember_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroupmember_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupmemberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -GetAll 
        Get all gslbvserver_gslbservicegroupmember_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -Count 
        Get the number of gslbvserver_gslbservicegroupmember_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -name <string>
        Get gslbvserver_gslbservicegroupmember_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupmemberbinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservicegroupmember_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicegroupmemberbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroupmember_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroupmember_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroupmember_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroupmember_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservicegroup_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbvservergslbservicegroupbinding -name <string>
        An example how to add gslbvserver_gslbservicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbvservergslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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
        [string]$Name,

        [string]$Servicegroupname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicegroupbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicegroupname') ) { $payload.Add('servicegroupname', $servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_gslbservicegroup_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservicegroup_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvservergslbservicegroupbinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicegroupname 
        The GSLB service group name bound to the selected GSLB virtual server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbvservergslbservicegroupbinding -Name <string>
        An example how to delete gslbvserver_gslbservicegroup_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbvservergslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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

        [string]$Servicegroupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicegroupbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicegroupname') ) { $arguments.Add('servicegroupname', $Servicegroupname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservicegroup that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservicegroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservicegroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupbinding -GetAll 
        Get all gslbvserver_gslbservicegroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupbinding -Count 
        Get the number of gslbvserver_gslbservicegroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupbinding -name <string>
        Get gslbvserver_gslbservicegroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicegroupbinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservicegroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicegroupbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservicegroup_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservicegroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservicegroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservicegroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Weight 
        Weight to assign to the GSLB service. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_gslbservice_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbvservergslbservicebinding -name <string>
        An example how to add gslbvserver_gslbservice_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbvservergslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateRange(1, 100)]
        [double]$Weight,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvservergslbservicebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_gslbservice_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_gslbservice_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvservergslbservicebinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Servicename 
        Name of the GSLB service for which to change the weight. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbvservergslbservicebinding -Name <string>
        An example how to delete gslbvserver_gslbservice_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbvservergslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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

        [string]$Servicename,

        [string]$Domainname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvservergslbservicebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servicename') ) { $arguments.Add('servicename', $Servicename) }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbservice that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_gslbservice_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_gslbservice_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicebinding -GetAll 
        Get all gslbvserver_gslbservice_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvservergslbservicebinding -Count 
        Get the number of gslbvserver_gslbservice_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicebinding -name <string>
        Get gslbvserver_gslbservice_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvservergslbservicebinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_gslbservice_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvservergslbservicebinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_gslbservice_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_gslbservice_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_gslbservice_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_gslbservice_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver. 
    .PARAMETER Priority 
        Priority. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. o If gotoPriorityExpression is not present or if it is equal to END then the policy bank evaluation ends here o Else if the gotoPriorityExpression is equal to NEXT then the next policy in the priority order is evaluated. o Else gotoPriorityExpression is evaluated. The result of gotoPriorityExpression (which has to be a number) is processed as follows: - An UNDEF event is triggered if . gotoPriorityExpression cannot be evaluated . gotoPriorityExpression evaluates to number which is smaller than the maximum priority in the policy bank but is not same as any policy's priority . gotoPriorityExpression evaluates to a priority that is smaller than the current policy's priority - If the gotoPriorityExpression evaluates to the priority of the current policy then the next policy in the priority order is evaluated. - If the gotoPriorityExpression evaluates to the priority of a policy further ahead in the list then that policy will be evaluated next. This field is applicable only to rewrite and responder policies. 
    .PARAMETER Type 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER PassThru 
        Return details about the created gslbvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddGslbvserverspilloverpolicybinding -name <string>
        An example how to add gslbvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddGslbvserverspilloverpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Type,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddGslbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("gslbvserver_spilloverpolicy_binding", "Add Global Server Load Balancing configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type gslbvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetGslbvserverspilloverpolicybinding -Filter $payload)
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
        Delete Global Server Load Balancing configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER Policyname 
        Name of the policy bound to the GSLB vserver.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteGslbvserverspilloverpolicybinding -Name <string>
        An example how to delete gslbvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteGslbvserverspilloverpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteGslbvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Global Server Load Balancing configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Global Server Load Balancing configuration object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to gslbvserver.
    .PARAMETER Name 
        Name of the virtual server on which to perform the binding operation. 
    .PARAMETER GetAll 
        Retrieve all gslbvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the gslbvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverspilloverpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverspilloverpolicybinding -GetAll 
        Get all gslbvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetGslbvserverspilloverpolicybinding -Count 
        Get the number of gslbvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverspilloverpolicybinding -name <string>
        Get gslbvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetGslbvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
        Get gslbvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetGslbvserverspilloverpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/gslb/gslbvserver_spilloverpolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for gslbvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving gslbvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type gslbvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


