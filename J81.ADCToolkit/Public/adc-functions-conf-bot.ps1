function Invoke-ADCGetBotglobalbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER GetAll 
        Retreive all botglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the botglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotglobalbinding
    .EXAMPLE 
        Invoke-ADCGetBotglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetBotglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_binding/
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
        Write-Verbose "Invoke-ADCGetBotglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotglobalbinding: Ended"
    }
}

function Invoke-ADCAddBotglobalbotpolicybinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER policyname 
        Name of the bot policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server. 
    .PARAMETER labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label.  
        Possible values = vserver, policylabel 
    .PARAMETER labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created botglobal_botpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddBotglobalbotpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddBotglobalbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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

        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotglobalbotpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botglobal_botpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotglobalbotpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotglobalbotpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteBotglobalbotpolicybinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
     .PARAMETER policyname 
       Name of the bot policy.    .PARAMETER type 
       Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteBotglobalbotpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteBotglobalbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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

        [string]$type ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotglobalbotpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotglobalbotpolicybinding: Finished"
    }
}

function Invoke-ADCGetBotglobalbotpolicybinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER GetAll 
        Retreive all botglobal_botpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the botglobal_botpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotglobalbotpolicybinding
    .EXAMPLE 
        Invoke-ADCGetBotglobalbotpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotglobalbotpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetBotglobalbotpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotglobalbotpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotglobalbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetBotglobalbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botglobal_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotglobalbotpolicybinding: Ended"
    }
}

function Invoke-ADCAddBotpolicy {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the bot policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER comment 
        Any type of information about this bot policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        Invoke-ADCAddBotpolicy -name <string> -rule <string> -profilename <string>
    .NOTES
        File Name : Invoke-ADCAddBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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

        [Parameter(Mandatory = $true)]
        [string]$profilename ,

        [string]$undefaction ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                profilename = $profilename
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("botpolicy", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotpolicy: Finished"
    }
}

function Invoke-ADCDeleteBotpolicy {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the bot policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .EXAMPLE
        Invoke-ADCDeleteBotpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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
        Write-Verbose "Invoke-ADCDeleteBotpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotpolicy: Finished"
    }
}

function Invoke-ADCUpdateBotpolicy {
<#
    .SYNOPSIS
        Update Bot configuration Object
    .DESCRIPTION
        Update Bot configuration Object 
    .PARAMETER name 
        Name for the bot policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER comment 
        Any type of information about this bot policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateBotpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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

        [string]$profilename ,

        [string]$undefaction ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Payload.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("botpolicy", "Update Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateBotpolicy: Finished"
    }
}

function Invoke-ADCUnsetBotpolicy {
<#
    .SYNOPSIS
        Unset Bot configuration Object
    .DESCRIPTION
        Unset Bot configuration Object 
   .PARAMETER name 
       Name for the bot policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
   .PARAMETER undefaction 
       Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
   .PARAMETER comment 
       Any type of information about this bot policy. 
   .PARAMETER logaction 
       Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetBotpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy
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

        [Boolean]$undefaction ,

        [Boolean]$comment ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetBotpolicy: Finished"
    }
}

function Invoke-ADCRenameBotpolicy {
<#
    .SYNOPSIS
        Rename Bot configuration Object
    .DESCRIPTION
        Rename Bot configuration Object 
    .PARAMETER name 
        Name for the bot policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER newname 
        New name for the bot policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        Invoke-ADCRenameBotpolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameBotpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("botpolicy", "Rename Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameBotpolicy: Finished"
    }
}

function Invoke-ADCGetBotpolicy {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the bot policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER GetAll 
        Retreive all botpolicy object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicy
    .EXAMPLE 
        Invoke-ADCGetBotpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicy -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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
        Write-Verbose "Invoke-ADCGetBotpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all botpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicy: Ended"
    }
}

function Invoke-ADCAddBotpolicylabel {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER comment 
        Any comments to preserve information about this bot policy label. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        Invoke-ADCAddBotpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCAddBotpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("botpolicylabel", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteBotpolicylabel {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER labelname 
       Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .EXAMPLE
        Invoke-ADCDeleteBotpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteBotpolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotpolicylabel: Finished"
    }
}

function Invoke-ADCRenameBotpolicylabel {
<#
    .SYNOPSIS
        Rename Bot configuration Object
    .DESCRIPTION
        Rename Bot configuration Object 
    .PARAMETER labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER newname 
        New name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameBotpolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameBotpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        Write-Verbose "Invoke-ADCRenameBotpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("botpolicylabel", "Rename Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameBotpolicylabel: Finished"
    }
}

function Invoke-ADCGetBotpolicylabel {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER labelname 
       Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER GetAll 
        Retreive all botpolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the botpolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicylabel
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        Write-Verbose "Invoke-ADCGetBotpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all botpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicylabel: Ended"
    }
}

function Invoke-ADCGetBotpolicylabelbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER labelname 
       Name of the bot policy label. 
    .PARAMETER GetAll 
        Retreive all botpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddBotpolicylabelbotpolicybinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER policyname 
        Name of the bot policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label.  
        Possible values = vserver, policylabel 
    .PARAMETER invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is vserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel_botpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddBotpolicylabelbotpolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddBotpolicylabelbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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

        [ValidateSet('vserver', 'policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicylabelbotpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("botpolicylabel_botpolicy_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botpolicylabel_botpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotpolicylabelbotpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotpolicylabelbotpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteBotpolicylabelbotpolicybinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER labelname 
       Name of the bot policy label to which to bind the policy.    .PARAMETER policyname 
       Name of the bot policy.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteBotpolicylabelbotpolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicylabelbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteBotpolicylabelbotpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotpolicylabelbotpolicybinding: Finished"
    }
}

