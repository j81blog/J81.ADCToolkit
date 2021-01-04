function Invoke-ADCUpdateAaacertparams {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER usernamefield 
        Client certificate field that contains the username, in the format <field>:<subfield>. . 
    .PARAMETER groupnamefield 
        Client certificate field that specifies the group, in the format <field>:<subfield>. 
    .PARAMETER defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.  
        Maximum length = 64
    .EXAMPLE
        Invoke-ADCUpdateAaacertparams 
    .NOTES
        File Name : Invoke-ADCUpdateAaacertparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams/
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

        [string]$usernamefield ,

        [string]$groupnamefield ,

        [string]$defaultauthenticationgroup 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaacertparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('usernamefield')) { $Payload.Add('usernamefield', $usernamefield) }
            if ($PSBoundParameters.ContainsKey('groupnamefield')) { $Payload.Add('groupnamefield', $groupnamefield) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
 
            if ($PSCmdlet.ShouldProcess("aaacertparams", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaacertparams -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaacertparams: Finished"
    }
}

function Invoke-ADCUnsetAaacertparams {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER usernamefield 
       Client certificate field that contains the username, in the format <field>:<subfield>. . 
   .PARAMETER groupnamefield 
       Client certificate field that specifies the group, in the format <field>:<subfield>. 
   .PARAMETER defaultauthenticationgroup 
       This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        Invoke-ADCUnsetAaacertparams 
    .NOTES
        File Name : Invoke-ADCUnsetAaacertparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams
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

        [Boolean]$usernamefield ,

        [Boolean]$groupnamefield ,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaacertparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('usernamefield')) { $Payload.Add('usernamefield', $usernamefield) }
            if ($PSBoundParameters.ContainsKey('groupnamefield')) { $Payload.Add('groupnamefield', $groupnamefield) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ($PSCmdlet.ShouldProcess("aaacertparams", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaacertparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaacertparams: Finished"
    }
}

function Invoke-ADCGetAaacertparams {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaacertparams object(s)
    .PARAMETER Count
        If specified, the count of the aaacertparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaacertparams
    .EXAMPLE 
        Invoke-ADCGetAaacertparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAaacertparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAaacertparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaacertparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams/
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
        Write-Verbose "Invoke-ADCGetAaacertparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaacertparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaacertparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaacertparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaacertparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaacertparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaacertparams: Ended"
    }
}

function Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER policy 
        Name of the policy to be unbound.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority of the bound policy. 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_aaapreauthenticationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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
        [string]$policy ,

        [double]$priority ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
 
            if ($PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_aaapreauthenticationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
     .PARAMETER policy 
       Name of the policy to be unbound.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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

        [string]$policy 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaglobal_aaapreauthenticationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaaglobal_aaapreauthenticationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER windowsprofile 
        Name of the negotiate profile to be bound.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_authenticationnegotiateaction_binding item.
    .EXAMPLE
        Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding 
    .NOTES
        File Name : Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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

        [ValidateLength(1, 32)]
        [string]$windowsprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('windowsprofile')) { $Payload.Add('windowsprofile', $windowsprofile) }
 
            if ($PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_authenticationnegotiateaction_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding: Finished"
    }
}

function Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
     .PARAMETER windowsprofile 
       Name of the negotiate profile to be bound.  
       Minimum length = 1  
       Maximum length = 32
    .EXAMPLE
        Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding 
    .NOTES
        File Name : Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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

        [string]$windowsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('windowsprofile')) { $Arguments.Add('windowsprofile', $windowsprofile) }
            if ($PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding: Finished"
    }
}

function Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaglobal_authenticationnegotiateaction_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaaglobal_authenticationnegotiateaction_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding
    .EXAMPLE 
        Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding: Ended"
    }
}

function Invoke-ADCGetAaaglobalbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaaglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAaaglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAaaglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaglobalbinding: Ended"
    }
}

function Invoke-ADCAddAaagroup {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER weight 
        Weight of this group with respect to other configured aaa groups (lower the number higher the weight).  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER PassThru 
        Return details about the created aaagroup item.
    .EXAMPLE
        Invoke-ADCAddAaagroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$groupname ,

        [ValidateRange(0, 65535)]
        [double]$weight = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('weight')) { $Payload.Add('weight', $weight) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaagroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroup -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroup: Finished"
    }
}

function Invoke-ADCDeleteAaagroup {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .EXAMPLE
        Invoke-ADCDeleteAaagroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroup: Finished"
    }
}

function Invoke-ADCGetAaagroup {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER GetAll 
        Retreive all aaagroup object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroup
    .EXAMPLE 
        Invoke-ADCGetAaagroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroup -Count
    .EXAMPLE
        Invoke-ADCGetAaagroup -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$groupname,

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
        Write-Verbose "Invoke-ADCGetAaagroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaagroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroup: Ended"
    }
}

function Invoke-ADCAddAaagroupaaauserbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER username 
        The user name. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_aaauser_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupaaauserbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupaaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$groupname ,

        [string]$username ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupaaauserbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_aaauser_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_aaauser_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupaaauserbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupaaauserbinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupaaauserbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER username 
       The user name.
    .EXAMPLE
        Invoke-ADCDeleteAaagroupaaauserbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupaaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$groupname ,

        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupaaauserbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('username')) { $Arguments.Add('username', $username) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupaaauserbinding: Finished"
    }
}

function Invoke-ADCGetAaagroupaaauserbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_aaauser_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_aaauser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupaaauserbinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupaaauserbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupaaauserbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupaaauserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupaaauserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupaaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupaaauserbinding: Ended"
    }
}

function Invoke-ADCAddAaagroupauditnslogpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupauditnslogpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_auditnslogpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupauditnslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupauditnslogpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupauditnslogpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupauditnslogpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupauditsyslogpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_auditsyslogpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupauditsyslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupauditsyslogpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupauthorizationpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_authorizationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupauthorizationpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_authorizationpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_authorizationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupauthorizationpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupauthorizationpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupauthorizationpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupauthorizationpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_authorizationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_authorizationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupauthorizationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupauthorizationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupauthorizationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupauthorizationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupauthorizationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupauthorizationpolicybinding: Ended"
    }
}

function Invoke-ADCGetAaagroupbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group. 
    .PARAMETER GetAll 
        Retreive all aaagroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupbinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAaagroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_binding/
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
        [string]$groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupbinding: Ended"
    }
}

function Invoke-ADCAddAaagroupintranetip6binding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER intranetip6 
        The Intranet IP6(s) bound to the group. 
    .PARAMETER numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip6_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupintranetip6binding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$groupname ,

        [string]$gotopriorityexpression ,

        [string]$intranetip6 ,

        [double]$numaddr ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupintranetip6binding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('intranetip6')) { $Payload.Add('intranetip6', $intranetip6) }
            if ($PSBoundParameters.ContainsKey('numaddr')) { $Payload.Add('numaddr', $numaddr) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_intranetip6_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip6_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupintranetip6binding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupintranetip6binding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupintranetip6binding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER intranetip6 
       The Intranet IP6(s) bound to the group.    .PARAMETER numaddr 
       Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        Invoke-ADCDeleteAaagroupintranetip6binding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$groupname ,

        [string]$intranetip6 ,

        [double]$numaddr 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetip6binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetip6')) { $Arguments.Add('intranetip6', $intranetip6) }
            if ($PSBoundParameters.ContainsKey('numaddr')) { $Arguments.Add('numaddr', $numaddr) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetip6binding: Finished"
    }
}

function Invoke-ADCGetAaagroupintranetip6binding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_intranetip6_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip6_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetip6binding
    .EXAMPLE 
        Invoke-ADCGetAaagroupintranetip6binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupintranetip6binding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetip6binding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetip6binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupintranetip6binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupintranetip6binding: Ended"
    }
}

function Invoke-ADCAddAaagroupintranetipbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER intranetip 
        The Intranet IP(s) bound to the group. 
    .PARAMETER netmask 
        The netmask for the Intranet IP. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupintranetipbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$groupname ,

        [string]$intranetip ,

        [string]$netmask ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupintranetipbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('intranetip')) { $Payload.Add('intranetip', $intranetip) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_intranetip_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupintranetipbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupintranetipbinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupintranetipbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER intranetip 
       The Intranet IP(s) bound to the group.    .PARAMETER netmask 
       The netmask for the Intranet IP.
    .EXAMPLE
        Invoke-ADCDeleteAaagroupintranetipbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$groupname ,

        [string]$intranetip ,

        [string]$netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetipbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetip')) { $Arguments.Add('intranetip', $intranetip) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetipbinding: Finished"
    }
}

function Invoke-ADCGetAaagroupintranetipbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_intranetip_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetipbinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupintranetipbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupintranetipbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetipbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupintranetipbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupintranetipbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupintranetipbinding: Ended"
    }
}

function Invoke-ADCAddAaagrouptmsessionpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_tmsessionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagrouptmsessionpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagrouptmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagrouptmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_tmsessionpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_tmsessionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagrouptmsessionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagrouptmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagrouptmsessionpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagrouptmsessionpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagrouptmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagrouptmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagrouptmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagrouptmsessionpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_tmsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_tmsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagrouptmsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagrouptmsessionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagrouptmsessionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagrouptmsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagrouptmsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagrouptmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagrouptmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagrouptmsessionpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupvpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER intranetapplication 
        Bind the group to the specified intranet VPN application. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnintranetapplication_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupvpnintranetapplicationbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$groupname ,

        [string]$intranetapplication ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('intranetapplication')) { $Payload.Add('intranetapplication', $intranetapplication) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_vpnintranetapplication_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnintranetapplication_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupvpnintranetapplicationbinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER intranetapplication 
       Bind the group to the specified intranet VPN application.
    .EXAMPLE
        Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$groupname ,

        [string]$intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetapplication')) { $Arguments.Add('intranetapplication', $intranetapplication) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding: Finished"
    }
}

function Invoke-ADCGetAaagroupvpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_vpnintranetapplication_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnintranetapplication_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnintranetapplicationbinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnintranetapplicationbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnintranetapplicationbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupvpnintranetapplicationbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupvpnintranetapplicationbinding: Ended"
    }
}

