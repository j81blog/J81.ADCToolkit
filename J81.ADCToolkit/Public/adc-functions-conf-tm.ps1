function Invoke-ADCAddTmformssoaction {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Actionurl 
        URL to which the completed form is submitted. 
    .PARAMETER Userfield 
        Name of the form field in which the user types in the user ID. 
    .PARAMETER Passwdfield 
        Name of the form field in which the user types in the password. 
    .PARAMETER Ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmformssoaction -name <string> -actionurl <string> -userfield <string> -passwdfield <string> -ssosuccessrule <string>
        An example how to add tmformssoaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmformssoaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        [string]$Actionurl,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Userfield,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Passwdfield,

        [Parameter(Mandatory)]
        [string]$Ssosuccessrule,

        [string]$Namevaluepair,

        [double]$Responsesize = '8096',

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$Nvtype = 'DYNAMIC',

        [ValidateSet('GET', 'POST')]
        [string]$Submitmethod = 'GET',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                actionurl      = $actionurl
                userfield      = $userfield
                passwdfield    = $passwdfield
                ssosuccessrule = $ssosuccessrule
            }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("tmformssoaction", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmformssoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmformssoaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmformssoaction: Finished"
    }
}

function Invoke-ADCDeleteTmformssoaction {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmformssoaction -Name <string>
        An example how to delete tmformssoaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmformssoaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        Write-Verbose "Invoke-ADCDeleteTmformssoaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmformssoaction: Finished"
    }
}

function Invoke-ADCUpdateTmformssoaction {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Actionurl 
        URL to which the completed form is submitted. 
    .PARAMETER Userfield 
        Name of the form field in which the user types in the user ID. 
    .PARAMETER Passwdfield 
        Name of the form field in which the user types in the password. 
    .PARAMETER Ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmformssoaction -name <string>
        An example how to update tmformssoaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmformssoaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        [string]$Actionurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Userfield,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Passwdfield,

        [string]$Ssosuccessrule,

        [double]$Responsesize,

        [string]$Namevaluepair,

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$Nvtype,

        [ValidateSet('GET', 'POST')]
        [string]$Submitmethod,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('actionurl') ) { $payload.Add('actionurl', $actionurl) }
            if ( $PSBoundParameters.ContainsKey('userfield') ) { $payload.Add('userfield', $userfield) }
            if ( $PSBoundParameters.ContainsKey('passwdfield') ) { $payload.Add('passwdfield', $passwdfield) }
            if ( $PSBoundParameters.ContainsKey('ssosuccessrule') ) { $payload.Add('ssosuccessrule', $ssosuccessrule) }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("tmformssoaction", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmformssoaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmformssoaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmformssoaction: Finished"
    }
}

function Invoke-ADCUnsetTmformssoaction {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Responsesize 
        Number of bytes, in the response, to parse for extracting the forms. 
    .PARAMETER Namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
    .PARAMETER Nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted. 
        Possible values = STATIC, DYNAMIC 
    .PARAMETER Submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type. 
        Possible values = GET, POST
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmformssoaction -name <string>
        An example how to unset tmformssoaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmformssoaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$responsesize,

        [Boolean]$namevaluepair,

        [Boolean]$nvtype,

        [Boolean]$submitmethod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmformssoaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('responsesize') ) { $payload.Add('responsesize', $responsesize) }
            if ( $PSBoundParameters.ContainsKey('namevaluepair') ) { $payload.Add('namevaluepair', $namevaluepair) }
            if ( $PSBoundParameters.ContainsKey('nvtype') ) { $payload.Add('nvtype', $nvtype) }
            if ( $PSBoundParameters.ContainsKey('submitmethod') ) { $payload.Add('submitmethod', $submitmethod) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmformssoaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmformssoaction: Finished"
    }
}

function Invoke-ADCGetTmformssoaction {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for Form sso action resource.
    .PARAMETER Name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retrieve all tmformssoaction object(s).
    .PARAMETER Count
        If specified, the count of the tmformssoaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmformssoaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmformssoaction -GetAll 
        Get all tmformssoaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmformssoaction -Count 
        Get the number of tmformssoaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmformssoaction -name <string>
        Get tmformssoaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmformssoaction -Filter @{ 'name'='<value>' }
        Get tmformssoaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmformssoaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        Write-Verbose "Invoke-ADCGetTmformssoaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmformssoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmformssoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmformssoaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmformssoaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmformssoaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmformssoaction: Ended"
    }
}

function Invoke-ADCAddTmglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmglobalauditnslogpolicybinding 
        An example how to add tmglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmglobalauditnslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmglobalauditnslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTmglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmglobalauditnslogpolicybinding 
        An example how to delete tmglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmglobalauditnslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetTmglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobalauditnslogpolicybinding -GetAll 
        Get all tmglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobalauditnslogpolicybinding -Count 
        Get the number of tmglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditnslogpolicybinding -name <string>
        Get tmglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get tmglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmglobalauditnslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmglobalauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddTmglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmglobalauditsyslogpolicybinding 
        An example how to add tmglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmglobalauditsyslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmglobalauditsyslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTmglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmglobalauditsyslogpolicybinding 
        An example how to delete tmglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmglobalauditsyslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetTmglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobalauditsyslogpolicybinding -GetAll 
        Get all tmglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobalauditsyslogpolicybinding -Count 
        Get the number of tmglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditsyslogpolicybinding -name <string>
        Get tmglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get tmglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmglobalauditsyslogpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmglobalauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetTmglobalbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobalbinding -GetAll 
        Get all tmglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalbinding -name <string>
        Get tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobalbinding -Filter @{ 'name'='<value>' }
        Get tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmglobalbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmglobalbinding: Ended"
    }
}