function Invoke-ADCGetBotpolicylabelbotpolicybinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER labelname 
       Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all botpolicylabel_botpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicylabel_botpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbotpolicybinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabelbotpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabelbotpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbotpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelbotpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelbotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicylabelbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicylabel_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicylabelbotpolicybinding: Ended"
    }
}

function Invoke-ADCGetBotpolicylabelpolicybindingbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER labelname 
       Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all botpolicylabel_policybinding_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicylabel_policybinding_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelpolicybindingbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabelpolicybindingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicylabelpolicybindingbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelpolicybindingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelpolicybindingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCGetBotpolicybinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all botpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicybinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetBotpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicybinding: Ended"
    }
}

function Invoke-ADCGetBotpolicybotglobalbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all botpolicy_botglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy_botglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicybotglobalbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicybotglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicybotglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicybotglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicybotglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicybotglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_botglobal_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicybotglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicy_botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicybotglobalbinding: Ended"
    }
}

function Invoke-ADCGetBotpolicybotpolicylabelbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all botpolicy_botpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy_botpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicybotpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicybotpolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicybotpolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicybotpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicybotpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicybotpolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_botpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicybotpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicy_botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicybotpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetBotpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all botpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicycsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetBotpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all botpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the botpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetBotpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotpolicylbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetBotpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCAddBotprofile {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER signature 
        Name of object containing bot static signature details.  
        Minimum length = 1 
    .PARAMETER errorurl 
        URL that Bot protection uses as the Error URL.  
        Minimum length = 1 
    .PARAMETER trapurl 
        URL that Bot protection uses as the Trap URL.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile.  
        Minimum length = 1 
    .PARAMETER bot_enable_white_list 
        Enable white-list bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_enable_black_list 
        Enable black-list bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_enable_rate_limit 
        Enable rate-limit bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER devicefingerprint 
        Enable device-fingerprint bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER bot_enable_ip_reputation 
        Enable IP-reputation bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trap 
        Enable trap bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trapaction 
        Action to be taken for bot trap based bot detection.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER bot_enable_tps 
        Enable TPS.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        Invoke-ADCAddBotprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signature ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$errorurl ,

        [ValidateLength(1, 127)]
        [string]$trapurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_white_list = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_black_list = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_rate_limit = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$devicefingerprint = 'OFF' ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$devicefingerprintaction = 'NONE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_ip_reputation = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$trap = 'OFF' ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$trapaction = 'NONE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_tps = 'OFF' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('signature')) { $Payload.Add('signature', $signature) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('trapurl')) { $Payload.Add('trapurl', $trapurl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('bot_enable_white_list')) { $Payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_black_list')) { $Payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_rate_limit')) { $Payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ($PSBoundParameters.ContainsKey('devicefingerprint')) { $Payload.Add('devicefingerprint', $devicefingerprint) }
            if ($PSBoundParameters.ContainsKey('devicefingerprintaction')) { $Payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_ip_reputation')) { $Payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ($PSBoundParameters.ContainsKey('trap')) { $Payload.Add('trap', $trap) }
            if ($PSBoundParameters.ContainsKey('trapaction')) { $Payload.Add('trapaction', $trapaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_tps')) { $Payload.Add('bot_enable_tps', $bot_enable_tps) }
 
            if ($PSCmdlet.ShouldProcess("botprofile", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofile: Finished"
    }
}

function Invoke-ADCUpdateBotprofile {
<#
    .SYNOPSIS
        Update Bot configuration Object
    .DESCRIPTION
        Update Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER signature 
        Name of object containing bot static signature details.  
        Minimum length = 1 
    .PARAMETER errorurl 
        URL that Bot protection uses as the Error URL.  
        Minimum length = 1 
    .PARAMETER trapurl 
        URL that Bot protection uses as the Trap URL.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile.  
        Minimum length = 1 
    .PARAMETER bot_enable_white_list 
        Enable white-list bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_enable_black_list 
        Enable black-list bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_enable_rate_limit 
        Enable rate-limit bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER devicefingerprint 
        Enable device-fingerprint bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER bot_enable_ip_reputation 
        Enable IP-reputation bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trap 
        Enable trap bot detection.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trapaction 
        Action to be taken for bot trap based bot detection.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER bot_enable_tps 
        Enable TPS.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        Invoke-ADCUpdateBotprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateBotprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signature ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$errorurl ,

        [ValidateLength(1, 127)]
        [string]$trapurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_white_list ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_black_list ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_rate_limit ,

        [ValidateSet('ON', 'OFF')]
        [string]$devicefingerprint ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$devicefingerprintaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_ip_reputation ,

        [ValidateSet('ON', 'OFF')]
        [string]$trap ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$trapaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_enable_tps ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('signature')) { $Payload.Add('signature', $signature) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('trapurl')) { $Payload.Add('trapurl', $trapurl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('bot_enable_white_list')) { $Payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_black_list')) { $Payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_rate_limit')) { $Payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ($PSBoundParameters.ContainsKey('devicefingerprint')) { $Payload.Add('devicefingerprint', $devicefingerprint) }
            if ($PSBoundParameters.ContainsKey('devicefingerprintaction')) { $Payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_ip_reputation')) { $Payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ($PSBoundParameters.ContainsKey('trap')) { $Payload.Add('trap', $trap) }
            if ($PSBoundParameters.ContainsKey('trapaction')) { $Payload.Add('trapaction', $trapaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_tps')) { $Payload.Add('bot_enable_tps', $bot_enable_tps) }
 
            if ($PSCmdlet.ShouldProcess("botprofile", "Update Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateBotprofile: Finished"
    }
}

function Invoke-ADCUnsetBotprofile {
<#
    .SYNOPSIS
        Unset Bot configuration Object
    .DESCRIPTION
        Unset Bot configuration Object 
   .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
   .PARAMETER signature 
       Name of object containing bot static signature details. 
   .PARAMETER errorurl 
       URL that Bot protection uses as the Error URL. 
   .PARAMETER trapurl 
       URL that Bot protection uses as the Trap URL. 
   .PARAMETER comment 
       Any comments about the purpose of profile, or other useful information about the profile. 
   .PARAMETER bot_enable_white_list 
       Enable white-list bot detection.  
       Possible values = ON, OFF 
   .PARAMETER bot_enable_black_list 
       Enable black-list bot detection.  
       Possible values = ON, OFF 
   .PARAMETER bot_enable_rate_limit 
       Enable rate-limit bot detection.  
       Possible values = ON, OFF 
   .PARAMETER devicefingerprint 
       Enable device-fingerprint bot detection.  
       Possible values = ON, OFF 
   .PARAMETER devicefingerprintaction 
       Action to be taken for device-fingerprint based bot detection.  
       Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
   .PARAMETER bot_enable_ip_reputation 
       Enable IP-reputation bot detection.  
       Possible values = ON, OFF 
   .PARAMETER trap 
       Enable trap bot detection.  
       Possible values = ON, OFF 
   .PARAMETER trapaction 
       Action to be taken for bot trap based bot detection.  
       Possible values = NONE, LOG, DROP, REDIRECT, RESET 
   .PARAMETER bot_enable_tps 
       Enable TPS.  
       Possible values = ON, OFF
    .EXAMPLE
        Invoke-ADCUnsetBotprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetBotprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [Boolean]$signature ,

        [Boolean]$errorurl ,

        [Boolean]$trapurl ,

        [Boolean]$comment ,

        [Boolean]$bot_enable_white_list ,

        [Boolean]$bot_enable_black_list ,

        [Boolean]$bot_enable_rate_limit ,

        [Boolean]$devicefingerprint ,

        [Boolean]$devicefingerprintaction ,

        [Boolean]$bot_enable_ip_reputation ,

        [Boolean]$trap ,

        [Boolean]$trapaction ,

        [Boolean]$bot_enable_tps 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('signature')) { $Payload.Add('signature', $signature) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('trapurl')) { $Payload.Add('trapurl', $trapurl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('bot_enable_white_list')) { $Payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_black_list')) { $Payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ($PSBoundParameters.ContainsKey('bot_enable_rate_limit')) { $Payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ($PSBoundParameters.ContainsKey('devicefingerprint')) { $Payload.Add('devicefingerprint', $devicefingerprint) }
            if ($PSBoundParameters.ContainsKey('devicefingerprintaction')) { $Payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_ip_reputation')) { $Payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ($PSBoundParameters.ContainsKey('trap')) { $Payload.Add('trap', $trap) }
            if ($PSBoundParameters.ContainsKey('trapaction')) { $Payload.Add('trapaction', $trapaction) }
            if ($PSBoundParameters.ContainsKey('bot_enable_tps')) { $Payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetBotprofile: Finished"
    }
}

function Invoke-ADCDeleteBotprofile {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .EXAMPLE
        Invoke-ADCDeleteBotprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        Write-Verbose "Invoke-ADCDeleteBotprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofile: Finished"
    }
}

function Invoke-ADCGetBotprofile {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile object(s)
    .PARAMETER Count
        If specified, the count of the botprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofile
    .EXAMPLE 
        Invoke-ADCGetBotprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofile -Count
    .EXAMPLE
        Invoke-ADCGetBotprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
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
        Write-Verbose "Invoke-ADCGetBotprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all botprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofile: Ended"
    }
}

function Invoke-ADCGetBotprofilebinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name of the bot management profile. 
    .PARAMETER GetAll 
        Retreive all botprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofilebinding
    .EXAMPLE 
        Invoke-ADCGetBotprofilebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetBotprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofilebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofilebinding: Ended"
    }
}

function Invoke-ADCAddBotprofileblacklistbinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER bot_blacklist 
        Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection. 
    .PARAMETER bot_blacklist_type 
        Type of the black-list entry.  
        Possible values = IPv4, SUBNET, EXPRESSION 
    .PARAMETER bot_blacklist_value 
        Value of the bot black-list entry. 
    .PARAMETER bot_blacklist_action 
        One or more actions to be taken if bot is detected based on this Blacklist binding. Only LOG action can be combined with DROP or RESET action.  
        Possible values = LOG, DROP, RESET 
    .PARAMETER bot_blacklist_enabled 
        Enabled or disbaled black-list binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_blacklist_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofileblacklistbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofileblacklistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$bot_blacklist ,

        [ValidateSet('IPv4', 'SUBNET', 'EXPRESSION')]
        [string]$bot_blacklist_type ,

        [string]$bot_blacklist_value ,

        [ValidateSet('LOG', 'DROP', 'RESET')]
        [string[]]$bot_blacklist_action ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_blacklist_enabled = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileblacklistbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('bot_blacklist')) { $Payload.Add('bot_blacklist', $bot_blacklist) }
            if ($PSBoundParameters.ContainsKey('bot_blacklist_type')) { $Payload.Add('bot_blacklist_type', $bot_blacklist_type) }
            if ($PSBoundParameters.ContainsKey('bot_blacklist_value')) { $Payload.Add('bot_blacklist_value', $bot_blacklist_value) }
            if ($PSBoundParameters.ContainsKey('bot_blacklist_action')) { $Payload.Add('bot_blacklist_action', $bot_blacklist_action) }
            if ($PSBoundParameters.ContainsKey('bot_blacklist_enabled')) { $Payload.Add('bot_blacklist_enabled', $bot_blacklist_enabled) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_blacklist_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_blacklist_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofileblacklistbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofileblacklistbinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofileblacklistbinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER bot_blacklist 
       Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection.    .PARAMETER bot_blacklist_value 
       Value of the bot black-list entry.
    .EXAMPLE
        Invoke-ADCDeleteBotprofileblacklistbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileblacklistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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

        [boolean]$bot_blacklist ,

        [string]$bot_blacklist_value 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileblacklistbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('bot_blacklist')) { $Arguments.Add('bot_blacklist', $bot_blacklist) }
            if ($PSBoundParameters.ContainsKey('bot_blacklist_value')) { $Arguments.Add('bot_blacklist_value', $bot_blacklist_value) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofileblacklistbinding: Finished"
    }
}

function Invoke-ADCGetBotprofileblacklistbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_blacklist_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_blacklist_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofileblacklistbinding
    .EXAMPLE 
        Invoke-ADCGetBotprofileblacklistbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofileblacklistbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofileblacklistbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofileblacklistbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofileblacklistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofileblacklistbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_blacklist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_blacklist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofileblacklistbinding: Ended"
    }
}

function Invoke-ADCAddBotprofilecaptchabinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER captcharesource 
        Captcha action binding. For each URL, only one binding is allowed. If a binding exists for a URL and another binding is configured for the same URL, then the previous binding information is removed. Maximum 30 bindings can be configured per profile. 
    .PARAMETER bot_captcha_url 
        URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied.  
        Minimum length = 1 
    .PARAMETER waittime 
        Wait time in seconds for which ADC needs to wait for the Captcha response. This is to avoid DOS attacks.  
        Default value: 15  
        Minimum value = 10  
        Maximum value = 60 
    .PARAMETER graceperiod 
        Time (in seconds) duration for which no new captcha challenge is sent after current captcha challenge has been answered successfully.  
        Default value: 900  
        Minimum value = 60  
        Maximum value = 900 
    .PARAMETER muteperiod 
        Time (in seconds) duration for which client which failed captcha need to wait until allowed to try again. The requests from this client are silently dropped during the mute period.  
        Default value: 300  
        Minimum value = 60  
        Maximum value = 900 
    .PARAMETER requestsizelimit 
        Length of body request (in Bytes) up to (equal or less than) which captcha challenge will be provided to client. Above this length threshold the request will be dropped. This is to avoid DOS and DDOS attacks.  
        Default value: 8000  
        Minimum value = 10  
        Maximum value = 30000 
    .PARAMETER retryattempts 
        Number of times client can retry solving the captcha.  
        Default value: 3  
        Minimum value = 1  
        Maximum value = 10 
    .PARAMETER bot_captcha_action 
        One or more actions to be taken when client fails captcha challenge. Only, log action can be configured with DROP, REDIRECT or RESET action.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER bot_captcha_enabled 
        Enable or disable the captcha binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_captcha_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofilecaptchabinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofilecaptchabinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$captcharesource ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_captcha_url ,

        [ValidateRange(10, 60)]
        [double]$waittime = '15' ,

        [ValidateRange(60, 900)]
        [double]$graceperiod = '900' ,

        [ValidateRange(60, 900)]
        [double]$muteperiod = '300' ,

        [ValidateRange(10, 30000)]
        [double]$requestsizelimit = '8000' ,

        [ValidateRange(1, 10)]
        [double]$retryattempts = '3' ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$bot_captcha_action = 'NONE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_captcha_enabled = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofilecaptchabinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('captcharesource')) { $Payload.Add('captcharesource', $captcharesource) }
            if ($PSBoundParameters.ContainsKey('bot_captcha_url')) { $Payload.Add('bot_captcha_url', $bot_captcha_url) }
            if ($PSBoundParameters.ContainsKey('waittime')) { $Payload.Add('waittime', $waittime) }
            if ($PSBoundParameters.ContainsKey('graceperiod')) { $Payload.Add('graceperiod', $graceperiod) }
            if ($PSBoundParameters.ContainsKey('muteperiod')) { $Payload.Add('muteperiod', $muteperiod) }
            if ($PSBoundParameters.ContainsKey('requestsizelimit')) { $Payload.Add('requestsizelimit', $requestsizelimit) }
            if ($PSBoundParameters.ContainsKey('retryattempts')) { $Payload.Add('retryattempts', $retryattempts) }
            if ($PSBoundParameters.ContainsKey('bot_captcha_action')) { $Payload.Add('bot_captcha_action', $bot_captcha_action) }
            if ($PSBoundParameters.ContainsKey('bot_captcha_enabled')) { $Payload.Add('bot_captcha_enabled', $bot_captcha_enabled) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_captcha_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_captcha_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofilecaptchabinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofilecaptchabinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofilecaptchabinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER captcharesource 
       Captcha action binding. For each URL, only one binding is allowed. If a binding exists for a URL and another binding is configured for the same URL, then the previous binding information is removed. Maximum 30 bindings can be configured per profile.    .PARAMETER bot_captcha_url 
       URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteBotprofilecaptchabinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofilecaptchabinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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

        [boolean]$captcharesource ,

        [string]$bot_captcha_url 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofilecaptchabinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('captcharesource')) { $Arguments.Add('captcharesource', $captcharesource) }
            if ($PSBoundParameters.ContainsKey('bot_captcha_url')) { $Arguments.Add('bot_captcha_url', $bot_captcha_url) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofilecaptchabinding: Finished"
    }
}

function Invoke-ADCGetBotprofilecaptchabinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_captcha_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_captcha_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofilecaptchabinding
    .EXAMPLE 
        Invoke-ADCGetBotprofilecaptchabinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofilecaptchabinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofilecaptchabinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofilecaptchabinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofilecaptchabinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofilecaptchabinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_captcha_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_captcha_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofilecaptchabinding: Ended"
    }
}