function Invoke-ADCAddAaagroupvpnsessionpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnsessionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupvpnsessionpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_vpnsessionpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnsessionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupvpnsessionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupvpnsessionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupvpnsessionpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupvpnsessionpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnsessionpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupvpnsessionpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_vpnsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnsessionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnsessionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupvpnsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupvpnsessionpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupvpntrafficpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpntrafficpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupvpntrafficpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_vpntrafficpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpntrafficpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupvpntrafficpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupvpntrafficpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupvpntrafficpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupvpntrafficpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupvpntrafficpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupvpntrafficpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_vpntrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_vpntrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupvpntrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpntrafficpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpntrafficpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupvpntrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupvpntrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupvpntrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupvpntrafficpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupvpnurlpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000.  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurlpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupvpnurlpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_vpnurlpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurlpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupvpnurlpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupvpnurlpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER policy 
       The policy name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaagroupvpnurlpolicybinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$groupname ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaagroupvpnurlpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_vpnurlpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurlpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnurlpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnurlpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupvpnurlpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupvpnurlpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaagroupvpnurlbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER groupname 
        Name of the group that you are binding.  
        Minimum length = 1 
    .PARAMETER urlname 
        The intranet url. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAaagroupvpnurlbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$groupname ,

        [string]$urlname ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('urlname')) { $Payload.Add('urlname', $urlname) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaagroup_vpnurl_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaagroupvpnurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAaagroupvpnurlbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER groupname 
       Name of the group that you are binding.  
       Minimum length = 1    .PARAMETER urlname 
       The intranet url.
    .EXAMPLE
        Invoke-ADCDeleteAaagroupvpnurlbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$groupname ,

        [string]$urlname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('urlname')) { $Arguments.Add('urlname', $urlname) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlbinding: Finished"
    }
}

function Invoke-ADCGetAaagroupvpnurlbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER groupname 
       Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retreive all aaagroup_vpnurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlbinding
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaagroupvpnurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaagroupvpnurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupvpnurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaagroup_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaagroupvpnurlbinding: Ended"
    }
}