function Invoke-ADCAddTmglobaltmsessionpolicybinding {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmsessionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmglobaltmsessionpolicybinding 
        An example how to add tmglobal_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmglobaltmsessionpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobaltmsessionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmsessionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmglobaltmsessionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmglobaltmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTmglobaltmsessionpolicybinding {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmglobaltmsessionpolicybinding 
        An example how to delete tmglobal_tmsessionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmglobaltmsessionpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobaltmsessionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmglobaltmsessionpolicybinding: Finished"
    }
}

function Invoke-ADCGetTmglobaltmsessionpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the tmsessionpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobaltmsessionpolicybinding -GetAll 
        Get all tmglobal_tmsessionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobaltmsessionpolicybinding -Count 
        Get the number of tmglobal_tmsessionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmsessionpolicybinding -name <string>
        Get tmglobal_tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get tmglobal_tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmglobaltmsessionpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobaltmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmglobaltmsessionpolicybinding: Ended"
    }
}

function Invoke-ADCAddTmglobaltmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmtrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmglobaltmtrafficpolicybinding 
        An example how to add tmglobal_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmglobaltmtrafficpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobaltmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmtrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmglobaltmtrafficpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmglobaltmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTmglobaltmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER Policyname 
        The name of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmglobaltmtrafficpolicybinding 
        An example how to delete tmglobal_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmglobaltmtrafficpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobaltmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmglobaltmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCGetTmglobaltmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to tmglobal.
    .PARAMETER GetAll 
        Retrieve all tmglobal_tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmglobal_tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmtrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobaltmtrafficpolicybinding -GetAll 
        Get all tmglobal_tmtrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmglobaltmtrafficpolicybinding -Count 
        Get the number of tmglobal_tmtrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmtrafficpolicybinding -name <string>
        Get tmglobal_tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmglobaltmtrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get tmglobal_tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmglobaltmtrafficpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobaltmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmglobaltmtrafficpolicybinding: Ended"
    }
}

function Invoke-ADCAddTmsamlssoprofile {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Assertionconsumerserviceurl 
        URL to which the assertion is to be sent. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmsamlssoprofile -name <string> -assertionconsumerserviceurl <string>
        An example how to add tmsamlssoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmsamlssoprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        [string]$Samlsigningcertname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Assertionconsumerserviceurl,

        [string]$Relaystaterule,

        [ValidateSet('ON', 'OFF')]
        [string]$Sendpassword = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlissuername,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$Signaturealg = 'RSA-SHA256',

        [ValidateSet('SHA1', 'SHA256')]
        [string]$Digestmethod = 'SHA256',

        [string]$Audience,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$Nameidformat = 'transient',

        [string]$Nameidexpr,

        [string]$Attribute1,

        [string]$Attribute1expr,

        [string]$Attribute1friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute1format,

        [string]$Attribute2,

        [string]$Attribute2expr,

        [string]$Attribute2friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute2format,

        [string]$Attribute3,

        [string]$Attribute3expr,

        [string]$Attribute3friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute3format,

        [string]$Attribute4,

        [string]$Attribute4expr,

        [string]$Attribute4friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute4format,

        [string]$Attribute5,

        [string]$Attribute5expr,

        [string]$Attribute5friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute5format,

        [string]$Attribute6,

        [string]$Attribute6expr,

        [string]$Attribute6friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute6format,

        [string]$Attribute7,

        [string]$Attribute7expr,

        [string]$Attribute7friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute7format,

        [string]$Attribute8,

        [string]$Attribute8expr,

        [string]$Attribute8friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute8format,

        [string]$Attribute9,

        [string]$Attribute9expr,

        [string]$Attribute9friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute9format,

        [string]$Attribute10,

        [string]$Attribute10expr,

        [string]$Attribute10friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute10format,

        [string]$Attribute11,

        [string]$Attribute11expr,

        [string]$Attribute11friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute11format,

        [string]$Attribute12,

        [string]$Attribute12expr,

        [string]$Attribute12friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute12format,

        [string]$Attribute13,

        [string]$Attribute13expr,

        [string]$Attribute13friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute13format,

        [string]$Attribute14,

        [string]$Attribute14expr,

        [string]$Attribute14friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute14format,

        [string]$Attribute15,

        [string]$Attribute15expr,

        [string]$Attribute15friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute15format,

        [string]$Attribute16,

        [string]$Attribute16expr,

        [string]$Attribute16friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute16format,

        [ValidateSet('ON', 'OFF')]
        [string]$Encryptassertion = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlspcertname,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$Encryptionalgorithm = 'AES256',

        [double]$Skewtime = '5',

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$Signassertion = 'ASSERTION',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name              = $name
                assertionconsumerserviceurl = $assertionconsumerserviceurl
            }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1expr') ) { $payload.Add('attribute1expr', $attribute1expr) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2expr') ) { $payload.Add('attribute2expr', $attribute2expr) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3expr') ) { $payload.Add('attribute3expr', $attribute3expr) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4expr') ) { $payload.Add('attribute4expr', $attribute4expr) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5expr') ) { $payload.Add('attribute5expr', $attribute5expr) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6expr') ) { $payload.Add('attribute6expr', $attribute6expr) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7expr') ) { $payload.Add('attribute7expr', $attribute7expr) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8expr') ) { $payload.Add('attribute8expr', $attribute8expr) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9expr') ) { $payload.Add('attribute9expr', $attribute9expr) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10expr') ) { $payload.Add('attribute10expr', $attribute10expr) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11expr') ) { $payload.Add('attribute11expr', $attribute11expr) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12expr') ) { $payload.Add('attribute12expr', $attribute12expr) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13expr') ) { $payload.Add('attribute13expr', $attribute13expr) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14expr') ) { $payload.Add('attribute14expr', $attribute14expr) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15expr') ) { $payload.Add('attribute15expr', $attribute15expr) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16expr') ) { $payload.Add('attribute16expr', $attribute16expr) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("tmsamlssoprofile", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsamlssoprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmsamlssoprofile: Finished"
    }
}