function Invoke-ADCAddBotprofileipreputationbinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER bot_ipreputation 
        IP reputation binding. For each category, only one binding is allowed. If a binding exists for a category and another binding is configured for the same category, then the previous binding information is removed. 
    .PARAMETER category 
        IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices.  
        Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS 
    .PARAMETER bot_iprep_enabled 
        Enabled or disabled IP-repuation binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_iprep_action 
        One or more actions to be taken if bot is detected based on this IP Reputation binding. Only LOG action can be combinded with DROP, RESET, REDIRECT or MITIGATION action.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_ipreputation_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofileipreputationbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofileipreputationbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$bot_ipreputation ,

        [ValidateSet('IP', 'BOTNETS', 'SPAM_SOURCES', 'SCANNERS', 'DOS', 'REPUTATION', 'PHISHING', 'PROXY', 'NETWORK', 'MOBILE_THREATS')]
        [string]$category ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_iprep_enabled = 'OFF' ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$bot_iprep_action = 'NONE' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileipreputationbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('bot_ipreputation')) { $Payload.Add('bot_ipreputation', $bot_ipreputation) }
            if ($PSBoundParameters.ContainsKey('category')) { $Payload.Add('category', $category) }
            if ($PSBoundParameters.ContainsKey('bot_iprep_enabled')) { $Payload.Add('bot_iprep_enabled', $bot_iprep_enabled) }
            if ($PSBoundParameters.ContainsKey('bot_iprep_action')) { $Payload.Add('bot_iprep_action', $bot_iprep_action) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_ipreputation_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ipreputation_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofileipreputationbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofileipreputationbinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofileipreputationbinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER bot_ipreputation 
       IP reputation binding. For each category, only one binding is allowed. If a binding exists for a category and another binding is configured for the same category, then the previous binding information is removed.    .PARAMETER category 
       IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices.  
       Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS
    .EXAMPLE
        Invoke-ADCDeleteBotprofileipreputationbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileipreputationbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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

        [boolean]$bot_ipreputation ,

        [string]$category 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileipreputationbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('bot_ipreputation')) { $Arguments.Add('bot_ipreputation', $bot_ipreputation) }
            if ($PSBoundParameters.ContainsKey('category')) { $Arguments.Add('category', $category) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofileipreputationbinding: Finished"
    }
}

function Invoke-ADCGetBotprofileipreputationbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_ipreputation_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_ipreputation_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofileipreputationbinding
    .EXAMPLE 
        Invoke-ADCGetBotprofileipreputationbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofileipreputationbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofileipreputationbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofileipreputationbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofileipreputationbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofileipreputationbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_ipreputation_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ipreputation_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofileipreputationbinding: Ended"
    }
}

function Invoke-ADCAddBotprofileratelimitbinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER bot_ratelimit 
        Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SESSION and IP_BASED types, only one binding can be configured. For these types, if a binding exists and another binding is configured then the previous binding information is removed. For URL type, only one binding is allowed per URL. Also, for URL type, previous binding information is removed if another binding is configured for the same URL. 
    .PARAMETER bot_rate_limit_type 
        Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL.  
        Possible values = SESSION, SOURCE_IP, URL 
    .PARAMETER bot_rate_limit_url 
        URL for the resource based rate-limiting. 
    .PARAMETER cookiename 
        Cookie name which is used to identify the session for session rate-limiting. 
    .PARAMETER rate 
        Maximum number of requests that are allowed in this session in the given period time.  
        Minimum value = 1000  
        Maximum value = 10000000 
    .PARAMETER timeslice 
        Time interval during which requests are tracked to check if they cross the given rate.  
        Minimum value = 1000  
        Maximum value = 10000000 
    .PARAMETER bot_rate_limit_action 
        One or more actions to be taken when the current rate becomes more than the configured rate. Only LOG action can be combined with DROP, REDIRECT or RESET action.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER bot_rate_limit_enabled 
        Enable or disable rate-limit binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_ratelimit_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofileratelimitbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofileratelimitbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$bot_ratelimit ,

        [ValidateSet('SESSION', 'SOURCE_IP', 'URL')]
        [string]$bot_rate_limit_type ,

        [string]$bot_rate_limit_url ,

        [string]$cookiename ,

        [ValidateRange(1000, 10000000)]
        [double]$rate ,

        [ValidateRange(1000, 10000000)]
        [double]$timeslice ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$bot_rate_limit_action = 'NONE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_rate_limit_enabled = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileratelimitbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('bot_ratelimit')) { $Payload.Add('bot_ratelimit', $bot_ratelimit) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_type')) { $Payload.Add('bot_rate_limit_type', $bot_rate_limit_type) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_url')) { $Payload.Add('bot_rate_limit_url', $bot_rate_limit_url) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('rate')) { $Payload.Add('rate', $rate) }
            if ($PSBoundParameters.ContainsKey('timeslice')) { $Payload.Add('timeslice', $timeslice) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_action')) { $Payload.Add('bot_rate_limit_action', $bot_rate_limit_action) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_enabled')) { $Payload.Add('bot_rate_limit_enabled', $bot_rate_limit_enabled) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_ratelimit_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ratelimit_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofileratelimitbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofileratelimitbinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofileratelimitbinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER bot_ratelimit 
       Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SESSION and IP_BASED types, only one binding can be configured. For these types, if a binding exists and another binding is configured then the previous binding information is removed. For URL type, only one binding is allowed per URL. Also, for URL type, previous binding information is removed if another binding is configured for the same URL.    .PARAMETER bot_rate_limit_type 
       Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL.  
       Possible values = SESSION, SOURCE_IP, URL    .PARAMETER bot_rate_limit_url 
       URL for the resource based rate-limiting.
    .EXAMPLE
        Invoke-ADCDeleteBotprofileratelimitbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileratelimitbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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

        [boolean]$bot_ratelimit ,

        [string]$bot_rate_limit_type ,

        [string]$bot_rate_limit_url 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileratelimitbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('bot_ratelimit')) { $Arguments.Add('bot_ratelimit', $bot_ratelimit) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_type')) { $Arguments.Add('bot_rate_limit_type', $bot_rate_limit_type) }
            if ($PSBoundParameters.ContainsKey('bot_rate_limit_url')) { $Arguments.Add('bot_rate_limit_url', $bot_rate_limit_url) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofileratelimitbinding: Finished"
    }
}

function Invoke-ADCGetBotprofileratelimitbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_ratelimit_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_ratelimit_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofileratelimitbinding
    .EXAMPLE 
        Invoke-ADCGetBotprofileratelimitbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofileratelimitbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofileratelimitbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofileratelimitbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofileratelimitbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofileratelimitbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_ratelimit_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ratelimit_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofileratelimitbinding: Ended"
    }
}

function Invoke-ADCAddBotprofiletpsbinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER bot_tps 
        TPS binding. For each type only binding can be configured. If a binding exists for a type and another binding is configured for the same type, then the previous binding information is removed. 
    .PARAMETER bot_tps_type 
        Type of TPS binding.  
        Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host 
    .PARAMETER threshold 
        Maximum number of requests that are allowed from (or to) a IP, Geolocation, URL or Host in 1 second time interval.  
        Minimum value = 1  
        Maximum value = 10000000 
    .PARAMETER percentage 
        Maximum percentage increase in the requests from (or to) a IP, Geolocation, URL or Host in 30 minutes interval.  
        Minimum value = 10  
        Maximum value = 10000000 
    .PARAMETER bot_tps_action 
        One to more actions to be taken if bot is detected based on this TPS binding. Only LOG action can be combined with DROP, RESET, REDIRECT, or MITIGIATION action.  
        Default value: NONE  
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_tps_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofiletpsbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofiletpsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$bot_tps ,

        [ValidateSet('SOURCE_IP', 'GEOLOCATION', 'REQUEST_URL', 'Host')]
        [string]$bot_tps_type ,

        [ValidateRange(1, 10000000)]
        [double]$threshold ,

        [ValidateRange(10, 10000000)]
        [double]$percentage ,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$bot_tps_action = 'NONE' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofiletpsbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('bot_tps')) { $Payload.Add('bot_tps', $bot_tps) }
            if ($PSBoundParameters.ContainsKey('bot_tps_type')) { $Payload.Add('bot_tps_type', $bot_tps_type) }
            if ($PSBoundParameters.ContainsKey('threshold')) { $Payload.Add('threshold', $threshold) }
            if ($PSBoundParameters.ContainsKey('percentage')) { $Payload.Add('percentage', $percentage) }
            if ($PSBoundParameters.ContainsKey('bot_tps_action')) { $Payload.Add('bot_tps_action', $bot_tps_action) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_tps_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_tps_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofiletpsbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofiletpsbinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofiletpsbinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER bot_tps 
       TPS binding. For each type only binding can be configured. If a binding exists for a type and another binding is configured for the same type, then the previous binding information is removed.    .PARAMETER bot_tps_type 
       Type of TPS binding.  
       Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host
    .EXAMPLE
        Invoke-ADCDeleteBotprofiletpsbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofiletpsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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

        [boolean]$bot_tps ,

        [string]$bot_tps_type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofiletpsbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('bot_tps')) { $Arguments.Add('bot_tps', $bot_tps) }
            if ($PSBoundParameters.ContainsKey('bot_tps_type')) { $Arguments.Add('bot_tps_type', $bot_tps_type) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofiletpsbinding: Finished"
    }
}

function Invoke-ADCGetBotprofiletpsbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_tps_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_tps_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofiletpsbinding
    .EXAMPLE 
        Invoke-ADCGetBotprofiletpsbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofiletpsbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofiletpsbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofiletpsbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofiletpsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofiletpsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_tps_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_tps_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_tps_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_tps_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_tps_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofiletpsbinding: Ended"
    }
}

function Invoke-ADCAddBotprofilewhitelistbinding {
<#
    .SYNOPSIS
        Add Bot configuration Object
    .DESCRIPTION
        Add Bot configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER bot_whitelist 
        Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection. 
    .PARAMETER bot_whitelist_type 
        Type of the white-list entry.  
        Possible values = IPv4, SUBNET, EXPRESSION 
    .PARAMETER bot_whitelist_value 
        Value of bot white-list entry. 
    .PARAMETER log 
        Enable logging for Whitelist binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER bot_whitelist_enabled 
        Enabled or disabled white-list binding.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER logmessage 
        Message to be logged for this binding.  
        Minimum length = 1 
    .PARAMETER bot_bind_comment 
        Any comments about this binding.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created botprofile_whitelist_binding item.
    .EXAMPLE
        Invoke-ADCAddBotprofilewhitelistbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddBotprofilewhitelistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [boolean]$bot_whitelist ,

        [ValidateSet('IPv4', 'SUBNET', 'EXPRESSION')]
        [string]$bot_whitelist_type ,

        [string]$bot_whitelist_value ,

        [ValidateSet('ON', 'OFF')]
        [string]$log = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$bot_whitelist_enabled = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$logmessage ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$bot_bind_comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofilewhitelistbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('bot_whitelist')) { $Payload.Add('bot_whitelist', $bot_whitelist) }
            if ($PSBoundParameters.ContainsKey('bot_whitelist_type')) { $Payload.Add('bot_whitelist_type', $bot_whitelist_type) }
            if ($PSBoundParameters.ContainsKey('bot_whitelist_value')) { $Payload.Add('bot_whitelist_value', $bot_whitelist_value) }
            if ($PSBoundParameters.ContainsKey('log')) { $Payload.Add('log', $log) }
            if ($PSBoundParameters.ContainsKey('bot_whitelist_enabled')) { $Payload.Add('bot_whitelist_enabled', $bot_whitelist_enabled) }
            if ($PSBoundParameters.ContainsKey('logmessage')) { $Payload.Add('logmessage', $logmessage) }
            if ($PSBoundParameters.ContainsKey('bot_bind_comment')) { $Payload.Add('bot_bind_comment', $bot_bind_comment) }
 
            if ($PSCmdlet.ShouldProcess("botprofile_whitelist_binding", "Add Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_whitelist_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotprofilewhitelistbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddBotprofilewhitelistbinding: Finished"
    }
}