function Invoke-ADCAddAaakcdaccount {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER kcdaccount 
        The name of the KCD account.  
        Minimum length = 1 
    .PARAMETER keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER realmstr 
        Kerberos Realm. 
    .PARAMETER delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER kcdpassword 
        Password for Delegated User. 
    .PARAMETER usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER userrealm 
        Realm of the user. 
    .PARAMETER enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        Invoke-ADCAddAaakcdaccount -kcdaccount <string>
    .NOTES
        File Name : Invoke-ADCAddAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$kcdaccount ,

        [string]$keytab ,

        [string]$realmstr ,

        [string]$delegateduser ,

        [string]$kcdpassword ,

        [string]$usercert ,

        [string]$cacert ,

        [string]$userrealm ,

        [string]$enterpriserealm ,

        [string]$servicespn ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaakcdaccount: Starting"
    }
    process {
        try {
            $Payload = @{
                kcdaccount = $kcdaccount
            }
            if ($PSBoundParameters.ContainsKey('keytab')) { $Payload.Add('keytab', $keytab) }
            if ($PSBoundParameters.ContainsKey('realmstr')) { $Payload.Add('realmstr', $realmstr) }
            if ($PSBoundParameters.ContainsKey('delegateduser')) { $Payload.Add('delegateduser', $delegateduser) }
            if ($PSBoundParameters.ContainsKey('kcdpassword')) { $Payload.Add('kcdpassword', $kcdpassword) }
            if ($PSBoundParameters.ContainsKey('usercert')) { $Payload.Add('usercert', $usercert) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('userrealm')) { $Payload.Add('userrealm', $userrealm) }
            if ($PSBoundParameters.ContainsKey('enterpriserealm')) { $Payload.Add('enterpriserealm', $enterpriserealm) }
            if ($PSBoundParameters.ContainsKey('servicespn')) { $Payload.Add('servicespn', $servicespn) }
 
            if ($PSCmdlet.ShouldProcess("aaakcdaccount", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaakcdaccount -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaakcdaccount: Finished"
    }
}

function Invoke-ADCDeleteAaakcdaccount {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER kcdaccount 
       The name of the KCD account.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAaakcdaccount -kcdaccount <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$kcdaccount 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaakcdaccount: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$kcdaccount", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaakcdaccount: Finished"
    }
}

function Invoke-ADCUpdateAaakcdaccount {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER kcdaccount 
        The name of the KCD account.  
        Minimum length = 1 
    .PARAMETER keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER realmstr 
        Kerberos Realm. 
    .PARAMETER delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER kcdpassword 
        Password for Delegated User. 
    .PARAMETER usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER userrealm 
        Realm of the user. 
    .PARAMETER enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        Invoke-ADCUpdateAaakcdaccount -kcdaccount <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$kcdaccount ,

        [string]$keytab ,

        [string]$realmstr ,

        [string]$delegateduser ,

        [string]$kcdpassword ,

        [string]$usercert ,

        [string]$cacert ,

        [string]$userrealm ,

        [string]$enterpriserealm ,

        [string]$servicespn ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaakcdaccount: Starting"
    }
    process {
        try {
            $Payload = @{
                kcdaccount = $kcdaccount
            }
            if ($PSBoundParameters.ContainsKey('keytab')) { $Payload.Add('keytab', $keytab) }
            if ($PSBoundParameters.ContainsKey('realmstr')) { $Payload.Add('realmstr', $realmstr) }
            if ($PSBoundParameters.ContainsKey('delegateduser')) { $Payload.Add('delegateduser', $delegateduser) }
            if ($PSBoundParameters.ContainsKey('kcdpassword')) { $Payload.Add('kcdpassword', $kcdpassword) }
            if ($PSBoundParameters.ContainsKey('usercert')) { $Payload.Add('usercert', $usercert) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('userrealm')) { $Payload.Add('userrealm', $userrealm) }
            if ($PSBoundParameters.ContainsKey('enterpriserealm')) { $Payload.Add('enterpriserealm', $enterpriserealm) }
            if ($PSBoundParameters.ContainsKey('servicespn')) { $Payload.Add('servicespn', $servicespn) }
 
            if ($PSCmdlet.ShouldProcess("aaakcdaccount", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaakcdaccount -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAaakcdaccount: Finished"
    }
}

function Invoke-ADCUnsetAaakcdaccount {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER kcdaccount 
       The name of the KCD account. 
   .PARAMETER keytab 
       The path to the keytab file. If specified other parameters in this command need not be given. 
   .PARAMETER usercert 
       SSL Cert (including private key) for Delegated User. 
   .PARAMETER cacert 
       CA Cert for UserCert or when doing PKINIT backchannel. 
   .PARAMETER userrealm 
       Realm of the user. 
   .PARAMETER enterpriserealm 
       Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
   .PARAMETER servicespn 
       Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn.
    .EXAMPLE
        Invoke-ADCUnsetAaakcdaccount -kcdaccount <string>
    .NOTES
        File Name : Invoke-ADCUnsetAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount
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
        [string]$kcdaccount ,

        [Boolean]$keytab ,

        [Boolean]$usercert ,

        [Boolean]$cacert ,

        [Boolean]$userrealm ,

        [Boolean]$enterpriserealm ,

        [Boolean]$servicespn 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaakcdaccount: Starting"
    }
    process {
        try {
            $Payload = @{
                kcdaccount = $kcdaccount
            }
            if ($PSBoundParameters.ContainsKey('keytab')) { $Payload.Add('keytab', $keytab) }
            if ($PSBoundParameters.ContainsKey('usercert')) { $Payload.Add('usercert', $usercert) }
            if ($PSBoundParameters.ContainsKey('cacert')) { $Payload.Add('cacert', $cacert) }
            if ($PSBoundParameters.ContainsKey('userrealm')) { $Payload.Add('userrealm', $userrealm) }
            if ($PSBoundParameters.ContainsKey('enterpriserealm')) { $Payload.Add('enterpriserealm', $enterpriserealm) }
            if ($PSBoundParameters.ContainsKey('servicespn')) { $Payload.Add('servicespn', $servicespn) }
            if ($PSCmdlet.ShouldProcess("$kcdaccount", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaakcdaccount -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaakcdaccount: Finished"
    }
}

function Invoke-ADCCheckAaakcdaccount {
<#
    .SYNOPSIS
        Check AAA configuration Object
    .DESCRIPTION
        Check AAA configuration Object 
    .PARAMETER realmstr 
        Kerberos Realm. 
    .PARAMETER delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER kcdpassword 
        Password for Delegated User. 
    .PARAMETER servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER userrealm 
        Realm of the user.
    .EXAMPLE
        Invoke-ADCCheckAaakcdaccount -realmstr <string> -delegateduser <string> -kcdpassword <string> -servicespn <string>
    .NOTES
        File Name : Invoke-ADCCheckAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$realmstr ,

        [Parameter(Mandatory = $true)]
        [string]$delegateduser ,

        [Parameter(Mandatory = $true)]
        [string]$kcdpassword ,

        [Parameter(Mandatory = $true)]
        [string]$servicespn ,

        [string]$userrealm 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckAaakcdaccount: Starting"
    }
    process {
        try {
            $Payload = @{
                realmstr = $realmstr
                delegateduser = $delegateduser
                kcdpassword = $kcdpassword
                servicespn = $servicespn
            }
            if ($PSBoundParameters.ContainsKey('userrealm')) { $Payload.Add('userrealm', $userrealm) }
            if ($PSCmdlet.ShouldProcess($Name, "Check AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Action check -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCCheckAaakcdaccount: Finished"
    }
}

function Invoke-ADCGetAaakcdaccount {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER kcdaccount 
       The name of the KCD account. 
    .PARAMETER GetAll 
        Retreive all aaakcdaccount object(s)
    .PARAMETER Count
        If specified, the count of the aaakcdaccount object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaakcdaccount
    .EXAMPLE 
        Invoke-ADCGetAaakcdaccount -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaakcdaccount -Count
    .EXAMPLE
        Invoke-ADCGetAaakcdaccount -name <string>
    .EXAMPLE
        Invoke-ADCGetAaakcdaccount -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaakcdaccount
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$kcdaccount,

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
        Write-Verbose "Invoke-ADCGetAaakcdaccount: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaakcdaccount objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaakcdaccount objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaakcdaccount objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaakcdaccount configuration for property 'kcdaccount'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaakcdaccount configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaakcdaccount: Ended"
    }
}

function Invoke-ADCUpdateAaaldapparams {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER serverip 
        IP address of your LDAP server. 
    .PARAMETER serverport 
        Port number on which the LDAP server listens for connections.  
        Default value: 389  
        Minimum value = 1 
    .PARAMETER authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server.  
        Default value: 3  
        Minimum value = 1 
    .PARAMETER ldapbase 
        Base (the server and location) from which LDAP search commands should start.  
        If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
    .PARAMETER ldapbinddn 
        Complete distinguished name (DN) string used for binding to the LDAP server. 
    .PARAMETER ldapbinddnpassword 
        Password for binding to the LDAP server.  
        Minimum length = 1 
    .PARAMETER ldaploginname 
        Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
    .PARAMETER searchfilter 
        String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search.  
        For example, the following values:  
        vpnallowed=true,  
        ldaploginame=""samaccount""  
        when combined with the user-supplied username ""bob"", yield the following LDAP search string:  
        ""(;(vpnallowed=true)(samaccount=bob)"".  
        Minimum length = 1 
    .PARAMETER groupattrname 
        Attribute name used for group extraction from the LDAP server. 
    .PARAMETER subattributename 
        Subattribute name used for group extraction from the LDAP server. 
    .PARAMETER sectype 
        Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required.  
        Default value: TLS  
        Possible values = PLAINTEXT, TLS, SSL 
    .PARAMETER svrtype 
        The type of LDAP server.  
        Default value: AAA_LDAP_SERVER_TYPE_DEFAULT  
        Possible values = AD, NDS 
    .PARAMETER ssonameattribute 
        Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username.  
        This alternative username is then used for single sign-on (SSO). 
    .PARAMETER passwdchange 
        Accept password change requests.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER nestedgroupextraction 
        Queries the external LDAP server to determine whether the specified group belongs to another group.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER maxnestinglevel 
        Number of levels up to which the system can query nested LDAP groups.  
        Default value: 2  
        Minimum value = 2 
    .PARAMETER groupnameidentifier 
        LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
    .PARAMETER groupsearchattribute 
        LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER groupsearchsubattribute 
        LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER groupsearchfilter 
        Search-expression that can be specified for sending group-search requests to the LDAP server. 
    .PARAMETER defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.  
        Maximum length = 64
    .EXAMPLE
        Invoke-ADCUpdateAaaldapparams 
    .NOTES
        File Name : Invoke-ADCUpdateAaaldapparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams/
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

        [string]$serverip ,

        [int]$serverport ,

        [double]$authtimeout ,

        [string]$ldapbase ,

        [string]$ldapbinddn ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ldapbinddnpassword ,

        [string]$ldaploginname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$searchfilter ,

        [string]$groupattrname ,

        [string]$subattributename ,

        [ValidateSet('PLAINTEXT', 'TLS', 'SSL')]
        [string]$sectype ,

        [ValidateSet('AD', 'NDS')]
        [string]$svrtype ,

        [string]$ssonameattribute ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$passwdchange ,

        [ValidateSet('ON', 'OFF')]
        [string]$nestedgroupextraction ,

        [double]$maxnestinglevel ,

        [string]$groupnameidentifier ,

        [string]$groupsearchattribute ,

        [string]$groupsearchsubattribute ,

        [string]$groupsearchfilter ,

        [string]$defaultauthenticationgroup 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaldapparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('ldapbase')) { $Payload.Add('ldapbase', $ldapbase) }
            if ($PSBoundParameters.ContainsKey('ldapbinddn')) { $Payload.Add('ldapbinddn', $ldapbinddn) }
            if ($PSBoundParameters.ContainsKey('ldapbinddnpassword')) { $Payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ($PSBoundParameters.ContainsKey('ldaploginname')) { $Payload.Add('ldaploginname', $ldaploginname) }
            if ($PSBoundParameters.ContainsKey('searchfilter')) { $Payload.Add('searchfilter', $searchfilter) }
            if ($PSBoundParameters.ContainsKey('groupattrname')) { $Payload.Add('groupattrname', $groupattrname) }
            if ($PSBoundParameters.ContainsKey('subattributename')) { $Payload.Add('subattributename', $subattributename) }
            if ($PSBoundParameters.ContainsKey('sectype')) { $Payload.Add('sectype', $sectype) }
            if ($PSBoundParameters.ContainsKey('svrtype')) { $Payload.Add('svrtype', $svrtype) }
            if ($PSBoundParameters.ContainsKey('ssonameattribute')) { $Payload.Add('ssonameattribute', $ssonameattribute) }
            if ($PSBoundParameters.ContainsKey('passwdchange')) { $Payload.Add('passwdchange', $passwdchange) }
            if ($PSBoundParameters.ContainsKey('nestedgroupextraction')) { $Payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ($PSBoundParameters.ContainsKey('maxnestinglevel')) { $Payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ($PSBoundParameters.ContainsKey('groupnameidentifier')) { $Payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ($PSBoundParameters.ContainsKey('groupsearchattribute')) { $Payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ($PSBoundParameters.ContainsKey('groupsearchsubattribute')) { $Payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ($PSBoundParameters.ContainsKey('groupsearchfilter')) { $Payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
 
            if ($PSCmdlet.ShouldProcess("aaaldapparams", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaldapparams -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaaldapparams: Finished"
    }
}

function Invoke-ADCUnsetAaaldapparams {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER serverip 
       IP address of your LDAP server. 
   .PARAMETER serverport 
       Port number on which the LDAP server listens for connections. 
   .PARAMETER authtimeout 
       Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server. 
   .PARAMETER ldapbase 
       Base (the server and location) from which LDAP search commands should start.  
       If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
   .PARAMETER ldapbinddn 
       Complete distinguished name (DN) string used for binding to the LDAP server. 
   .PARAMETER ldapbinddnpassword 
       Password for binding to the LDAP server. 
   .PARAMETER ldaploginname 
       Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
   .PARAMETER searchfilter 
       String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search.  
       For example, the following values:  
       vpnallowed=true,  
       ldaploginame=""samaccount""  
       when combined with the user-supplied username ""bob"", yield the following LDAP search string:  
       ""(;(vpnallowed=true)(samaccount=bob)"". 
   .PARAMETER groupattrname 
       Attribute name used for group extraction from the LDAP server. 
   .PARAMETER subattributename 
       Subattribute name used for group extraction from the LDAP server. 
   .PARAMETER sectype 
       Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required.  
       Possible values = PLAINTEXT, TLS, SSL 
   .PARAMETER svrtype 
       The type of LDAP server.  
       Possible values = AD, NDS 
   .PARAMETER ssonameattribute 
       Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username.  
       This alternative username is then used for single sign-on (SSO). 
   .PARAMETER passwdchange 
       Accept password change requests.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER nestedgroupextraction 
       Queries the external LDAP server to determine whether the specified group belongs to another group.  
       Possible values = ON, OFF 
   .PARAMETER maxnestinglevel 
       Number of levels up to which the system can query nested LDAP groups. 
   .PARAMETER groupnameidentifier 
       LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
   .PARAMETER groupsearchattribute 
       LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
   .PARAMETER groupsearchsubattribute 
       LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
   .PARAMETER groupsearchfilter 
       Search-expression that can be specified for sending group-search requests to the LDAP server. 
   .PARAMETER defaultauthenticationgroup 
       This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        Invoke-ADCUnsetAaaldapparams 
    .NOTES
        File Name : Invoke-ADCUnsetAaaldapparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams
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

        [Boolean]$serverip ,

        [Boolean]$serverport ,

        [Boolean]$authtimeout ,

        [Boolean]$ldapbase ,

        [Boolean]$ldapbinddn ,

        [Boolean]$ldapbinddnpassword ,

        [Boolean]$ldaploginname ,

        [Boolean]$searchfilter ,

        [Boolean]$groupattrname ,

        [Boolean]$subattributename ,

        [Boolean]$sectype ,

        [Boolean]$svrtype ,

        [Boolean]$ssonameattribute ,

        [Boolean]$passwdchange ,

        [Boolean]$nestedgroupextraction ,

        [Boolean]$maxnestinglevel ,

        [Boolean]$groupnameidentifier ,

        [Boolean]$groupsearchattribute ,

        [Boolean]$groupsearchsubattribute ,

        [Boolean]$groupsearchfilter ,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaldapparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('ldapbase')) { $Payload.Add('ldapbase', $ldapbase) }
            if ($PSBoundParameters.ContainsKey('ldapbinddn')) { $Payload.Add('ldapbinddn', $ldapbinddn) }
            if ($PSBoundParameters.ContainsKey('ldapbinddnpassword')) { $Payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ($PSBoundParameters.ContainsKey('ldaploginname')) { $Payload.Add('ldaploginname', $ldaploginname) }
            if ($PSBoundParameters.ContainsKey('searchfilter')) { $Payload.Add('searchfilter', $searchfilter) }
            if ($PSBoundParameters.ContainsKey('groupattrname')) { $Payload.Add('groupattrname', $groupattrname) }
            if ($PSBoundParameters.ContainsKey('subattributename')) { $Payload.Add('subattributename', $subattributename) }
            if ($PSBoundParameters.ContainsKey('sectype')) { $Payload.Add('sectype', $sectype) }
            if ($PSBoundParameters.ContainsKey('svrtype')) { $Payload.Add('svrtype', $svrtype) }
            if ($PSBoundParameters.ContainsKey('ssonameattribute')) { $Payload.Add('ssonameattribute', $ssonameattribute) }
            if ($PSBoundParameters.ContainsKey('passwdchange')) { $Payload.Add('passwdchange', $passwdchange) }
            if ($PSBoundParameters.ContainsKey('nestedgroupextraction')) { $Payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ($PSBoundParameters.ContainsKey('maxnestinglevel')) { $Payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ($PSBoundParameters.ContainsKey('groupnameidentifier')) { $Payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ($PSBoundParameters.ContainsKey('groupsearchattribute')) { $Payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ($PSBoundParameters.ContainsKey('groupsearchsubattribute')) { $Payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ($PSBoundParameters.ContainsKey('groupsearchfilter')) { $Payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ($PSCmdlet.ShouldProcess("aaaldapparams", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaldapparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaaldapparams: Finished"
    }
}

function Invoke-ADCGetAaaldapparams {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaldapparams object(s)
    .PARAMETER Count
        If specified, the count of the aaaldapparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaldapparams
    .EXAMPLE 
        Invoke-ADCGetAaaldapparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAaaldapparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaldapparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaldapparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams/
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
        Write-Verbose "Invoke-ADCGetAaaldapparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaaldapparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaldapparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaldapparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaldapparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaldapparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaldapparams: Ended"
    }
}

function Invoke-ADCUpdateAaaotpparameter {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER encryption 
        To encrypt otp secret in AD or not. Default value is OFF.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER maxotpdevices 
        Maximum number of otp devices user can register. Default value is 4. Max value is 255.  
        Default value: 4  
        Minimum value = 0  
        Maximum value = 255
    .EXAMPLE
        Invoke-ADCUpdateAaaotpparameter 
    .NOTES
        File Name : Invoke-ADCUpdateAaaotpparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter/
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

        [ValidateSet('ON', 'OFF')]
        [string]$encryption ,

        [ValidateRange(0, 255)]
        [double]$maxotpdevices 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaotpparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('encryption')) { $Payload.Add('encryption', $encryption) }
            if ($PSBoundParameters.ContainsKey('maxotpdevices')) { $Payload.Add('maxotpdevices', $maxotpdevices) }
 
            if ($PSCmdlet.ShouldProcess("aaaotpparameter", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaotpparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaaotpparameter: Finished"
    }
}

function Invoke-ADCUnsetAaaotpparameter {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER encryption 
       To encrypt otp secret in AD or not. Default value is OFF.  
       Possible values = ON, OFF 
   .PARAMETER maxotpdevices 
       Maximum number of otp devices user can register. Default value is 4. Max value is 255.
    .EXAMPLE
        Invoke-ADCUnsetAaaotpparameter 
    .NOTES
        File Name : Invoke-ADCUnsetAaaotpparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter
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

        [Boolean]$encryption ,

        [Boolean]$maxotpdevices 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaotpparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('encryption')) { $Payload.Add('encryption', $encryption) }
            if ($PSBoundParameters.ContainsKey('maxotpdevices')) { $Payload.Add('maxotpdevices', $maxotpdevices) }
            if ($PSCmdlet.ShouldProcess("aaaotpparameter", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaotpparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaaotpparameter: Finished"
    }
}

function Invoke-ADCGetAaaotpparameter {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaotpparameter object(s)
    .PARAMETER Count
        If specified, the count of the aaaotpparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaotpparameter
    .EXAMPLE 
        Invoke-ADCGetAaaotpparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetAaaotpparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaotpparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaotpparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter/
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
        Write-Verbose "Invoke-ADCGetAaaotpparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaaotpparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaotpparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaotpparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaotpparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaotpparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaotpparameter: Ended"
    }
}

function Invoke-ADCUpdateAaaparameter {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER enablestaticpagecaching 
        The default state of VPN Static Page caching. If nothing is specified, the default value is set to YES.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER enableenhancedauthfeedback 
        Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER defaultauthtype 
        The default authentication server type.  
        Default value: LOCAL  
        Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
    .PARAMETER maxaaausers 
        Maximum number of concurrent users allowed to log on to VPN simultaneously.  
        Minimum value = 1 
    .PARAMETER maxloginattempts 
        Maximum Number of login Attempts.  
        Minimum value = 1 
    .PARAMETER failedlogintimeout 
        Number of minutes an account will be locked if user exceeds maximum permissible attempts.  
        Minimum value = 1 
    .PARAMETER aaadnatip 
        Source IP address to use for traffic that is sent to the authentication server. 
    .PARAMETER enablesessionstickiness 
        Enables/Disables stickiness to authentication servers.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER aaasessionloglevel 
        Audit log level, which specifies the types of events to log for cli executed commands.  
        Available values function as follows:  
        * EMERGENCY - Events that indicate an immediate crisis on the server.  
        * ALERT - Events that might require action.  
        * CRITICAL - Events that indicate an imminent server crisis.  
        * ERROR - Events that indicate some type of error.  
        * WARNING - Events that require action in the near future.  
        * NOTICE - Events that the administrator should know about.  
        * INFORMATIONAL - All but low-level events.  
        * DEBUG - All events, in extreme detail.  
        Default value: DEFAULT_LOGLEVEL_AAA  
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER aaadloglevel 
        AAAD log level, which specifies the types of AAAD events to log in nsvpn.log.  
        Available values function as follows:  
        * EMERGENCY - Events that indicate an immediate crisis on the server.  
        * ALERT - Events that might require action.  
        * CRITICAL - Events that indicate an imminent server crisis.  
        * ERROR - Events that indicate some type of error.  
        * WARNING - Events that require action in the near future.  
        * NOTICE - Events that the administrator should know about.  
        * INFORMATIONAL - All but low-level events.  
        * DEBUG - All events, in extreme detail.  
        Default value: INFORMATIONAL  
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER dynaddr 
        Set by the DHCP client when the IP address was fetched dynamically.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER ftmode 
        First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI.  
        Default value: ON  
        Possible values = ON, HA, OFF 
    .PARAMETER maxsamldeflatesize 
        This will set the maximum deflate size in case of SAML Redirect binding. 
    .PARAMETER persistentloginattempts 
        Persistent storage of unsuccessful user login attempts.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pwdexpirynotificationdays 
        This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
    .PARAMETER maxkbquestions 
        This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6.  
        Minimum value = 2  
        Maximum value = 6 
    .PARAMETER loginencryption 
        Parameter to encrypt login information for nFactor flow.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER samesite 
        SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite.  
        Possible values = None, LAX, STRICT 
    .PARAMETER apitokencache 
        Option to enable/disable API cache feature.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tokenintrospectioninterval 
        Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache.
    .EXAMPLE
        Invoke-ADCUpdateAaaparameter 
    .NOTES
        File Name : Invoke-ADCUpdateAaaparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter/
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

        [ValidateSet('YES', 'NO')]
        [string]$enablestaticpagecaching ,

        [ValidateSet('YES', 'NO')]
        [string]$enableenhancedauthfeedback ,

        [ValidateSet('LOCAL', 'LDAP', 'RADIUS', 'TACACS', 'CERT')]
        [string]$defaultauthtype ,

        [double]$maxaaausers ,

        [double]$maxloginattempts ,

        [double]$failedlogintimeout ,

        [string]$aaadnatip ,

        [ValidateSet('YES', 'NO')]
        [string]$enablesessionstickiness ,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$aaasessionloglevel ,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$aaadloglevel ,

        [ValidateSet('ON', 'OFF')]
        [string]$dynaddr ,

        [ValidateSet('ON', 'HA', 'OFF')]
        [string]$ftmode ,

        [double]$maxsamldeflatesize ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$persistentloginattempts ,

        [double]$pwdexpirynotificationdays ,

        [ValidateRange(2, 6)]
        [double]$maxkbquestions ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$loginencryption ,

        [ValidateSet('None', 'LAX', 'STRICT')]
        [string]$samesite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$apitokencache ,

        [double]$tokenintrospectioninterval 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('enablestaticpagecaching')) { $Payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ($PSBoundParameters.ContainsKey('enableenhancedauthfeedback')) { $Payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ($PSBoundParameters.ContainsKey('defaultauthtype')) { $Payload.Add('defaultauthtype', $defaultauthtype) }
            if ($PSBoundParameters.ContainsKey('maxaaausers')) { $Payload.Add('maxaaausers', $maxaaausers) }
            if ($PSBoundParameters.ContainsKey('maxloginattempts')) { $Payload.Add('maxloginattempts', $maxloginattempts) }
            if ($PSBoundParameters.ContainsKey('failedlogintimeout')) { $Payload.Add('failedlogintimeout', $failedlogintimeout) }
            if ($PSBoundParameters.ContainsKey('aaadnatip')) { $Payload.Add('aaadnatip', $aaadnatip) }
            if ($PSBoundParameters.ContainsKey('enablesessionstickiness')) { $Payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ($PSBoundParameters.ContainsKey('aaasessionloglevel')) { $Payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ($PSBoundParameters.ContainsKey('aaadloglevel')) { $Payload.Add('aaadloglevel', $aaadloglevel) }
            if ($PSBoundParameters.ContainsKey('dynaddr')) { $Payload.Add('dynaddr', $dynaddr) }
            if ($PSBoundParameters.ContainsKey('ftmode')) { $Payload.Add('ftmode', $ftmode) }
            if ($PSBoundParameters.ContainsKey('maxsamldeflatesize')) { $Payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ($PSBoundParameters.ContainsKey('persistentloginattempts')) { $Payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ($PSBoundParameters.ContainsKey('pwdexpirynotificationdays')) { $Payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ($PSBoundParameters.ContainsKey('maxkbquestions')) { $Payload.Add('maxkbquestions', $maxkbquestions) }
            if ($PSBoundParameters.ContainsKey('loginencryption')) { $Payload.Add('loginencryption', $loginencryption) }
            if ($PSBoundParameters.ContainsKey('samesite')) { $Payload.Add('samesite', $samesite) }
            if ($PSBoundParameters.ContainsKey('apitokencache')) { $Payload.Add('apitokencache', $apitokencache) }
            if ($PSBoundParameters.ContainsKey('tokenintrospectioninterval')) { $Payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
 
            if ($PSCmdlet.ShouldProcess("aaaparameter", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaaparameter: Finished"
    }
}

function Invoke-ADCUnsetAaaparameter {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER enablestaticpagecaching 
       The default state of VPN Static Page caching. If nothing is specified, the default value is set to YES.  
       Possible values = YES, NO 
   .PARAMETER enableenhancedauthfeedback 
       Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO.  
       Possible values = YES, NO 
   .PARAMETER defaultauthtype 
       The default authentication server type.  
       Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
   .PARAMETER maxaaausers 
       Maximum number of concurrent users allowed to log on to VPN simultaneously. 
   .PARAMETER aaadnatip 
       Source IP address to use for traffic that is sent to the authentication server. 
   .PARAMETER maxloginattempts 
       Maximum Number of login Attempts. 
   .PARAMETER enablesessionstickiness 
       Enables/Disables stickiness to authentication servers.  
       Possible values = YES, NO 
   .PARAMETER maxsamldeflatesize 
       This will set the maximum deflate size in case of SAML Redirect binding. 
   .PARAMETER persistentloginattempts 
       Persistent storage of unsuccessful user login attempts.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER pwdexpirynotificationdays 
       This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
   .PARAMETER maxkbquestions 
       This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6. 
   .PARAMETER aaasessionloglevel 
       Audit log level, which specifies the types of events to log for cli executed commands.  
       Available values function as follows:  
       * EMERGENCY - Events that indicate an immediate crisis on the server.  
       * ALERT - Events that might require action.  
       * CRITICAL - Events that indicate an imminent server crisis.  
       * ERROR - Events that indicate some type of error.  
       * WARNING - Events that require action in the near future.  
       * NOTICE - Events that the administrator should know about.  
       * INFORMATIONAL - All but low-level events.  
       * DEBUG - All events, in extreme detail.  
       Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
   .PARAMETER aaadloglevel 
       AAAD log level, which specifies the types of AAAD events to log in nsvpn.log.  
       Available values function as follows:  
       * EMERGENCY - Events that indicate an immediate crisis on the server.  
       * ALERT - Events that might require action.  
       * CRITICAL - Events that indicate an imminent server crisis.  
       * ERROR - Events that indicate some type of error.  
       * WARNING - Events that require action in the near future.  
       * NOTICE - Events that the administrator should know about.  
       * INFORMATIONAL - All but low-level events.  
       * DEBUG - All events, in extreme detail.  
       Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
   .PARAMETER dynaddr 
       Set by the DHCP client when the IP address was fetched dynamically.  
       Possible values = ON, OFF 
   .PARAMETER ftmode 
       First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI.  
       Possible values = ON, HA, OFF 
   .PARAMETER loginencryption 
       Parameter to encrypt login information for nFactor flow.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER samesite 
       SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite.  
       Possible values = None, LAX, STRICT 
   .PARAMETER apitokencache 
       Option to enable/disable API cache feature.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tokenintrospectioninterval 
       Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache.
    .EXAMPLE
        Invoke-ADCUnsetAaaparameter 
    .NOTES
        File Name : Invoke-ADCUnsetAaaparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter
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

        [Boolean]$enablestaticpagecaching ,

        [Boolean]$enableenhancedauthfeedback ,

        [Boolean]$defaultauthtype ,

        [Boolean]$maxaaausers ,

        [Boolean]$aaadnatip ,

        [Boolean]$maxloginattempts ,

        [Boolean]$enablesessionstickiness ,

        [Boolean]$maxsamldeflatesize ,

        [Boolean]$persistentloginattempts ,

        [Boolean]$pwdexpirynotificationdays ,

        [Boolean]$maxkbquestions ,

        [Boolean]$aaasessionloglevel ,

        [Boolean]$aaadloglevel ,

        [Boolean]$dynaddr ,

        [Boolean]$ftmode ,

        [Boolean]$loginencryption ,

        [Boolean]$samesite ,

        [Boolean]$apitokencache ,

        [Boolean]$tokenintrospectioninterval 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('enablestaticpagecaching')) { $Payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ($PSBoundParameters.ContainsKey('enableenhancedauthfeedback')) { $Payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ($PSBoundParameters.ContainsKey('defaultauthtype')) { $Payload.Add('defaultauthtype', $defaultauthtype) }
            if ($PSBoundParameters.ContainsKey('maxaaausers')) { $Payload.Add('maxaaausers', $maxaaausers) }
            if ($PSBoundParameters.ContainsKey('aaadnatip')) { $Payload.Add('aaadnatip', $aaadnatip) }
            if ($PSBoundParameters.ContainsKey('maxloginattempts')) { $Payload.Add('maxloginattempts', $maxloginattempts) }
            if ($PSBoundParameters.ContainsKey('enablesessionstickiness')) { $Payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ($PSBoundParameters.ContainsKey('maxsamldeflatesize')) { $Payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ($PSBoundParameters.ContainsKey('persistentloginattempts')) { $Payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ($PSBoundParameters.ContainsKey('pwdexpirynotificationdays')) { $Payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ($PSBoundParameters.ContainsKey('maxkbquestions')) { $Payload.Add('maxkbquestions', $maxkbquestions) }
            if ($PSBoundParameters.ContainsKey('aaasessionloglevel')) { $Payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ($PSBoundParameters.ContainsKey('aaadloglevel')) { $Payload.Add('aaadloglevel', $aaadloglevel) }
            if ($PSBoundParameters.ContainsKey('dynaddr')) { $Payload.Add('dynaddr', $dynaddr) }
            if ($PSBoundParameters.ContainsKey('ftmode')) { $Payload.Add('ftmode', $ftmode) }
            if ($PSBoundParameters.ContainsKey('loginencryption')) { $Payload.Add('loginencryption', $loginencryption) }
            if ($PSBoundParameters.ContainsKey('samesite')) { $Payload.Add('samesite', $samesite) }
            if ($PSBoundParameters.ContainsKey('apitokencache')) { $Payload.Add('apitokencache', $apitokencache) }
            if ($PSBoundParameters.ContainsKey('tokenintrospectioninterval')) { $Payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
            if ($PSCmdlet.ShouldProcess("aaaparameter", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaaparameter: Finished"
    }
}

function Invoke-ADCGetAaaparameter {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaparameter object(s)
    .PARAMETER Count
        If specified, the count of the aaaparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaparameter
    .EXAMPLE 
        Invoke-ADCGetAaaparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetAaaparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter/
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
        Write-Verbose "Invoke-ADCGetAaaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaparameter: Ended"
    }
}

function Invoke-ADCAddAaapreauthenticationaction {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results.  
        Possible values = ALLOW, DENY 
    .PARAMETER killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds.  
        Maximum length = 64 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        Invoke-ADCAddAaapreauthenticationaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddAaapreauthenticationaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$preauthenticationaction ,

        [string]$killprocess ,

        [string]$deletefiles ,

        [string]$defaultepagroup ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('preauthenticationaction')) { $Payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ($PSBoundParameters.ContainsKey('killprocess')) { $Payload.Add('killprocess', $killprocess) }
            if ($PSBoundParameters.ContainsKey('deletefiles')) { $Payload.Add('deletefiles', $deletefiles) }
            if ($PSBoundParameters.ContainsKey('defaultepagroup')) { $Payload.Add('defaultepagroup', $defaultepagroup) }
 
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaapreauthenticationaction: Finished"
    }
}

function Invoke-ADCDeleteAaapreauthenticationaction {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER name 
       Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .EXAMPLE
        Invoke-ADCDeleteAaapreauthenticationaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaapreauthenticationaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationaction: Finished"
    }
}

function Invoke-ADCUpdateAaapreauthenticationaction {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results.  
        Possible values = ALLOW, DENY 
    .PARAMETER killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds.  
        Maximum length = 64 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        Invoke-ADCUpdateAaapreauthenticationaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$preauthenticationaction ,

        [string]$killprocess ,

        [string]$deletefiles ,

        [string]$defaultepagroup ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('preauthenticationaction')) { $Payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ($PSBoundParameters.ContainsKey('killprocess')) { $Payload.Add('killprocess', $killprocess) }
            if ($PSBoundParameters.ContainsKey('deletefiles')) { $Payload.Add('deletefiles', $deletefiles) }
            if ($PSBoundParameters.ContainsKey('defaultepagroup')) { $Payload.Add('defaultepagroup', $defaultepagroup) }
 
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationaction: Finished"
    }
}

function Invoke-ADCUnsetAaapreauthenticationaction {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER name 
       Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
   .PARAMETER killprocess 
       String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
   .PARAMETER deletefiles 
       String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
   .PARAMETER defaultepagroup 
       This is the default group that is chosen when the EPA check succeeds.
    .EXAMPLE
        Invoke-ADCUnsetAaapreauthenticationaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAaapreauthenticationaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction
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

        [Boolean]$killprocess ,

        [Boolean]$deletefiles ,

        [Boolean]$defaultepagroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('killprocess')) { $Payload.Add('killprocess', $killprocess) }
            if ($PSBoundParameters.ContainsKey('deletefiles')) { $Payload.Add('deletefiles', $deletefiles) }
            if ($PSBoundParameters.ContainsKey('defaultepagroup')) { $Payload.Add('defaultepagroup', $defaultepagroup) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationaction: Finished"
    }
}

function Invoke-ADCGetAaapreauthenticationaction {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationaction object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationaction
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationaction -Count
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationaction: Ended"
    }
}

function Invoke-ADCUpdateAaapreauthenticationparameter {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER preauthenticationaction 
        Deny or allow login on the basis of end point analysis results.  
        Possible values = ALLOW, DENY 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
    .PARAMETER killprocess 
        String specifying the name of a process to be terminated by the EPA tool. 
    .PARAMETER deletefiles 
        String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        Invoke-ADCUpdateAaapreauthenticationparameter 
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$preauthenticationaction ,

        [string]$rule ,

        [string]$killprocess ,

        [string]$deletefiles 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('preauthenticationaction')) { $Payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('killprocess')) { $Payload.Add('killprocess', $killprocess) }
            if ($PSBoundParameters.ContainsKey('deletefiles')) { $Payload.Add('deletefiles', $deletefiles) }
 
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationparameter: Finished"
    }
}

function Invoke-ADCUnsetAaapreauthenticationparameter {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER rule 
       Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
   .PARAMETER preauthenticationaction 
       Deny or allow login on the basis of end point analysis results.  
       Possible values = ALLOW, DENY 
   .PARAMETER killprocess 
       String specifying the name of a process to be terminated by the EPA tool. 
   .PARAMETER deletefiles 
       String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        Invoke-ADCUnsetAaapreauthenticationparameter 
    .NOTES
        File Name : Invoke-ADCUnsetAaapreauthenticationparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter
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

        [Boolean]$rule ,

        [Boolean]$preauthenticationaction ,

        [Boolean]$killprocess ,

        [Boolean]$deletefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('preauthenticationaction')) { $Payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ($PSBoundParameters.ContainsKey('killprocess')) { $Payload.Add('killprocess', $killprocess) }
            if ($PSBoundParameters.ContainsKey('deletefiles')) { $Payload.Add('deletefiles', $deletefiles) }
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationparameter: Finished"
    }
}

function Invoke-ADCGetAaapreauthenticationparameter {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationparameter object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationparameter
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationparameter: Ended"
    }
}

function Invoke-ADCAddAaapreauthenticationpolicy {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        Invoke-ADCAddAaapreauthenticationpolicy -name <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddAaapreauthenticationpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reqaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('reqaction')) { $Payload.Add('reqaction', $reqaction) }
 
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-ADCDeleteAaapreauthenticationpolicy {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER name 
       Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteAaapreauthenticationpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaapreauthenticationpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-ADCUpdateAaapreauthenticationpolicy {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAaapreauthenticationpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reqaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('reqaction')) { $Payload.Add('reqaction', $reqaction) }
 
            if ($PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationpolicy: Finished"
    }
}

function Invoke-ADCGetAaapreauthenticationpolicy {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationpolicy object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicy
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicy -Count
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicy: Ended"
    }
}

function Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationpolicy_aaaglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_aaaglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_aaaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding: Ended"
    }
}

function Invoke-ADCGetAaapreauthenticationpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicybinding: Ended"
    }
}

function Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retreive all aaapreauthenticationpolicy_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding: Ended"
    }
}

function Invoke-ADCUpdateAaaradiusparams {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER serverip 
        IP address of your RADIUS server.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port number on which the RADIUS server listens for connections.  
        Default value: 1812  
        Minimum value = 1 
    .PARAMETER authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server.  
        Default value: 3  
        Minimum value = 1 
    .PARAMETER radkey 
        The key shared between the RADIUS server and clients.  
        Required for allowing the Citrix ADC to communicate with the RADIUS server.  
        Minimum length = 1 
    .PARAMETER radnasip 
        Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER radnasid 
        Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
    .PARAMETER radvendorid 
        Vendor ID for RADIUS group extraction.  
        Minimum value = 1 
    .PARAMETER radattributetype 
        Attribute type for RADIUS group extraction.  
        Minimum value = 1 
    .PARAMETER radgroupsprefix 
        Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER radgroupseparator 
        Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER passencoding 
        Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server.  
        Default value: mschapv2  
        Possible values = pap, chap, mschapv1, mschapv2 
    .PARAMETER ipvendorid 
        Vendor ID attribute in the RADIUS response.  
        If the attribute is not vendor-encoded, it is set to 0. 
    .PARAMETER ipattributetype 
        IP attribute type in the RADIUS response.  
        Minimum value = 1 
    .PARAMETER accounting 
        Configure the RADIUS server state to accept or refuse accounting messages.  
        Possible values = ON, OFF 
    .PARAMETER pwdvendorid 
        Vendor ID of the password in the RADIUS response. Used to extract the user password.  
        Minimum value = 1 
    .PARAMETER pwdattributetype 
        Attribute type of the Vendor ID in the RADIUS response.  
        Minimum value = 1 
    .PARAMETER defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.  
        Maximum length = 64 
    .PARAMETER callingstationid 
        Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER authservretry 
        Number of retry by the Citrix ADC before getting response from the RADIUS server.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 10 
    .PARAMETER authentication 
        Configure the RADIUS server state to accept or refuse authentication messages.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER tunnelendpointclientip 
        Send Tunnel Endpoint Client IP address to the RADIUS server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateAaaradiusparams -radkey <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaaradiusparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams/
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
        [string]$serverip ,

        [int]$serverport ,

        [double]$authtimeout ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$radkey ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$radnasip ,

        [string]$radnasid ,

        [double]$radvendorid ,

        [double]$radattributetype ,

        [string]$radgroupsprefix ,

        [string]$radgroupseparator ,

        [ValidateSet('pap', 'chap', 'mschapv1', 'mschapv2')]
        [string]$passencoding ,

        [double]$ipvendorid ,

        [double]$ipattributetype ,

        [ValidateSet('ON', 'OFF')]
        [string]$accounting ,

        [double]$pwdvendorid ,

        [double]$pwdattributetype ,

        [string]$defaultauthenticationgroup ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$callingstationid ,

        [ValidateRange(1, 10)]
        [double]$authservretry ,

        [ValidateSet('ON', 'OFF')]
        [string]$authentication ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tunnelendpointclientip 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaradiusparams: Starting"
    }
    process {
        try {
            $Payload = @{
                radkey = $radkey
            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('radnasip')) { $Payload.Add('radnasip', $radnasip) }
            if ($PSBoundParameters.ContainsKey('radnasid')) { $Payload.Add('radnasid', $radnasid) }
            if ($PSBoundParameters.ContainsKey('radvendorid')) { $Payload.Add('radvendorid', $radvendorid) }
            if ($PSBoundParameters.ContainsKey('radattributetype')) { $Payload.Add('radattributetype', $radattributetype) }
            if ($PSBoundParameters.ContainsKey('radgroupsprefix')) { $Payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ($PSBoundParameters.ContainsKey('radgroupseparator')) { $Payload.Add('radgroupseparator', $radgroupseparator) }
            if ($PSBoundParameters.ContainsKey('passencoding')) { $Payload.Add('passencoding', $passencoding) }
            if ($PSBoundParameters.ContainsKey('ipvendorid')) { $Payload.Add('ipvendorid', $ipvendorid) }
            if ($PSBoundParameters.ContainsKey('ipattributetype')) { $Payload.Add('ipattributetype', $ipattributetype) }
            if ($PSBoundParameters.ContainsKey('accounting')) { $Payload.Add('accounting', $accounting) }
            if ($PSBoundParameters.ContainsKey('pwdvendorid')) { $Payload.Add('pwdvendorid', $pwdvendorid) }
            if ($PSBoundParameters.ContainsKey('pwdattributetype')) { $Payload.Add('pwdattributetype', $pwdattributetype) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ($PSBoundParameters.ContainsKey('callingstationid')) { $Payload.Add('callingstationid', $callingstationid) }
            if ($PSBoundParameters.ContainsKey('authservretry')) { $Payload.Add('authservretry', $authservretry) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('tunnelendpointclientip')) { $Payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
 
            if ($PSCmdlet.ShouldProcess("aaaradiusparams", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaradiusparams -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaaradiusparams: Finished"
    }
}

function Invoke-ADCUnsetAaaradiusparams {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER serverip 
       IP address of your RADIUS server. 
   .PARAMETER serverport 
       Port number on which the RADIUS server listens for connections. 
   .PARAMETER authtimeout 
       Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server. 
   .PARAMETER radnasip 
       Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER radnasid 
       Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
   .PARAMETER radvendorid 
       Vendor ID for RADIUS group extraction. 
   .PARAMETER radattributetype 
       Attribute type for RADIUS group extraction. 
   .PARAMETER radgroupsprefix 
       Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
   .PARAMETER radgroupseparator 
       Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
   .PARAMETER passencoding 
       Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server.  
       Possible values = pap, chap, mschapv1, mschapv2 
   .PARAMETER ipvendorid 
       Vendor ID attribute in the RADIUS response.  
       If the attribute is not vendor-encoded, it is set to 0. 
   .PARAMETER ipattributetype 
       IP attribute type in the RADIUS response. 
   .PARAMETER accounting 
       Configure the RADIUS server state to accept or refuse accounting messages.  
       Possible values = ON, OFF 
   .PARAMETER pwdvendorid 
       Vendor ID of the password in the RADIUS response. Used to extract the user password. 
   .PARAMETER pwdattributetype 
       Attribute type of the Vendor ID in the RADIUS response. 
   .PARAMETER defaultauthenticationgroup 
       This is the default group that is chosen when the authentication succeeds in addition to extracted groups. 
   .PARAMETER callingstationid 
       Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER authservretry 
       Number of retry by the Citrix ADC before getting response from the RADIUS server. 
   .PARAMETER authentication 
       Configure the RADIUS server state to accept or refuse authentication messages.  
       Possible values = ON, OFF 
   .PARAMETER tunnelendpointclientip 
       Send Tunnel Endpoint Client IP address to the RADIUS server.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAaaradiusparams 
    .NOTES
        File Name : Invoke-ADCUnsetAaaradiusparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams
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

        [Boolean]$serverip ,

        [Boolean]$serverport ,

        [Boolean]$authtimeout ,

        [Boolean]$radnasip ,

        [Boolean]$radnasid ,

        [Boolean]$radvendorid ,

        [Boolean]$radattributetype ,

        [Boolean]$radgroupsprefix ,

        [Boolean]$radgroupseparator ,

        [Boolean]$passencoding ,

        [Boolean]$ipvendorid ,

        [Boolean]$ipattributetype ,

        [Boolean]$accounting ,

        [Boolean]$pwdvendorid ,

        [Boolean]$pwdattributetype ,

        [Boolean]$defaultauthenticationgroup ,

        [Boolean]$callingstationid ,

        [Boolean]$authservretry ,

        [Boolean]$authentication ,

        [Boolean]$tunnelendpointclientip 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaradiusparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('radnasip')) { $Payload.Add('radnasip', $radnasip) }
            if ($PSBoundParameters.ContainsKey('radnasid')) { $Payload.Add('radnasid', $radnasid) }
            if ($PSBoundParameters.ContainsKey('radvendorid')) { $Payload.Add('radvendorid', $radvendorid) }
            if ($PSBoundParameters.ContainsKey('radattributetype')) { $Payload.Add('radattributetype', $radattributetype) }
            if ($PSBoundParameters.ContainsKey('radgroupsprefix')) { $Payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ($PSBoundParameters.ContainsKey('radgroupseparator')) { $Payload.Add('radgroupseparator', $radgroupseparator) }
            if ($PSBoundParameters.ContainsKey('passencoding')) { $Payload.Add('passencoding', $passencoding) }
            if ($PSBoundParameters.ContainsKey('ipvendorid')) { $Payload.Add('ipvendorid', $ipvendorid) }
            if ($PSBoundParameters.ContainsKey('ipattributetype')) { $Payload.Add('ipattributetype', $ipattributetype) }
            if ($PSBoundParameters.ContainsKey('accounting')) { $Payload.Add('accounting', $accounting) }
            if ($PSBoundParameters.ContainsKey('pwdvendorid')) { $Payload.Add('pwdvendorid', $pwdvendorid) }
            if ($PSBoundParameters.ContainsKey('pwdattributetype')) { $Payload.Add('pwdattributetype', $pwdattributetype) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ($PSBoundParameters.ContainsKey('callingstationid')) { $Payload.Add('callingstationid', $callingstationid) }
            if ($PSBoundParameters.ContainsKey('authservretry')) { $Payload.Add('authservretry', $authservretry) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('tunnelendpointclientip')) { $Payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
            if ($PSCmdlet.ShouldProcess("aaaradiusparams", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaradiusparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaaradiusparams: Finished"
    }
}

function Invoke-ADCGetAaaradiusparams {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaaradiusparams object(s)
    .PARAMETER Count
        If specified, the count of the aaaradiusparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaaradiusparams
    .EXAMPLE 
        Invoke-ADCGetAaaradiusparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAaaradiusparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAaaradiusparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaaradiusparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams/
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
        Write-Verbose "Invoke-ADCGetAaaradiusparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaaradiusparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaradiusparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaradiusparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaradiusparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaradiusparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaaradiusparams: Ended"
    }
}

function Invoke-ADCKillAaasession {
<#
    .SYNOPSIS
        Kill AAA configuration Object
    .DESCRIPTION
        Kill AAA configuration Object 
    .PARAMETER username 
        Name of the AAA user. 
    .PARAMETER groupname 
        Name of the AAA group. 
    .PARAMETER iip 
        IP address or the first address in the intranet IP range. 
    .PARAMETER netmask 
        Subnet mask for the intranet IP range. 
    .PARAMETER sessionkey 
        Show aaa session associated with given session key. 
    .PARAMETER all 
        Terminate all active AAA-TM/VPN sessions.
    .EXAMPLE
        Invoke-ADCKillAaasession 
    .NOTES
        File Name : Invoke-ADCKillAaasession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaasession/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$groupname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$iip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [ValidateLength(1, 127)]
        [string]$sessionkey ,

        [boolean]$all 

    )
    begin {
        Write-Verbose "Invoke-ADCKillAaasession: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('groupname')) { $Payload.Add('groupname', $groupname) }
            if ($PSBoundParameters.ContainsKey('iip')) { $Payload.Add('iip', $iip) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('sessionkey')) { $Payload.Add('sessionkey', $sessionkey) }
            if ($PSBoundParameters.ContainsKey('all')) { $Payload.Add('all', $all) }
            if ($PSCmdlet.ShouldProcess($Name, "Kill AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaasession -Action kill -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCKillAaasession: Finished"
    }
}

function Invoke-ADCGetAaasession {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       Name of the AAA user. 
    .PARAMETER groupname 
       Name of the AAA group. 
    .PARAMETER iip 
       IP address or the first address in the intranet IP range. 
    .PARAMETER netmask 
       Subnet mask for the intranet IP range. 
    .PARAMETER sessionkey 
       Show aaa session associated with given session key. 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all aaasession object(s)
    .PARAMETER Count
        If specified, the count of the aaasession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaasession
    .EXAMPLE 
        Invoke-ADCGetAaasession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaasession -Count
    .EXAMPLE
        Invoke-ADCGetAaasession -name <string>
    .EXAMPLE
        Invoke-ADCGetAaasession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaasession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaasession/
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
        [string]$username ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$groupname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$iip ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$netmask ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateLength(1, 127)]
        [string]$sessionkey ,

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
        Write-Verbose "Invoke-ADCGetAaasession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaasession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaasession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaasession objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('username')) { $Arguments.Add('username', $username) } 
                if ($PSBoundParameters.ContainsKey('groupname')) { $Arguments.Add('groupname', $groupname) } 
                if ($PSBoundParameters.ContainsKey('iip')) { $Arguments.Add('iip', $iip) } 
                if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) } 
                if ($PSBoundParameters.ContainsKey('sessionkey')) { $Arguments.Add('sessionkey', $sessionkey) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaasession configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaasession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaasession: Ended"
    }
}

function Invoke-ADCAddAaassoprofile {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created.  
        The following requirement applies only to the NetScaler CLI:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
        Minimum length = 1 
    .PARAMETER username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').  
        Minimum length = 1 
    .PARAMETER password 
        Password with which the user logs on. Required for Single sign on to external server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        Invoke-ADCAddAaassoprofile -name <string> -username <string> -password <string>
    .NOTES
        File Name : Invoke-ADCAddAaassoprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$username ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaassoprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                username = $username
                password = $password
            }

 
            if ($PSCmdlet.ShouldProcess("aaassoprofile", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaassoprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaassoprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaassoprofile: Finished"
    }
}

function Invoke-ADCDeleteAaassoprofile {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER name 
       Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created.  
       The following requirement applies only to the NetScaler CLI:  
       If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAaassoprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaassoprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        Write-Verbose "Invoke-ADCDeleteAaassoprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaassoprofile: Finished"
    }
}

function Invoke-ADCUpdateAaassoprofile {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created.  
        The following requirement applies only to the NetScaler CLI:  
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
        Minimum length = 1 
    .PARAMETER username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group').  
        Minimum length = 1 
    .PARAMETER password 
        Password with which the user logs on. Required for Single sign on to external server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        Invoke-ADCUpdateAaassoprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaassoprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaassoprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('username')) { $Payload.Add('username', $username) }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("aaassoprofile", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaassoprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaassoprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAaassoprofile: Finished"
    }
}

function Invoke-ADCGetAaassoprofile {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER name 
       Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created.  
       The following requirement applies only to the NetScaler CLI:  
       If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER GetAll 
        Retreive all aaassoprofile object(s)
    .PARAMETER Count
        If specified, the count of the aaassoprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaassoprofile
    .EXAMPLE 
        Invoke-ADCGetAaassoprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaassoprofile -Count
    .EXAMPLE
        Invoke-ADCGetAaassoprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetAaassoprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaassoprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        Write-Verbose "Invoke-ADCGetAaassoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaassoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaassoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaassoprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaassoprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaassoprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaassoprofile: Ended"
    }
}

function Invoke-ADCUpdateAaatacacsparams {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER serverip 
        IP address of your TACACS+ server.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port number on which the TACACS+ server listens for connections.  
        Default value: 49  
        Minimum value = 1 
    .PARAMETER authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server.  
        Default value: 3  
        Minimum value = 1 
    .PARAMETER tacacssecret 
        Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server.  
        Minimum length = 1 
    .PARAMETER authorization 
        Use streaming authorization on the TACACS+ server.  
        Possible values = ON, OFF 
    .PARAMETER accounting 
        Send accounting messages to the TACACS+ server.  
        Possible values = ON, OFF 
    .PARAMETER auditfailedcmds 
        The option for sending accounting messages to the TACACS+ server.  
        Possible values = ON, OFF 
    .PARAMETER groupattrname 
        TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
    .PARAMETER defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.  
        Maximum length = 64
    .EXAMPLE
        Invoke-ADCUpdateAaatacacsparams 
    .NOTES
        File Name : Invoke-ADCUpdateAaatacacsparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams/
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
        [string]$serverip ,

        [int]$serverport ,

        [double]$authtimeout ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$tacacssecret ,

        [ValidateSet('ON', 'OFF')]
        [string]$authorization ,

        [ValidateSet('ON', 'OFF')]
        [string]$accounting ,

        [ValidateSet('ON', 'OFF')]
        [string]$auditfailedcmds ,

        [string]$groupattrname ,

        [string]$defaultauthenticationgroup 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaatacacsparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('tacacssecret')) { $Payload.Add('tacacssecret', $tacacssecret) }
            if ($PSBoundParameters.ContainsKey('authorization')) { $Payload.Add('authorization', $authorization) }
            if ($PSBoundParameters.ContainsKey('accounting')) { $Payload.Add('accounting', $accounting) }
            if ($PSBoundParameters.ContainsKey('auditfailedcmds')) { $Payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ($PSBoundParameters.ContainsKey('groupattrname')) { $Payload.Add('groupattrname', $groupattrname) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
 
            if ($PSCmdlet.ShouldProcess("aaatacacsparams", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaatacacsparams -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAaatacacsparams: Finished"
    }
}

function Invoke-ADCUnsetAaatacacsparams {
<#
    .SYNOPSIS
        Unset AAA configuration Object
    .DESCRIPTION
        Unset AAA configuration Object 
   .PARAMETER serverip 
       IP address of your TACACS+ server. 
   .PARAMETER serverport 
       Port number on which the TACACS+ server listens for connections. 
   .PARAMETER authtimeout 
       Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server. 
   .PARAMETER tacacssecret 
       Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server. 
   .PARAMETER authorization 
       Use streaming authorization on the TACACS+ server.  
       Possible values = ON, OFF 
   .PARAMETER accounting 
       Send accounting messages to the TACACS+ server.  
       Possible values = ON, OFF 
   .PARAMETER auditfailedcmds 
       The option for sending accounting messages to the TACACS+ server.  
       Possible values = ON, OFF 
   .PARAMETER groupattrname 
       TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
   .PARAMETER defaultauthenticationgroup 
       This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        Invoke-ADCUnsetAaatacacsparams 
    .NOTES
        File Name : Invoke-ADCUnsetAaatacacsparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams
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

        [Boolean]$serverip ,

        [Boolean]$serverport ,

        [Boolean]$authtimeout ,

        [Boolean]$tacacssecret ,

        [Boolean]$authorization ,

        [Boolean]$accounting ,

        [Boolean]$auditfailedcmds ,

        [Boolean]$groupattrname ,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaatacacsparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('authtimeout')) { $Payload.Add('authtimeout', $authtimeout) }
            if ($PSBoundParameters.ContainsKey('tacacssecret')) { $Payload.Add('tacacssecret', $tacacssecret) }
            if ($PSBoundParameters.ContainsKey('authorization')) { $Payload.Add('authorization', $authorization) }
            if ($PSBoundParameters.ContainsKey('accounting')) { $Payload.Add('accounting', $accounting) }
            if ($PSBoundParameters.ContainsKey('auditfailedcmds')) { $Payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ($PSBoundParameters.ContainsKey('groupattrname')) { $Payload.Add('groupattrname', $groupattrname) }
            if ($PSBoundParameters.ContainsKey('defaultauthenticationgroup')) { $Payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ($PSCmdlet.ShouldProcess("aaatacacsparams", "Unset AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaatacacsparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAaatacacsparams: Finished"
    }
}

function Invoke-ADCGetAaatacacsparams {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER GetAll 
        Retreive all aaatacacsparams object(s)
    .PARAMETER Count
        If specified, the count of the aaatacacsparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaatacacsparams
    .EXAMPLE 
        Invoke-ADCGetAaatacacsparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAaatacacsparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAaatacacsparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaatacacsparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams/
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
        Write-Verbose "Invoke-ADCGetAaatacacsparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaatacacsparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaatacacsparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaatacacsparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaatacacsparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaatacacsparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaatacacsparams: Ended"
    }
}

function Invoke-ADCAddAaauser {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server.  
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        Invoke-ADCAddAaauser -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("aaauser", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauser -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauser: Finished"
    }
}

function Invoke-ADCDeleteAaauser {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .EXAMPLE
        Invoke-ADCDeleteAaauser -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauser: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauser: Finished"
    }
}

function Invoke-ADCUpdateAaauser {
<#
    .SYNOPSIS
        Update AAA configuration Object
    .DESCRIPTION
        Update AAA configuration Object 
    .PARAMETER username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server.  
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        Invoke-ADCUpdateAaauser -username <string> -password <string>
    .NOTES
        File Name : Invoke-ADCUpdateAaauser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$username ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaauser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
                password = $password
            }

 
            if ($PSCmdlet.ShouldProcess("aaauser", "Update AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauser -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAaauser: Finished"
    }
}

function Invoke-ADCUnlockAaauser {
<#
    .SYNOPSIS
        Unlock AAA configuration Object
    .DESCRIPTION
        Unlock AAA configuration Object 
    .PARAMETER username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added.
    .EXAMPLE
        Invoke-ADCUnlockAaauser -username <string>
    .NOTES
        File Name : Invoke-ADCUnlockAaauser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$username 

    )
    begin {
        Write-Verbose "Invoke-ADCUnlockAaauser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }

            if ($PSCmdlet.ShouldProcess($Name, "Unlock AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Action unlock -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnlockAaauser: Finished"
    }
}

function Invoke-ADCGetAaauser {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER GetAll 
        Retreive all aaauser object(s)
    .PARAMETER Count
        If specified, the count of the aaauser object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauser
    .EXAMPLE 
        Invoke-ADCGetAaauser -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauser -Count
    .EXAMPLE
        Invoke-ADCGetAaauser -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauser -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$username,

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
        Write-Verbose "Invoke-ADCGetAaauser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all aaauser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauser: Ended"
    }
}

function Invoke-ADCGetAaauseraaagroupbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_aaagroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_aaagroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauseraaagroupbinding
    .EXAMPLE 
        Invoke-ADCGetAaauseraaagroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauseraaagroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauseraaagroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauseraaagroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauseraaagroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_aaagroup_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauseraaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauseraaagroupbinding: Ended"
    }
}

function Invoke-ADCAddAaauserauditnslogpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauserauditnslogpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauserauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_auditnslogpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauserauditnslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauserauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauserauditnslogpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauserauditnslogpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauserauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauserauditnslogpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauserauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauserauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauserauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauserauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauserauditsyslogpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauserauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_auditsyslogpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauserauditsyslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauserauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauserauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauserauditsyslogpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauserauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauserauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauserauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauserauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauserauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauserauthorizationpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_authorizationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauserauthorizationpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauserauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_authorizationpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_authorizationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauserauthorizationpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauserauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauserauthorizationpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauserauthorizationpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauserauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauserauthorizationpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_authorizationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_authorizationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserauthorizationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauserauthorizationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauserauthorizationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauserauthorizationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserauthorizationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserauthorizationpolicybinding: Ended"
    }
}

function Invoke-ADCGetAaauserbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       Name of the user who has the account. 
    .PARAMETER GetAll 
        Retreive all aaauser_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserbinding
    .EXAMPLE 
        Invoke-ADCGetAaauserbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAaauserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_binding/
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
        [string]$username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserbinding: Ended"
    }
}

function Invoke-ADCAddAaauserintranetip6binding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER intranetip6 
        The Intranet IP6 bound to the user. 
    .PARAMETER numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip6_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauserintranetip6binding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauserintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$username ,

        [string]$gotopriorityexpression ,

        [string]$intranetip6 ,

        [double]$numaddr ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserintranetip6binding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('intranetip6')) { $Payload.Add('intranetip6', $intranetip6) }
            if ($PSBoundParameters.ContainsKey('numaddr')) { $Payload.Add('numaddr', $numaddr) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_intranetip6_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip6_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauserintranetip6binding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauserintranetip6binding: Finished"
    }
}

function Invoke-ADCDeleteAaauserintranetip6binding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER intranetip6 
       The Intranet IP6 bound to the user.    .PARAMETER numaddr 
       Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        Invoke-ADCDeleteAaauserintranetip6binding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauserintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$username ,

        [string]$intranetip6 ,

        [double]$numaddr 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserintranetip6binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetip6')) { $Arguments.Add('intranetip6', $intranetip6) }
            if ($PSBoundParameters.ContainsKey('numaddr')) { $Arguments.Add('numaddr', $numaddr) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauserintranetip6binding: Finished"
    }
}

function Invoke-ADCGetAaauserintranetip6binding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_intranetip6_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip6_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserintranetip6binding
    .EXAMPLE 
        Invoke-ADCGetAaauserintranetip6binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauserintranetip6binding -Count
    .EXAMPLE
        Invoke-ADCGetAaauserintranetip6binding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserintranetip6binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserintranetip6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserintranetip6binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserintranetip6binding: Ended"
    }
}

function Invoke-ADCAddAaauserintranetipbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER intranetip 
        The Intranet IP bound to the user. 
    .PARAMETER netmask 
        The netmask for the Intranet IP. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauserintranetipbinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauserintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$username ,

        [string]$intranetip ,

        [string]$netmask ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserintranetipbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('intranetip')) { $Payload.Add('intranetip', $intranetip) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_intranetip_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauserintranetipbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauserintranetipbinding: Finished"
    }
}

function Invoke-ADCDeleteAaauserintranetipbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER intranetip 
       The Intranet IP bound to the user.    .PARAMETER netmask 
       The netmask for the Intranet IP.
    .EXAMPLE
        Invoke-ADCDeleteAaauserintranetipbinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauserintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$username ,

        [string]$intranetip ,

        [string]$netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserintranetipbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetip')) { $Arguments.Add('intranetip', $intranetip) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauserintranetipbinding: Finished"
    }
}

function Invoke-ADCGetAaauserintranetipbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_intranetip_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauserintranetipbinding
    .EXAMPLE 
        Invoke-ADCGetAaauserintranetipbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauserintranetipbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauserintranetipbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauserintranetipbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauserintranetipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserintranetipbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauserintranetipbinding: Ended"
    }
}

function Invoke-ADCAddAaausertmsessionpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_tmsessionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaausertmsessionpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaausertmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaausertmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_tmsessionpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_tmsessionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaausertmsessionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaausertmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaausertmsessionpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaausertmsessionpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaausertmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaausertmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaausertmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaausertmsessionpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_tmsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_tmsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaausertmsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaausertmsessionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaausertmsessionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaausertmsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaausertmsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaausertmsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaausertmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaausertmsessionpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauservpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER intranetapplication 
        Name of the intranet VPN application to which the policy applies. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnintranetapplication_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauservpnintranetapplicationbinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauservpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$username ,

        [string]$intranetapplication ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('intranetapplication')) { $Payload.Add('intranetapplication', $intranetapplication) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_vpnintranetapplication_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnintranetapplication_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauservpnintranetapplicationbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauservpnintranetapplicationbinding: Finished"
    }
}

function Invoke-ADCDeleteAaauservpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER intranetapplication 
       Name of the intranet VPN application to which the policy applies.
    .EXAMPLE
        Invoke-ADCDeleteAaauservpnintranetapplicationbinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$username ,

        [string]$intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('intranetapplication')) { $Arguments.Add('intranetapplication', $intranetapplication) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauservpnintranetapplicationbinding: Finished"
    }
}

function Invoke-ADCGetAaauservpnintranetapplicationbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_vpnintranetapplication_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_vpnintranetapplication_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauservpnintranetapplicationbinding
    .EXAMPLE 
        Invoke-ADCGetAaauservpnintranetapplicationbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauservpnintranetapplicationbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauservpnintranetapplicationbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauservpnintranetapplicationbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauservpnintranetapplicationbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauservpnintranetapplicationbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauservpnintranetapplicationbinding: Ended"
    }
}

function Invoke-ADCAddAaauservpnsessionpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnsessionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauservpnsessionpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauservpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_vpnsessionpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnsessionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauservpnsessionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauservpnsessionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauservpnsessionpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauservpnsessionpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauservpnsessionpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauservpnsessionpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_vpnsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_vpnsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauservpnsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauservpnsessionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauservpnsessionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauservpnsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauservpnsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauservpnsessionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauservpnsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauservpnsessionpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauservpntrafficpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpntrafficpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauservpntrafficpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauservpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_vpntrafficpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpntrafficpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauservpntrafficpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauservpntrafficpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauservpntrafficpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauservpntrafficpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauservpntrafficpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauservpntrafficpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_vpntrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_vpntrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauservpntrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauservpntrafficpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauservpntrafficpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauservpntrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauservpntrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauservpntrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauservpntrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauservpntrafficpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauservpnurlpolicybinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policy 
        The policy Name. 
    .PARAMETER priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. .  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER type 
        Bindpoint to which the policy is bound.  
        Default value: REQUEST  
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurlpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauservpnurlpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauservpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [ValidateRange(0, 2147483647)]
        [double]$priority ,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$type = 'REQUEST' ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnurlpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Payload.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_vpnurlpolicy_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurlpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauservpnurlpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauservpnurlpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAaauservpnurlpolicybinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER policy 
       The policy Name.    .PARAMETER type 
       Bindpoint to which the policy is bound.  
       Default value: REQUEST  
       Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteAaauservpnurlpolicybinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$username ,

        [string]$policy ,

        [string]$type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policy')) { $Arguments.Add('policy', $policy) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlpolicybinding: Finished"
    }
}