function Invoke-ADCDeleteTmsamlssoprofile {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmsamlssoprofile -Name <string>
        An example how to delete tmsamlssoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmsamlssoprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        Write-Verbose "Invoke-ADCDeleteTmsamlssoprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmsamlssoprofile: Finished"
    }
}

function Invoke-ADCUpdateTmsamlssoprofile {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Assertionconsumerserviceurl 
        URL to which the assertion is to be sent. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmsamlssoprofile -name <string>
        An example how to update tmsamlssoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmsamlssoprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        [string]$Samlsigningcertname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Assertionconsumerserviceurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Sendpassword,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlissuername,

        [string]$Relaystaterule,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$Signaturealg,

        [ValidateSet('SHA1', 'SHA256')]
        [string]$Digestmethod,

        [string]$Audience,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$Nameidformat,

        [string]$Nameidexpr,

        [string]$Attribute1,

        [string]$Attribute1expr,

        [string]$Attribute1friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute1format,

        [string]$Attribute2,

        [string]$Attribute2expr,

        [string]$Attribute2friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute2format,

        [string]$Attribute3,

        [string]$Attribute3expr,

        [string]$Attribute3friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute3format,

        [string]$Attribute4,

        [string]$Attribute4expr,

        [string]$Attribute4friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute4format,

        [string]$Attribute5,

        [string]$Attribute5expr,

        [string]$Attribute5friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute5format,

        [string]$Attribute6,

        [string]$Attribute6expr,

        [string]$Attribute6friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute6format,

        [string]$Attribute7,

        [string]$Attribute7expr,

        [string]$Attribute7friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute7format,

        [string]$Attribute8,

        [string]$Attribute8expr,

        [string]$Attribute8friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute8format,

        [string]$Attribute9,

        [string]$Attribute9expr,

        [string]$Attribute9friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute9format,

        [string]$Attribute10,

        [string]$Attribute10expr,

        [string]$Attribute10friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute10format,

        [string]$Attribute11,

        [string]$Attribute11expr,

        [string]$Attribute11friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute11format,

        [string]$Attribute12,

        [string]$Attribute12expr,

        [string]$Attribute12friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute12format,

        [string]$Attribute13,

        [string]$Attribute13expr,

        [string]$Attribute13friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute13format,

        [string]$Attribute14,

        [string]$Attribute14expr,

        [string]$Attribute14friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute14format,

        [string]$Attribute15,

        [string]$Attribute15expr,

        [string]$Attribute15friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute15format,

        [string]$Attribute16,

        [string]$Attribute16expr,

        [string]$Attribute16friendlyname,

        [ValidateSet('URI', 'Basic')]
        [string]$Attribute16format,

        [ValidateSet('ON', 'OFF')]
        [string]$Encryptassertion,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlspcertname,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$Encryptionalgorithm,

        [double]$Skewtime,

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$Signassertion,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('assertionconsumerserviceurl') ) { $payload.Add('assertionconsumerserviceurl', $assertionconsumerserviceurl) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1expr') ) { $payload.Add('attribute1expr', $attribute1expr) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2expr') ) { $payload.Add('attribute2expr', $attribute2expr) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3expr') ) { $payload.Add('attribute3expr', $attribute3expr) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4expr') ) { $payload.Add('attribute4expr', $attribute4expr) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5expr') ) { $payload.Add('attribute5expr', $attribute5expr) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6expr') ) { $payload.Add('attribute6expr', $attribute6expr) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7expr') ) { $payload.Add('attribute7expr', $attribute7expr) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8expr') ) { $payload.Add('attribute8expr', $attribute8expr) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9expr') ) { $payload.Add('attribute9expr', $attribute9expr) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10expr') ) { $payload.Add('attribute10expr', $attribute10expr) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11expr') ) { $payload.Add('attribute11expr', $attribute11expr) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12expr') ) { $payload.Add('attribute12expr', $attribute12expr) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13expr') ) { $payload.Add('attribute13expr', $attribute13expr) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14expr') ) { $payload.Add('attribute14expr', $attribute14expr) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15expr') ) { $payload.Add('attribute15expr', $attribute15expr) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16expr') ) { $payload.Add('attribute16expr', $attribute16expr) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("tmsamlssoprofile", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsamlssoprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmsamlssoprofile: Finished"
    }
}

