function Invoke-ADCUpdateAaacertparams {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER Usernamefield 
        Client certificate field that contains the username, in the format <field>:<subfield>. . 
    .PARAMETER Groupnamefield 
        Client certificate field that specifies the group, in the format <field>:<subfield>. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaacertparams 
        An example how to update aaacertparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaacertparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams/
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

        [string]$Usernamefield,

        [string]$Groupnamefield,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaacertparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('usernamefield') ) { $payload.Add('usernamefield', $usernamefield) }
            if ( $PSBoundParameters.ContainsKey('groupnamefield') ) { $payload.Add('groupnamefield', $groupnamefield) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaacertparams", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaacertparams -Payload $payload -GetWarning
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
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER Usernamefield 
        Client certificate field that contains the username, in the format <field>:<subfield>. . 
    .PARAMETER Groupnamefield 
        Client certificate field that specifies the group, in the format <field>:<subfield>. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaacertparams 
        An example how to unset aaacertparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaacertparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams
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

        [Boolean]$usernamefield,

        [Boolean]$groupnamefield,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaacertparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('usernamefield') ) { $payload.Add('usernamefield', $usernamefield) }
            if ( $PSBoundParameters.ContainsKey('groupnamefield') ) { $payload.Add('groupnamefield', $groupnamefield) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaacertparams", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaacertparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for certificate parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaacertparams object(s).
    .PARAMETER Count
        If specified, the count of the aaacertparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaacertparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaacertparams -GetAll 
        Get all aaacertparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaacertparams -name <string>
        Get aaacertparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaacertparams -Filter @{ 'name'='<value>' }
        Get aaacertparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaacertparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaacertparams/
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
        Write-Verbose "Invoke-ADCGetAaacertparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaacertparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaacertparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaacertparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaacertparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaacertparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaacertparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER Policy 
        Name of the policy to be unbound. 
    .PARAMETER Priority 
        Priority of the bound policy. 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_aaapreauthenticationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding 
        An example how to add aaaglobal_aaapreauthenticationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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
        [string]$Policy,

        [double]$Priority,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaaglobalaaapreauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_aaapreauthenticationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER Policy 
        Name of the policy to be unbound.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding 
        An example how to delete aaaglobal_aaapreauthenticationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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

        [string]$Policy 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaaglobalaaapreauthenticationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_aaapreauthenticationpolicy_binding", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the aaapreauthenticationpolicy that can be bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_aaapreauthenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_aaapreauthenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -GetAll 
        Get all aaaglobal_aaapreauthenticationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Count 
        Get the number of aaaglobal_aaapreauthenticationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -name <string>
        Get aaaglobal_aaapreauthenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_aaapreauthenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_aaapreauthenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalaaapreauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER Windowsprofile 
        Name of the negotiate profile to be bound. 
    .PARAMETER PassThru 
        Return details about the created aaaglobal_authenticationnegotiateaction_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding 
        An example how to add aaaglobal_authenticationnegotiateaction_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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
        [string]$Windowsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaaglobalauthenticationnegotiateactionbinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('windowsprofile') ) { $payload.Add('windowsprofile', $windowsprofile) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaglobal_authenticationnegotiateaction_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER Windowsprofile 
        Name of the negotiate profile to be bound.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding 
        An example how to delete aaaglobal_authenticationnegotiateaction_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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

        [string]$Windowsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaaglobalauthenticationnegotiateactionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Windowsprofile') ) { $arguments.Add('windowsprofile', $Windowsprofile) }
            if ( $PSCmdlet.ShouldProcess("aaaglobal_authenticationnegotiateaction_binding", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationnegotiateaction that can be bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_authenticationnegotiateaction_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_authenticationnegotiateaction_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -GetAll 
        Get all aaaglobal_authenticationnegotiateaction_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Count 
        Get the number of aaaglobal_authenticationnegotiateaction_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -name <string>
        Get aaaglobal_authenticationnegotiateaction_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_authenticationnegotiateaction_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_authenticationnegotiateaction_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalauthenticationnegotiateactionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_authenticationnegotiateaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_authenticationnegotiateaction_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_authenticationnegotiateaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaaglobal.
    .PARAMETER GetAll 
        Retrieve all aaaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaglobalbinding -GetAll 
        Get all aaaglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalbinding -name <string>
        Get aaaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaglobalbinding -Filter @{ 'name'='<value>' }
        Get aaaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAaaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER Weight 
        Weight of this group with respect to other configured aaa groups (lower the number higher the weight). 
    .PARAMETER PassThru 
        Return details about the created aaagroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroup -groupname <string>
        An example how to add aaagroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$Groupname,

        [ValidateRange(0, 65535)]
        [double]$Weight = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('weight') ) { $payload.Add('weight', $weight) }
            if ( $PSCmdlet.ShouldProcess("aaagroup", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaagroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroup -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroup -Groupname <string>
        An example how to delete aaagroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$Groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for AAA group resource.
    .PARAMETER Groupname 
        Name for the group. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the group is added. 
    .PARAMETER GetAll 
        Retrieve all aaagroup object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroup -GetAll 
        Get all aaagroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroup -Count 
        Get the number of aaagroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroup -name <string>
        Get aaagroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroup -Filter @{ 'name'='<value>' }
        Get aaagroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroup
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup/
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
        [string]$Groupname,

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
        Write-Verbose "Invoke-ADCGetAaagroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaagroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Username 
        The user name. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_aaauser_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupaaauserbinding -groupname <string>
        An example how to add aaagroup_aaauser_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupaaauserbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$Groupname,

        [string]$Username,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupaaauserbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_aaauser_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_aaauser_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupaaauserbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Username 
        The user name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupaaauserbinding -Groupname <string>
        An example how to delete aaagroup_aaauser_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupaaauserbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$Groupname,

        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupaaauserbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Username') ) { $arguments.Add('username', $Username) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupaaauserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupaaauserbinding -GetAll 
        Get all aaagroup_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupaaauserbinding -Count 
        Get the number of aaagroup_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupaaauserbinding -name <string>
        Get aaagroup_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupaaauserbinding -Filter @{ 'name'='<value>' }
        Get aaagroup_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupaaauserbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_aaauser_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupauditnslogpolicybinding -groupname <string>
        An example how to add aaagroup_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_auditnslogpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupauditnslogpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupauditnslogpolicybinding -Groupname <string>
        An example how to delete aaagroup_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauditnslogpolicybinding -GetAll 
        Get all aaagroup_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauditnslogpolicybinding -Count 
        Get the number of aaagroup_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditnslogpolicybinding -name <string>
        Get aaagroup_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditnslogpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupauditsyslogpolicybinding -groupname <string>
        An example how to add aaagroup_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_auditsyslogpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupauditsyslogpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupauditsyslogpolicybinding -Groupname <string>
        An example how to delete aaagroup_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauditsyslogpolicybinding -GetAll 
        Get all aaagroup_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauditsyslogpolicybinding -Count 
        Get the number of aaagroup_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditsyslogpolicybinding -name <string>
        Get aaagroup_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_auditsyslogpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupauthorizationpolicybinding -groupname <string>
        An example how to add aaagroup_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_authorizationpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupauthorizationpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupauthorizationpolicybinding -Groupname <string>
        An example how to delete aaagroup_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauthorizationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauthorizationpolicybinding -GetAll 
        Get all aaagroup_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupauthorizationpolicybinding -Count 
        Get the number of aaagroup_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauthorizationpolicybinding -name <string>
        Get aaagroup_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupauthorizationpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_authorizationpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupbinding -GetAll 
        Get all aaagroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupbinding -name <string>
        Get aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupbinding -Filter @{ 'name'='<value>' }
        Get aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_binding/
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
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Intranetip6 
        The Intranet IP6(s) bound to the group. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip6_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupintranetip6binding -groupname <string>
        An example how to add aaagroup_intranetip6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$Groupname,

        [string]$Gotopriorityexpression,

        [string]$Intranetip6,

        [double]$Numaddr,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupintranetip6binding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('intranetip6') ) { $payload.Add('intranetip6', $intranetip6) }
            if ( $PSBoundParameters.ContainsKey('numaddr') ) { $payload.Add('numaddr', $numaddr) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_intranetip6_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupintranetip6binding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip6 
        The Intranet IP6(s) bound to the group. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupintranetip6binding -Groupname <string>
        An example how to delete aaagroup_intranetip6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$Groupname,

        [string]$Intranetip6,

        [double]$Numaddr 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetip6binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip6') ) { $arguments.Add('intranetip6', $Intranetip6) }
            if ( $PSBoundParameters.ContainsKey('Numaddr') ) { $arguments.Add('numaddr', $Numaddr) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_intranetip6_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetip6binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupintranetip6binding -GetAll 
        Get all aaagroup_intranetip6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupintranetip6binding -Count 
        Get the number of aaagroup_intranetip6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetip6binding -name <string>
        Get aaagroup_intranetip6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetip6binding -Filter @{ 'name'='<value>' }
        Get aaagroup_intranetip6_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip6_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip 
        The Intranet IP(s) bound to the group. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_intranetip_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupintranetipbinding -groupname <string>
        An example how to add aaagroup_intranetip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$Groupname,

        [string]$Intranetip,

        [string]$Netmask,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupintranetipbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('intranetip') ) { $payload.Add('intranetip', $intranetip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_intranetip_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_intranetip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupintranetipbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetip 
        The Intranet IP(s) bound to the group. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupintranetipbinding -Groupname <string>
        An example how to delete aaagroup_intranetip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$Groupname,

        [string]$Intranetip,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupintranetipbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip') ) { $arguments.Add('intranetip', $Intranetip) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_intranetip_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_intranetip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetipbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupintranetipbinding -GetAll 
        Get all aaagroup_intranetip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupintranetipbinding -Count 
        Get the number of aaagroup_intranetip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetipbinding -name <string>
        Get aaagroup_intranetip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupintranetipbinding -Filter @{ 'name'='<value>' }
        Get aaagroup_intranetip_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_intranetip_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_intranetip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagrouptmsessionpolicybinding -groupname <string>
        An example how to add aaagroup_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagrouptmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagrouptmsessionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_tmsessionpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagrouptmsessionpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagrouptmsessionpolicybinding -Groupname <string>
        An example how to delete aaagroup_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagrouptmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagrouptmsessionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagrouptmsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagrouptmsessionpolicybinding -GetAll 
        Get all aaagroup_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagrouptmsessionpolicybinding -Count 
        Get the number of aaagroup_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagrouptmsessionpolicybinding -name <string>
        Get aaagroup_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagrouptmsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagrouptmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_tmsessionpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetapplication 
        Bind the group to the specified intranet VPN application. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnintranetapplication_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupvpnintranetapplicationbinding -groupname <string>
        An example how to add aaagroup_vpnintranetapplication_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$Groupname,

        [string]$Intranetapplication,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('intranetapplication') ) { $payload.Add('intranetapplication', $intranetapplication) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnintranetapplication_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnintranetapplication_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Intranetapplication 
        Bind the group to the specified intranet VPN application.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding -Groupname <string>
        An example how to delete aaagroup_vpnintranetapplication_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$Groupname,

        [string]$Intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetapplication') ) { $arguments.Add('intranetapplication', $Intranetapplication) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnintranetapplication_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnintranetapplication_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnintranetapplicationbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnintranetapplicationbinding -GetAll 
        Get all aaagroup_vpnintranetapplication_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Count 
        Get the number of aaagroup_vpnintranetapplication_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnintranetapplicationbinding -name <string>
        Get aaagroup_vpnintranetapplication_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnintranetapplicationbinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnintranetapplication_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnintranetapplication_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnintranetapplication_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupvpnsessionpolicybinding -groupname <string>
        An example how to add aaagroup_vpnsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnsessionpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupvpnsessionpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupvpnsessionpolicybinding -Groupname <string>
        An example how to delete aaagroup_vpnsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnsessionpolicybinding -GetAll 
        Get all aaagroup_vpnsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnsessionpolicybinding -Count 
        Get the number of aaagroup_vpnsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnsessionpolicybinding -name <string>
        Get aaagroup_vpnsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnsessionpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpntrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupvpntrafficpolicybinding -groupname <string>
        An example how to add aaagroup_vpntrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpntrafficpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpntrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupvpntrafficpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupvpntrafficpolicybinding -Groupname <string>
        An example how to delete aaagroup_vpntrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpntrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpntrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpntrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpntrafficpolicybinding -GetAll 
        Get all aaagroup_vpntrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpntrafficpolicybinding -Count 
        Get the number of aaagroup_vpntrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpntrafficpolicybinding -name <string>
        Get aaagroup_vpntrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpntrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpntrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpntrafficpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies is 64000. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurlpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupvpnurlpolicybinding -groupname <string>
        An example how to add aaagroup_vpnurlpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnurlpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurlpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupvpnurlpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Policy 
        The policy name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupvpnurlpolicybinding -Groupname <string>
        An example how to delete aaagroup_vpnurlpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$Groupname,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnurlpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurlpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnurlpolicybinding -GetAll 
        Get all aaagroup_vpnurlpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnurlpolicybinding -Count 
        Get the number of aaagroup_vpnurlpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlpolicybinding -name <string>
        Get aaagroup_vpnurlpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlpolicybinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnurlpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurlpolicy_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurlpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Urlname 
        The intranet url. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaagroup_vpnurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaagroupvpnurlbinding -groupname <string>
        An example how to add aaagroup_vpnurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaagroupvpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$Groupname,

        [string]$Urlname,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaagroupvpnurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('urlname') ) { $payload.Add('urlname', $urlname) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaagroup_vpnurl_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaagroup_vpnurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaagroupvpnurlbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER Urlname 
        The intranet url.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaagroupvpnurlbinding -Groupname <string>
        An example how to delete aaagroup_vpnurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaagroupvpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$Groupname,

        [string]$Urlname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaagroupvpnurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Urlname') ) { $arguments.Add('urlname', $Urlname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaagroup.
    .PARAMETER Groupname 
        Name of the group that you are binding. 
    .PARAMETER GetAll 
        Retrieve all aaagroup_vpnurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaagroup_vpnurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnurlbinding -GetAll 
        Get all aaagroup_vpnurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaagroupvpnurlbinding -Count 
        Get the number of aaagroup_vpnurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlbinding -name <string>
        Get aaagroup_vpnurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaagroupvpnurlbinding -Filter @{ 'name'='<value>' }
        Get aaagroup_vpnurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaagroupvpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaagroup_vpnurl_binding/
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
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaagroup_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaagroup_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaagroup_vpnurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaagroup_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCCheckAaakcdaccount {
    <#
    .SYNOPSIS
        Check AAA configuration Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER Userrealm 
        Realm of the user.
    .EXAMPLE
        PS C:\>Invoke-ADCCheckAaakcdaccount -realmstr <string> -delegateduser <string> -kcdpassword <string> -servicespn <string>
        An example how to check aaakcdaccount configuration Object(s).
    .NOTES
        File Name : Invoke-ADCCheckAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$Realmstr,

        [Parameter(Mandatory)]
        [string]$Delegateduser,

        [Parameter(Mandatory)]
        [string]$Kcdpassword,

        [Parameter(Mandatory)]
        [string]$Servicespn,

        [string]$Userrealm 

    )
    begin {
        Write-Verbose "Invoke-ADCCheckAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ realmstr = $realmstr
                delegateduser      = $delegateduser
                kcdpassword        = $kcdpassword
                servicespn         = $servicespn
            }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSCmdlet.ShouldProcess($Name, "Check AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Action check -Payload $payload -GetWarning
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

function Invoke-ADCUnsetAaakcdaccount {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaakcdaccount -kcdaccount <string>
        An example how to unset aaakcdaccount configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount
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
        [string]$Kcdaccount,

        [Boolean]$keytab,

        [Boolean]$usercert,

        [Boolean]$cacert,

        [Boolean]$userrealm,

        [Boolean]$enterpriserealm,

        [Boolean]$servicespn 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("$kcdaccount", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaakcdaccount -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAaakcdaccount {
    <#
    .SYNOPSIS
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaakcdaccount -Kcdaccount <string>
        An example how to delete aaakcdaccount configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$Kcdaccount 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaakcdaccount: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$kcdaccount", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Arguments $arguments
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
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaakcdaccount -kcdaccount <string>
        An example how to update aaakcdaccount configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$Kcdaccount,

        [string]$Keytab,

        [string]$Realmstr,

        [string]$Delegateduser,

        [string]$Kcdpassword,

        [string]$Usercert,

        [string]$Cacert,

        [string]$Userrealm,

        [string]$Enterpriserealm,

        [string]$Servicespn,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('realmstr') ) { $payload.Add('realmstr', $realmstr) }
            if ( $PSBoundParameters.ContainsKey('delegateduser') ) { $payload.Add('delegateduser', $delegateduser) }
            if ( $PSBoundParameters.ContainsKey('kcdpassword') ) { $payload.Add('kcdpassword', $kcdpassword) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("aaakcdaccount", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaakcdaccount -Filter $payload)
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

function Invoke-ADCAddAaakcdaccount {
    <#
    .SYNOPSIS
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER Keytab 
        The path to the keytab file. If specified other parameters in this command need not be given. 
    .PARAMETER Realmstr 
        Kerberos Realm. 
    .PARAMETER Delegateduser 
        Username that can perform kerberos constrained delegation. 
    .PARAMETER Kcdpassword 
        Password for Delegated User. 
    .PARAMETER Usercert 
        SSL Cert (including private key) for Delegated User. 
    .PARAMETER Cacert 
        CA Cert for UserCert or when doing PKINIT backchannel. 
    .PARAMETER Userrealm 
        Realm of the user. 
    .PARAMETER Enterpriserealm 
        Enterprise Realm of the user. This should be given only in certain KDC deployments where KDC expects Enterprise username instead of Principal Name. 
    .PARAMETER Servicespn 
        Service SPN. When specified, this will be used to fetch kerberos tickets. If not specified, Citrix ADC will construct SPN using service fqdn. 
    .PARAMETER PassThru 
        Return details about the created aaakcdaccount item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaakcdaccount -kcdaccount <string>
        An example how to add aaakcdaccount configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$Kcdaccount,

        [string]$Keytab,

        [string]$Realmstr,

        [string]$Delegateduser,

        [string]$Kcdpassword,

        [string]$Usercert,

        [string]$Cacert,

        [string]$Userrealm,

        [string]$Enterpriserealm,

        [string]$Servicespn,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaakcdaccount: Starting"
    }
    process {
        try {
            $payload = @{ kcdaccount = $kcdaccount }
            if ( $PSBoundParameters.ContainsKey('keytab') ) { $payload.Add('keytab', $keytab) }
            if ( $PSBoundParameters.ContainsKey('realmstr') ) { $payload.Add('realmstr', $realmstr) }
            if ( $PSBoundParameters.ContainsKey('delegateduser') ) { $payload.Add('delegateduser', $delegateduser) }
            if ( $PSBoundParameters.ContainsKey('kcdpassword') ) { $payload.Add('kcdpassword', $kcdpassword) }
            if ( $PSBoundParameters.ContainsKey('usercert') ) { $payload.Add('usercert', $usercert) }
            if ( $PSBoundParameters.ContainsKey('cacert') ) { $payload.Add('cacert', $cacert) }
            if ( $PSBoundParameters.ContainsKey('userrealm') ) { $payload.Add('userrealm', $userrealm) }
            if ( $PSBoundParameters.ContainsKey('enterpriserealm') ) { $payload.Add('enterpriserealm', $enterpriserealm) }
            if ( $PSBoundParameters.ContainsKey('servicespn') ) { $payload.Add('servicespn', $servicespn) }
            if ( $PSCmdlet.ShouldProcess("aaakcdaccount", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaakcdaccount -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaakcdaccount -Filter $payload)
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

function Invoke-ADCGetAaakcdaccount {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for Kerberos constrained delegation account resource.
    .PARAMETER Kcdaccount 
        The name of the KCD account. 
    .PARAMETER GetAll 
        Retrieve all aaakcdaccount object(s).
    .PARAMETER Count
        If specified, the count of the aaakcdaccount object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaakcdaccount
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaakcdaccount -GetAll 
        Get all aaakcdaccount data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaakcdaccount -Count 
        Get the number of aaakcdaccount objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaakcdaccount -name <string>
        Get aaakcdaccount object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaakcdaccount -Filter @{ 'name'='<value>' }
        Get aaakcdaccount data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaakcdaccount
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaakcdaccount/
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
        [string]$Kcdaccount,

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
        Write-Verbose "Invoke-ADCGetAaakcdaccount: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaakcdaccount objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaakcdaccount objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaakcdaccount objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaakcdaccount configuration for property 'kcdaccount'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Resource $kcdaccount -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaakcdaccount configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaakcdaccount -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaaldapparams {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER Serverip 
        IP address of your LDAP server. 
    .PARAMETER Serverport 
        Port number on which the LDAP server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server. 
    .PARAMETER Ldapbase 
        Base (the server and location) from which LDAP search commands should start. 
        If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
    .PARAMETER Ldapbinddn 
        Complete distinguished name (DN) string used for binding to the LDAP server. 
    .PARAMETER Ldapbinddnpassword 
        Password for binding to the LDAP server. 
    .PARAMETER Ldaploginname 
        Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
    .PARAMETER Searchfilter 
        String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search. 
        For example, the following values: 
        vpnallowed=true, 
        ldaploginame=""samaccount"" 
        when combined with the user-supplied username ""bob"", yield the following LDAP search string: 
        ""(;(vpnallowed=true)(samaccount=bob)"". 
    .PARAMETER Groupattrname 
        Attribute name used for group extraction from the LDAP server. 
    .PARAMETER Subattributename 
        Subattribute name used for group extraction from the LDAP server. 
    .PARAMETER Sectype 
        Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required. 
        Possible values = PLAINTEXT, TLS, SSL 
    .PARAMETER Svrtype 
        The type of LDAP server. 
        Possible values = AD, NDS 
    .PARAMETER Ssonameattribute 
        Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username. 
        This alternative username is then used for single sign-on (SSO). 
    .PARAMETER Passwdchange 
        Accept password change requests. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nestedgroupextraction 
        Queries the external LDAP server to determine whether the specified group belongs to another group. 
        Possible values = ON, OFF 
    .PARAMETER Maxnestinglevel 
        Number of levels up to which the system can query nested LDAP groups. 
    .PARAMETER Groupnameidentifier 
        LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
    .PARAMETER Groupsearchattribute 
        LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchsubattribute 
        LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchfilter 
        Search-expression that can be specified for sending group-search requests to the LDAP server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaaldapparams 
        An example how to unset aaaldapparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaaldapparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams
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

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$ldapbase,

        [Boolean]$ldapbinddn,

        [Boolean]$ldapbinddnpassword,

        [Boolean]$ldaploginname,

        [Boolean]$searchfilter,

        [Boolean]$groupattrname,

        [Boolean]$subattributename,

        [Boolean]$sectype,

        [Boolean]$svrtype,

        [Boolean]$ssonameattribute,

        [Boolean]$passwdchange,

        [Boolean]$nestedgroupextraction,

        [Boolean]$maxnestinglevel,

        [Boolean]$groupnameidentifier,

        [Boolean]$groupsearchattribute,

        [Boolean]$groupsearchsubattribute,

        [Boolean]$groupsearchfilter,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaldapparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('ldapbase') ) { $payload.Add('ldapbase', $ldapbase) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddn') ) { $payload.Add('ldapbinddn', $ldapbinddn) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddnpassword') ) { $payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ( $PSBoundParameters.ContainsKey('ldaploginname') ) { $payload.Add('ldaploginname', $ldaploginname) }
            if ( $PSBoundParameters.ContainsKey('searchfilter') ) { $payload.Add('searchfilter', $searchfilter) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('subattributename') ) { $payload.Add('subattributename', $subattributename) }
            if ( $PSBoundParameters.ContainsKey('sectype') ) { $payload.Add('sectype', $sectype) }
            if ( $PSBoundParameters.ContainsKey('svrtype') ) { $payload.Add('svrtype', $svrtype) }
            if ( $PSBoundParameters.ContainsKey('ssonameattribute') ) { $payload.Add('ssonameattribute', $ssonameattribute) }
            if ( $PSBoundParameters.ContainsKey('passwdchange') ) { $payload.Add('passwdchange', $passwdchange) }
            if ( $PSBoundParameters.ContainsKey('nestedgroupextraction') ) { $payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ( $PSBoundParameters.ContainsKey('maxnestinglevel') ) { $payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ( $PSBoundParameters.ContainsKey('groupnameidentifier') ) { $payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ( $PSBoundParameters.ContainsKey('groupsearchattribute') ) { $payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchsubattribute') ) { $payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchfilter') ) { $payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaaldapparams", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaldapparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAaaldapparams {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER Serverip 
        IP address of your LDAP server. 
    .PARAMETER Serverport 
        Port number on which the LDAP server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the LDAP server. 
    .PARAMETER Ldapbase 
        Base (the server and location) from which LDAP search commands should start. 
        If the LDAP server is running locally, the default value of base is dc=netscaler, dc=com. 
    .PARAMETER Ldapbinddn 
        Complete distinguished name (DN) string used for binding to the LDAP server. 
    .PARAMETER Ldapbinddnpassword 
        Password for binding to the LDAP server. 
    .PARAMETER Ldaploginname 
        Name attribute that the Citrix ADC uses to query the external LDAP server or an Active Directory. 
    .PARAMETER Searchfilter 
        String to be combined with the default LDAP user search string to form the value to use when executing an LDAP search. 
        For example, the following values: 
        vpnallowed=true, 
        ldaploginame=""samaccount"" 
        when combined with the user-supplied username ""bob"", yield the following LDAP search string: 
        ""(;(vpnallowed=true)(samaccount=bob)"". 
    .PARAMETER Groupattrname 
        Attribute name used for group extraction from the LDAP server. 
    .PARAMETER Subattributename 
        Subattribute name used for group extraction from the LDAP server. 
    .PARAMETER Sectype 
        Type of security used for communications between the Citrix ADC and the LDAP server. For the PLAINTEXT setting, no encryption is required. 
        Possible values = PLAINTEXT, TLS, SSL 
    .PARAMETER Svrtype 
        The type of LDAP server. 
        Possible values = AD, NDS 
    .PARAMETER Ssonameattribute 
        Attribute used by the Citrix ADC to query an external LDAP server or Active Directory for an alternative username. 
        This alternative username is then used for single sign-on (SSO). 
    .PARAMETER Passwdchange 
        Accept password change requests. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Nestedgroupextraction 
        Queries the external LDAP server to determine whether the specified group belongs to another group. 
        Possible values = ON, OFF 
    .PARAMETER Maxnestinglevel 
        Number of levels up to which the system can query nested LDAP groups. 
    .PARAMETER Groupnameidentifier 
        LDAP-group attribute that uniquely identifies the group. No two groups on one LDAP server can have the same group name identifier. 
    .PARAMETER Groupsearchattribute 
        LDAP-group attribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchsubattribute 
        LDAP-group subattribute that designates the parent group of the specified group. Use this attribute to search for a group's parent group. 
    .PARAMETER Groupsearchfilter 
        Search-expression that can be specified for sending group-search requests to the LDAP server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaaldapparams 
        An example how to update aaaldapparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaaldapparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams/
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

        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [string]$Ldapbase,

        [string]$Ldapbinddn,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ldapbinddnpassword,

        [string]$Ldaploginname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Searchfilter,

        [string]$Groupattrname,

        [string]$Subattributename,

        [ValidateSet('PLAINTEXT', 'TLS', 'SSL')]
        [string]$Sectype,

        [ValidateSet('AD', 'NDS')]
        [string]$Svrtype,

        [string]$Ssonameattribute,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Passwdchange,

        [ValidateSet('ON', 'OFF')]
        [string]$Nestedgroupextraction,

        [double]$Maxnestinglevel,

        [string]$Groupnameidentifier,

        [string]$Groupsearchattribute,

        [string]$Groupsearchsubattribute,

        [string]$Groupsearchfilter,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaldapparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('ldapbase') ) { $payload.Add('ldapbase', $ldapbase) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddn') ) { $payload.Add('ldapbinddn', $ldapbinddn) }
            if ( $PSBoundParameters.ContainsKey('ldapbinddnpassword') ) { $payload.Add('ldapbinddnpassword', $ldapbinddnpassword) }
            if ( $PSBoundParameters.ContainsKey('ldaploginname') ) { $payload.Add('ldaploginname', $ldaploginname) }
            if ( $PSBoundParameters.ContainsKey('searchfilter') ) { $payload.Add('searchfilter', $searchfilter) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('subattributename') ) { $payload.Add('subattributename', $subattributename) }
            if ( $PSBoundParameters.ContainsKey('sectype') ) { $payload.Add('sectype', $sectype) }
            if ( $PSBoundParameters.ContainsKey('svrtype') ) { $payload.Add('svrtype', $svrtype) }
            if ( $PSBoundParameters.ContainsKey('ssonameattribute') ) { $payload.Add('ssonameattribute', $ssonameattribute) }
            if ( $PSBoundParameters.ContainsKey('passwdchange') ) { $payload.Add('passwdchange', $passwdchange) }
            if ( $PSBoundParameters.ContainsKey('nestedgroupextraction') ) { $payload.Add('nestedgroupextraction', $nestedgroupextraction) }
            if ( $PSBoundParameters.ContainsKey('maxnestinglevel') ) { $payload.Add('maxnestinglevel', $maxnestinglevel) }
            if ( $PSBoundParameters.ContainsKey('groupnameidentifier') ) { $payload.Add('groupnameidentifier', $groupnameidentifier) }
            if ( $PSBoundParameters.ContainsKey('groupsearchattribute') ) { $payload.Add('groupsearchattribute', $groupsearchattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchsubattribute') ) { $payload.Add('groupsearchsubattribute', $groupsearchsubattribute) }
            if ( $PSBoundParameters.ContainsKey('groupsearchfilter') ) { $payload.Add('groupsearchfilter', $groupsearchfilter) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaaldapparams", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaldapparams -Payload $payload -GetWarning
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

function Invoke-ADCGetAaaldapparams {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for LDAP parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaldapparams object(s).
    .PARAMETER Count
        If specified, the count of the aaaldapparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaldapparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaldapparams -GetAll 
        Get all aaaldapparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaldapparams -name <string>
        Get aaaldapparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaldapparams -Filter @{ 'name'='<value>' }
        Get aaaldapparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaldapparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaldapparams/
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
        Write-Verbose "Invoke-ADCGetAaaldapparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaldapparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaldapparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaldapparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaldapparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaldapparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaldapparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER Encryption 
        To encrypt otp secret in AD or not. Default value is OFF. 
        Possible values = ON, OFF 
    .PARAMETER Maxotpdevices 
        Maximum number of otp devices user can register. Default value is 4. Max value is 255.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaaotpparameter 
        An example how to update aaaotpparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaaotpparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter/
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

        [ValidateSet('ON', 'OFF')]
        [string]$Encryption,

        [ValidateRange(0, 255)]
        [double]$Maxotpdevices 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaotpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('encryption') ) { $payload.Add('encryption', $encryption) }
            if ( $PSBoundParameters.ContainsKey('maxotpdevices') ) { $payload.Add('maxotpdevices', $maxotpdevices) }
            if ( $PSCmdlet.ShouldProcess("aaaotpparameter", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaotpparameter -Payload $payload -GetWarning
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
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER Encryption 
        To encrypt otp secret in AD or not. Default value is OFF. 
        Possible values = ON, OFF 
    .PARAMETER Maxotpdevices 
        Maximum number of otp devices user can register. Default value is 4. Max value is 255.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaaotpparameter 
        An example how to unset aaaotpparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaaotpparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter
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

        [Boolean]$encryption,

        [Boolean]$maxotpdevices 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaotpparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('encryption') ) { $payload.Add('encryption', $encryption) }
            if ( $PSBoundParameters.ContainsKey('maxotpdevices') ) { $payload.Add('maxotpdevices', $maxotpdevices) }
            if ( $PSCmdlet.ShouldProcess("aaaotpparameter", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaotpparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for AAA otpparameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaotpparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaaotpparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaotpparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaotpparameter -GetAll 
        Get all aaaotpparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaotpparameter -name <string>
        Get aaaotpparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaotpparameter -Filter @{ 'name'='<value>' }
        Get aaaotpparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaotpparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaotpparameter/
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
        Write-Verbose "Invoke-ADCGetAaaotpparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaotpparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaotpparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaotpparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaotpparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaotpparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaotpparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaaparameter {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER Enablestaticpagecaching 
        The default state of VPN Static Page caching. If nothing is specified, the default value is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Enableenhancedauthfeedback 
        Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO. 
        Possible values = YES, NO 
    .PARAMETER Defaultauthtype 
        The default authentication server type. 
        Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
    .PARAMETER Maxaaausers 
        Maximum number of concurrent users allowed to log on to VPN simultaneously. 
    .PARAMETER Aaadnatip 
        Source IP address to use for traffic that is sent to the authentication server. 
    .PARAMETER Maxloginattempts 
        Maximum Number of login Attempts. 
    .PARAMETER Enablesessionstickiness 
        Enables/Disables stickiness to authentication servers. 
        Possible values = YES, NO 
    .PARAMETER Maxsamldeflatesize 
        This will set the maximum deflate size in case of SAML Redirect binding. 
    .PARAMETER Persistentloginattempts 
        Persistent storage of unsuccessful user login attempts. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pwdexpirynotificationdays 
        This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
    .PARAMETER Maxkbquestions 
        This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6. 
    .PARAMETER Aaasessionloglevel 
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
    .PARAMETER Aaadloglevel 
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
    .PARAMETER Dynaddr 
        Set by the DHCP client when the IP address was fetched dynamically. 
        Possible values = ON, OFF 
    .PARAMETER Ftmode 
        First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI. 
        Possible values = ON, HA, OFF 
    .PARAMETER Loginencryption 
        Parameter to encrypt login information for nFactor flow. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Samesite 
        SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite. 
        Possible values = None, LAX, STRICT 
    .PARAMETER Apitokencache 
        Option to enable/disable API cache feature. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tokenintrospectioninterval 
        Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache. 
    .PARAMETER Defaultcspheader 
        Parameter to enable/disable default CSP header. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaaparameter 
        An example how to unset aaaparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter
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

        [Boolean]$enablestaticpagecaching,

        [Boolean]$enableenhancedauthfeedback,

        [Boolean]$defaultauthtype,

        [Boolean]$maxaaausers,

        [Boolean]$aaadnatip,

        [Boolean]$maxloginattempts,

        [Boolean]$enablesessionstickiness,

        [Boolean]$maxsamldeflatesize,

        [Boolean]$persistentloginattempts,

        [Boolean]$pwdexpirynotificationdays,

        [Boolean]$maxkbquestions,

        [Boolean]$aaasessionloglevel,

        [Boolean]$aaadloglevel,

        [Boolean]$dynaddr,

        [Boolean]$ftmode,

        [Boolean]$loginencryption,

        [Boolean]$samesite,

        [Boolean]$apitokencache,

        [Boolean]$tokenintrospectioninterval,

        [Boolean]$defaultcspheader 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablestaticpagecaching') ) { $payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ( $PSBoundParameters.ContainsKey('enableenhancedauthfeedback') ) { $payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ( $PSBoundParameters.ContainsKey('defaultauthtype') ) { $payload.Add('defaultauthtype', $defaultauthtype) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('aaadnatip') ) { $payload.Add('aaadnatip', $aaadnatip) }
            if ( $PSBoundParameters.ContainsKey('maxloginattempts') ) { $payload.Add('maxloginattempts', $maxloginattempts) }
            if ( $PSBoundParameters.ContainsKey('enablesessionstickiness') ) { $payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ( $PSBoundParameters.ContainsKey('maxsamldeflatesize') ) { $payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ( $PSBoundParameters.ContainsKey('persistentloginattempts') ) { $payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ( $PSBoundParameters.ContainsKey('pwdexpirynotificationdays') ) { $payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ( $PSBoundParameters.ContainsKey('maxkbquestions') ) { $payload.Add('maxkbquestions', $maxkbquestions) }
            if ( $PSBoundParameters.ContainsKey('aaasessionloglevel') ) { $payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ( $PSBoundParameters.ContainsKey('aaadloglevel') ) { $payload.Add('aaadloglevel', $aaadloglevel) }
            if ( $PSBoundParameters.ContainsKey('dynaddr') ) { $payload.Add('dynaddr', $dynaddr) }
            if ( $PSBoundParameters.ContainsKey('ftmode') ) { $payload.Add('ftmode', $ftmode) }
            if ( $PSBoundParameters.ContainsKey('loginencryption') ) { $payload.Add('loginencryption', $loginencryption) }
            if ( $PSBoundParameters.ContainsKey('samesite') ) { $payload.Add('samesite', $samesite) }
            if ( $PSBoundParameters.ContainsKey('apitokencache') ) { $payload.Add('apitokencache', $apitokencache) }
            if ( $PSBoundParameters.ContainsKey('tokenintrospectioninterval') ) { $payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
            if ( $PSBoundParameters.ContainsKey('defaultcspheader') ) { $payload.Add('defaultcspheader', $defaultcspheader) }
            if ( $PSCmdlet.ShouldProcess("aaaparameter", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAaaparameter {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER Enablestaticpagecaching 
        The default state of VPN Static Page caching. If nothing is specified, the default value is set to YES. 
        Possible values = YES, NO 
    .PARAMETER Enableenhancedauthfeedback 
        Enhanced auth feedback provides more information to the end user about the reason for an authentication failure. The default value is set to NO. 
        Possible values = YES, NO 
    .PARAMETER Defaultauthtype 
        The default authentication server type. 
        Possible values = LOCAL, LDAP, RADIUS, TACACS, CERT 
    .PARAMETER Maxaaausers 
        Maximum number of concurrent users allowed to log on to VPN simultaneously. 
    .PARAMETER Maxloginattempts 
        Maximum Number of login Attempts. 
    .PARAMETER Failedlogintimeout 
        Number of minutes an account will be locked if user exceeds maximum permissible attempts. 
    .PARAMETER Aaadnatip 
        Source IP address to use for traffic that is sent to the authentication server. 
    .PARAMETER Enablesessionstickiness 
        Enables/Disables stickiness to authentication servers. 
        Possible values = YES, NO 
    .PARAMETER Aaasessionloglevel 
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
    .PARAMETER Aaadloglevel 
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
    .PARAMETER Dynaddr 
        Set by the DHCP client when the IP address was fetched dynamically. 
        Possible values = ON, OFF 
    .PARAMETER Ftmode 
        First time user mode determines which configuration options are shown by default when logging in to the GUI. This setting is controlled by the GUI. 
        Possible values = ON, HA, OFF 
    .PARAMETER Maxsamldeflatesize 
        This will set the maximum deflate size in case of SAML Redirect binding. 
    .PARAMETER Persistentloginattempts 
        Persistent storage of unsuccessful user login attempts. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pwdexpirynotificationdays 
        This will set the threshold time in days for password expiry notification. Default value is 0, which means no notification is sent. 
    .PARAMETER Maxkbquestions 
        This will set maximum number of Questions to be asked for KB Validation. Default value is 2, Max Value is 6. 
    .PARAMETER Loginencryption 
        Parameter to encrypt login information for nFactor flow. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Samesite 
        SameSite attribute value for Cookies generated in AAATM context. This attribute value will be appended only for the cookies which are specified in the builtin patset ns_cookies_samesite. 
        Possible values = None, LAX, STRICT 
    .PARAMETER Apitokencache 
        Option to enable/disable API cache feature. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tokenintrospectioninterval 
        Frequency at which a token must be verified at the Authorization Server (AS) despite being found in cache. 
    .PARAMETER Defaultcspheader 
        Parameter to enable/disable default CSP header. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaaparameter 
        An example how to update aaaparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter/
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

        [ValidateSet('YES', 'NO')]
        [string]$Enablestaticpagecaching,

        [ValidateSet('YES', 'NO')]
        [string]$Enableenhancedauthfeedback,

        [ValidateSet('LOCAL', 'LDAP', 'RADIUS', 'TACACS', 'CERT')]
        [string]$Defaultauthtype,

        [double]$Maxaaausers,

        [double]$Maxloginattempts,

        [ValidateRange(1, 525600)]
        [double]$Failedlogintimeout,

        [string]$Aaadnatip,

        [ValidateSet('YES', 'NO')]
        [string]$Enablesessionstickiness,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Aaasessionloglevel,

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Aaadloglevel,

        [ValidateSet('ON', 'OFF')]
        [string]$Dynaddr,

        [ValidateSet('ON', 'HA', 'OFF')]
        [string]$Ftmode,

        [double]$Maxsamldeflatesize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Persistentloginattempts,

        [double]$Pwdexpirynotificationdays,

        [ValidateRange(2, 6)]
        [double]$Maxkbquestions,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loginencryption,

        [ValidateSet('None', 'LAX', 'STRICT')]
        [string]$Samesite,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Apitokencache,

        [double]$Tokenintrospectioninterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Defaultcspheader 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('enablestaticpagecaching') ) { $payload.Add('enablestaticpagecaching', $enablestaticpagecaching) }
            if ( $PSBoundParameters.ContainsKey('enableenhancedauthfeedback') ) { $payload.Add('enableenhancedauthfeedback', $enableenhancedauthfeedback) }
            if ( $PSBoundParameters.ContainsKey('defaultauthtype') ) { $payload.Add('defaultauthtype', $defaultauthtype) }
            if ( $PSBoundParameters.ContainsKey('maxaaausers') ) { $payload.Add('maxaaausers', $maxaaausers) }
            if ( $PSBoundParameters.ContainsKey('maxloginattempts') ) { $payload.Add('maxloginattempts', $maxloginattempts) }
            if ( $PSBoundParameters.ContainsKey('failedlogintimeout') ) { $payload.Add('failedlogintimeout', $failedlogintimeout) }
            if ( $PSBoundParameters.ContainsKey('aaadnatip') ) { $payload.Add('aaadnatip', $aaadnatip) }
            if ( $PSBoundParameters.ContainsKey('enablesessionstickiness') ) { $payload.Add('enablesessionstickiness', $enablesessionstickiness) }
            if ( $PSBoundParameters.ContainsKey('aaasessionloglevel') ) { $payload.Add('aaasessionloglevel', $aaasessionloglevel) }
            if ( $PSBoundParameters.ContainsKey('aaadloglevel') ) { $payload.Add('aaadloglevel', $aaadloglevel) }
            if ( $PSBoundParameters.ContainsKey('dynaddr') ) { $payload.Add('dynaddr', $dynaddr) }
            if ( $PSBoundParameters.ContainsKey('ftmode') ) { $payload.Add('ftmode', $ftmode) }
            if ( $PSBoundParameters.ContainsKey('maxsamldeflatesize') ) { $payload.Add('maxsamldeflatesize', $maxsamldeflatesize) }
            if ( $PSBoundParameters.ContainsKey('persistentloginattempts') ) { $payload.Add('persistentloginattempts', $persistentloginattempts) }
            if ( $PSBoundParameters.ContainsKey('pwdexpirynotificationdays') ) { $payload.Add('pwdexpirynotificationdays', $pwdexpirynotificationdays) }
            if ( $PSBoundParameters.ContainsKey('maxkbquestions') ) { $payload.Add('maxkbquestions', $maxkbquestions) }
            if ( $PSBoundParameters.ContainsKey('loginencryption') ) { $payload.Add('loginencryption', $loginencryption) }
            if ( $PSBoundParameters.ContainsKey('samesite') ) { $payload.Add('samesite', $samesite) }
            if ( $PSBoundParameters.ContainsKey('apitokencache') ) { $payload.Add('apitokencache', $apitokencache) }
            if ( $PSBoundParameters.ContainsKey('tokenintrospectioninterval') ) { $payload.Add('tokenintrospectioninterval', $tokenintrospectioninterval) }
            if ( $PSBoundParameters.ContainsKey('defaultcspheader') ) { $payload.Add('defaultcspheader', $defaultcspheader) }
            if ( $PSCmdlet.ShouldProcess("aaaparameter", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaparameter -Payload $payload -GetWarning
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

function Invoke-ADCGetAaaparameter {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for AAA parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaaparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaparameter -GetAll 
        Get all aaaparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaparameter -name <string>
        Get aaaparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaparameter -Filter @{ 'name'='<value>' }
        Get aaaparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaparameter/
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
        Write-Verbose "Invoke-ADCGetAaaparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaapreauthenticationaction -name <string>
        An example how to unset aaapreauthenticationaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaapreauthenticationaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction
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
        [string]$Name,

        [Boolean]$killprocess,

        [Boolean]$deletefiles,

        [Boolean]$defaultepagroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaapreauthenticationaction -Name <string>
        An example how to delete aaapreauthenticationaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaapreauthenticationaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaapreauthenticationaction -name <string>
        An example how to update aaapreauthenticationaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Killprocess,

        [string]$Deletefiles,

        [string]$Defaultepagroup,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationaction -Filter $payload)
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

function Invoke-ADCAddAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER Preauthenticationaction 
        Allow or deny logon after endpoint analysis (EPA) results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the endpoint analysis (EPA) tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) and name(s) of the files to be deleted by the endpoint analysis (EPA) tool. 
    .PARAMETER Defaultepagroup 
        This is the default group that is chosen when the EPA check succeeds. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaapreauthenticationaction -name <string>
        An example how to add aaapreauthenticationaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaapreauthenticationaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Killprocess,

        [string]$Deletefiles,

        [string]$Defaultepagroup,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaapreauthenticationaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSBoundParameters.ContainsKey('defaultepagroup') ) { $payload.Add('defaultepagroup', $defaultepagroup) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationaction", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationaction -Filter $payload)
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

function Invoke-ADCGetAaapreauthenticationaction {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for pre authentication action resource.
    .PARAMETER Name 
        Name for the preauthentication action. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after preauthentication action is created. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationaction object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationaction -GetAll 
        Get all aaapreauthenticationaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationaction -Count 
        Get the number of aaapreauthenticationaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationaction -name <string>
        Get aaapreauthenticationaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationaction -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationaction/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
    .PARAMETER Preauthenticationaction 
        Deny or allow login on the basis of end point analysis results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the EPA tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaapreauthenticationparameter 
        An example how to unset aaapreauthenticationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaapreauthenticationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter
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

        [Boolean]$rule,

        [Boolean]$preauthenticationaction,

        [Boolean]$killprocess,

        [Boolean]$deletefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER Preauthenticationaction 
        Deny or allow login on the basis of end point analysis results. 
        Possible values = ALLOW, DENY 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, to be evaluated by the EPA tool. 
    .PARAMETER Killprocess 
        String specifying the name of a process to be terminated by the EPA tool. 
    .PARAMETER Deletefiles 
        String specifying the path(s) to and name(s) of the files to be deleted by the EPA tool, as a string of between 1 and 1023 characters.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaapreauthenticationparameter 
        An example how to update aaapreauthenticationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter/
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

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Preauthenticationaction,

        [string]$Rule,

        [string]$Killprocess,

        [string]$Deletefiles 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('preauthenticationaction') ) { $payload.Add('preauthenticationaction', $preauthenticationaction) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('killprocess') ) { $payload.Add('killprocess', $killprocess) }
            if ( $PSBoundParameters.ContainsKey('deletefiles') ) { $payload.Add('deletefiles', $deletefiles) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationparameter", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationparameter -Payload $payload -GetWarning
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

function Invoke-ADCGetAaapreauthenticationparameter {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for pre authentication parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationparameter object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationparameter -GetAll 
        Get all aaapreauthenticationparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationparameter -name <string>
        Get aaapreauthenticationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationparameter -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationparameter/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaapreauthenticationparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER Reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaapreauthenticationpolicy -name <string> -rule <string>
        An example how to add aaapreauthenticationpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaapreauthenticationpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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

        [Parameter(Mandatory)]
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationpolicy -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaapreauthenticationpolicy -Name <string>
        An example how to delete aaapreauthenticationpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaapreauthenticationpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, defining connections that match the policy. 
    .PARAMETER Reqaction 
        Name of the action that the policy is to invoke when a connection matches the policy. 
    .PARAMETER PassThru 
        Return details about the created aaapreauthenticationpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaapreauthenticationpolicy -name <string>
        An example how to update aaapreauthenticationpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaapreauthenticationpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaapreauthenticationpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSCmdlet.ShouldProcess("aaapreauthenticationpolicy", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaapreauthenticationpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaapreauthenticationpolicy -Filter $payload)
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for pre authentication policy resource.
    .PARAMETER Name 
        Name for the preauthentication policy. Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the preauthentication policy is created. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicy -GetAll 
        Get all aaapreauthenticationpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicy -Count 
        Get the number of aaapreauthenticationpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicy -name <string>
        Get aaapreauthenticationpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicy -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the aaaglobal that can be bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_aaaglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_aaaglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -GetAll 
        Get all aaapreauthenticationpolicy_aaaglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -Count 
        Get the number of aaapreauthenticationpolicy_aaaglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -name <string>
        Get aaapreauthenticationpolicy_aaaglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_aaaglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_aaaglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyaaaglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_aaaglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_aaaglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_aaaglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicybinding -GetAll 
        Get all aaapreauthenticationpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicybinding -name <string>
        Get aaapreauthenticationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicybinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to aaapreauthenticationpolicy.
    .PARAMETER Name 
        Name of the preauthentication policy whose properties you want to view. 
    .PARAMETER GetAll 
        Retrieve all aaapreauthenticationpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaapreauthenticationpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -GetAll 
        Get all aaapreauthenticationpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -Count 
        Get the number of aaapreauthenticationpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -name <string>
        Get aaapreauthenticationpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get aaapreauthenticationpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaapreauthenticationpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAaapreauthenticationpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaapreauthenticationpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaapreauthenticationpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaapreauthenticationpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaaradiusparams {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER Serverip 
        IP address of your RADIUS server. 
    .PARAMETER Serverport 
        Port number on which the RADIUS server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server. 
    .PARAMETER Radnasip 
        Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Radnasid 
        Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
    .PARAMETER Radvendorid 
        Vendor ID for RADIUS group extraction. 
    .PARAMETER Radattributetype 
        Attribute type for RADIUS group extraction. 
    .PARAMETER Radgroupsprefix 
        Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Radgroupseparator 
        Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Passencoding 
        Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server. 
        Possible values = pap, chap, mschapv1, mschapv2 
    .PARAMETER Ipvendorid 
        Vendor ID attribute in the RADIUS response. 
        If the attribute is not vendor-encoded, it is set to 0. 
    .PARAMETER Ipattributetype 
        IP attribute type in the RADIUS response. 
    .PARAMETER Accounting 
        Configure the RADIUS server state to accept or refuse accounting messages. 
        Possible values = ON, OFF 
    .PARAMETER Pwdvendorid 
        Vendor ID of the password in the RADIUS response. Used to extract the user password. 
    .PARAMETER Pwdattributetype 
        Attribute type of the Vendor ID in the RADIUS response. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups. 
    .PARAMETER Callingstationid 
        Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Authservretry 
        Number of retry by the Citrix ADC before getting response from the RADIUS server. 
    .PARAMETER Authentication 
        Configure the RADIUS server state to accept or refuse authentication messages. 
        Possible values = ON, OFF 
    .PARAMETER Tunnelendpointclientip 
        Send Tunnel Endpoint Client IP address to the RADIUS server. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaaradiusparams 
        An example how to unset aaaradiusparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaaradiusparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams
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

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$radnasip,

        [Boolean]$radnasid,

        [Boolean]$radvendorid,

        [Boolean]$radattributetype,

        [Boolean]$radgroupsprefix,

        [Boolean]$radgroupseparator,

        [Boolean]$passencoding,

        [Boolean]$ipvendorid,

        [Boolean]$ipattributetype,

        [Boolean]$accounting,

        [Boolean]$pwdvendorid,

        [Boolean]$pwdattributetype,

        [Boolean]$defaultauthenticationgroup,

        [Boolean]$callingstationid,

        [Boolean]$authservretry,

        [Boolean]$authentication,

        [Boolean]$tunnelendpointclientip 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaaradiusparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radvendorid') ) { $payload.Add('radvendorid', $radvendorid) }
            if ( $PSBoundParameters.ContainsKey('radattributetype') ) { $payload.Add('radattributetype', $radattributetype) }
            if ( $PSBoundParameters.ContainsKey('radgroupsprefix') ) { $payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ( $PSBoundParameters.ContainsKey('radgroupseparator') ) { $payload.Add('radgroupseparator', $radgroupseparator) }
            if ( $PSBoundParameters.ContainsKey('passencoding') ) { $payload.Add('passencoding', $passencoding) }
            if ( $PSBoundParameters.ContainsKey('ipvendorid') ) { $payload.Add('ipvendorid', $ipvendorid) }
            if ( $PSBoundParameters.ContainsKey('ipattributetype') ) { $payload.Add('ipattributetype', $ipattributetype) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('pwdvendorid') ) { $payload.Add('pwdvendorid', $pwdvendorid) }
            if ( $PSBoundParameters.ContainsKey('pwdattributetype') ) { $payload.Add('pwdattributetype', $pwdattributetype) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSBoundParameters.ContainsKey('callingstationid') ) { $payload.Add('callingstationid', $callingstationid) }
            if ( $PSBoundParameters.ContainsKey('authservretry') ) { $payload.Add('authservretry', $authservretry) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('tunnelendpointclientip') ) { $payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
            if ( $PSCmdlet.ShouldProcess("aaaradiusparams", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaaradiusparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAaaradiusparams {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER Serverip 
        IP address of your RADIUS server. 
    .PARAMETER Serverport 
        Port number on which the RADIUS server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the RADIUS server. 
    .PARAMETER Radkey 
        The key shared between the RADIUS server and clients. 
        Required for allowing the Citrix ADC to communicate with the RADIUS server. 
    .PARAMETER Radnasip 
        Send the Citrix ADC IP (NSIP) address to the RADIUS server as the Network Access Server IP (NASIP) part of the Radius protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Radnasid 
        Send the Network Access Server ID (NASID) for your Citrix ADC to the RADIUS server as the nasid part of the Radius protocol. 
    .PARAMETER Radvendorid 
        Vendor ID for RADIUS group extraction. 
    .PARAMETER Radattributetype 
        Attribute type for RADIUS group extraction. 
    .PARAMETER Radgroupsprefix 
        Prefix string that precedes group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Radgroupseparator 
        Group separator string that delimits group names within a RADIUS attribute for RADIUS group extraction. 
    .PARAMETER Passencoding 
        Enable password encoding in RADIUS packets that the Citrix ADC sends to the RADIUS server. 
        Possible values = pap, chap, mschapv1, mschapv2 
    .PARAMETER Ipvendorid 
        Vendor ID attribute in the RADIUS response. 
        If the attribute is not vendor-encoded, it is set to 0. 
    .PARAMETER Ipattributetype 
        IP attribute type in the RADIUS response. 
    .PARAMETER Accounting 
        Configure the RADIUS server state to accept or refuse accounting messages. 
        Possible values = ON, OFF 
    .PARAMETER Pwdvendorid 
        Vendor ID of the password in the RADIUS response. Used to extract the user password. 
    .PARAMETER Pwdattributetype 
        Attribute type of the Vendor ID in the RADIUS response. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups. 
    .PARAMETER Callingstationid 
        Send Calling-Station-ID of the client to the RADIUS server. IP Address of the client is sent as its Calling-Station-ID. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Authservretry 
        Number of retry by the Citrix ADC before getting response from the RADIUS server. 
    .PARAMETER Authentication 
        Configure the RADIUS server state to accept or refuse authentication messages. 
        Possible values = ON, OFF 
    .PARAMETER Tunnelendpointclientip 
        Send Tunnel Endpoint Client IP address to the RADIUS server. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaaradiusparams -radkey <string>
        An example how to update aaaradiusparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaaradiusparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams/
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
        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Radkey,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Radnasip,

        [string]$Radnasid,

        [double]$Radvendorid,

        [double]$Radattributetype,

        [string]$Radgroupsprefix,

        [string]$Radgroupseparator,

        [ValidateSet('pap', 'chap', 'mschapv1', 'mschapv2')]
        [string]$Passencoding,

        [double]$Ipvendorid,

        [double]$Ipattributetype,

        [ValidateSet('ON', 'OFF')]
        [string]$Accounting,

        [double]$Pwdvendorid,

        [double]$Pwdattributetype,

        [string]$Defaultauthenticationgroup,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Callingstationid,

        [ValidateRange(1, 10)]
        [double]$Authservretry,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tunnelendpointclientip 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaaradiusparams: Starting"
    }
    process {
        try {
            $payload = @{ radkey = $radkey }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('radnasip') ) { $payload.Add('radnasip', $radnasip) }
            if ( $PSBoundParameters.ContainsKey('radnasid') ) { $payload.Add('radnasid', $radnasid) }
            if ( $PSBoundParameters.ContainsKey('radvendorid') ) { $payload.Add('radvendorid', $radvendorid) }
            if ( $PSBoundParameters.ContainsKey('radattributetype') ) { $payload.Add('radattributetype', $radattributetype) }
            if ( $PSBoundParameters.ContainsKey('radgroupsprefix') ) { $payload.Add('radgroupsprefix', $radgroupsprefix) }
            if ( $PSBoundParameters.ContainsKey('radgroupseparator') ) { $payload.Add('radgroupseparator', $radgroupseparator) }
            if ( $PSBoundParameters.ContainsKey('passencoding') ) { $payload.Add('passencoding', $passencoding) }
            if ( $PSBoundParameters.ContainsKey('ipvendorid') ) { $payload.Add('ipvendorid', $ipvendorid) }
            if ( $PSBoundParameters.ContainsKey('ipattributetype') ) { $payload.Add('ipattributetype', $ipattributetype) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('pwdvendorid') ) { $payload.Add('pwdvendorid', $pwdvendorid) }
            if ( $PSBoundParameters.ContainsKey('pwdattributetype') ) { $payload.Add('pwdattributetype', $pwdattributetype) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSBoundParameters.ContainsKey('callingstationid') ) { $payload.Add('callingstationid', $callingstationid) }
            if ( $PSBoundParameters.ContainsKey('authservretry') ) { $payload.Add('authservretry', $authservretry) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('tunnelendpointclientip') ) { $payload.Add('tunnelendpointclientip', $tunnelendpointclientip) }
            if ( $PSCmdlet.ShouldProcess("aaaradiusparams", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaaradiusparams -Payload $payload -GetWarning
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

function Invoke-ADCGetAaaradiusparams {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for RADIUS parameter resource.
    .PARAMETER GetAll 
        Retrieve all aaaradiusparams object(s).
    .PARAMETER Count
        If specified, the count of the aaaradiusparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaradiusparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaaradiusparams -GetAll 
        Get all aaaradiusparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaradiusparams -name <string>
        Get aaaradiusparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaaradiusparams -Filter @{ 'name'='<value>' }
        Get aaaradiusparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaaradiusparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaaradiusparams/
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
        Write-Verbose "Invoke-ADCGetAaaradiusparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaaradiusparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaaradiusparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaaradiusparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaaradiusparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaaradiusparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaaradiusparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Kill AAA configuration Object.
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Username 
        Name of the AAA user. 
    .PARAMETER Groupname 
        Name of the AAA group. 
    .PARAMETER Iip 
        IP address or the first address in the intranet IP range. 
    .PARAMETER Netmask 
        Subnet mask for the intranet IP range. 
    .PARAMETER Sessionkey 
        Show aaa session associated with given session key. 
    .PARAMETER All 
        Terminate all active AAA-TM/VPN sessions.
    .EXAMPLE
        PS C:\>Invoke-ADCKillAaasession 
        An example how to kill aaasession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCKillAaasession
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaasession/
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
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Iip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [ValidateLength(1, 127)]
        [string]$Sessionkey,

        [boolean]$All 

    )
    begin {
        Write-Verbose "Invoke-ADCKillAaasession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('groupname') ) { $payload.Add('groupname', $groupname) }
            if ( $PSBoundParameters.ContainsKey('iip') ) { $payload.Add('iip', $iip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('sessionkey') ) { $payload.Add('sessionkey', $sessionkey) }
            if ( $PSBoundParameters.ContainsKey('all') ) { $payload.Add('all', $all) }
            if ( $PSCmdlet.ShouldProcess($Name, "Kill AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaasession -Action kill -Payload $payload -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Username 
        Name of the AAA user. 
    .PARAMETER Groupname 
        Name of the AAA group. 
    .PARAMETER Iip 
        IP address or the first address in the intranet IP range. 
    .PARAMETER Netmask 
        Subnet mask for the intranet IP range. 
    .PARAMETER Sessionkey 
        Show aaa session associated with given session key. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all aaasession object(s).
    .PARAMETER Count
        If specified, the count of the aaasession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaasession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaasession -GetAll 
        Get all aaasession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaasession -Count 
        Get the number of aaasession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaasession -name <string>
        Get aaasession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaasession -Filter @{ 'name'='<value>' }
        Get aaasession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaasession
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaasession/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Iip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Netmask,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateLength(1, 127)]
        [string]$Sessionkey,

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
        Write-Verbose "Invoke-ADCGetAaasession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaasession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaasession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaasession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('username') ) { $arguments.Add('username', $username) } 
                if ( $PSBoundParameters.ContainsKey('groupname') ) { $arguments.Add('groupname', $groupname) } 
                if ( $PSBoundParameters.ContainsKey('iip') ) { $arguments.Add('iip', $iip) } 
                if ( $PSBoundParameters.ContainsKey('netmask') ) { $arguments.Add('netmask', $netmask) } 
                if ( $PSBoundParameters.ContainsKey('sessionkey') ) { $arguments.Add('sessionkey', $sessionkey) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaasession configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaasession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaasession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUpdateAaassoprofile {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Password 
        Password with which the user logs on. Required for Single sign on to external server. 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaassoprofile -name <string>
        An example how to update aaassoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaassoprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaassoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('username') ) { $payload.Add('username', $username) }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("aaassoprofile", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaassoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaassoprofile -Filter $payload)
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

function Invoke-ADCDeleteAaassoprofile {
    <#
    .SYNOPSIS
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaassoprofile -Name <string>
        An example how to delete aaassoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaassoprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        Write-Verbose "Invoke-ADCDeleteAaassoprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCAddAaassoprofile {
    <#
    .SYNOPSIS
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore (_) character, and must contain only alphanumeric, hyphen (-), period (.), hash (#), space ( ), at (@), equal (=), colon (:), and underscore characters. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my group" or 'my group'). 
    .PARAMETER Password 
        Password with which the user logs on. Required for Single sign on to external server. 
    .PARAMETER PassThru 
        Return details about the created aaassoprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaassoprofile -name <string> -username <string> -password <string>
        An example how to add aaassoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaassoprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaassoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                username       = $username
                password       = $password
            }

            if ( $PSCmdlet.ShouldProcess("aaassoprofile", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaassoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaassoprofile -Filter $payload)
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

function Invoke-ADCGetAaassoprofile {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for aaa sso profile resource.
    .PARAMETER Name 
        Name for the SSO Profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a SSO Profile is created. 
        The following requirement applies only to the NetScaler CLI: 
        If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER GetAll 
        Retrieve all aaassoprofile object(s).
    .PARAMETER Count
        If specified, the count of the aaassoprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaassoprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaassoprofile -GetAll 
        Get all aaassoprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaassoprofile -Count 
        Get the number of aaassoprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaassoprofile -name <string>
        Get aaassoprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaassoprofile -Filter @{ 'name'='<value>' }
        Get aaassoprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaassoprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaassoprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetAaassoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaassoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaassoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaassoprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaassoprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaassoprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaassoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAaatacacsparams {
    <#
    .SYNOPSIS
        Unset AAA configuration Object.
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER Serverip 
        IP address of your TACACS+ server. 
    .PARAMETER Serverport 
        Port number on which the TACACS+ server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server. 
    .PARAMETER Tacacssecret 
        Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server. 
    .PARAMETER Authorization 
        Use streaming authorization on the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Accounting 
        Send accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Auditfailedcmds 
        The option for sending accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Groupattrname 
        TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAaatacacsparams 
        An example how to unset aaatacacsparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAaatacacsparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams
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

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$authtimeout,

        [Boolean]$tacacssecret,

        [Boolean]$authorization,

        [Boolean]$accounting,

        [Boolean]$auditfailedcmds,

        [Boolean]$groupattrname,

        [Boolean]$defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAaatacacsparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('tacacssecret') ) { $payload.Add('tacacssecret', $tacacssecret) }
            if ( $PSBoundParameters.ContainsKey('authorization') ) { $payload.Add('authorization', $authorization) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('auditfailedcmds') ) { $payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaatacacsparams", "Unset AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type aaatacacsparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAaatacacsparams {
    <#
    .SYNOPSIS
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER Serverip 
        IP address of your TACACS+ server. 
    .PARAMETER Serverport 
        Port number on which the TACACS+ server listens for connections. 
    .PARAMETER Authtimeout 
        Maximum number of seconds that the Citrix ADC waits for a response from the TACACS+ server. 
    .PARAMETER Tacacssecret 
        Key shared between the TACACS+ server and clients. Required for allowing the Citrix ADC to communicate with the TACACS+ server. 
    .PARAMETER Authorization 
        Use streaming authorization on the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Accounting 
        Send accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Auditfailedcmds 
        The option for sending accounting messages to the TACACS+ server. 
        Possible values = ON, OFF 
    .PARAMETER Groupattrname 
        TACACS+ group attribute name.Used for group extraction on the TACACS+ server. 
    .PARAMETER Defaultauthenticationgroup 
        This is the default group that is chosen when the authentication succeeds in addition to extracted groups.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaatacacsparams 
        An example how to update aaatacacsparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaatacacsparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams/
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
        [string]$Serverip,

        [int]$Serverport,

        [double]$Authtimeout,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Tacacssecret,

        [ValidateSet('ON', 'OFF')]
        [string]$Authorization,

        [ValidateSet('ON', 'OFF')]
        [string]$Accounting,

        [ValidateSet('ON', 'OFF')]
        [string]$Auditfailedcmds,

        [string]$Groupattrname,

        [string]$Defaultauthenticationgroup 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaatacacsparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('authtimeout') ) { $payload.Add('authtimeout', $authtimeout) }
            if ( $PSBoundParameters.ContainsKey('tacacssecret') ) { $payload.Add('tacacssecret', $tacacssecret) }
            if ( $PSBoundParameters.ContainsKey('authorization') ) { $payload.Add('authorization', $authorization) }
            if ( $PSBoundParameters.ContainsKey('accounting') ) { $payload.Add('accounting', $accounting) }
            if ( $PSBoundParameters.ContainsKey('auditfailedcmds') ) { $payload.Add('auditfailedcmds', $auditfailedcmds) }
            if ( $PSBoundParameters.ContainsKey('groupattrname') ) { $payload.Add('groupattrname', $groupattrname) }
            if ( $PSBoundParameters.ContainsKey('defaultauthenticationgroup') ) { $payload.Add('defaultauthenticationgroup', $defaultauthenticationgroup) }
            if ( $PSCmdlet.ShouldProcess("aaatacacsparams", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaatacacsparams -Payload $payload -GetWarning
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

function Invoke-ADCGetAaatacacsparams {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for tacacs parameters resource.
    .PARAMETER GetAll 
        Retrieve all aaatacacsparams object(s).
    .PARAMETER Count
        If specified, the count of the aaatacacsparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaatacacsparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaatacacsparams -GetAll 
        Get all aaatacacsparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaatacacsparams -name <string>
        Get aaatacacsparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaatacacsparams -Filter @{ 'name'='<value>' }
        Get aaatacacsparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaatacacsparams
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaatacacsparams/
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
        Write-Verbose "Invoke-ADCGetAaatacacsparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaatacacsparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaatacacsparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaatacacsparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaatacacsparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving aaatacacsparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaatacacsparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnlockAaauser {
    <#
    .SYNOPSIS
        Unlock AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added.
    .EXAMPLE
        PS C:\>Invoke-ADCUnlockAaauser -username <string>
        An example how to unlock aaauser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnlockAaauser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$Username 

    )
    begin {
        Write-Verbose "Invoke-ADCUnlockAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }

            if ( $PSCmdlet.ShouldProcess($Name, "Unlock AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Action unlock -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAaauser {
    <#
    .SYNOPSIS
        Delete AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauser -Username <string>
        An example how to delete aaauser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Update AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER Password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server. 
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server. 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAaauser -username <string> -password <string>
        An example how to update aaauser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAaauser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$Username,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username
                password           = $password
            }

            if ( $PSCmdlet.ShouldProcess("aaauser", "Update AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauser -Filter $payload)
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

function Invoke-ADCAddAaauser {
    <#
    .SYNOPSIS
        Add AAA configuration Object.
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER Password 
        Password with which the user logs on. Required for any user account that does not exist on an external authentication server. 
        If you are not using an external authentication server, all user accounts must have a password. If you are using an external authentication server, you must provide a password for local user accounts that do not exist on the authentication server. 
    .PARAMETER PassThru 
        Return details about the created aaauser item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauser -username <string>
        An example how to add aaauser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("aaauser", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type aaauser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauser -Filter $payload)
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

function Invoke-ADCGetAaauser {
    <#
    .SYNOPSIS
        Get AAA configuration object(s).
    .DESCRIPTION
        Configuration for AAA user resource.
    .PARAMETER Username 
        Name for the user. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the user is added. 
    .PARAMETER GetAll 
        Retrieve all aaauser object(s).
    .PARAMETER Count
        If specified, the count of the aaauser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauser -GetAll 
        Get all aaauser data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauser -Count 
        Get the number of aaauser objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauser -name <string>
        Get aaauser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauser -Filter @{ 'name'='<value>' }
        Get aaauser data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser/
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
        [string]$Username,

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
        Write-Verbose "Invoke-ADCGetAaauser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all aaauser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauseraaagroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauseraaagroupbinding -GetAll 
        Get all aaauser_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauseraaagroupbinding -Count 
        Get the number of aaauser_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauseraaagroupbinding -name <string>
        Get aaauser_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauseraaagroupbinding -Filter @{ 'name'='<value>' }
        Get aaauser_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauseraaagroupbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_aaagroup_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauserauditnslogpolicybinding -username <string>
        An example how to add aaauser_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauserauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_auditnslogpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauserauditnslogpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauserauditnslogpolicybinding -Username <string>
        An example how to delete aaauser_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauditnslogpolicybinding -GetAll 
        Get all aaauser_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauditnslogpolicybinding -Count 
        Get the number of aaauser_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditnslogpolicybinding -name <string>
        Get aaauser_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditnslogpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauserauditsyslogpolicybinding -username <string>
        An example how to add aaauser_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauserauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_auditsyslogpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauserauditsyslogpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauserauditsyslogpolicybinding -Username <string>
        An example how to delete aaauser_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauditsyslogpolicybinding -GetAll 
        Get all aaauser_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauditsyslogpolicybinding -Count 
        Get the number of aaauser_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditsyslogpolicybinding -name <string>
        Get aaauser_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_auditsyslogpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauserauthorizationpolicybinding -username <string>
        An example how to add aaauser_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauserauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_authorizationpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauserauthorizationpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauserauthorizationpolicybinding -Username <string>
        An example how to delete aaauser_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauserauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauthorizationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauthorizationpolicybinding -GetAll 
        Get all aaauser_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserauthorizationpolicybinding -Count 
        Get the number of aaauser_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauthorizationpolicybinding -name <string>
        Get aaauser_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserauthorizationpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_authorizationpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to aaauser.
    .PARAMETER Username 
        Name of the user who has the account. 
    .PARAMETER GetAll 
        Retrieve all aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserbinding -GetAll 
        Get all aaauser_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserbinding -name <string>
        Get aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserbinding -Filter @{ 'name'='<value>' }
        Get aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_binding/
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
        [string]$Username,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Intranetip6 
        The Intranet IP6 bound to the user. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip6_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauserintranetip6binding -username <string>
        An example how to add aaauser_intranetip6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauserintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$Username,

        [string]$Gotopriorityexpression,

        [string]$Intranetip6,

        [double]$Numaddr,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserintranetip6binding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('intranetip6') ) { $payload.Add('intranetip6', $intranetip6) }
            if ( $PSBoundParameters.ContainsKey('numaddr') ) { $payload.Add('numaddr', $numaddr) }
            if ( $PSCmdlet.ShouldProcess("aaauser_intranetip6_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauserintranetip6binding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip6 
        The Intranet IP6 bound to the user. 
    .PARAMETER Numaddr 
        Numbers of ipv6 address bound starting with intranetip6.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauserintranetip6binding -Username <string>
        An example how to delete aaauser_intranetip6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauserintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$Username,

        [string]$Intranetip6,

        [double]$Numaddr 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserintranetip6binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip6') ) { $arguments.Add('intranetip6', $Intranetip6) }
            if ( $PSBoundParameters.ContainsKey('Numaddr') ) { $arguments.Add('numaddr', $Numaddr) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the intranetip6 that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_intranetip6_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetip6binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserintranetip6binding -GetAll 
        Get all aaauser_intranetip6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserintranetip6binding -Count 
        Get the number of aaauser_intranetip6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetip6binding -name <string>
        Get aaauser_intranetip6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetip6binding -Filter @{ 'name'='<value>' }
        Get aaauser_intranetip6_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserintranetip6binding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip6_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip 
        The Intranet IP bound to the user. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_intranetip_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauserintranetipbinding -username <string>
        An example how to add aaauser_intranetip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauserintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$Username,

        [string]$Intranetip,

        [string]$Netmask,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauserintranetipbinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('intranetip') ) { $payload.Add('intranetip', $intranetip) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_intranetip_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_intranetip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauserintranetipbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetip 
        The Intranet IP bound to the user. 
    .PARAMETER Netmask 
        The netmask for the Intranet IP.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauserintranetipbinding -Username <string>
        An example how to delete aaauser_intranetip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauserintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$Username,

        [string]$Intranetip,

        [string]$Netmask 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauserintranetipbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetip') ) { $arguments.Add('intranetip', $Intranetip) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the intranetip that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_intranetip_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_intranetip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetipbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserintranetipbinding -GetAll 
        Get all aaauser_intranetip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauserintranetipbinding -Count 
        Get the number of aaauser_intranetip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetipbinding -name <string>
        Get aaauser_intranetip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauserintranetipbinding -Filter @{ 'name'='<value>' }
        Get aaauser_intranetip_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauserintranetipbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_intranetip_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_intranetip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_intranetip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_intranetip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaausertmsessionpolicybinding -username <string>
        An example how to add aaauser_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaausertmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaausertmsessionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_tmsessionpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaausertmsessionpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaausertmsessionpolicybinding -Username <string>
        An example how to delete aaauser_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaausertmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaausertmsessionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaausertmsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaausertmsessionpolicybinding -GetAll 
        Get all aaauser_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaausertmsessionpolicybinding -Count 
        Get the number of aaauser_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaausertmsessionpolicybinding -name <string>
        Get aaauser_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaausertmsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaausertmsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_tmsessionpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetapplication 
        Name of the intranet VPN application to which the policy applies. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnintranetapplication_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauservpnintranetapplicationbinding -username <string>
        An example how to add aaauser_vpnintranetapplication_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauservpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$Username,

        [string]$Intranetapplication,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('intranetapplication') ) { $payload.Add('intranetapplication', $intranetapplication) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnintranetapplication_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnintranetapplication_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauservpnintranetapplicationbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Intranetapplication 
        Name of the intranet VPN application to which the policy applies.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauservpnintranetapplicationbinding -Username <string>
        An example how to delete aaauser_vpnintranetapplication_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$Username,

        [string]$Intranetapplication 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnintranetapplicationbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Intranetapplication') ) { $arguments.Add('intranetapplication', $Intranetapplication) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnintranetapplication that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnintranetapplication_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnintranetapplication_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnintranetapplicationbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnintranetapplicationbinding -GetAll 
        Get all aaauser_vpnintranetapplication_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnintranetapplicationbinding -Count 
        Get the number of aaauser_vpnintranetapplication_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnintranetapplicationbinding -name <string>
        Get aaauser_vpnintranetapplication_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnintranetapplicationbinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnintranetapplication_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauservpnintranetapplicationbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnintranetapplication_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnintranetapplication_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnintranetapplication_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnintranetapplication_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauservpnsessionpolicybinding -username <string>
        An example how to add aaauser_vpnsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauservpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnsessionpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauservpnsessionpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauservpnsessionpolicybinding -Username <string>
        An example how to delete aaauser_vpnsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnsessionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnsessionpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnsessionpolicybinding -GetAll 
        Get all aaauser_vpnsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnsessionpolicybinding -Count 
        Get the number of aaauser_vpnsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnsessionpolicybinding -name <string>
        Get aaauser_vpnsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauservpnsessionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnsessionpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpntrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauservpntrafficpolicybinding -username <string>
        An example how to add aaauser_vpntrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauservpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpntrafficpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpntrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauservpntrafficpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauservpntrafficpolicybinding -Username <string>
        An example how to delete aaauser_vpntrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpntrafficpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpntrafficpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpntrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpntrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpntrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpntrafficpolicybinding -GetAll 
        Get all aaauser_vpntrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpntrafficpolicybinding -Count 
        Get the number of aaauser_vpntrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpntrafficpolicybinding -name <string>
        Get aaauser_vpntrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpntrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpntrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauservpntrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpntrafficpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpntrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpntrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpntrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Priority 
        Integer specifying the priority of the policy. A lower number indicates a higher priority. Policies are evaluated in the order of their priority numbers. Maximum value for default syntax policies is 2147483647 and for classic policies max priority is 64000. . 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurlpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauservpnurlpolicybinding -username <string>
        An example how to add aaauser_vpnurlpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauservpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [ValidateRange(0, 2147483647)]
        [double]$Priority,

        [ValidateSet('REQUEST', 'UDP_REQUEST', 'DNS_REQUEST', 'ICMP_REQUEST')]
        [string]$Type = 'REQUEST',

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnurlpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('policy') ) { $payload.Add('policy', $policy) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnurlpolicy_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurlpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauservpnurlpolicybinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Policy 
        The policy Name. 
    .PARAMETER Type 
        Bindpoint to which the policy is bound. 
        Possible values = REQUEST, UDP_REQUEST, DNS_REQUEST, ICMP_REQUEST
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauservpnurlpolicybinding -Username <string>
        An example how to delete aaauser_vpnurlpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$Username,

        [string]$Policy,

        [string]$Type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policy') ) { $arguments.Add('policy', $Policy) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnurlpolicy that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnurlpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurlpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnurlpolicybinding -GetAll 
        Get all aaauser_vpnurlpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnurlpolicybinding -Count 
        Get the number of aaauser_vpnurlpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlpolicybinding -name <string>
        Get aaauser_vpnurlpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlpolicybinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnurlpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauservpnurlpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurlpolicy_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurlpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurlpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurlpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Urlname 
        The intranet url. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created aaauser_vpnurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAaauservpnurlbinding -username <string>
        An example how to add aaauser_vpnurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAaauservpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$Username,

        [string]$Urlname,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAaauservpnurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('urlname') ) { $payload.Add('urlname', $urlname) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("aaauser_vpnurl_binding", "Add AAA configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type aaauser_vpnurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAaauservpnurlbinding -Filter $payload)
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
        Delete AAA configuration Object.
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER Urlname 
        The intranet url.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAaauservpnurlbinding -Username <string>
        An example how to delete aaauser_vpnurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAaauservpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$Username,

        [string]$Urlname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAaauservpnurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Urlname') ) { $arguments.Add('urlname', $Urlname) }
            if ( $PSCmdlet.ShouldProcess("$username", "Delete AAA configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Get AAA configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnurl that can be bound to aaauser.
    .PARAMETER Username 
        User account to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all aaauser_vpnurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the aaauser_vpnurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnurlbinding -GetAll 
        Get all aaauser_vpnurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAaauservpnurlbinding -Count 
        Get the number of aaauser_vpnurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlbinding -name <string>
        Get aaauser_vpnurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAaauservpnurlbinding -Filter @{ 'name'='<value>' }
        Get aaauser_vpnurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAaauservpnurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/aaa/aaauser_vpnurl_binding/
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
        [string]$Username,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all aaauser_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for aaauser_vpnurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving aaauser_vpnurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type aaauser_vpnurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


