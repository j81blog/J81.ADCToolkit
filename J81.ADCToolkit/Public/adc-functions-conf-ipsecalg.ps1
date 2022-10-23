function Invoke-ADCAddIpsecalgprofile {
    <#
    .SYNOPSIS
        Add Ipsecalg configuration Object.
    .DESCRIPTION
        Configuration for IPSEC ALG profile resource.
    .PARAMETER Name 
        The name of the ipsec alg profile. 
    .PARAMETER Ikesessiontimeout 
        IKE session timeout in minutes. 
    .PARAMETER Espsessiontimeout 
        ESP session timeout in minutes. 
    .PARAMETER Espgatetimeout 
        Timeout ESP in seconds as no ESP packets are seen after IKE negotiation. 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ipsecalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIpsecalgprofile -name <string>
        An example how to add ipsecalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIpsecalgprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateRange(1, 1440)]
        [double]$Ikesessiontimeout = '60',

        [ValidateRange(1, 1440)]
        [double]$Espsessiontimeout = '60',

        [ValidateRange(3, 1200)]
        [double]$Espgatetimeout = '30',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Connfailover = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIpsecalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ikesessiontimeout') ) { $payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espsessiontimeout') ) { $payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espgatetimeout') ) { $payload.Add('espgatetimeout', $espgatetimeout) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSCmdlet.ShouldProcess("ipsecalgprofile", "Add Ipsecalg configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIpsecalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddIpsecalgprofile: Finished"
    }
}

function Invoke-ADCUpdateIpsecalgprofile {
    <#
    .SYNOPSIS
        Update Ipsecalg configuration Object.
    .DESCRIPTION
        Configuration for IPSEC ALG profile resource.
    .PARAMETER Name 
        The name of the ipsec alg profile. 
    .PARAMETER Ikesessiontimeout 
        IKE session timeout in minutes. 
    .PARAMETER Espsessiontimeout 
        ESP session timeout in minutes. 
    .PARAMETER Espgatetimeout 
        Timeout ESP in seconds as no ESP packets are seen after IKE negotiation. 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ipsecalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIpsecalgprofile -name <string>
        An example how to update ipsecalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIpsecalgprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateRange(1, 1440)]
        [double]$Ikesessiontimeout,

        [ValidateRange(1, 1440)]
        [double]$Espsessiontimeout,

        [ValidateRange(3, 1200)]
        [double]$Espgatetimeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Connfailover,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIpsecalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ikesessiontimeout') ) { $payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espsessiontimeout') ) { $payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espgatetimeout') ) { $payload.Add('espgatetimeout', $espgatetimeout) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSCmdlet.ShouldProcess("ipsecalgprofile", "Update Ipsecalg configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ipsecalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIpsecalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateIpsecalgprofile: Finished"
    }
}

function Invoke-ADCUnsetIpsecalgprofile {
    <#
    .SYNOPSIS
        Unset Ipsecalg configuration Object.
    .DESCRIPTION
        Configuration for IPSEC ALG profile resource.
    .PARAMETER Name 
        The name of the ipsec alg profile. 
    .PARAMETER Ikesessiontimeout 
        IKE session timeout in minutes. 
    .PARAMETER Espsessiontimeout 
        ESP session timeout in minutes. 
    .PARAMETER Espgatetimeout 
        Timeout ESP in seconds as no ESP packets are seen after IKE negotiation. 
    .PARAMETER Connfailover 
        Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIpsecalgprofile -name <string>
        An example how to unset ipsecalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIpsecalgprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile
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

        [ValidateLength(1, 32)]
        [string]$Name,

        [Boolean]$ikesessiontimeout,

        [Boolean]$espsessiontimeout,

        [Boolean]$espgatetimeout,

        [Boolean]$connfailover 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIpsecalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ikesessiontimeout') ) { $payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espsessiontimeout') ) { $payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('espgatetimeout') ) { $payload.Add('espgatetimeout', $espgatetimeout) }
            if ( $PSBoundParameters.ContainsKey('connfailover') ) { $payload.Add('connfailover', $connfailover) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Ipsecalg configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ipsecalgprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIpsecalgprofile: Finished"
    }
}