function Invoke-ADCUnsetTmsamlssoprofile {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER Samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion. 
    .PARAMETER Sendpassword 
        Option to send password in assertion. 
        Possible values = ON, OFF 
    .PARAMETER Samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
    .PARAMETER Relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ 
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER Signaturealg 
        Algorithm to be used to sign/verify SAML transactions. 
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER Digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions. 
        Possible values = SHA1, SHA256 
    .PARAMETER Audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER Nameidformat 
        Format of Name Identifier sent in Assertion. 
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER Nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
    .PARAMETER Attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute1format 
        Format of Attribute1 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute2format 
        Format of Attribute2 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute3format 
        Format of Attribute3 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute4format 
        Format of Attribute4 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute5format 
        Format of Attribute5 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute6format 
        Format of Attribute6 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute7format 
        Format of Attribute7 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute8format 
        Format of Attribute8 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute9format 
        Format of Attribute9 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute10format 
        Format of Attribute10 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute11format 
        Format of Attribute11 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute12format 
        Format of Attribute12 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute13format 
        Format of Attribute13 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute14format 
        Format of Attribute14 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute15format 
        Format of Attribute15 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER Attribute16format 
        Format of Attribute16 to be sent in Assertion. 
        Possible values = URI, Basic 
    .PARAMETER Encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one. 
        Possible values = ON, OFF 
    .PARAMETER Samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
    .PARAMETER Encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion. 
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER Skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
    .PARAMETER Signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed. 
        Possible values = NONE, ASSERTION, RESPONSE, BOTH
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmsamlssoprofile -name <string>
        An example how to unset tmsamlssoprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmsamlssoprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$samlsigningcertname,

        [Boolean]$sendpassword,

        [Boolean]$samlissuername,

        [Boolean]$relaystaterule,

        [Boolean]$signaturealg,

        [Boolean]$digestmethod,

        [Boolean]$audience,

        [Boolean]$nameidformat,

        [Boolean]$nameidexpr,

        [Boolean]$attribute1,

        [Boolean]$attribute1friendlyname,

        [Boolean]$attribute1format,

        [Boolean]$attribute2,

        [Boolean]$attribute2friendlyname,

        [Boolean]$attribute2format,

        [Boolean]$attribute3,

        [Boolean]$attribute3friendlyname,

        [Boolean]$attribute3format,

        [Boolean]$attribute4,

        [Boolean]$attribute4friendlyname,

        [Boolean]$attribute4format,

        [Boolean]$attribute5,

        [Boolean]$attribute5friendlyname,

        [Boolean]$attribute5format,

        [Boolean]$attribute6,

        [Boolean]$attribute6friendlyname,

        [Boolean]$attribute6format,

        [Boolean]$attribute7,

        [Boolean]$attribute7friendlyname,

        [Boolean]$attribute7format,

        [Boolean]$attribute8,

        [Boolean]$attribute8friendlyname,

        [Boolean]$attribute8format,

        [Boolean]$attribute9,

        [Boolean]$attribute9friendlyname,

        [Boolean]$attribute9format,

        [Boolean]$attribute10,

        [Boolean]$attribute10friendlyname,

        [Boolean]$attribute10format,

        [Boolean]$attribute11,

        [Boolean]$attribute11friendlyname,

        [Boolean]$attribute11format,

        [Boolean]$attribute12,

        [Boolean]$attribute12friendlyname,

        [Boolean]$attribute12format,

        [Boolean]$attribute13,

        [Boolean]$attribute13friendlyname,

        [Boolean]$attribute13format,

        [Boolean]$attribute14,

        [Boolean]$attribute14friendlyname,

        [Boolean]$attribute14format,

        [Boolean]$attribute15,

        [Boolean]$attribute15friendlyname,

        [Boolean]$attribute15format,

        [Boolean]$attribute16,

        [Boolean]$attribute16friendlyname,

        [Boolean]$attribute16format,

        [Boolean]$encryptassertion,

        [Boolean]$samlspcertname,

        [Boolean]$encryptionalgorithm,

        [Boolean]$skewtime,

        [Boolean]$signassertion 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsamlssoprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('samlsigningcertname') ) { $payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ( $PSBoundParameters.ContainsKey('sendpassword') ) { $payload.Add('sendpassword', $sendpassword) }
            if ( $PSBoundParameters.ContainsKey('samlissuername') ) { $payload.Add('samlissuername', $samlissuername) }
            if ( $PSBoundParameters.ContainsKey('relaystaterule') ) { $payload.Add('relaystaterule', $relaystaterule) }
            if ( $PSBoundParameters.ContainsKey('signaturealg') ) { $payload.Add('signaturealg', $signaturealg) }
            if ( $PSBoundParameters.ContainsKey('digestmethod') ) { $payload.Add('digestmethod', $digestmethod) }
            if ( $PSBoundParameters.ContainsKey('audience') ) { $payload.Add('audience', $audience) }
            if ( $PSBoundParameters.ContainsKey('nameidformat') ) { $payload.Add('nameidformat', $nameidformat) }
            if ( $PSBoundParameters.ContainsKey('nameidexpr') ) { $payload.Add('nameidexpr', $nameidexpr) }
            if ( $PSBoundParameters.ContainsKey('attribute1') ) { $payload.Add('attribute1', $attribute1) }
            if ( $PSBoundParameters.ContainsKey('attribute1friendlyname') ) { $payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute1format') ) { $payload.Add('attribute1format', $attribute1format) }
            if ( $PSBoundParameters.ContainsKey('attribute2') ) { $payload.Add('attribute2', $attribute2) }
            if ( $PSBoundParameters.ContainsKey('attribute2friendlyname') ) { $payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute2format') ) { $payload.Add('attribute2format', $attribute2format) }
            if ( $PSBoundParameters.ContainsKey('attribute3') ) { $payload.Add('attribute3', $attribute3) }
            if ( $PSBoundParameters.ContainsKey('attribute3friendlyname') ) { $payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute3format') ) { $payload.Add('attribute3format', $attribute3format) }
            if ( $PSBoundParameters.ContainsKey('attribute4') ) { $payload.Add('attribute4', $attribute4) }
            if ( $PSBoundParameters.ContainsKey('attribute4friendlyname') ) { $payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute4format') ) { $payload.Add('attribute4format', $attribute4format) }
            if ( $PSBoundParameters.ContainsKey('attribute5') ) { $payload.Add('attribute5', $attribute5) }
            if ( $PSBoundParameters.ContainsKey('attribute5friendlyname') ) { $payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute5format') ) { $payload.Add('attribute5format', $attribute5format) }
            if ( $PSBoundParameters.ContainsKey('attribute6') ) { $payload.Add('attribute6', $attribute6) }
            if ( $PSBoundParameters.ContainsKey('attribute6friendlyname') ) { $payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute6format') ) { $payload.Add('attribute6format', $attribute6format) }
            if ( $PSBoundParameters.ContainsKey('attribute7') ) { $payload.Add('attribute7', $attribute7) }
            if ( $PSBoundParameters.ContainsKey('attribute7friendlyname') ) { $payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute7format') ) { $payload.Add('attribute7format', $attribute7format) }
            if ( $PSBoundParameters.ContainsKey('attribute8') ) { $payload.Add('attribute8', $attribute8) }
            if ( $PSBoundParameters.ContainsKey('attribute8friendlyname') ) { $payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute8format') ) { $payload.Add('attribute8format', $attribute8format) }
            if ( $PSBoundParameters.ContainsKey('attribute9') ) { $payload.Add('attribute9', $attribute9) }
            if ( $PSBoundParameters.ContainsKey('attribute9friendlyname') ) { $payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute9format') ) { $payload.Add('attribute9format', $attribute9format) }
            if ( $PSBoundParameters.ContainsKey('attribute10') ) { $payload.Add('attribute10', $attribute10) }
            if ( $PSBoundParameters.ContainsKey('attribute10friendlyname') ) { $payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute10format') ) { $payload.Add('attribute10format', $attribute10format) }
            if ( $PSBoundParameters.ContainsKey('attribute11') ) { $payload.Add('attribute11', $attribute11) }
            if ( $PSBoundParameters.ContainsKey('attribute11friendlyname') ) { $payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute11format') ) { $payload.Add('attribute11format', $attribute11format) }
            if ( $PSBoundParameters.ContainsKey('attribute12') ) { $payload.Add('attribute12', $attribute12) }
            if ( $PSBoundParameters.ContainsKey('attribute12friendlyname') ) { $payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute12format') ) { $payload.Add('attribute12format', $attribute12format) }
            if ( $PSBoundParameters.ContainsKey('attribute13') ) { $payload.Add('attribute13', $attribute13) }
            if ( $PSBoundParameters.ContainsKey('attribute13friendlyname') ) { $payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute13format') ) { $payload.Add('attribute13format', $attribute13format) }
            if ( $PSBoundParameters.ContainsKey('attribute14') ) { $payload.Add('attribute14', $attribute14) }
            if ( $PSBoundParameters.ContainsKey('attribute14friendlyname') ) { $payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute14format') ) { $payload.Add('attribute14format', $attribute14format) }
            if ( $PSBoundParameters.ContainsKey('attribute15') ) { $payload.Add('attribute15', $attribute15) }
            if ( $PSBoundParameters.ContainsKey('attribute15friendlyname') ) { $payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute15format') ) { $payload.Add('attribute15format', $attribute15format) }
            if ( $PSBoundParameters.ContainsKey('attribute16') ) { $payload.Add('attribute16', $attribute16) }
            if ( $PSBoundParameters.ContainsKey('attribute16friendlyname') ) { $payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ( $PSBoundParameters.ContainsKey('attribute16format') ) { $payload.Add('attribute16format', $attribute16format) }
            if ( $PSBoundParameters.ContainsKey('encryptassertion') ) { $payload.Add('encryptassertion', $encryptassertion) }
            if ( $PSBoundParameters.ContainsKey('samlspcertname') ) { $payload.Add('samlspcertname', $samlspcertname) }
            if ( $PSBoundParameters.ContainsKey('encryptionalgorithm') ) { $payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('skewtime') ) { $payload.Add('skewtime', $skewtime) }
            if ( $PSBoundParameters.ContainsKey('signassertion') ) { $payload.Add('signassertion', $signassertion) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsamlssoprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmsamlssoprofile: Finished"
    }
}

function Invoke-ADCGetTmsamlssoprofile {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for SAML sso action resource.
    .PARAMETER Name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retrieve all tmsamlssoprofile object(s).
    .PARAMETER Count
        If specified, the count of the tmsamlssoprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsamlssoprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsamlssoprofile -GetAll 
        Get all tmsamlssoprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsamlssoprofile -Count 
        Get the number of tmsamlssoprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsamlssoprofile -name <string>
        Get tmsamlssoprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsamlssoprofile -Filter @{ 'name'='<value>' }
        Get tmsamlssoprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsamlssoprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        Write-Verbose "Invoke-ADCGetTmsamlssoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsamlssoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsamlssoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsamlssoprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsamlssoprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsamlssoprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsamlssoprofile: Ended"
    }
}

function Invoke-ADCAddTmsessionaction {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
        Possible values = YES, NO 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmsessionaction -name <string>
        An example how to add tmsessionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmsessionaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso = 'OFF',

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie = 'YES',

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionaction", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsessionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsessionaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmsessionaction: Finished"
    }
}

function Invoke-ADCDeleteTmsessionaction {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmsessionaction -Name <string>
        An example how to delete tmsessionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmsessionaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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
        Write-Verbose "Invoke-ADCDeleteTmsessionaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmsessionaction: Finished"
    }
}

function Invoke-ADCUpdateTmsessionaction {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmsessionaction -name <string>
        An example how to update tmsessionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionaction", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsessionaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmsessionaction: Finished"
    }
}

function Invoke-ADCUnsetTmsessionaction {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO). 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on (SSO). 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF. 
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmsessionaction -name <string>
        An example how to unset tmsessionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$sesstimeout,

        [Boolean]$defaultauthorizationaction,

        [Boolean]$sso,

        [Boolean]$ssocredential,

        [Boolean]$ssodomain,

        [Boolean]$kcdaccount,

        [Boolean]$httponlycookie,

        [Boolean]$persistentcookie,

        [Boolean]$persistentcookievalidity,

        [Boolean]$homepage 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmsessionaction: Finished"
    }
}

function Invoke-ADCGetTmsessionaction {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for TM session action resource.
    .PARAMETER Name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER GetAll 
        Retrieve all tmsessionaction object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionaction -GetAll 
        Get all tmsessionaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionaction -Count 
        Get the number of tmsessionaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionaction -name <string>
        Get tmsessionaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionaction -Filter @{ 'name'='<value>' }
        Get tmsessionaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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
        Write-Verbose "Invoke-ADCGetTmsessionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionaction: Ended"
    }
}

function Invoke-ADCUpdateTmsessionparameter {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Sso 
        Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
        Possible values = ON, OFF 
    .PARAMETER Ssocredential 
        Use primary or secondary authentication credentials for single sign-on. 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on. 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
        Possible values = YES, NO 
    .PARAMETER Persistentcookie 
        Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled. 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmsessionparameter 
        An example how to update tmsessionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter/
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

        [double]$Sesstimeout,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Defaultauthorizationaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$Ssocredential,

        [ValidateLength(1, 32)]
        [string]$Ssodomain,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateSet('YES', 'NO')]
        [string]$Httponlycookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [double]$Persistentcookievalidity,

        [string]$Homepage 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSCmdlet.ShouldProcess("tmsessionparameter", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateTmsessionparameter: Finished"
    }
}

function Invoke-ADCUnsetTmsessionparameter {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER Sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources. 
    .PARAMETER Sso 
        Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application. Note that this configuration does not honor the following authentication types for security reason. BASIC, DIGEST, and NTLM (without Negotiate NTLM2 Key or Negotiate Sign Flag). Use TM TrafficAction to configure SSO for these authentication types. 
        Possible values = ON, OFF 
    .PARAMETER Ssodomain 
        Domain to use for single sign-on. 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Persistentcookie 
        Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER Defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy. 
        Possible values = ALLOW, DENY 
    .PARAMETER Ssocredential 
        Use primary or secondary authentication credentials for single sign-on. 
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER Httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts. 
        Possible values = YES, NO 
    .PARAMETER Persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmsessionparameter 
        An example how to unset tmsessionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter
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

        [Boolean]$sesstimeout,

        [Boolean]$sso,

        [Boolean]$ssodomain,

        [Boolean]$kcdaccount,

        [Boolean]$persistentcookie,

        [Boolean]$homepage,

        [Boolean]$defaultauthorizationaction,

        [Boolean]$ssocredential,

        [Boolean]$httponlycookie,

        [Boolean]$persistentcookievalidity 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sesstimeout') ) { $payload.Add('sesstimeout', $sesstimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('ssodomain') ) { $payload.Add('ssodomain', $ssodomain) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('homepage') ) { $payload.Add('homepage', $homepage) }
            if ( $PSBoundParameters.ContainsKey('defaultauthorizationaction') ) { $payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ( $PSBoundParameters.ContainsKey('ssocredential') ) { $payload.Add('ssocredential', $ssocredential) }
            if ( $PSBoundParameters.ContainsKey('httponlycookie') ) { $payload.Add('httponlycookie', $httponlycookie) }
            if ( $PSBoundParameters.ContainsKey('persistentcookievalidity') ) { $payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ( $PSCmdlet.ShouldProcess("tmsessionparameter", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmsessionparameter: Finished"
    }
}

function Invoke-ADCGetTmsessionparameter {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for session parameter resource.
    .PARAMETER GetAll 
        Retrieve all tmsessionparameter object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionparameter -GetAll 
        Get all tmsessionparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionparameter -name <string>
        Get tmsessionparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionparameter -Filter @{ 'name'='<value>' }
        Get tmsessionparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter/
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
        Write-Verbose "Invoke-ADCGetTmsessionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmsessionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionparameter: Ended"
    }
}

function Invoke-ADCAddTmsessionpolicy {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmsessionpolicy -name <string> -rule <string> -action <string>
        An example how to add tmsessionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmsessionpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("tmsessionpolicy", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsessionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmsessionpolicy: Finished"
    }
}

function Invoke-ADCDeleteTmsessionpolicy {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmsessionpolicy -Name <string>
        An example how to delete tmsessionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmsessionpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        Write-Verbose "Invoke-ADCDeleteTmsessionpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmsessionpolicy: Finished"
    }
}

function Invoke-ADCUpdateTmsessionpolicy {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmsessionpolicy -name <string>
        An example how to update tmsessionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("tmsessionpolicy", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmsessionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmsessionpolicy: Finished"
    }
}

function Invoke-ADCUnsetTmsessionpolicy {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER Rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Action to be applied to connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmsessionpolicy -name <string>
        An example how to unset tmsessionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$rule,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmsessionpolicy: Finished"
    }
}

function Invoke-ADCGetTmsessionpolicy {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for TM session policy resource.
    .PARAMETER Name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicy -GetAll 
        Get all tmsessionpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicy -Count 
        Get the number of tmsessionpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicy -name <string>
        Get tmsessionpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicy -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmsessionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicy: Ended"
    }
}

function Invoke-ADCGetTmsessionpolicyaaagroupbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaagroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyaaagroupbinding -GetAll 
        Get all tmsessionpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyaaagroupbinding -Count 
        Get the number of tmsessionpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaagroupbinding -name <string>
        Get tmsessionpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyaaagroupbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaagroupbinding: Ended"
    }
}

function Invoke-ADCGetTmsessionpolicyaaauserbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaauserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyaaauserbinding -GetAll 
        Get all tmsessionpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyaaauserbinding -Count 
        Get the number of tmsessionpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaauserbinding -name <string>
        Get tmsessionpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyaaauserbinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyaaauserbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaauserbinding: Ended"
    }
}

function Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -GetAll 
        Get all tmsessionpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -Count 
        Get the number of tmsessionpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -name <string>
        Get tmsessionpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding: Ended"
    }
}

function Invoke-ADCGetTmsessionpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicybinding -GetAll 
        Get all tmsessionpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicybinding -name <string>
        Get tmsessionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicybinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicybinding: Ended"
    }
}

