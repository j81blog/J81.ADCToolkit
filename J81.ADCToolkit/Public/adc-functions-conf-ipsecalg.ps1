function Invoke-ADCAddIpsecalgprofile {
<#
    .SYNOPSIS
        Add Ipsecalg configuration Object
    .DESCRIPTION
        Add Ipsecalg configuration Object 
    .PARAMETER name 
        The name of the ipsec alg profile.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER ikesessiontimeout 
        IKE session timeout in minutes.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER espsessiontimeout 
        ESP session timeout in minutes.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER espgatetimeout 
        Timeout ESP in seconds as no ESP packets are seen after IKE negotiation.  
        Default value: 30  
        Minimum value = 3  
        Maximum value = 1200 
    .PARAMETER connfailover 
        Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ipsecalgprofile item.
    .EXAMPLE
        Invoke-ADCAddIpsecalgprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddIpsecalgprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [ValidateRange(1, 1440)]
        [double]$ikesessiontimeout = '60' ,

        [ValidateRange(1, 1440)]
        [double]$espsessiontimeout = '60' ,

        [ValidateRange(3, 1200)]
        [double]$espgatetimeout = '30' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$connfailover = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIpsecalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ikesessiontimeout')) { $Payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espsessiontimeout')) { $Payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espgatetimeout')) { $Payload.Add('espgatetimeout', $espgatetimeout) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
 
            if ($PSCmdlet.ShouldProcess("ipsecalgprofile", "Add Ipsecalg configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIpsecalgprofile -Filter $Payload)
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
        Update Ipsecalg configuration Object
    .DESCRIPTION
        Update Ipsecalg configuration Object 
    .PARAMETER name 
        The name of the ipsec alg profile.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER ikesessiontimeout 
        IKE session timeout in minutes.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER espsessiontimeout 
        ESP session timeout in minutes.  
        Default value: 60  
        Minimum value = 1  
        Maximum value = 1440 
    .PARAMETER espgatetimeout 
        Timeout ESP in seconds as no ESP packets are seen after IKE negotiation.  
        Default value: 30  
        Minimum value = 3  
        Maximum value = 1200 
    .PARAMETER connfailover 
        Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created ipsecalgprofile item.
    .EXAMPLE
        Invoke-ADCUpdateIpsecalgprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateIpsecalgprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [ValidateRange(1, 1440)]
        [double]$ikesessiontimeout ,

        [ValidateRange(1, 1440)]
        [double]$espsessiontimeout ,

        [ValidateRange(3, 1200)]
        [double]$espgatetimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$connfailover ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIpsecalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ikesessiontimeout')) { $Payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espsessiontimeout')) { $Payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espgatetimeout')) { $Payload.Add('espgatetimeout', $espgatetimeout) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
 
            if ($PSCmdlet.ShouldProcess("ipsecalgprofile", "Update Ipsecalg configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ipsecalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIpsecalgprofile -Filter $Payload)
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
        Unset Ipsecalg configuration Object
    .DESCRIPTION
        Unset Ipsecalg configuration Object 
   .PARAMETER name 
       The name of the ipsec alg profile. 
   .PARAMETER ikesessiontimeout 
       IKE session timeout in minutes. 
   .PARAMETER espsessiontimeout 
       ESP session timeout in minutes. 
   .PARAMETER espgatetimeout 
       Timeout ESP in seconds as no ESP packets are seen after IKE negotiation. 
   .PARAMETER connfailover 
       Mode in which the connection failover feature must operate for the IPSec Alg. After a failover, established UDP connections and ESP packet flows are kept active and resumed on the secondary appliance. Recomended setting is ENABLED.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetIpsecalgprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetIpsecalgprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [Boolean]$ikesessiontimeout ,

        [Boolean]$espsessiontimeout ,

        [Boolean]$espgatetimeout ,

        [Boolean]$connfailover 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIpsecalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ikesessiontimeout')) { $Payload.Add('ikesessiontimeout', $ikesessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espsessiontimeout')) { $Payload.Add('espsessiontimeout', $espsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('espgatetimeout')) { $Payload.Add('espgatetimeout', $espgatetimeout) }
            if ($PSBoundParameters.ContainsKey('connfailover')) { $Payload.Add('connfailover', $connfailover) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Ipsecalg configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ipsecalgprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Ipsecalg configuration Object
    .DESCRIPTION
        Delete Ipsecalg configuration Object
    .PARAMETER name 
       The name of the ipsec alg profile.  
       Minimum length = 1  
       Maximum length = 32 
    .EXAMPLE
        Invoke-ADCDeleteIpsecalgprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIpsecalgprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        Write-Verbose "Invoke-ADCDeleteIpsecalgprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ipsecalg configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ipsecalgprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Ipsecalg configuration object(s)
    .DESCRIPTION
        Get Ipsecalg configuration object(s)
    .PARAMETER name 
       The name of the ipsec alg profile. 
    .PARAMETER GetAll 
        Retreive all ipsecalgprofile object(s)
    .PARAMETER Count
        If specified, the count of the ipsecalgprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIpsecalgprofile
    .EXAMPLE 
        Invoke-ADCGetIpsecalgprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIpsecalgprofile -Count
    .EXAMPLE
        Invoke-ADCGetIpsecalgprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetIpsecalgprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIpsecalgprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-ADCGetIpsecalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ipsecalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecalgprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecalgprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ipsecalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Ipsecalg configuration Object
    .DESCRIPTION
        Flush Ipsecalg configuration Object 
    .PARAMETER sourceip 
        Original Source IP address. 
    .PARAMETER natip 
        Natted Source IP address. 
    .PARAMETER destip 
        Destination IP address.
    .EXAMPLE
        Invoke-ADCFlushIpsecalgsession 
    .NOTES
        File Name : Invoke-ADCFlushIpsecalgsession
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgsession/
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
        [string]$sourceip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$natip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$destip 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushIpsecalgsession: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sourceip')) { $Payload.Add('sourceip', $sourceip) }
            if ($PSBoundParameters.ContainsKey('natip')) { $Payload.Add('natip', $natip) }
            if ($PSBoundParameters.ContainsKey('destip')) { $Payload.Add('destip', $destip) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Ipsecalg configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecalgsession -Action flush -Payload $Payload -GetWarning
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
        Get Ipsecalg configuration object(s)
    .DESCRIPTION
        Get Ipsecalg configuration object(s)
    .PARAMETER sourceip_alg 
       Original Source IP address. 
    .PARAMETER natip_alg 
       Natted Source IP address. 
    .PARAMETER destip_alg 
       Destination IP address. 
    .PARAMETER GetAll 
        Retreive all ipsecalgsession object(s)
    .PARAMETER Count
        If specified, the count of the ipsecalgsession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIpsecalgsession
    .EXAMPLE 
        Invoke-ADCGetIpsecalgsession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIpsecalgsession -Count
    .EXAMPLE
        Invoke-ADCGetIpsecalgsession -name <string>
    .EXAMPLE
        Invoke-ADCGetIpsecalgsession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIpsecalgsession
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsecalg/ipsecalgsession/
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
        [string]$sourceip_alg ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$natip_alg ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$destip_alg,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ipsecalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecalgsession objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('sourceip_alg')) { $Arguments.Add('sourceip_alg', $sourceip_alg) } 
                if ($PSBoundParameters.ContainsKey('natip_alg')) { $Arguments.Add('natip_alg', $natip_alg) } 
                if ($PSBoundParameters.ContainsKey('destip_alg')) { $Arguments.Add('destip_alg', $destip_alg) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecalgsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving ipsecalgsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecalgsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


