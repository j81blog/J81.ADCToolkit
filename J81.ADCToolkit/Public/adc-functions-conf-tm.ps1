function Invoke-ADCAddTmformssoaction {
<#
    .SYNOPSIS
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER actionurl 
        URL to which the completed form is submitted.  
        Minimum length = 1 
    .PARAMETER userfield 
        Name of the form field in which the user types in the user ID.  
        Minimum length = 1 
    .PARAMETER passwdfield 
        Name of the form field in which the user types in the password.  
        Minimum length = 1 
    .PARAMETER ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
    .PARAMETER responsesize 
        Number of bytes, in the response, to parse for extracting the forms.  
        Default value: 8096 
    .PARAMETER nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted.  
        Default value: DYNAMIC  
        Possible values = STATIC, DYNAMIC 
    .PARAMETER submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type.  
        Default value: GET  
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        Invoke-ADCAddTmformssoaction -name <string> -actionurl <string> -userfield <string> -passwdfield <string> -ssosuccessrule <string>
    .NOTES
        File Name : Invoke-ADCAddTmformssoaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        [string]$actionurl ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$userfield ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$passwdfield ,

        [Parameter(Mandatory = $true)]
        [string]$ssosuccessrule ,

        [string]$namevaluepair ,

        [double]$responsesize = '8096' ,

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$nvtype = 'DYNAMIC' ,

        [ValidateSet('GET', 'POST')]
        [string]$submitmethod = 'GET' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmformssoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                actionurl = $actionurl
                userfield = $userfield
                passwdfield = $passwdfield
                ssosuccessrule = $ssosuccessrule
            }
            if ($PSBoundParameters.ContainsKey('namevaluepair')) { $Payload.Add('namevaluepair', $namevaluepair) }
            if ($PSBoundParameters.ContainsKey('responsesize')) { $Payload.Add('responsesize', $responsesize) }
            if ($PSBoundParameters.ContainsKey('nvtype')) { $Payload.Add('nvtype', $nvtype) }
            if ($PSBoundParameters.ContainsKey('submitmethod')) { $Payload.Add('submitmethod', $submitmethod) }
 
            if ($PSCmdlet.ShouldProcess("tmformssoaction", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmformssoaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmformssoaction -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmformssoaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmformssoaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        Write-Verbose "Invoke-ADCDeleteTmformssoaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER actionurl 
        URL to which the completed form is submitted.  
        Minimum length = 1 
    .PARAMETER userfield 
        Name of the form field in which the user types in the user ID.  
        Minimum length = 1 
    .PARAMETER passwdfield 
        Name of the form field in which the user types in the password.  
        Minimum length = 1 
    .PARAMETER ssosuccessrule 
        Expression, that checks to see if single sign-on is successful. 
    .PARAMETER responsesize 
        Number of bytes, in the response, to parse for extracting the forms.  
        Default value: 8096 
    .PARAMETER namevaluepair 
        Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
    .PARAMETER nvtype 
        Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted.  
        Default value: DYNAMIC  
        Possible values = STATIC, DYNAMIC 
    .PARAMETER submitmethod 
        HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type.  
        Default value: GET  
        Possible values = GET, POST 
    .PARAMETER PassThru 
        Return details about the created tmformssoaction item.
    .EXAMPLE
        Invoke-ADCUpdateTmformssoaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmformssoaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        [string]$actionurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$userfield ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$passwdfield ,

        [string]$ssosuccessrule ,

        [double]$responsesize ,

        [string]$namevaluepair ,

        [ValidateSet('STATIC', 'DYNAMIC')]
        [string]$nvtype ,

        [ValidateSet('GET', 'POST')]
        [string]$submitmethod ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmformssoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('actionurl')) { $Payload.Add('actionurl', $actionurl) }
            if ($PSBoundParameters.ContainsKey('userfield')) { $Payload.Add('userfield', $userfield) }
            if ($PSBoundParameters.ContainsKey('passwdfield')) { $Payload.Add('passwdfield', $passwdfield) }
            if ($PSBoundParameters.ContainsKey('ssosuccessrule')) { $Payload.Add('ssosuccessrule', $ssosuccessrule) }
            if ($PSBoundParameters.ContainsKey('responsesize')) { $Payload.Add('responsesize', $responsesize) }
            if ($PSBoundParameters.ContainsKey('namevaluepair')) { $Payload.Add('namevaluepair', $namevaluepair) }
            if ($PSBoundParameters.ContainsKey('nvtype')) { $Payload.Add('nvtype', $nvtype) }
            if ($PSBoundParameters.ContainsKey('submitmethod')) { $Payload.Add('submitmethod', $submitmethod) }
 
            if ($PSCmdlet.ShouldProcess("tmformssoaction", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmformssoaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmformssoaction -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
   .PARAMETER responsesize 
       Number of bytes, in the response, to parse for extracting the forms. 
   .PARAMETER namevaluepair 
       Name-value pair attributes to send to the server in addition to sending the username and password. Value names are separated by an ampersand (;) (for example, name1=value1;name2=value2). 
   .PARAMETER nvtype 
       Type of processing of the name-value pair. If you specify STATIC, the values configured by the administrator are used. For DYNAMIC, the response is parsed, and the form is extracted and then submitted.  
       Possible values = STATIC, DYNAMIC 
   .PARAMETER submitmethod 
       HTTP method used by the single sign-on form to send the logon credentials to the logon server. Applies only to STATIC name-value type.  
       Possible values = GET, POST
    .EXAMPLE
        Invoke-ADCUnsetTmformssoaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmformssoaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction
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

        [Boolean]$responsesize ,

        [Boolean]$namevaluepair ,

        [Boolean]$nvtype ,

        [Boolean]$submitmethod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmformssoaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('responsesize')) { $Payload.Add('responsesize', $responsesize) }
            if ($PSBoundParameters.ContainsKey('namevaluepair')) { $Payload.Add('namevaluepair', $namevaluepair) }
            if ($PSBoundParameters.ContainsKey('nvtype')) { $Payload.Add('nvtype', $nvtype) }
            if ($PSBoundParameters.ContainsKey('submitmethod')) { $Payload.Add('submitmethod', $submitmethod) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmformssoaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the new form-based single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retreive all tmformssoaction object(s)
    .PARAMETER Count
        If specified, the count of the tmformssoaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmformssoaction
    .EXAMPLE 
        Invoke-ADCGetTmformssoaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmformssoaction -Count
    .EXAMPLE
        Invoke-ADCGetTmformssoaction -name <string>
    .EXAMPLE
        Invoke-ADCGetTmformssoaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmformssoaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmformssoaction/
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
        Write-Verbose "Invoke-ADCGetTmformssoaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmformssoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmformssoaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmformssoaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmformssoaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmformssoaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmformssoaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER policyname 
        The name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddTmglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddTmglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmglobalauditnslogpolicybinding -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
     .PARAMETER policyname 
       The name of the policy.
    .EXAMPLE
        Invoke-ADCDeleteTmglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteTmglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("tmglobal_auditnslogpolicy_binding", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmglobal_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmglobal_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmglobalauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmglobalauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmglobalauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetTmglobalauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER policyname 
        The name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddTmglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddTmglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmglobalauditsyslogpolicybinding -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
     .PARAMETER policyname 
       The name of the policy.
    .EXAMPLE
        Invoke-ADCDeleteTmglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteTmglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("tmglobal_auditsyslogpolicy_binding", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmglobal_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmglobal_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmglobalauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmglobalauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmglobalauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetTmglobalauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmglobalbinding
    .EXAMPLE 
        Invoke-ADCGetTmglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetTmglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER policyname 
        The name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmsessionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddTmglobaltmsessionpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddTmglobaltmsessionpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobaltmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmsessionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmglobaltmsessionpolicybinding -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
     .PARAMETER policyname 
       The name of the policy.
    .EXAMPLE
        Invoke-ADCDeleteTmglobaltmsessionpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteTmglobaltmsessionpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobaltmsessionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("tmglobal_tmsessionpolicy_binding", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmglobal_tmsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmglobal_tmsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmglobaltmsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmglobaltmsessionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmglobaltmsessionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetTmglobaltmsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmglobaltmsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmglobaltmsessionpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmsessionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobaltmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER policyname 
        The name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Applicable only to advance tmsession policy. Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER PassThru 
        Return details about the created tmglobal_tmtrafficpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddTmglobaltmtrafficpolicybinding 
    .NOTES
        File Name : Invoke-ADCAddTmglobaltmtrafficpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmglobaltmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmglobal_tmtrafficpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmglobaltmtrafficpolicybinding -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
     .PARAMETER policyname 
       The name of the policy.
    .EXAMPLE
        Invoke-ADCDeleteTmglobaltmtrafficpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteTmglobaltmtrafficpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteTmglobaltmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("tmglobal_tmtrafficpolicy_binding", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmglobal_tmtrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmglobal_tmtrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmglobaltmtrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmglobaltmtrafficpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmglobaltmtrafficpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetTmglobaltmtrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmglobaltmtrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmglobaltmtrafficpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmglobal_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmglobaltmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmglobal_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmglobal_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmglobal_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion.  
        Minimum length = 1 
    .PARAMETER assertionconsumerserviceurl 
        URL to which the assertion is to be sent.  
        Minimum length = 1 
    .PARAMETER relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ  
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER sendpassword 
        Option to send password in assertion.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC.  
        Minimum length = 1 
    .PARAMETER signaturealg 
        Algorithm to be used to sign/verify SAML transactions.  
        Default value: RSA-SHA256  
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions.  
        Default value: SHA256  
        Possible values = SHA1, SHA256 
    .PARAMETER audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER nameidformat 
        Format of Name Identifier sent in Assertion.  
        Default value: transient  
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion.  
        Maximum length = 128 
    .PARAMETER attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute1format 
        Format of Attribute1 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute2format 
        Format of Attribute2 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute3format 
        Format of Attribute3 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute4format 
        Format of Attribute4 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute5format 
        Format of Attribute5 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute6format 
        Format of Attribute6 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute7format 
        Format of Attribute7 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute8format 
        Format of Attribute8 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute9format 
        Format of Attribute9 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute10format 
        Format of Attribute10 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute11format 
        Format of Attribute11 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute12format 
        Format of Attribute12 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute13format 
        Format of Attribute13 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute14format 
        Format of Attribute14 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute15format 
        Format of Attribute15 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute16format 
        Format of Attribute16 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted.  
        Minimum length = 1 
    .PARAMETER encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion.  
        Default value: AES256  
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all.  
        Default value: 5 
    .PARAMETER signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed.  
        Default value: ASSERTION  
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        Invoke-ADCAddTmsamlssoprofile -name <string> -assertionconsumerserviceurl <string>
    .NOTES
        File Name : Invoke-ADCAddTmsamlssoprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        [string]$samlsigningcertname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$assertionconsumerserviceurl ,

        [string]$relaystaterule ,

        [ValidateSet('ON', 'OFF')]
        [string]$sendpassword = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlissuername ,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$signaturealg = 'RSA-SHA256' ,

        [ValidateSet('SHA1', 'SHA256')]
        [string]$digestmethod = 'SHA256' ,

        [string]$audience ,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$nameidformat = 'transient' ,

        [string]$nameidexpr ,

        [string]$attribute1 ,

        [string]$attribute1expr ,

        [string]$attribute1friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute1format ,

        [string]$attribute2 ,

        [string]$attribute2expr ,

        [string]$attribute2friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute2format ,

        [string]$attribute3 ,

        [string]$attribute3expr ,

        [string]$attribute3friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute3format ,

        [string]$attribute4 ,

        [string]$attribute4expr ,

        [string]$attribute4friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute4format ,

        [string]$attribute5 ,

        [string]$attribute5expr ,

        [string]$attribute5friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute5format ,

        [string]$attribute6 ,

        [string]$attribute6expr ,

        [string]$attribute6friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute6format ,

        [string]$attribute7 ,

        [string]$attribute7expr ,

        [string]$attribute7friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute7format ,

        [string]$attribute8 ,

        [string]$attribute8expr ,

        [string]$attribute8friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute8format ,

        [string]$attribute9 ,

        [string]$attribute9expr ,

        [string]$attribute9friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute9format ,

        [string]$attribute10 ,

        [string]$attribute10expr ,

        [string]$attribute10friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute10format ,

        [string]$attribute11 ,

        [string]$attribute11expr ,

        [string]$attribute11friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute11format ,

        [string]$attribute12 ,

        [string]$attribute12expr ,

        [string]$attribute12friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute12format ,

        [string]$attribute13 ,

        [string]$attribute13expr ,

        [string]$attribute13friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute13format ,

        [string]$attribute14 ,

        [string]$attribute14expr ,

        [string]$attribute14friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute14format ,

        [string]$attribute15 ,

        [string]$attribute15expr ,

        [string]$attribute15friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute15format ,

        [string]$attribute16 ,

        [string]$attribute16expr ,

        [string]$attribute16friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute16format ,

        [ValidateSet('ON', 'OFF')]
        [string]$encryptassertion = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlspcertname ,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$encryptionalgorithm = 'AES256' ,

        [double]$skewtime = '5' ,

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$signassertion = 'ASSERTION' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsamlssoprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                assertionconsumerserviceurl = $assertionconsumerserviceurl
            }
            if ($PSBoundParameters.ContainsKey('samlsigningcertname')) { $Payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ($PSBoundParameters.ContainsKey('relaystaterule')) { $Payload.Add('relaystaterule', $relaystaterule) }
            if ($PSBoundParameters.ContainsKey('sendpassword')) { $Payload.Add('sendpassword', $sendpassword) }
            if ($PSBoundParameters.ContainsKey('samlissuername')) { $Payload.Add('samlissuername', $samlissuername) }
            if ($PSBoundParameters.ContainsKey('signaturealg')) { $Payload.Add('signaturealg', $signaturealg) }
            if ($PSBoundParameters.ContainsKey('digestmethod')) { $Payload.Add('digestmethod', $digestmethod) }
            if ($PSBoundParameters.ContainsKey('audience')) { $Payload.Add('audience', $audience) }
            if ($PSBoundParameters.ContainsKey('nameidformat')) { $Payload.Add('nameidformat', $nameidformat) }
            if ($PSBoundParameters.ContainsKey('nameidexpr')) { $Payload.Add('nameidexpr', $nameidexpr) }
            if ($PSBoundParameters.ContainsKey('attribute1')) { $Payload.Add('attribute1', $attribute1) }
            if ($PSBoundParameters.ContainsKey('attribute1expr')) { $Payload.Add('attribute1expr', $attribute1expr) }
            if ($PSBoundParameters.ContainsKey('attribute1friendlyname')) { $Payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute1format')) { $Payload.Add('attribute1format', $attribute1format) }
            if ($PSBoundParameters.ContainsKey('attribute2')) { $Payload.Add('attribute2', $attribute2) }
            if ($PSBoundParameters.ContainsKey('attribute2expr')) { $Payload.Add('attribute2expr', $attribute2expr) }
            if ($PSBoundParameters.ContainsKey('attribute2friendlyname')) { $Payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute2format')) { $Payload.Add('attribute2format', $attribute2format) }
            if ($PSBoundParameters.ContainsKey('attribute3')) { $Payload.Add('attribute3', $attribute3) }
            if ($PSBoundParameters.ContainsKey('attribute3expr')) { $Payload.Add('attribute3expr', $attribute3expr) }
            if ($PSBoundParameters.ContainsKey('attribute3friendlyname')) { $Payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute3format')) { $Payload.Add('attribute3format', $attribute3format) }
            if ($PSBoundParameters.ContainsKey('attribute4')) { $Payload.Add('attribute4', $attribute4) }
            if ($PSBoundParameters.ContainsKey('attribute4expr')) { $Payload.Add('attribute4expr', $attribute4expr) }
            if ($PSBoundParameters.ContainsKey('attribute4friendlyname')) { $Payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute4format')) { $Payload.Add('attribute4format', $attribute4format) }
            if ($PSBoundParameters.ContainsKey('attribute5')) { $Payload.Add('attribute5', $attribute5) }
            if ($PSBoundParameters.ContainsKey('attribute5expr')) { $Payload.Add('attribute5expr', $attribute5expr) }
            if ($PSBoundParameters.ContainsKey('attribute5friendlyname')) { $Payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute5format')) { $Payload.Add('attribute5format', $attribute5format) }
            if ($PSBoundParameters.ContainsKey('attribute6')) { $Payload.Add('attribute6', $attribute6) }
            if ($PSBoundParameters.ContainsKey('attribute6expr')) { $Payload.Add('attribute6expr', $attribute6expr) }
            if ($PSBoundParameters.ContainsKey('attribute6friendlyname')) { $Payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute6format')) { $Payload.Add('attribute6format', $attribute6format) }
            if ($PSBoundParameters.ContainsKey('attribute7')) { $Payload.Add('attribute7', $attribute7) }
            if ($PSBoundParameters.ContainsKey('attribute7expr')) { $Payload.Add('attribute7expr', $attribute7expr) }
            if ($PSBoundParameters.ContainsKey('attribute7friendlyname')) { $Payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute7format')) { $Payload.Add('attribute7format', $attribute7format) }
            if ($PSBoundParameters.ContainsKey('attribute8')) { $Payload.Add('attribute8', $attribute8) }
            if ($PSBoundParameters.ContainsKey('attribute8expr')) { $Payload.Add('attribute8expr', $attribute8expr) }
            if ($PSBoundParameters.ContainsKey('attribute8friendlyname')) { $Payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute8format')) { $Payload.Add('attribute8format', $attribute8format) }
            if ($PSBoundParameters.ContainsKey('attribute9')) { $Payload.Add('attribute9', $attribute9) }
            if ($PSBoundParameters.ContainsKey('attribute9expr')) { $Payload.Add('attribute9expr', $attribute9expr) }
            if ($PSBoundParameters.ContainsKey('attribute9friendlyname')) { $Payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute9format')) { $Payload.Add('attribute9format', $attribute9format) }
            if ($PSBoundParameters.ContainsKey('attribute10')) { $Payload.Add('attribute10', $attribute10) }
            if ($PSBoundParameters.ContainsKey('attribute10expr')) { $Payload.Add('attribute10expr', $attribute10expr) }
            if ($PSBoundParameters.ContainsKey('attribute10friendlyname')) { $Payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute10format')) { $Payload.Add('attribute10format', $attribute10format) }
            if ($PSBoundParameters.ContainsKey('attribute11')) { $Payload.Add('attribute11', $attribute11) }
            if ($PSBoundParameters.ContainsKey('attribute11expr')) { $Payload.Add('attribute11expr', $attribute11expr) }
            if ($PSBoundParameters.ContainsKey('attribute11friendlyname')) { $Payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute11format')) { $Payload.Add('attribute11format', $attribute11format) }
            if ($PSBoundParameters.ContainsKey('attribute12')) { $Payload.Add('attribute12', $attribute12) }
            if ($PSBoundParameters.ContainsKey('attribute12expr')) { $Payload.Add('attribute12expr', $attribute12expr) }
            if ($PSBoundParameters.ContainsKey('attribute12friendlyname')) { $Payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute12format')) { $Payload.Add('attribute12format', $attribute12format) }
            if ($PSBoundParameters.ContainsKey('attribute13')) { $Payload.Add('attribute13', $attribute13) }
            if ($PSBoundParameters.ContainsKey('attribute13expr')) { $Payload.Add('attribute13expr', $attribute13expr) }
            if ($PSBoundParameters.ContainsKey('attribute13friendlyname')) { $Payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute13format')) { $Payload.Add('attribute13format', $attribute13format) }
            if ($PSBoundParameters.ContainsKey('attribute14')) { $Payload.Add('attribute14', $attribute14) }
            if ($PSBoundParameters.ContainsKey('attribute14expr')) { $Payload.Add('attribute14expr', $attribute14expr) }
            if ($PSBoundParameters.ContainsKey('attribute14friendlyname')) { $Payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute14format')) { $Payload.Add('attribute14format', $attribute14format) }
            if ($PSBoundParameters.ContainsKey('attribute15')) { $Payload.Add('attribute15', $attribute15) }
            if ($PSBoundParameters.ContainsKey('attribute15expr')) { $Payload.Add('attribute15expr', $attribute15expr) }
            if ($PSBoundParameters.ContainsKey('attribute15friendlyname')) { $Payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute15format')) { $Payload.Add('attribute15format', $attribute15format) }
            if ($PSBoundParameters.ContainsKey('attribute16')) { $Payload.Add('attribute16', $attribute16) }
            if ($PSBoundParameters.ContainsKey('attribute16expr')) { $Payload.Add('attribute16expr', $attribute16expr) }
            if ($PSBoundParameters.ContainsKey('attribute16friendlyname')) { $Payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute16format')) { $Payload.Add('attribute16format', $attribute16format) }
            if ($PSBoundParameters.ContainsKey('encryptassertion')) { $Payload.Add('encryptassertion', $encryptassertion) }
            if ($PSBoundParameters.ContainsKey('samlspcertname')) { $Payload.Add('samlspcertname', $samlspcertname) }
            if ($PSBoundParameters.ContainsKey('encryptionalgorithm')) { $Payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ($PSBoundParameters.ContainsKey('skewtime')) { $Payload.Add('skewtime', $skewtime) }
            if ($PSBoundParameters.ContainsKey('signassertion')) { $Payload.Add('signassertion', $signassertion) }
 
            if ($PSCmdlet.ShouldProcess("tmsamlssoprofile", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsamlssoprofile -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmsamlssoprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmsamlssoprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        Write-Verbose "Invoke-ADCDeleteTmsamlssoprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER samlsigningcertname 
        Name of the SSL certificate that is used to Sign Assertion.  
        Minimum length = 1 
    .PARAMETER assertionconsumerserviceurl 
        URL to which the assertion is to be sent.  
        Minimum length = 1 
    .PARAMETER sendpassword 
        Option to send password in assertion.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER samlissuername 
        The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC.  
        Minimum length = 1 
    .PARAMETER relaystaterule 
        Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ  
        et url to which user is redirected after the recipient validates SAML token. 
    .PARAMETER signaturealg 
        Algorithm to be used to sign/verify SAML transactions.  
        Default value: RSA-SHA256  
        Possible values = RSA-SHA1, RSA-SHA256 
    .PARAMETER digestmethod 
        Algorithm to be used to compute/verify digest for SAML transactions.  
        Default value: SHA256  
        Possible values = SHA1, SHA256 
    .PARAMETER audience 
        Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
    .PARAMETER nameidformat 
        Format of Name Identifier sent in Assertion.  
        Default value: transient  
        Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
    .PARAMETER nameidexpr 
        Expression that will be evaluated to obtain NameIdentifier to be sent in assertion.  
        Maximum length = 128 
    .PARAMETER attribute1 
        Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute1expr 
        Expression that will be evaluated to obtain attribute1's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute1friendlyname 
        User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute1format 
        Format of Attribute1 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute2 
        Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute2expr 
        Expression that will be evaluated to obtain attribute2's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute2friendlyname 
        User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute2format 
        Format of Attribute2 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute3 
        Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute3expr 
        Expression that will be evaluated to obtain attribute3's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute3friendlyname 
        User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute3format 
        Format of Attribute3 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute4 
        Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute4expr 
        Expression that will be evaluated to obtain attribute4's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute4friendlyname 
        User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute4format 
        Format of Attribute4 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute5 
        Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute5expr 
        Expression that will be evaluated to obtain attribute5's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute5friendlyname 
        User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute5format 
        Format of Attribute5 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute6 
        Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute6expr 
        Expression that will be evaluated to obtain attribute6's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute6friendlyname 
        User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute6format 
        Format of Attribute6 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute7 
        Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute7expr 
        Expression that will be evaluated to obtain attribute7's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute7friendlyname 
        User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute7format 
        Format of Attribute7 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute8 
        Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute8expr 
        Expression that will be evaluated to obtain attribute8's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute8friendlyname 
        User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute8format 
        Format of Attribute8 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute9 
        Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute9expr 
        Expression that will be evaluated to obtain attribute9's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute9friendlyname 
        User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute9format 
        Format of Attribute9 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute10 
        Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute10expr 
        Expression that will be evaluated to obtain attribute10's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute10friendlyname 
        User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute10format 
        Format of Attribute10 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute11 
        Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute11expr 
        Expression that will be evaluated to obtain attribute11's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute11friendlyname 
        User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute11format 
        Format of Attribute11 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute12 
        Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute12expr 
        Expression that will be evaluated to obtain attribute12's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute12friendlyname 
        User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute12format 
        Format of Attribute12 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute13 
        Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute13expr 
        Expression that will be evaluated to obtain attribute13's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute13friendlyname 
        User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute13format 
        Format of Attribute13 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute14 
        Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute14expr 
        Expression that will be evaluated to obtain attribute14's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute14friendlyname 
        User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute14format 
        Format of Attribute14 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute15 
        Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute15expr 
        Expression that will be evaluated to obtain attribute15's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute15friendlyname 
        User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute15format 
        Format of Attribute15 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER attribute16 
        Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute16expr 
        Expression that will be evaluated to obtain attribute16's value to be sent in Assertion.  
        Maximum length = 128 
    .PARAMETER attribute16friendlyname 
        User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
    .PARAMETER attribute16format 
        Format of Attribute16 to be sent in Assertion.  
        Possible values = URI, Basic 
    .PARAMETER encryptassertion 
        Option to encrypt assertion when Citrix ADC sends one.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER samlspcertname 
        Name of the SSL certificate of peer/receving party using which Assertion is encrypted.  
        Minimum length = 1 
    .PARAMETER encryptionalgorithm 
        Algorithm to be used to encrypt SAML assertion.  
        Default value: AES256  
        Possible values = DES3, AES128, AES192, AES256 
    .PARAMETER skewtime 
        This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all.  
        Default value: 5 
    .PARAMETER signassertion 
        Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed.  
        Default value: ASSERTION  
        Possible values = NONE, ASSERTION, RESPONSE, BOTH 
    .PARAMETER PassThru 
        Return details about the created tmsamlssoprofile item.
    .EXAMPLE
        Invoke-ADCUpdateTmsamlssoprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmsamlssoprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        [string]$samlsigningcertname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$assertionconsumerserviceurl ,

        [ValidateSet('ON', 'OFF')]
        [string]$sendpassword ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlissuername ,

        [string]$relaystaterule ,

        [ValidateSet('RSA-SHA1', 'RSA-SHA256')]
        [string]$signaturealg ,

        [ValidateSet('SHA1', 'SHA256')]
        [string]$digestmethod ,

        [string]$audience ,

        [ValidateSet('Unspecified', 'emailAddress', 'X509SubjectName', 'WindowsDomainQualifiedName', 'kerberos', 'entity', 'persistent', 'transient')]
        [string]$nameidformat ,

        [string]$nameidexpr ,

        [string]$attribute1 ,

        [string]$attribute1expr ,

        [string]$attribute1friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute1format ,

        [string]$attribute2 ,

        [string]$attribute2expr ,

        [string]$attribute2friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute2format ,

        [string]$attribute3 ,

        [string]$attribute3expr ,

        [string]$attribute3friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute3format ,

        [string]$attribute4 ,

        [string]$attribute4expr ,

        [string]$attribute4friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute4format ,

        [string]$attribute5 ,

        [string]$attribute5expr ,

        [string]$attribute5friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute5format ,

        [string]$attribute6 ,

        [string]$attribute6expr ,

        [string]$attribute6friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute6format ,

        [string]$attribute7 ,

        [string]$attribute7expr ,

        [string]$attribute7friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute7format ,

        [string]$attribute8 ,

        [string]$attribute8expr ,

        [string]$attribute8friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute8format ,

        [string]$attribute9 ,

        [string]$attribute9expr ,

        [string]$attribute9friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute9format ,

        [string]$attribute10 ,

        [string]$attribute10expr ,

        [string]$attribute10friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute10format ,

        [string]$attribute11 ,

        [string]$attribute11expr ,

        [string]$attribute11friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute11format ,

        [string]$attribute12 ,

        [string]$attribute12expr ,

        [string]$attribute12friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute12format ,

        [string]$attribute13 ,

        [string]$attribute13expr ,

        [string]$attribute13friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute13format ,

        [string]$attribute14 ,

        [string]$attribute14expr ,

        [string]$attribute14friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute14format ,

        [string]$attribute15 ,

        [string]$attribute15expr ,

        [string]$attribute15friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute15format ,

        [string]$attribute16 ,

        [string]$attribute16expr ,

        [string]$attribute16friendlyname ,

        [ValidateSet('URI', 'Basic')]
        [string]$attribute16format ,

        [ValidateSet('ON', 'OFF')]
        [string]$encryptassertion ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlspcertname ,

        [ValidateSet('DES3', 'AES128', 'AES192', 'AES256')]
        [string]$encryptionalgorithm ,

        [double]$skewtime ,

        [ValidateSet('NONE', 'ASSERTION', 'RESPONSE', 'BOTH')]
        [string]$signassertion ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsamlssoprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('samlsigningcertname')) { $Payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ($PSBoundParameters.ContainsKey('assertionconsumerserviceurl')) { $Payload.Add('assertionconsumerserviceurl', $assertionconsumerserviceurl) }
            if ($PSBoundParameters.ContainsKey('sendpassword')) { $Payload.Add('sendpassword', $sendpassword) }
            if ($PSBoundParameters.ContainsKey('samlissuername')) { $Payload.Add('samlissuername', $samlissuername) }
            if ($PSBoundParameters.ContainsKey('relaystaterule')) { $Payload.Add('relaystaterule', $relaystaterule) }
            if ($PSBoundParameters.ContainsKey('signaturealg')) { $Payload.Add('signaturealg', $signaturealg) }
            if ($PSBoundParameters.ContainsKey('digestmethod')) { $Payload.Add('digestmethod', $digestmethod) }
            if ($PSBoundParameters.ContainsKey('audience')) { $Payload.Add('audience', $audience) }
            if ($PSBoundParameters.ContainsKey('nameidformat')) { $Payload.Add('nameidformat', $nameidformat) }
            if ($PSBoundParameters.ContainsKey('nameidexpr')) { $Payload.Add('nameidexpr', $nameidexpr) }
            if ($PSBoundParameters.ContainsKey('attribute1')) { $Payload.Add('attribute1', $attribute1) }
            if ($PSBoundParameters.ContainsKey('attribute1expr')) { $Payload.Add('attribute1expr', $attribute1expr) }
            if ($PSBoundParameters.ContainsKey('attribute1friendlyname')) { $Payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute1format')) { $Payload.Add('attribute1format', $attribute1format) }
            if ($PSBoundParameters.ContainsKey('attribute2')) { $Payload.Add('attribute2', $attribute2) }
            if ($PSBoundParameters.ContainsKey('attribute2expr')) { $Payload.Add('attribute2expr', $attribute2expr) }
            if ($PSBoundParameters.ContainsKey('attribute2friendlyname')) { $Payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute2format')) { $Payload.Add('attribute2format', $attribute2format) }
            if ($PSBoundParameters.ContainsKey('attribute3')) { $Payload.Add('attribute3', $attribute3) }
            if ($PSBoundParameters.ContainsKey('attribute3expr')) { $Payload.Add('attribute3expr', $attribute3expr) }
            if ($PSBoundParameters.ContainsKey('attribute3friendlyname')) { $Payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute3format')) { $Payload.Add('attribute3format', $attribute3format) }
            if ($PSBoundParameters.ContainsKey('attribute4')) { $Payload.Add('attribute4', $attribute4) }
            if ($PSBoundParameters.ContainsKey('attribute4expr')) { $Payload.Add('attribute4expr', $attribute4expr) }
            if ($PSBoundParameters.ContainsKey('attribute4friendlyname')) { $Payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute4format')) { $Payload.Add('attribute4format', $attribute4format) }
            if ($PSBoundParameters.ContainsKey('attribute5')) { $Payload.Add('attribute5', $attribute5) }
            if ($PSBoundParameters.ContainsKey('attribute5expr')) { $Payload.Add('attribute5expr', $attribute5expr) }
            if ($PSBoundParameters.ContainsKey('attribute5friendlyname')) { $Payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute5format')) { $Payload.Add('attribute5format', $attribute5format) }
            if ($PSBoundParameters.ContainsKey('attribute6')) { $Payload.Add('attribute6', $attribute6) }
            if ($PSBoundParameters.ContainsKey('attribute6expr')) { $Payload.Add('attribute6expr', $attribute6expr) }
            if ($PSBoundParameters.ContainsKey('attribute6friendlyname')) { $Payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute6format')) { $Payload.Add('attribute6format', $attribute6format) }
            if ($PSBoundParameters.ContainsKey('attribute7')) { $Payload.Add('attribute7', $attribute7) }
            if ($PSBoundParameters.ContainsKey('attribute7expr')) { $Payload.Add('attribute7expr', $attribute7expr) }
            if ($PSBoundParameters.ContainsKey('attribute7friendlyname')) { $Payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute7format')) { $Payload.Add('attribute7format', $attribute7format) }
            if ($PSBoundParameters.ContainsKey('attribute8')) { $Payload.Add('attribute8', $attribute8) }
            if ($PSBoundParameters.ContainsKey('attribute8expr')) { $Payload.Add('attribute8expr', $attribute8expr) }
            if ($PSBoundParameters.ContainsKey('attribute8friendlyname')) { $Payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute8format')) { $Payload.Add('attribute8format', $attribute8format) }
            if ($PSBoundParameters.ContainsKey('attribute9')) { $Payload.Add('attribute9', $attribute9) }
            if ($PSBoundParameters.ContainsKey('attribute9expr')) { $Payload.Add('attribute9expr', $attribute9expr) }
            if ($PSBoundParameters.ContainsKey('attribute9friendlyname')) { $Payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute9format')) { $Payload.Add('attribute9format', $attribute9format) }
            if ($PSBoundParameters.ContainsKey('attribute10')) { $Payload.Add('attribute10', $attribute10) }
            if ($PSBoundParameters.ContainsKey('attribute10expr')) { $Payload.Add('attribute10expr', $attribute10expr) }
            if ($PSBoundParameters.ContainsKey('attribute10friendlyname')) { $Payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute10format')) { $Payload.Add('attribute10format', $attribute10format) }
            if ($PSBoundParameters.ContainsKey('attribute11')) { $Payload.Add('attribute11', $attribute11) }
            if ($PSBoundParameters.ContainsKey('attribute11expr')) { $Payload.Add('attribute11expr', $attribute11expr) }
            if ($PSBoundParameters.ContainsKey('attribute11friendlyname')) { $Payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute11format')) { $Payload.Add('attribute11format', $attribute11format) }
            if ($PSBoundParameters.ContainsKey('attribute12')) { $Payload.Add('attribute12', $attribute12) }
            if ($PSBoundParameters.ContainsKey('attribute12expr')) { $Payload.Add('attribute12expr', $attribute12expr) }
            if ($PSBoundParameters.ContainsKey('attribute12friendlyname')) { $Payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute12format')) { $Payload.Add('attribute12format', $attribute12format) }
            if ($PSBoundParameters.ContainsKey('attribute13')) { $Payload.Add('attribute13', $attribute13) }
            if ($PSBoundParameters.ContainsKey('attribute13expr')) { $Payload.Add('attribute13expr', $attribute13expr) }
            if ($PSBoundParameters.ContainsKey('attribute13friendlyname')) { $Payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute13format')) { $Payload.Add('attribute13format', $attribute13format) }
            if ($PSBoundParameters.ContainsKey('attribute14')) { $Payload.Add('attribute14', $attribute14) }
            if ($PSBoundParameters.ContainsKey('attribute14expr')) { $Payload.Add('attribute14expr', $attribute14expr) }
            if ($PSBoundParameters.ContainsKey('attribute14friendlyname')) { $Payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute14format')) { $Payload.Add('attribute14format', $attribute14format) }
            if ($PSBoundParameters.ContainsKey('attribute15')) { $Payload.Add('attribute15', $attribute15) }
            if ($PSBoundParameters.ContainsKey('attribute15expr')) { $Payload.Add('attribute15expr', $attribute15expr) }
            if ($PSBoundParameters.ContainsKey('attribute15friendlyname')) { $Payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute15format')) { $Payload.Add('attribute15format', $attribute15format) }
            if ($PSBoundParameters.ContainsKey('attribute16')) { $Payload.Add('attribute16', $attribute16) }
            if ($PSBoundParameters.ContainsKey('attribute16expr')) { $Payload.Add('attribute16expr', $attribute16expr) }
            if ($PSBoundParameters.ContainsKey('attribute16friendlyname')) { $Payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute16format')) { $Payload.Add('attribute16format', $attribute16format) }
            if ($PSBoundParameters.ContainsKey('encryptassertion')) { $Payload.Add('encryptassertion', $encryptassertion) }
            if ($PSBoundParameters.ContainsKey('samlspcertname')) { $Payload.Add('samlspcertname', $samlspcertname) }
            if ($PSBoundParameters.ContainsKey('encryptionalgorithm')) { $Payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ($PSBoundParameters.ContainsKey('skewtime')) { $Payload.Add('skewtime', $skewtime) }
            if ($PSBoundParameters.ContainsKey('signassertion')) { $Payload.Add('signassertion', $signassertion) }
 
            if ($PSCmdlet.ShouldProcess("tmsamlssoprofile", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsamlssoprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsamlssoprofile -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
   .PARAMETER samlsigningcertname 
       Name of the SSL certificate that is used to Sign Assertion. 
   .PARAMETER sendpassword 
       Option to send password in assertion.  
       Possible values = ON, OFF 
   .PARAMETER samlissuername 
       The name to be used in requests sent from Citrix ADC to IdP to uniquely identify Citrix ADC. 
   .PARAMETER relaystaterule 
       Expression to extract relaystate to be sent along with assertion. Evaluation of this expression should return TEXT content. This is typically a targ  
       et url to which user is redirected after the recipient validates SAML token. 
   .PARAMETER signaturealg 
       Algorithm to be used to sign/verify SAML transactions.  
       Possible values = RSA-SHA1, RSA-SHA256 
   .PARAMETER digestmethod 
       Algorithm to be used to compute/verify digest for SAML transactions.  
       Possible values = SHA1, SHA256 
   .PARAMETER audience 
       Audience for which assertion sent by IdP is applicable. This is typically entity name or url that represents ServiceProvider. 
   .PARAMETER nameidformat 
       Format of Name Identifier sent in Assertion.  
       Possible values = Unspecified, emailAddress, X509SubjectName, WindowsDomainQualifiedName, kerberos, entity, persistent, transient 
   .PARAMETER nameidexpr 
       Expression that will be evaluated to obtain NameIdentifier to be sent in assertion. 
   .PARAMETER attribute1 
       Name of attribute1 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute1friendlyname 
       User-Friendly Name of attribute1 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute1format 
       Format of Attribute1 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute2 
       Name of attribute2 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute2friendlyname 
       User-Friendly Name of attribute2 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute2format 
       Format of Attribute2 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute3 
       Name of attribute3 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute3friendlyname 
       User-Friendly Name of attribute3 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute3format 
       Format of Attribute3 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute4 
       Name of attribute4 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute4friendlyname 
       User-Friendly Name of attribute4 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute4format 
       Format of Attribute4 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute5 
       Name of attribute5 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute5friendlyname 
       User-Friendly Name of attribute5 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute5format 
       Format of Attribute5 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute6 
       Name of attribute6 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute6friendlyname 
       User-Friendly Name of attribute6 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute6format 
       Format of Attribute6 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute7 
       Name of attribute7 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute7friendlyname 
       User-Friendly Name of attribute7 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute7format 
       Format of Attribute7 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute8 
       Name of attribute8 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute8friendlyname 
       User-Friendly Name of attribute8 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute8format 
       Format of Attribute8 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute9 
       Name of attribute9 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute9friendlyname 
       User-Friendly Name of attribute9 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute9format 
       Format of Attribute9 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute10 
       Name of attribute10 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute10friendlyname 
       User-Friendly Name of attribute10 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute10format 
       Format of Attribute10 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute11 
       Name of attribute11 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute11friendlyname 
       User-Friendly Name of attribute11 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute11format 
       Format of Attribute11 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute12 
       Name of attribute12 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute12friendlyname 
       User-Friendly Name of attribute12 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute12format 
       Format of Attribute12 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute13 
       Name of attribute13 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute13friendlyname 
       User-Friendly Name of attribute13 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute13format 
       Format of Attribute13 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute14 
       Name of attribute14 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute14friendlyname 
       User-Friendly Name of attribute14 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute14format 
       Format of Attribute14 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute15 
       Name of attribute15 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute15friendlyname 
       User-Friendly Name of attribute15 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute15format 
       Format of Attribute15 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER attribute16 
       Name of attribute16 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute16friendlyname 
       User-Friendly Name of attribute16 that needs to be sent in SAML Assertion. 
   .PARAMETER attribute16format 
       Format of Attribute16 to be sent in Assertion.  
       Possible values = URI, Basic 
   .PARAMETER encryptassertion 
       Option to encrypt assertion when Citrix ADC sends one.  
       Possible values = ON, OFF 
   .PARAMETER samlspcertname 
       Name of the SSL certificate of peer/receving party using which Assertion is encrypted. 
   .PARAMETER encryptionalgorithm 
       Algorithm to be used to encrypt SAML assertion.  
       Possible values = DES3, AES128, AES192, AES256 
   .PARAMETER skewtime 
       This option specifies the number of minutes on either side of current time that the assertion would be valid. For example, if skewTime is 10, then assertion would be valid from (current time - 10) min to (current time + 10) min, ie 20min in all. 
   .PARAMETER signassertion 
       Option to sign portions of assertion when Citrix ADC IDP sends one. Based on the user selection, either Assertion or Response or Both or none can be signed.  
       Possible values = NONE, ASSERTION, RESPONSE, BOTH
    .EXAMPLE
        Invoke-ADCUnsetTmsamlssoprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmsamlssoprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile
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

        [Boolean]$samlsigningcertname ,

        [Boolean]$sendpassword ,

        [Boolean]$samlissuername ,

        [Boolean]$relaystaterule ,

        [Boolean]$signaturealg ,

        [Boolean]$digestmethod ,

        [Boolean]$audience ,

        [Boolean]$nameidformat ,

        [Boolean]$nameidexpr ,

        [Boolean]$attribute1 ,

        [Boolean]$attribute1friendlyname ,

        [Boolean]$attribute1format ,

        [Boolean]$attribute2 ,

        [Boolean]$attribute2friendlyname ,

        [Boolean]$attribute2format ,

        [Boolean]$attribute3 ,

        [Boolean]$attribute3friendlyname ,

        [Boolean]$attribute3format ,

        [Boolean]$attribute4 ,

        [Boolean]$attribute4friendlyname ,

        [Boolean]$attribute4format ,

        [Boolean]$attribute5 ,

        [Boolean]$attribute5friendlyname ,

        [Boolean]$attribute5format ,

        [Boolean]$attribute6 ,

        [Boolean]$attribute6friendlyname ,

        [Boolean]$attribute6format ,

        [Boolean]$attribute7 ,

        [Boolean]$attribute7friendlyname ,

        [Boolean]$attribute7format ,

        [Boolean]$attribute8 ,

        [Boolean]$attribute8friendlyname ,

        [Boolean]$attribute8format ,

        [Boolean]$attribute9 ,

        [Boolean]$attribute9friendlyname ,

        [Boolean]$attribute9format ,

        [Boolean]$attribute10 ,

        [Boolean]$attribute10friendlyname ,

        [Boolean]$attribute10format ,

        [Boolean]$attribute11 ,

        [Boolean]$attribute11friendlyname ,

        [Boolean]$attribute11format ,

        [Boolean]$attribute12 ,

        [Boolean]$attribute12friendlyname ,

        [Boolean]$attribute12format ,

        [Boolean]$attribute13 ,

        [Boolean]$attribute13friendlyname ,

        [Boolean]$attribute13format ,

        [Boolean]$attribute14 ,

        [Boolean]$attribute14friendlyname ,

        [Boolean]$attribute14format ,

        [Boolean]$attribute15 ,

        [Boolean]$attribute15friendlyname ,

        [Boolean]$attribute15format ,

        [Boolean]$attribute16 ,

        [Boolean]$attribute16friendlyname ,

        [Boolean]$attribute16format ,

        [Boolean]$encryptassertion ,

        [Boolean]$samlspcertname ,

        [Boolean]$encryptionalgorithm ,

        [Boolean]$skewtime ,

        [Boolean]$signassertion 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsamlssoprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('samlsigningcertname')) { $Payload.Add('samlsigningcertname', $samlsigningcertname) }
            if ($PSBoundParameters.ContainsKey('sendpassword')) { $Payload.Add('sendpassword', $sendpassword) }
            if ($PSBoundParameters.ContainsKey('samlissuername')) { $Payload.Add('samlissuername', $samlissuername) }
            if ($PSBoundParameters.ContainsKey('relaystaterule')) { $Payload.Add('relaystaterule', $relaystaterule) }
            if ($PSBoundParameters.ContainsKey('signaturealg')) { $Payload.Add('signaturealg', $signaturealg) }
            if ($PSBoundParameters.ContainsKey('digestmethod')) { $Payload.Add('digestmethod', $digestmethod) }
            if ($PSBoundParameters.ContainsKey('audience')) { $Payload.Add('audience', $audience) }
            if ($PSBoundParameters.ContainsKey('nameidformat')) { $Payload.Add('nameidformat', $nameidformat) }
            if ($PSBoundParameters.ContainsKey('nameidexpr')) { $Payload.Add('nameidexpr', $nameidexpr) }
            if ($PSBoundParameters.ContainsKey('attribute1')) { $Payload.Add('attribute1', $attribute1) }
            if ($PSBoundParameters.ContainsKey('attribute1friendlyname')) { $Payload.Add('attribute1friendlyname', $attribute1friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute1format')) { $Payload.Add('attribute1format', $attribute1format) }
            if ($PSBoundParameters.ContainsKey('attribute2')) { $Payload.Add('attribute2', $attribute2) }
            if ($PSBoundParameters.ContainsKey('attribute2friendlyname')) { $Payload.Add('attribute2friendlyname', $attribute2friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute2format')) { $Payload.Add('attribute2format', $attribute2format) }
            if ($PSBoundParameters.ContainsKey('attribute3')) { $Payload.Add('attribute3', $attribute3) }
            if ($PSBoundParameters.ContainsKey('attribute3friendlyname')) { $Payload.Add('attribute3friendlyname', $attribute3friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute3format')) { $Payload.Add('attribute3format', $attribute3format) }
            if ($PSBoundParameters.ContainsKey('attribute4')) { $Payload.Add('attribute4', $attribute4) }
            if ($PSBoundParameters.ContainsKey('attribute4friendlyname')) { $Payload.Add('attribute4friendlyname', $attribute4friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute4format')) { $Payload.Add('attribute4format', $attribute4format) }
            if ($PSBoundParameters.ContainsKey('attribute5')) { $Payload.Add('attribute5', $attribute5) }
            if ($PSBoundParameters.ContainsKey('attribute5friendlyname')) { $Payload.Add('attribute5friendlyname', $attribute5friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute5format')) { $Payload.Add('attribute5format', $attribute5format) }
            if ($PSBoundParameters.ContainsKey('attribute6')) { $Payload.Add('attribute6', $attribute6) }
            if ($PSBoundParameters.ContainsKey('attribute6friendlyname')) { $Payload.Add('attribute6friendlyname', $attribute6friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute6format')) { $Payload.Add('attribute6format', $attribute6format) }
            if ($PSBoundParameters.ContainsKey('attribute7')) { $Payload.Add('attribute7', $attribute7) }
            if ($PSBoundParameters.ContainsKey('attribute7friendlyname')) { $Payload.Add('attribute7friendlyname', $attribute7friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute7format')) { $Payload.Add('attribute7format', $attribute7format) }
            if ($PSBoundParameters.ContainsKey('attribute8')) { $Payload.Add('attribute8', $attribute8) }
            if ($PSBoundParameters.ContainsKey('attribute8friendlyname')) { $Payload.Add('attribute8friendlyname', $attribute8friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute8format')) { $Payload.Add('attribute8format', $attribute8format) }
            if ($PSBoundParameters.ContainsKey('attribute9')) { $Payload.Add('attribute9', $attribute9) }
            if ($PSBoundParameters.ContainsKey('attribute9friendlyname')) { $Payload.Add('attribute9friendlyname', $attribute9friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute9format')) { $Payload.Add('attribute9format', $attribute9format) }
            if ($PSBoundParameters.ContainsKey('attribute10')) { $Payload.Add('attribute10', $attribute10) }
            if ($PSBoundParameters.ContainsKey('attribute10friendlyname')) { $Payload.Add('attribute10friendlyname', $attribute10friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute10format')) { $Payload.Add('attribute10format', $attribute10format) }
            if ($PSBoundParameters.ContainsKey('attribute11')) { $Payload.Add('attribute11', $attribute11) }
            if ($PSBoundParameters.ContainsKey('attribute11friendlyname')) { $Payload.Add('attribute11friendlyname', $attribute11friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute11format')) { $Payload.Add('attribute11format', $attribute11format) }
            if ($PSBoundParameters.ContainsKey('attribute12')) { $Payload.Add('attribute12', $attribute12) }
            if ($PSBoundParameters.ContainsKey('attribute12friendlyname')) { $Payload.Add('attribute12friendlyname', $attribute12friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute12format')) { $Payload.Add('attribute12format', $attribute12format) }
            if ($PSBoundParameters.ContainsKey('attribute13')) { $Payload.Add('attribute13', $attribute13) }
            if ($PSBoundParameters.ContainsKey('attribute13friendlyname')) { $Payload.Add('attribute13friendlyname', $attribute13friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute13format')) { $Payload.Add('attribute13format', $attribute13format) }
            if ($PSBoundParameters.ContainsKey('attribute14')) { $Payload.Add('attribute14', $attribute14) }
            if ($PSBoundParameters.ContainsKey('attribute14friendlyname')) { $Payload.Add('attribute14friendlyname', $attribute14friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute14format')) { $Payload.Add('attribute14format', $attribute14format) }
            if ($PSBoundParameters.ContainsKey('attribute15')) { $Payload.Add('attribute15', $attribute15) }
            if ($PSBoundParameters.ContainsKey('attribute15friendlyname')) { $Payload.Add('attribute15friendlyname', $attribute15friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute15format')) { $Payload.Add('attribute15format', $attribute15format) }
            if ($PSBoundParameters.ContainsKey('attribute16')) { $Payload.Add('attribute16', $attribute16) }
            if ($PSBoundParameters.ContainsKey('attribute16friendlyname')) { $Payload.Add('attribute16friendlyname', $attribute16friendlyname) }
            if ($PSBoundParameters.ContainsKey('attribute16format')) { $Payload.Add('attribute16format', $attribute16format) }
            if ($PSBoundParameters.ContainsKey('encryptassertion')) { $Payload.Add('encryptassertion', $encryptassertion) }
            if ($PSBoundParameters.ContainsKey('samlspcertname')) { $Payload.Add('samlspcertname', $samlspcertname) }
            if ($PSBoundParameters.ContainsKey('encryptionalgorithm')) { $Payload.Add('encryptionalgorithm', $encryptionalgorithm) }
            if ($PSBoundParameters.ContainsKey('skewtime')) { $Payload.Add('skewtime', $skewtime) }
            if ($PSBoundParameters.ContainsKey('signassertion')) { $Payload.Add('signassertion', $signassertion) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsamlssoprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the new saml single sign-on profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after an SSO action is created. 
    .PARAMETER GetAll 
        Retreive all tmsamlssoprofile object(s)
    .PARAMETER Count
        If specified, the count of the tmsamlssoprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsamlssoprofile
    .EXAMPLE 
        Invoke-ADCGetTmsamlssoprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsamlssoprofile -Count
    .EXAMPLE
        Invoke-ADCGetTmsamlssoprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsamlssoprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsamlssoprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsamlssoprofile/
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
        Write-Verbose "Invoke-ADCGetTmsamlssoprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmsamlssoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsamlssoprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsamlssoprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsamlssoprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsamlssoprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsamlssoprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources.  
        Minimum value = 1 
    .PARAMETER defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy.  
        Possible values = ALLOW, DENY 
    .PARAMETER sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO).  
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER ssodomain 
        Domain to use for single sign-on (SSO).  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER kcdaccount 
        Kerberos constrained delegation account name.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF.  
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity.  
        Possible values = ON, OFF 
    .PARAMETER persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled.  
        Minimum value = 1 
    .PARAMETER homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        Invoke-ADCAddTmsessionaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddTmsessionaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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

        [double]$sesstimeout ,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$defaultauthorizationaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$sso = 'OFF' ,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$ssocredential ,

        [ValidateLength(1, 32)]
        [string]$ssodomain ,

        [ValidateSet('YES', 'NO')]
        [string]$httponlycookie = 'YES' ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateSet('ON', 'OFF')]
        [string]$persistentcookie ,

        [double]$persistentcookievalidity ,

        [string]$homepage ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsessionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('defaultauthorizationaction')) { $Payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('ssocredential')) { $Payload.Add('ssocredential', $ssocredential) }
            if ($PSBoundParameters.ContainsKey('ssodomain')) { $Payload.Add('ssodomain', $ssodomain) }
            if ($PSBoundParameters.ContainsKey('httponlycookie')) { $Payload.Add('httponlycookie', $httponlycookie) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookievalidity')) { $Payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ($PSBoundParameters.ContainsKey('homepage')) { $Payload.Add('homepage', $homepage) }
 
            if ($PSCmdlet.ShouldProcess("tmsessionaction", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsessionaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsessionaction -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmsessionaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmsessionaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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
        Write-Verbose "Invoke-ADCDeleteTmsessionaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources.  
        Minimum value = 1 
    .PARAMETER defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy.  
        Possible values = ALLOW, DENY 
    .PARAMETER sso 
        Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER ssocredential 
        Use the primary or secondary authentication credentials for single sign-on (SSO).  
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER ssodomain 
        Domain to use for single sign-on (SSO).  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER kcdaccount 
        Kerberos constrained delegation account name.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER persistentcookie 
        Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF.  
        Note: If persistent cookie is enabled, make sure you set the persistent cookie validity.  
        Possible values = ON, OFF 
    .PARAMETER persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled.  
        Minimum value = 1 
    .PARAMETER homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
    .PARAMETER PassThru 
        Return details about the created tmsessionaction item.
    .EXAMPLE
        Invoke-ADCUpdateTmsessionaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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

        [double]$sesstimeout ,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$defaultauthorizationaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$sso ,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$ssocredential ,

        [ValidateLength(1, 32)]
        [string]$ssodomain ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateSet('YES', 'NO')]
        [string]$httponlycookie ,

        [ValidateSet('ON', 'OFF')]
        [string]$persistentcookie ,

        [double]$persistentcookievalidity ,

        [string]$homepage ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('defaultauthorizationaction')) { $Payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('ssocredential')) { $Payload.Add('ssocredential', $ssocredential) }
            if ($PSBoundParameters.ContainsKey('ssodomain')) { $Payload.Add('ssodomain', $ssodomain) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('httponlycookie')) { $Payload.Add('httponlycookie', $httponlycookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookievalidity')) { $Payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ($PSBoundParameters.ContainsKey('homepage')) { $Payload.Add('homepage', $homepage) }
 
            if ($PSCmdlet.ShouldProcess("tmsessionaction", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsessionaction -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
   .PARAMETER sesstimeout 
       Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access intranet resources. 
   .PARAMETER defaultauthorizationaction 
       Allow or deny access to content for which there is no specific authorization policy.  
       Possible values = ALLOW, DENY 
   .PARAMETER sso 
       Use single sign-on (SSO) to log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate to each application individually.  
       Possible values = ON, OFF 
   .PARAMETER ssocredential 
       Use the primary or secondary authentication credentials for single sign-on (SSO).  
       Possible values = PRIMARY, SECONDARY 
   .PARAMETER ssodomain 
       Domain to use for single sign-on (SSO). 
   .PARAMETER kcdaccount 
       Kerberos constrained delegation account name. 
   .PARAMETER httponlycookie 
       Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts.  
       Possible values = YES, NO 
   .PARAMETER persistentcookie 
       Enable or disable persistent SSO cookies for the traffic management (TM) session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends. This setting is overwritten if a traffic action sets persistent cookie to OFF.  
       Note: If persistent cookie is enabled, make sure you set the persistent cookie validity.  
       Possible values = ON, OFF 
   .PARAMETER persistentcookievalidity 
       Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistent cookie setting is enabled. 
   .PARAMETER homepage 
       Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.
    .EXAMPLE
        Invoke-ADCUnsetTmsessionaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction
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

        [Boolean]$sesstimeout ,

        [Boolean]$defaultauthorizationaction ,

        [Boolean]$sso ,

        [Boolean]$ssocredential ,

        [Boolean]$ssodomain ,

        [Boolean]$kcdaccount ,

        [Boolean]$httponlycookie ,

        [Boolean]$persistentcookie ,

        [Boolean]$persistentcookievalidity ,

        [Boolean]$homepage 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('defaultauthorizationaction')) { $Payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('ssocredential')) { $Payload.Add('ssocredential', $ssocredential) }
            if ($PSBoundParameters.ContainsKey('ssodomain')) { $Payload.Add('ssodomain', $ssodomain) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('httponlycookie')) { $Payload.Add('httponlycookie', $httponlycookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookievalidity')) { $Payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ($PSBoundParameters.ContainsKey('homepage')) { $Payload.Add('homepage', $homepage) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the session action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a session action is created. 
    .PARAMETER GetAll 
        Retreive all tmsessionaction object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionaction
    .EXAMPLE 
        Invoke-ADCGetTmsessionaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionaction -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionaction -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionaction/
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
        Write-Verbose "Invoke-ADCGetTmsessionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmsessionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER sesstimeout 
        Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources.  
        Default value: 30  
        Minimum value = 1 
    .PARAMETER defaultauthorizationaction 
        Allow or deny access to content for which there is no specific authorization policy.  
        Default value: DENY  
        Possible values = ALLOW, DENY 
    .PARAMETER sso 
        Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER ssocredential 
        Use primary or secondary authentication credentials for single sign-on.  
        Default value: PRIMARY  
        Possible values = PRIMARY, SECONDARY 
    .PARAMETER ssodomain 
        Domain to use for single sign-on.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER kcdaccount 
        Kerberos constrained delegation account name.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER httponlycookie 
        Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER persistentcookie 
        Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER persistentcookievalidity 
        Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled.  
        Minimum value = 1 
    .PARAMETER homepage 
        Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login.  
        Default value: "None"
    .EXAMPLE
        Invoke-ADCUpdateTmsessionparameter 
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter/
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

        [double]$sesstimeout ,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$defaultauthorizationaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$sso ,

        [ValidateSet('PRIMARY', 'SECONDARY')]
        [string]$ssocredential ,

        [ValidateLength(1, 32)]
        [string]$ssodomain ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateSet('YES', 'NO')]
        [string]$httponlycookie ,

        [ValidateSet('ON', 'OFF')]
        [string]$persistentcookie ,

        [double]$persistentcookievalidity ,

        [string]$homepage 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('defaultauthorizationaction')) { $Payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('ssocredential')) { $Payload.Add('ssocredential', $ssocredential) }
            if ($PSBoundParameters.ContainsKey('ssodomain')) { $Payload.Add('ssodomain', $ssodomain) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('httponlycookie')) { $Payload.Add('httponlycookie', $httponlycookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookievalidity')) { $Payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ($PSBoundParameters.ContainsKey('homepage')) { $Payload.Add('homepage', $homepage) }
 
            if ($PSCmdlet.ShouldProcess("tmsessionparameter", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionparameter -Payload $Payload -GetWarning
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER sesstimeout 
       Session timeout, in minutes. If there is no traffic during the timeout period, the user is disconnected and must reauthenticate to access the intranet resources. 
   .PARAMETER sso 
       Log users on to all web applications automatically after they authenticate, or pass users to the web application logon page to authenticate for each application.  
       Possible values = ON, OFF 
   .PARAMETER ssodomain 
       Domain to use for single sign-on. 
   .PARAMETER kcdaccount 
       Kerberos constrained delegation account name. 
   .PARAMETER persistentcookie 
       Use persistent SSO cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends.  
       Possible values = ON, OFF 
   .PARAMETER homepage 
       Web address of the home page that a user is displayed when authentication vserver is bookmarked and used to login. 
   .PARAMETER defaultauthorizationaction 
       Allow or deny access to content for which there is no specific authorization policy.  
       Possible values = ALLOW, DENY 
   .PARAMETER ssocredential 
       Use primary or secondary authentication credentials for single sign-on.  
       Possible values = PRIMARY, SECONDARY 
   .PARAMETER httponlycookie 
       Allow only an HTTP session cookie, in which case the cookie cannot be accessed by scripts.  
       Possible values = YES, NO 
   .PARAMETER persistentcookievalidity 
       Integer specifying the number of minutes for which the persistent cookie remains valid. Can be set only if the persistence cookie setting is enabled.
    .EXAMPLE
        Invoke-ADCUnsetTmsessionparameter 
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter
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

        [Boolean]$sesstimeout ,

        [Boolean]$sso ,

        [Boolean]$ssodomain ,

        [Boolean]$kcdaccount ,

        [Boolean]$persistentcookie ,

        [Boolean]$homepage ,

        [Boolean]$defaultauthorizationaction ,

        [Boolean]$ssocredential ,

        [Boolean]$httponlycookie ,

        [Boolean]$persistentcookievalidity 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sesstimeout')) { $Payload.Add('sesstimeout', $sesstimeout) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('ssodomain')) { $Payload.Add('ssodomain', $ssodomain) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('homepage')) { $Payload.Add('homepage', $homepage) }
            if ($PSBoundParameters.ContainsKey('defaultauthorizationaction')) { $Payload.Add('defaultauthorizationaction', $defaultauthorizationaction) }
            if ($PSBoundParameters.ContainsKey('ssocredential')) { $Payload.Add('ssocredential', $ssocredential) }
            if ($PSBoundParameters.ContainsKey('httponlycookie')) { $Payload.Add('httponlycookie', $httponlycookie) }
            if ($PSBoundParameters.ContainsKey('persistentcookievalidity')) { $Payload.Add('persistentcookievalidity', $persistentcookievalidity) }
            if ($PSCmdlet.ShouldProcess("tmsessionparameter", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER GetAll 
        Retreive all tmsessionparameter object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionparameter
    .EXAMPLE 
        Invoke-ADCGetTmsessionparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetTmsessionparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionparameter/
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
        Write-Verbose "Invoke-ADCGetTmsessionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmsessionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving tmsessionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Action to be applied to connections that match this policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        Invoke-ADCAddTmsessionpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddTmsessionpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmsessionpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("tmsessionpolicy", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsessionpolicy -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmsessionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmsessionpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        Write-Verbose "Invoke-ADCDeleteTmsessionpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER rule 
        Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Action to be applied to connections that match this policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created tmsessionpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateTmsessionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmsessionpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmsessionpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("tmsessionpolicy", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmsessionpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmsessionpolicy -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
   .PARAMETER rule 
       Expression, against which traffic is evaluated. Both classic and advance expressions are supported in default partition but only advance expressions in non-default partition.  
       The following requirements apply only to the Citrix ADC CLI:  
       * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
       * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
       * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
   .PARAMETER action 
       Action to be applied to connections that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetTmsessionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmsessionpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy
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

        [Boolean]$rule ,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmsessionpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmsessionpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the session policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a session policy is created. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicy
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicy -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmsessionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy_aaagroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaagroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaagroupbinding
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyaaagroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyaaagroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaagroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyaaagroupbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy_aaauser_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_aaauser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaauserbinding
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyaaauserbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyaaauserbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaauserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyaaauserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyaaauserbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy_authenticationvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_authenticationvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the session policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmsessionpolicy_tmglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmsessionpolicy_tmglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicytmglobalbinding
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicytmglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmsessionpolicytmglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicytmglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmsessionpolicytmglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmsessionpolicytmglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmsessionpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmsessionpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmsessionpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmsessionpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmsessionpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed.  
        Minimum value = 1  
        Maximum value = 715827 
    .PARAMETER sso 
        Use single sign-on for the resource that the user is accessing now.  
        Possible values = ON, OFF 
    .PARAMETER formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends.  
        Possible values = ON, OFF 
    .PARAMETER initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes.  
        Possible values = ON, OFF 
    .PARAMETER kcdaccount 
        Kerberos constrained delegation account name.  
        Default value: "None"  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party.  
        Minimum length = 1 
    .PARAMETER forcedtimeout 
        Setting to start, stop or reset TM session force timer.  
        Possible values = START, STOP, RESET 
    .PARAMETER forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER userexpression 
        expression that will be evaluated to obtain username for SingleSignOn.  
        Maximum length = 256 
    .PARAMETER passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn.  
        Maximum length = 256 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        Invoke-ADCAddTmtrafficaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddTmtrafficaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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

        [ValidateRange(1, 715827)]
        [double]$apptimeout ,

        [ValidateSet('ON', 'OFF')]
        [string]$sso ,

        [string]$formssoaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$persistentcookie ,

        [ValidateSet('ON', 'OFF')]
        [string]$initiatelogout ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount = '"None"' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlssoprofile ,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$forcedtimeout ,

        [double]$forcedtimeoutval ,

        [string]$userexpression ,

        [string]$passwdexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmtrafficaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('apptimeout')) { $Payload.Add('apptimeout', $apptimeout) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('formssoaction')) { $Payload.Add('formssoaction', $formssoaction) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('initiatelogout')) { $Payload.Add('initiatelogout', $initiatelogout) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('samlssoprofile')) { $Payload.Add('samlssoprofile', $samlssoprofile) }
            if ($PSBoundParameters.ContainsKey('forcedtimeout')) { $Payload.Add('forcedtimeout', $forcedtimeout) }
            if ($PSBoundParameters.ContainsKey('forcedtimeoutval')) { $Payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ($PSBoundParameters.ContainsKey('userexpression')) { $Payload.Add('userexpression', $userexpression) }
            if ($PSBoundParameters.ContainsKey('passwdexpression')) { $Payload.Add('passwdexpression', $passwdexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmtrafficaction", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmtrafficaction -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmtrafficaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmtrafficaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER apptimeout 
        Time interval, in minutes, of user inactivity after which the connection is closed.  
        Minimum value = 1  
        Maximum value = 715827 
    .PARAMETER sso 
        Use single sign-on for the resource that the user is accessing now.  
        Possible values = ON, OFF 
    .PARAMETER formssoaction 
        Name of the configured form-based single sign-on profile. 
    .PARAMETER persistentcookie 
        Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends.  
        Possible values = ON, OFF 
    .PARAMETER initiatelogout 
        Initiate logout for the traffic management (TM) session if the policy evaluates to true. The session is then terminated after two minutes.  
        Possible values = ON, OFF 
    .PARAMETER kcdaccount 
        Kerberos constrained delegation account name.  
        Default value: "None"  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER samlssoprofile 
        Profile to be used for doing SAML SSO to remote relying party.  
        Minimum length = 1 
    .PARAMETER forcedtimeout 
        Setting to start, stop or reset TM session force timer.  
        Possible values = START, STOP, RESET 
    .PARAMETER forcedtimeoutval 
        Time interval, in minutes, for which force timer should be set. 
    .PARAMETER userexpression 
        expression that will be evaluated to obtain username for SingleSignOn.  
        Maximum length = 256 
    .PARAMETER passwdexpression 
        expression that will be evaluated to obtain password for SingleSignOn.  
        Maximum length = 256 
    .PARAMETER PassThru 
        Return details about the created tmtrafficaction item.
    .EXAMPLE
        Invoke-ADCUpdateTmtrafficaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmtrafficaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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

        [ValidateRange(1, 715827)]
        [double]$apptimeout ,

        [ValidateSet('ON', 'OFF')]
        [string]$sso ,

        [string]$formssoaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$persistentcookie ,

        [ValidateSet('ON', 'OFF')]
        [string]$initiatelogout ,

        [ValidateLength(1, 32)]
        [string]$kcdaccount ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$samlssoprofile ,

        [ValidateSet('START', 'STOP', 'RESET')]
        [string]$forcedtimeout ,

        [double]$forcedtimeoutval ,

        [string]$userexpression ,

        [string]$passwdexpression ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmtrafficaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('apptimeout')) { $Payload.Add('apptimeout', $apptimeout) }
            if ($PSBoundParameters.ContainsKey('sso')) { $Payload.Add('sso', $sso) }
            if ($PSBoundParameters.ContainsKey('formssoaction')) { $Payload.Add('formssoaction', $formssoaction) }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('initiatelogout')) { $Payload.Add('initiatelogout', $initiatelogout) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('samlssoprofile')) { $Payload.Add('samlssoprofile', $samlssoprofile) }
            if ($PSBoundParameters.ContainsKey('forcedtimeout')) { $Payload.Add('forcedtimeout', $forcedtimeout) }
            if ($PSBoundParameters.ContainsKey('forcedtimeoutval')) { $Payload.Add('forcedtimeoutval', $forcedtimeoutval) }
            if ($PSBoundParameters.ContainsKey('userexpression')) { $Payload.Add('userexpression', $userexpression) }
            if ($PSBoundParameters.ContainsKey('passwdexpression')) { $Payload.Add('passwdexpression', $passwdexpression) }
 
            if ($PSCmdlet.ShouldProcess("tmtrafficaction", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmtrafficaction -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
   .PARAMETER persistentcookie 
       Use persistent cookies for the traffic session. A persistent cookie remains on the user device and is sent with each HTTP request. The cookie becomes stale if the session ends.  
       Possible values = ON, OFF 
   .PARAMETER kcdaccount 
       Kerberos constrained delegation account name. 
   .PARAMETER forcedtimeout 
       Setting to start, stop or reset TM session force timer.  
       Possible values = START, STOP, RESET 
   .PARAMETER userexpression 
       expression that will be evaluated to obtain username for SingleSignOn. 
   .PARAMETER passwdexpression 
       expression that will be evaluated to obtain password for SingleSignOn.
    .EXAMPLE
        Invoke-ADCUnsetTmtrafficaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmtrafficaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction
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

        [Boolean]$persistentcookie ,

        [Boolean]$kcdaccount ,

        [Boolean]$forcedtimeout ,

        [Boolean]$userexpression ,

        [Boolean]$passwdexpression 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmtrafficaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('persistentcookie')) { $Payload.Add('persistentcookie', $persistentcookie) }
            if ($PSBoundParameters.ContainsKey('kcdaccount')) { $Payload.Add('kcdaccount', $kcdaccount) }
            if ($PSBoundParameters.ContainsKey('forcedtimeout')) { $Payload.Add('forcedtimeout', $forcedtimeout) }
            if ($PSBoundParameters.ContainsKey('userexpression')) { $Payload.Add('userexpression', $userexpression) }
            if ($PSBoundParameters.ContainsKey('passwdexpression')) { $Payload.Add('passwdexpression', $passwdexpression) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmtrafficaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the traffic action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after a traffic action is created. 
    .PARAMETER GetAll 
        Retreive all tmtrafficaction object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficaction
    .EXAMPLE 
        Invoke-ADCGetTmtrafficaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmtrafficaction -Count
    .EXAMPLE
        Invoke-ADCGetTmtrafficaction -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficaction/
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
        Write-Verbose "Invoke-ADCGetTmtrafficaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmtrafficaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Traffic Management configuration Object
    .DESCRIPTION
        Add Traffic Management configuration Object 
    .PARAMETER name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER action 
        Name of the action to apply to requests or connections that match this policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        Invoke-ADCAddTmtrafficpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddTmtrafficpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddTmtrafficpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("tmtrafficpolicy", "Add Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmtrafficpolicy -Filter $Payload)
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
        Delete Traffic Management configuration Object
    .DESCRIPTION
        Delete Traffic Management configuration Object
    .PARAMETER name 
       Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteTmtrafficpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteTmtrafficpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        Write-Verbose "Invoke-ADCDeleteTmtrafficpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Traffic Management configuration Object
    .DESCRIPTION
        Update Traffic Management configuration Object 
    .PARAMETER name 
        Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
    .PARAMETER action 
        Name of the action to apply to requests or connections that match this policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created tmtrafficpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateTmtrafficpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateTmtrafficpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTmtrafficpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("tmtrafficpolicy", "Update Traffic Management configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type tmtrafficpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetTmtrafficpolicy -Filter $Payload)
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
        Unset Traffic Management configuration Object
    .DESCRIPTION
        Unset Traffic Management configuration Object 
   .PARAMETER name 
       Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
   .PARAMETER rule 
       Name of the Citrix ADC named expression, or an expression, that the policy uses to determine whether to apply certain action on the current traffic. 
   .PARAMETER action 
       Name of the action to apply to requests or connections that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetTmtrafficpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetTmtrafficpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy
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

        [Boolean]$rule ,

        [Boolean]$action 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTmtrafficpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Traffic Management configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type tmtrafficpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name for the traffic policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retreive all tmtrafficpolicy object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicy
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicy -Count
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all tmtrafficpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmtrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmtrafficpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicycsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmtrafficpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicylbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Traffic Management configuration object(s)
    .DESCRIPTION
        Get Traffic Management configuration object(s)
    .PARAMETER name 
       Name of the traffic policy for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all tmtrafficpolicy_tmglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the tmtrafficpolicy_tmglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicytmglobalbinding
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicytmglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetTmtrafficpolicytmglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicytmglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetTmtrafficpolicytmglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetTmtrafficpolicytmglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/tm/tmtrafficpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTmtrafficpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for tmtrafficpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving tmtrafficpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type tmtrafficpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