function Invoke-ADCGetTmsessionpolicytmglobalbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to tmsessionpolicy.
    .PARAMETER Name 
        Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmsessionpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicytmglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicytmglobalbinding -GetAll 
        Get all tmsessionpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmsessionpolicytmglobalbinding -Count 
        Get the number of tmsessionpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicytmglobalbinding -name <string>
        Get tmsessionpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmsessionpolicytmglobalbinding -Filter @{ 'name'='<value>' }
        Get tmsessionpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicytmglobalbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmsessionpolicytmglobalbinding: Ended"
    }
}

function Invoke-ADCAddTmtrafficaction {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed. 
    .PARAMETER Sso 
        Use single sign-on for the resource that the user is accessing now. 
        Possible values = ON, OFF 
    .PARAMETER Formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmtrafficaction -name <string>
        An example how to add tmtrafficaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmtrafficaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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

        [ValidateRange(1, 715827)]
        [double]$Apptimeout,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [string]$Formssoaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Initiatelogout,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount = '"None"',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlssoprofile,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$Forcedtimeout,

        [double]$Forcedtimeoutval,

        [string]$Userexpression,

        [string]$Passwdexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('apptimeout') ) { $payload.Add('apptimeout', $apptimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('formssoaction') ) { $payload.Add('formssoaction', $formssoaction) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('initiatelogout') ) { $payload.Add('initiatelogout', $initiatelogout) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('samlssoprofile') ) { $payload.Add('samlssoprofile', $samlssoprofile) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeoutval') ) { $payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficaction", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmtrafficaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmtrafficaction: Finished"
    }
}