function Invoke-ADCGetAaauservpnurlpolicybinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_vpnurlpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurlpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAaauservpnurlpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauservpnurlpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauservpnurlpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauservpnurlpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauservpnurlpolicybinding: Ended"
    }
}

function Invoke-ADCAddAaauservpnurlbinding {
<#
    .SYNOPSIS
        Add AAA configuration Object
    .DESCRIPTION
        Add AAA configuration Object 
    .PARAMETER username 
        User account to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER urlname 
        The intranet url. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAaauservpnurlbinding -username <string>
    .NOTES
        File Name : Invoke-ADCAddAaauservpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$username ,

        [string]$urlname ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('urlname')) { $Payload.Add('urlname', $urlname) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("aaauser_vpnurl_binding", "Add AAA configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAaauservpnurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAaauservpnurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAaauservpnurlbinding {
<#
    .SYNOPSIS
        Delete AAA configuration Object
    .DESCRIPTION
        Delete AAA configuration Object
    .PARAMETER username 
       User account to which to bind the policy.  
       Minimum length = 1    .PARAMETER urlname 
       The intranet url.
    .EXAMPLE
        Invoke-ADCDeleteAaauservpnurlbinding -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$username ,

        [string]$urlname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('urlname')) { $Arguments.Add('urlname', $urlname) }
            if ($PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlbinding: Finished"
    }
}

function Invoke-ADCGetAaauservpnurlbinding {
<#
    .SYNOPSIS
        Get AAA configuration object(s)
    .DESCRIPTION
        Get AAA configuration object(s)
    .PARAMETER username 
       User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all aaauser_vpnurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlbinding
    .EXAMPLE 
        Invoke-ADCGetAaauservpnurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAaauservpnurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAaauservpnurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAaauservpnurlbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$username,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauservpnurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all aaauser_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAaauservpnurlbinding: Ended"
    }
}