function Invoke-ADCDeleteBotprofilewhitelistbinding {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.    .PARAMETER bot_whitelist 
       Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection.    .PARAMETER bot_whitelist_value 
       Value of bot white-list entry.
    .EXAMPLE
        Invoke-ADCDeleteBotprofilewhitelistbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotprofilewhitelistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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

        [boolean]$bot_whitelist ,

        [string]$bot_whitelist_value 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofilewhitelistbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('bot_whitelist')) { $Arguments.Add('bot_whitelist', $bot_whitelist) }
            if ($PSBoundParameters.ContainsKey('bot_whitelist_value')) { $Arguments.Add('bot_whitelist_value', $bot_whitelist_value) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotprofilewhitelistbinding: Finished"
    }
}

function Invoke-ADCGetBotprofilewhitelistbinding {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all botprofile_whitelist_binding object(s)
    .PARAMETER Count
        If specified, the count of the botprofile_whitelist_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotprofilewhitelistbinding
    .EXAMPLE 
        Invoke-ADCGetBotprofilewhitelistbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetBotprofilewhitelistbinding -Count
    .EXAMPLE
        Invoke-ADCGetBotprofilewhitelistbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetBotprofilewhitelistbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotprofilewhitelistbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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
        [ValidateLength(1, 31)]
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofilewhitelistbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all botprofile_whitelist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_whitelist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotprofilewhitelistbinding: Ended"
    }
}