function Invoke-ADCDeleteTmtrafficaction {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmtrafficaction -Name <string>
        An example how to delete tmtrafficaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmtrafficaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficaction: Finished"
    }
}

function Invoke-ADCUpdateTmtrafficaction {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed. 
    .PARAMETER Sso 
        Use single sign-on for the resource that the user is accessing now. 
        Possible values = ON, OFF 
    .PARAMETER Formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmtrafficaction -name <string>
        An example how to update tmtrafficaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmtrafficaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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

        [ValidateRange(1, 715827)]
        [double]$Apptimeout,

        [ValidateSet('ON', 'OFF')]
        [string]$Sso,

        [string]$Formssoaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Persistentcookie,

        [ValidateSet('ON', 'OFF')]
        [string]$Initiatelogout,

        [ValidateLength(1, 32)]
        [string]$Kcdaccount,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Samlssoprofile,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$Forcedtimeout,

        [double]$Forcedtimeoutval,

        [string]$Userexpression,

        [string]$Passwdexpression,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('apptimeout') ) { $payload.Add('apptimeout', $apptimeout) }
            if ( $PSBoundParameters.ContainsKey('sso') ) { $payload.Add('sso', $sso) }
            if ( $PSBoundParameters.ContainsKey('formssoaction') ) { $payload.Add('formssoaction', $formssoaction) }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('initiatelogout') ) { $payload.Add('initiatelogout', $initiatelogout) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('samlssoprofile') ) { $payload.Add('samlssoprofile', $samlssoprofile) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeoutval') ) { $payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficaction", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmtrafficaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmtrafficaction: Finished"
    }
}