function Invoke-ADCDeleteIpsecalgprofile {
    <#
    .SYNOPSIS
        Delete Ipsecalg configuration Object.
    .DESCRIPTION
        Configuration for IPSEC ALG profile resource.
    .PARAMETER Name 
        The name of the ipsec alg profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIpsecalgprofile -Name <string>
        An example how to delete ipsecalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIpsecalgprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        Write-Verbose "Invoke-ADCDeleteIpsecalgprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ipsecalg configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ipsecalgprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteIpsecalgprofile: Finished"
    }
}

function Invoke-ADCGetIpsecalgprofile {
    <#
    .SYNOPSIS
        Get Ipsecalg configuration object(s).
    .DESCRIPTION
        Configuration for IPSEC ALG profile resource.
    .PARAMETER Name 
        The name of the ipsec alg profile. 
    .PARAMETER GetAll 
        Retrieve all ipsecalgprofile object(s).
    .PARAMETER Count
        If specified, the count of the ipsecalgprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecalgprofile -GetAll 
        Get all ipsecalgprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecalgprofile -Count 
        Get the number of ipsecalgprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgprofile -name <string>
        Get ipsecalgprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgprofile -Filter @{ 'name'='<value>' }
        Get ipsecalgprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIpsecalgprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-ADCGetIpsecalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ipsecalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecalgprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecalgprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ipsecalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIpsecalgprofile: Ended"
    }
}

function Invoke-ADCFlushIpsecalgsession {
    <#
    .SYNOPSIS
        Flush Ipsecalg configuration Object.
    .DESCRIPTION
        Configuration for IPSEC ALG session resource.
    .PARAMETER Sourceip 
        Original Source IP address. 
    .PARAMETER Natip 
        Natted Source IP address. 
    .PARAMETER Destip 
        Destination IP address.
    .EXAMPLE
        PS C:\>Invoke-ADCFlushIpsecalgsession 
        An example how to flush ipsecalgsession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushIpsecalgsession
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgsession/
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
        [string]$Sourceip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Natip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destip 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushIpsecalgsession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sourceip') ) { $payload.Add('sourceip', $sourceip) }
            if ( $PSBoundParameters.ContainsKey('natip') ) { $payload.Add('natip', $natip) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Ipsecalg configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecalgsession -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushIpsecalgsession: Finished"
    }
}

function Invoke-ADCGetIpsecalgsession {
    <#
    .SYNOPSIS
        Get Ipsecalg configuration object(s).
    .DESCRIPTION
        Configuration for IPSEC ALG session resource.
    .PARAMETER Sourceip_alg 
        Original Source IP address. 
    .PARAMETER Natip_alg 
        Natted Source IP address. 
    .PARAMETER Destip_alg 
        Destination IP address. 
    .PARAMETER GetAll 
        Retrieve all ipsecalgsession object(s).
    .PARAMETER Count
        If specified, the count of the ipsecalgsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecalgsession -GetAll 
        Get all ipsecalgsession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecalgsession -Count 
        Get the number of ipsecalgsession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgsession -name <string>
        Get ipsecalgsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecalgsession -Filter @{ 'name'='<value>' }
        Get ipsecalgsession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIpsecalgsession
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgsession/
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
        [string]$Sourceip_alg,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Natip_alg,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destip_alg,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetIpsecalgsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ipsecalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecalgsession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('sourceip_alg') ) { $arguments.Add('sourceip_alg', $sourceip_alg) } 
                if ( $PSBoundParameters.ContainsKey('natip_alg') ) { $arguments.Add('natip_alg', $natip_alg) } 
                if ( $PSBoundParameters.ContainsKey('destip_alg') ) { $arguments.Add('destip_alg', $destip_alg) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecalgsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving ipsecalgsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIpsecalgsession: Ended"
    }
}