function Invoke-ADCUpdateBotsettings {
<#
    .SYNOPSIS
        Update Bot configuration Object
    .DESCRIPTION
        Update Bot configuration Object 
    .PARAMETER defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further.  
        Minimum length = 1 
    .PARAMETER javascriptname 
        Name of the JavaScript that the Bot Management feature uses in response.  
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, after which a user session is terminated.  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking.  
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled.  
        Minimum value = 1 
    .PARAMETER signatureautoupdate 
        Flag used to enable/disable bot auto update signatures.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER signatureurl 
        URL to download the bot signature mapping file from server.  
        Default value: https://nsbotsignatures.s3.amazonaws.com/BotSignatureMapping.json 
    .PARAMETER proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER proxyport 
        Proxy Server Port to get updated signatures from AWS.  
        Default value: 8080  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUpdateBotsettings 
    .NOTES
        File Name : Invoke-ADCUpdateBotsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings/
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
        [string]$defaultprofile ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$javascriptname ,

        [ValidateRange(1, 65535)]
        [double]$sessiontimeout ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sessioncookiename ,

        [double]$dfprequestlimit ,

        [ValidateSet('ON', 'OFF')]
        [string]$signatureautoupdate ,

        [string]$signatureurl ,

        [string]$proxyserver ,

        [ValidateRange(1, 65535)]
        [int]$proxyport 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('javascriptname')) { $Payload.Add('javascriptname', $javascriptname) }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('sessioncookiename')) { $Payload.Add('sessioncookiename', $sessioncookiename) }
            if ($PSBoundParameters.ContainsKey('dfprequestlimit')) { $Payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ($PSBoundParameters.ContainsKey('signatureautoupdate')) { $Payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ($PSBoundParameters.ContainsKey('signatureurl')) { $Payload.Add('signatureurl', $signatureurl) }
            if ($PSBoundParameters.ContainsKey('proxyserver')) { $Payload.Add('proxyserver', $proxyserver) }
            if ($PSBoundParameters.ContainsKey('proxyport')) { $Payload.Add('proxyport', $proxyport) }
 
            if ($PSCmdlet.ShouldProcess("botsettings", "Update Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botsettings -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateBotsettings: Finished"
    }
}

function Invoke-ADCUnsetBotsettings {
<#
    .SYNOPSIS
        Unset Bot configuration Object
    .DESCRIPTION
        Unset Bot configuration Object 
   .PARAMETER defaultprofile 
       Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
   .PARAMETER javascriptname 
       Name of the JavaScript that the Bot Management feature uses in response.  
       Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
   .PARAMETER sessiontimeout 
       Timeout, in seconds, after which a user session is terminated. 
   .PARAMETER sessioncookiename 
       Name of the SessionCookie that the Bot Management feature uses for tracking.  
       Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
   .PARAMETER dfprequestlimit 
       Number of requests to allow without bot session cookie if device fingerprint is enabled. 
   .PARAMETER signatureautoupdate 
       Flag used to enable/disable bot auto update signatures.  
       Possible values = ON, OFF 
   .PARAMETER signatureurl 
       URL to download the bot signature mapping file from server. 
   .PARAMETER proxyserver 
       Proxy Server IP to get updated signatures from AWS. 
   .PARAMETER proxyport 
       Proxy Server Port to get updated signatures from AWS.  
       * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        Invoke-ADCUnsetBotsettings 
    .NOTES
        File Name : Invoke-ADCUnsetBotsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings
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

        [Boolean]$defaultprofile ,

        [Boolean]$javascriptname ,

        [Boolean]$sessiontimeout ,

        [Boolean]$sessioncookiename ,

        [Boolean]$dfprequestlimit ,

        [Boolean]$signatureautoupdate ,

        [Boolean]$signatureurl ,

        [Boolean]$proxyserver ,

        [Boolean]$proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('javascriptname')) { $Payload.Add('javascriptname', $javascriptname) }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('sessioncookiename')) { $Payload.Add('sessioncookiename', $sessioncookiename) }
            if ($PSBoundParameters.ContainsKey('dfprequestlimit')) { $Payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ($PSBoundParameters.ContainsKey('signatureautoupdate')) { $Payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ($PSBoundParameters.ContainsKey('signatureurl')) { $Payload.Add('signatureurl', $signatureurl) }
            if ($PSBoundParameters.ContainsKey('proxyserver')) { $Payload.Add('proxyserver', $proxyserver) }
            if ($PSBoundParameters.ContainsKey('proxyport')) { $Payload.Add('proxyport', $proxyport) }
            if ($PSCmdlet.ShouldProcess("botsettings", "Unset Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botsettings -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetBotsettings: Finished"
    }
}

function Invoke-ADCGetBotsettings {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER GetAll 
        Retreive all botsettings object(s)
    .PARAMETER Count
        If specified, the count of the botsettings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotsettings
    .EXAMPLE 
        Invoke-ADCGetBotsettings -GetAll
    .EXAMPLE
        Invoke-ADCGetBotsettings -name <string>
    .EXAMPLE
        Invoke-ADCGetBotsettings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings/
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
        Write-Verbose "Invoke-ADCGetBotsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all botsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsettings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving botsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotsettings: Ended"
    }
}

function Invoke-ADCImportBotsignature {
<#
    .SYNOPSIS
        Import Bot configuration Object
    .DESCRIPTION
        Import Bot configuration Object 
    .PARAMETER src 
        Local path to and name of, or URL (protocol, host, path, and file name) for, the file in which to store the imported signature file.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER comment 
        Any comments to preserve information about the signature file object. 
    .PARAMETER overwrite 
        Overwrites the existing file.
    .EXAMPLE
        Invoke-ADCImportBotsignature -name <string>
    .NOTES
        File Name : Invoke-ADCImportBotsignature
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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

        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportBotsignature: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('src')) { $Payload.Add('src', $src) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportBotsignature: Finished"
    }
}

function Invoke-ADCDeleteBotsignature {
<#
    .SYNOPSIS
        Delete Bot configuration Object
    .DESCRIPTION
        Delete Bot configuration Object
    .PARAMETER name 
       Name to assign to the bot signature file object on the Citrix ADC.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteBotsignature -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteBotsignature
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        Write-Verbose "Invoke-ADCDeleteBotsignature: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botsignature -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteBotsignature: Finished"
    }
}

function Invoke-ADCChangeBotsignature {
<#
    .SYNOPSIS
        Change Bot configuration Object
    .DESCRIPTION
        Change Bot configuration Object 
    .PARAMETER name 
        Name to assign to the bot signature file object on the Citrix ADC.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created botsignature item.
    .EXAMPLE
        Invoke-ADCChangeBotsignature -name <string>
    .NOTES
        File Name : Invoke-ADCChangeBotsignature
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        [ValidateLength(1, 31)]
        [string]$name ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeBotsignature: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("botsignature", "Change Bot configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetBotsignature -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeBotsignature: Finished"
    }
}

function Invoke-ADCGetBotsignature {
<#
    .SYNOPSIS
        Get Bot configuration object(s)
    .DESCRIPTION
        Get Bot configuration object(s)
    .PARAMETER name 
       Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER GetAll 
        Retreive all botsignature object(s)
    .PARAMETER Count
        If specified, the count of the botsignature object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetBotsignature
    .EXAMPLE 
        Invoke-ADCGetBotsignature -GetAll
    .EXAMPLE
        Invoke-ADCGetBotsignature -name <string>
    .EXAMPLE
        Invoke-ADCGetBotsignature -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetBotsignature
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetBotsignature: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all botsignature objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsignature objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsignature objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsignature configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botsignature configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetBotsignature: Ended"
    }
}