function Invoke-ADCUnsetTmtrafficaction {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER Persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. 
        Possible values = ON, OFF 
    .PARAMETER Kcdaccount 
        Kerberos constrained delegation account name. 
    .PARAMETER Forcedtimeout 
        Setting to start, stop or reset TM session force timer. 
        Possible values = START, STOP, RESET 
    .PARAMETER Userexpression 
        expression that will be evaluated to obtain username for SingleSignOn. 
    .PARAMETER Passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmtrafficaction -name <string>
        An example how to unset tmtrafficaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmtrafficaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$persistentcookie,

        [Boolean]$kcdaccount,

        [Boolean]$forcedtimeout,

        [Boolean]$userexpression,

        [Boolean]$passwdexpression 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmtrafficaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('persistentcookie') ) { $payload.Add('persistentcookie', $persistentcookie) }
            if ( $PSBoundParameters.ContainsKey('kcdaccount') ) { $payload.Add('kcdaccount', $kcdaccount) }
            if ( $PSBoundParameters.ContainsKey('forcedtimeout') ) { $payload.Add('forcedtimeout', $forcedtimeout) }
            if ( $PSBoundParameters.ContainsKey('userexpression') ) { $payload.Add('userexpression', $userexpression) }
            if ( $PSBoundParameters.ContainsKey('passwdexpression') ) { $payload.Add('passwdexpression', $passwdexpression) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmtrafficaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmtrafficaction: Finished"
    }
}

function Invoke-ADCGetTmtrafficaction {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for TM traffic action resource.
    .PARAMETER Name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficaction object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficaction -GetAll 
        Get all tmtrafficaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficaction -Count 
        Get the number of tmtrafficaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficaction -name <string>
        Get tmtrafficaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficaction -Filter @{ 'name'='<value>' }
        Get tmtrafficaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficaction
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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
        Write-Verbose "Invoke-ADCGetTmtrafficaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmtrafficaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficaction: Ended"
    }
}

function Invoke-ADCAddTmtrafficpolicy {
    <#
    .SYNOPSIS
        Add Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTmtrafficpolicy -name <string> -rule <string> -action <string>
        An example how to add tmtrafficpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTmtrafficpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("tmtrafficpolicy", "Add Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmtrafficpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTmtrafficpolicy: Finished"
    }
}

function Invoke-ADCDeleteTmtrafficpolicy {
    <#
    .SYNOPSIS
        Delete Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTmtrafficpolicy -Name <string>
        An example how to delete tmtrafficpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTmtrafficpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficpolicy: Finished"
    }
}

function Invoke-ADCUpdateTmtrafficpolicy {
    <#
    .SYNOPSIS
        Update Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTmtrafficpolicy -name <string>
        An example how to update tmtrafficpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTmtrafficpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("tmtrafficpolicy", "Update Traffic Management configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTmtrafficpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTmtrafficpolicy: Finished"
    }
}

