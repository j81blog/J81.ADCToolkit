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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBoHe2CuPILleoA
# YKF2RmqS0cB05/kDbVrFQQl1vO+ZNqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgzkKfhTA0Z5FmmDLrbl4TEq18tIo3PYs1gMr/oNN30U4wDQYJKoZIhvcNAQEB
# BQAEggEANf8FMbANKhmrfW9kc/v7xxpputxy7/0YAkDGZO/a+Xoso0A1+u7crRTR
# hMWrayBVDzjPiDculFMd7ug5EA0SdOdXCRanHHdorErmBNeIkWafkTOcG4csPSVy
# B9tNoeIguTMVxjezoj+obYiyb8BR0/tjyS9gyDLzoB8MWyyzldhn+/q5j2kv0ZcI
# wMZQCfNR6mWKU593zVBmP1nvRyZ63uS29pmqD2kbQc+2/dduvzw5yhfI+8OQZ6mT
# wGmAJB4FZfngs4DZKUfRilaMlYbH0SfuYNt6LxI4HmnwHnFTVZVGd+5MC6KAx6Ko
# o5hVN1SFua8FpsXeEc0zI3P5vj21kQ==
# SIG # End signature block