function Invoke-ADCUnsetTmtrafficpolicy {
    <#
    .SYNOPSIS
        Unset Traffic Management configuration Object.
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER Action 
        Name of the action to apply to requests or connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTmtrafficpolicy -name <string>
        An example how to unset tmtrafficpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTmtrafficpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$rule,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmtrafficpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmtrafficpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTmtrafficpolicy: Finished"
    }
}

function Invoke-ADCGetTmtrafficpolicy {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Configuration for TM traffic policy resource.
    .PARAMETER Name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicy -GetAll 
        Get all tmtrafficpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicy -Count 
        Get the number of tmtrafficpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicy -name <string>
        Get tmtrafficpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicy -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicy
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all tmtrafficpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficpolicy: Ended"
    }
}

function Invoke-ADCGetTmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicybinding -GetAll 
        Get all tmtrafficpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicybinding -name <string>
        Get tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicybinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficpolicybinding: Ended"
    }
}

function Invoke-ADCGetTmtrafficpolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicycsvserverbinding -GetAll 
        Get all tmtrafficpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicycsvserverbinding -Count 
        Get the number of tmtrafficpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicycsvserverbinding -name <string>
        Get tmtrafficpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicycsvserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetTmtrafficpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicylbvserverbinding -GetAll 
        Get all tmtrafficpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicylbvserverbinding -Count 
        Get the number of tmtrafficpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicylbvserverbinding -name <string>
        Get tmtrafficpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicylbvserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetTmtrafficpolicytmglobalbinding {
    <#
    .SYNOPSIS
        Get Traffic Management configuration object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to tmtrafficpolicy.
    .PARAMETER Name 
        Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all tmtrafficpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicytmglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicytmglobalbinding -GetAll 
        Get all tmtrafficpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTmtrafficpolicytmglobalbinding -Count 
        Get the number of tmtrafficpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicytmglobalbinding -name <string>
        Get tmtrafficpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTmtrafficpolicytmglobalbinding -Filter @{ 'name'='<value>' }
        Get tmtrafficpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicytmglobalbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTmtrafficpolicytmglobalbinding: Ended"
    }
}

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBiN78Kk60R57lf
# w6lJXqaV97Z8Y1yOHFm9PSCDZHuyrKCCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWsw
# DQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4X
# DTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRsw
# GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGlt
# ZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DW
# mn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJre
# TAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fW
# uCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2H
# YxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv
# 53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKV
# KoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRX
# yCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEV
# YFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzG
# PATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4s
# rjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCC
# AXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1
# N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
# AQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1Ud
# HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRp
# bWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0
# dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcN
# AQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu6
# 6ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIV
# y0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQ
# Lt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55
# aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9o
# GsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkW
# mcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiG
# oDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6
# R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TU
# JikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbW
# w/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFkzCC
# BY8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
# c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
# MSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL
# /bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgkbdo1joeMa4VSp0CEPF00QwD
# LeS/ScV18usP5xDUn1cwDQYJKoZIhvcNAQEBBQAEggEAChAjIfb/AzYgwku/CBZ9
# 0ZWWceX/Z+HGHkcRvw1Xw0/mQ89BHHGpbW4Sym1hgHCCYm5lMQDBELDVwmtU+DMR
# F1FfsccXzJvfFFYYWbHPtjtvthqk/v05C97UKU8IKIWLDyxWjbKfYHMUINO5lFZ1
# zt58ryYzj6EwO4r/+gg6+EJgTpo35Si7wCAU428/5Ps/dEuNi7+15DKpfwB8VsZj
# uMS49XxXw4mwx1069p6c3KF1pqVDAkxw7I1vWmS5m6I4LnqNuCPsWtHvmNqq0Pod
# G5jNpMQvoA6KOzp0aY5E4RwKlgTKlJF4YO64vdtQZ3IkvlmxfPTXJHgQkDkZrhug
# uqGCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwNDAzMTkwNzIxWjA/BgkqhkiG9w0BCQQxMgQwjdh3DyVv4BBK2baE/yTk9McN
# 9R8vtzH8ISVqJ388KI/JmyqDJP3I9HJ+6OlVU699MA0GCSqGSIb3DQEBAQUABIIC
# AFBtIUaZmmBIOertbMHbJryzejRocZ7HvdMp1r439tVun8S+MSTRXw/6ImRL6D2n
# qFe6Cf37UoGjdS4zV+/vpxyZ2pcib7doKkTOhPWGUaDFiUtMYo5fSo2oa9qxTFmP
# IHLuaZ8nshnxXUcrZX4gk26d2ket9fuIhp0axGxtX9h8vk2C3FtqxzesgN88Tqzv
# nXF7wj/ArHpT/m3u87fPAlZaicRQefhKD24KZ0nPUKnvJDartXSNg1nwmov+3Xgu
# kAYy47ECwPp7AC5H65/L0AElWuzlpSBvL1uycJHG+KxtJDwWfw2836ZFhWHZqqY0
# 1FpC468ZGip+5rQTglpMLE4/YY8lBw26aqTbheN9BbAT/QgBcr4eqpoADgvsFg5u
# AI6ZPHBcDM/XXGTNebyNz34pjpsgZb51hQ+vhdSPN+HlrniNwgcrtTOqru/HUaRQ
# GAYv5ZL0OvRmCnY/xFE5FzmQiKfjUG5UQ3AJvvnjEmx7iZMD6QeVnJIB5iFwC8Dm
# cQuFvPZTSziv2RNg1CwpOFDdZUzBfAk4RVecJ2/77L51JcbTyo+JVudExKDR0i9I
# etRBpPZsbW7w6Atu0G6/qzHFxuNMy6Ck/NB04mAOvOg+uujaqwmZm5IDb+jav8hT
# NjwnQi5x+EPYuYIIHQY1BPs2ehIDt44Z8wKz5lhJz9OC
# SIG # End signature block
