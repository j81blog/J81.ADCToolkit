function Invoke-ADCGetBotglobalbinding {
    <#
    .SYNOPSIS
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botglobal.
    .PARAMETER GetAll 
        Retrieve all botglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the botglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotglobalbinding -GetAll 
        Get all botglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbinding -name <string>
        Get botglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbinding -Filter @{ 'name'='<value>' }
        Get botglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_binding/
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
        Write-Verbose "Invoke-ADCGetBotglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created botglobal_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotglobalbotpolicybinding -policyname <string> -priority <double>
        An example how to add botglobal_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotglobalbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotglobalbotpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botglobal_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotglobalbotpolicybinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. Available settings function as follows: * REQ_OVERRIDE - Request override. Binds the policy to the priority request queue. * REQ_DEFAULT - Binds the policy to the default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotglobalbotpolicybinding 
        An example how to delete botglobal_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotglobalbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotglobalbotpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("botglobal_botpolicy_binding", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botglobal.
    .PARAMETER GetAll 
        Retrieve all botglobal_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botglobal_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbotpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotglobalbotpolicybinding -GetAll 
        Get all botglobal_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotglobalbotpolicybinding -Count 
        Get the number of botglobal_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbotpolicybinding -name <string>
        Get botglobal_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotglobalbotpolicybinding -Filter @{ 'name'='<value>' }
        Get botglobal_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotglobalbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botglobal_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetBotglobalbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botglobal_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botglobal_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving botglobal_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botglobal_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER Profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotpolicy -name <string> -rule <string> -profilename <string>
        An example how to add botpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [string]$Profilename,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                profilename    = $profilename
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("botpolicy", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotpolicy -Name <string>
        An example how to delete botpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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
        Write-Verbose "Invoke-ADCDeleteBotpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to apply bot profile on the specified request. 
    .PARAMETER Profilename 
        Name of the bot profile to apply if the request matches this bot policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateBotpolicy -name <string>
        An example how to update botpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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

        [string]$Rule,

        [string]$Profilename,

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("botpolicy", "Update Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $payload)
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
        Unset Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. 
    .PARAMETER Comment 
        Any type of information about this bot policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetBotpolicy -name <string>
        An example how to unset botpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy
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

        [string]$Name,

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER Newname 
        New name for the bot policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created botpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameBotpolicy -name <string> -newname <string>
        An example how to rename botpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameBotpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("botpolicy", "Rename Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicy -Filter $payload)
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Configuration for Bot policy resource.
    .PARAMETER Name 
        Name for the bot policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the bot policy is added. 
    .PARAMETER GetAll 
        Retrieve all botpolicy object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicy -GetAll 
        Get all botpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicy -Count 
        Get the number of botpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicy -name <string>
        Get botpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicy -Filter @{ 'name'='<value>' }
        Get botpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy/
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
        Write-Verbose "Invoke-ADCGetBotpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER Comment 
        Any comments to preserve information about this bot policy label. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotpolicylabel -labelname <string>
        An example how to add botpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        [string]$Labelname,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("botpolicylabel", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicylabel -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotpolicylabel -Labelname <string>
        An example how to delete botpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        [string]$Labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Rename Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER Newname 
        New name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameBotpolicylabel -labelname <string> -newname <string>
        An example how to rename botpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameBotpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameBotpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("botpolicylabel", "Rename Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicylabel -Filter $payload)
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Configuration for Bot policy label resource.
    .PARAMETER Labelname 
        Name for the bot policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the responder policy label is added. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabel -GetAll 
        Get all botpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabel -Count 
        Get the number of botpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabel -name <string>
        Get botpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabel -Filter @{ 'name'='<value>' }
        Get botpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel/
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
        [string]$Labelname,

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
        Write-Verbose "Invoke-ADCGetBotpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabelbinding -GetAll 
        Get all botpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbinding -name <string>
        Get botpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is vserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created botpolicylabel_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotpolicylabelbotpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add botpolicylabel_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotpolicylabelbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotpolicylabelbotpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("botpolicylabel_botpolicy_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botpolicylabel_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotpolicylabelbotpolicybinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the bot policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotpolicylabelbotpolicybinding -Labelname <string>
        An example how to delete botpolicylabel_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotpolicylabelbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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
        [string]$Labelname,

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotpolicylabelbotpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbotpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabelbotpolicybinding -GetAll 
        Get all botpolicylabel_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabelbotpolicybinding -Count 
        Get the number of botpolicylabel_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbotpolicybinding -name <string>
        Get botpolicylabel_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelbotpolicybinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelbotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_botpolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to botpolicylabel.
    .PARAMETER Labelname 
        Name of the bot policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all botpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabelpolicybindingbinding -GetAll 
        Get all botpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylabelpolicybindingbinding -Count 
        Get the number of botpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelpolicybindingbinding -name <string>
        Get botpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get botpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicylabelpolicybindingbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicylabel_policybinding_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicybinding -GetAll 
        Get all botpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybinding -name <string>
        Get botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybinding -Filter @{ 'name'='<value>' }
        Get botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the botglobal that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_botglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_botglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicybotglobalbinding -GetAll 
        Get all botpolicy_botglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicybotglobalbinding -Count 
        Get the number of botpolicy_botglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotglobalbinding -name <string>
        Get botpolicy_botglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotglobalbinding -Filter @{ 'name'='<value>' }
        Get botpolicy_botglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicybotglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_botglobal_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the botpolicylabel that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_botpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_botpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicybotpolicylabelbinding -GetAll 
        Get all botpolicy_botpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicybotpolicylabelbinding -Count 
        Get the number of botpolicy_botpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotpolicylabelbinding -name <string>
        Get botpolicy_botpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicybotpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get botpolicy_botpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicybotpolicylabelbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_botpolicylabel_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_botpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_botpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_botpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicycsvserverbinding -GetAll 
        Get all botpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicycsvserverbinding -Count 
        Get the number of botpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicycsvserverbinding -name <string>
        Get botpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get botpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicycsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_csvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to botpolicy.
    .PARAMETER Name 
        Name of the bot policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all botpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the botpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylbvserverbinding -GetAll 
        Get all botpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotpolicylbvserverbinding -Count 
        Get the number of botpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylbvserverbinding -name <string>
        Get botpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get botpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotpolicylbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botpolicy_lbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
        Possible values = NONE, Android, iOS 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
        Possible values = NONE, HTTP_FULL_HEADER 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofile -name <string>
        An example how to add botprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signature,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateLength(1, 127)]
        [string]$Trapurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_white_list = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_black_list = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_rate_limit = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Devicefingerprint = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Devicefingerprintaction = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_ip_reputation = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Trap = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Trapaction = 'NONE',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturenouseragentheaderaction = 'DROP',

        [ValidateSet('CHECKLAST', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturemultipleuseragentheaderaction = 'CHECKLAST',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_tps = 'OFF',

        [ValidateSet('NONE', 'Android', 'iOS')]
        [string[]]$Devicefingerprintmobile = 'NONE',

        [string]$Clientipexpression,

        [string]$Kmjavascriptname,

        [ValidateSet('ON', 'OFF')]
        [string]$Kmdetection = 'OFF',

        [ValidateRange(1, 204800)]
        [double]$Kmeventspostbodylimit,

        [ValidateSet('NONE', 'HTTP_FULL_HEADER')]
        [string]$Verboseloglevel = 'NONE',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSCmdlet.ShouldProcess("botprofile", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofile -Filter $payload)
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
        Update Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
        Possible values = NONE, Android, iOS 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
        Possible values = NONE, HTTP_FULL_HEADER 
    .PARAMETER PassThru 
        Return details about the created botprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateBotprofile -name <string>
        An example how to update botprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateBotprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signature,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateLength(1, 127)]
        [string]$Trapurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_white_list,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_black_list,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_rate_limit,

        [ValidateSet('ON', 'OFF')]
        [string]$Devicefingerprint,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Devicefingerprintaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_ip_reputation,

        [ValidateSet('ON', 'OFF')]
        [string]$Trap,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturenouseragentheaderaction,

        [ValidateSet('CHECKLAST', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Signaturemultipleuseragentheaderaction,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Trapaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_enable_tps,

        [ValidateSet('NONE', 'Android', 'iOS')]
        [string[]]$Devicefingerprintmobile,

        [string]$Clientipexpression,

        [string]$Kmjavascriptname,

        [ValidateSet('ON', 'OFF')]
        [string]$Kmdetection,

        [ValidateRange(1, 204800)]
        [double]$Kmeventspostbodylimit,

        [ValidateSet('NONE', 'HTTP_FULL_HEADER')]
        [string]$Verboseloglevel,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSCmdlet.ShouldProcess("botprofile", "Update Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofile -Filter $payload)
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
        Unset Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Signature 
        Name of object containing bot static signature details. 
    .PARAMETER Errorurl 
        URL that Bot protection uses as the Error URL. 
    .PARAMETER Trapurl 
        URL that Bot protection uses as the Trap URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Bot_enable_white_list 
        Enable white-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_black_list 
        Enable black-list bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Bot_enable_rate_limit 
        Enable rate-limit bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprint 
        Enable device-fingerprint bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintaction 
        Action to be taken for device-fingerprint based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_enable_ip_reputation 
        Enable IP-reputation bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Trap 
        Enable trap bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Signaturenouseragentheaderaction 
        Actions to be taken if no User-Agent header in the request (Applicable if Signature check is enabled). 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Signaturemultipleuseragentheaderaction 
        Actions to be taken if multiple User-Agent headers are seen in a request (Applicable if Signature check is enabled). Log action should be combined with other actions. 
        Possible values = CHECKLAST, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Trapaction 
        Action to be taken for bot trap based bot detection. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_enable_tps 
        Enable TPS. 
        Possible values = ON, OFF 
    .PARAMETER Devicefingerprintmobile 
        Enabling bot device fingerprint protection for mobile clients. 
        Possible values = NONE, Android, iOS 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Kmjavascriptname 
        Name of the JavaScript file that the Bot Management feature will insert in the response for keyboard-mouse based detection. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Kmdetection 
        Enable keyboard-mouse based bot detection. 
        Possible values = ON, OFF 
    .PARAMETER Kmeventspostbodylimit 
        Size of the KM data send by the browser, needs to be processed on ADC. 
    .PARAMETER Verboseloglevel 
        Bot verbose Logging. Based on the log level, ADC will log additional information whenever client is detected as a bot. 
        Possible values = NONE, HTTP_FULL_HEADER
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetBotprofile -name <string>
        An example how to unset botprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetBotprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile
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

        [ValidateLength(1, 31)]
        [string]$Name,

        [Boolean]$signature,

        [Boolean]$errorurl,

        [Boolean]$trapurl,

        [Boolean]$comment,

        [Boolean]$bot_enable_white_list,

        [Boolean]$bot_enable_black_list,

        [Boolean]$bot_enable_rate_limit,

        [Boolean]$devicefingerprint,

        [Boolean]$devicefingerprintaction,

        [Boolean]$bot_enable_ip_reputation,

        [Boolean]$trap,

        [Boolean]$signaturenouseragentheaderaction,

        [Boolean]$signaturemultipleuseragentheaderaction,

        [Boolean]$trapaction,

        [Boolean]$bot_enable_tps,

        [Boolean]$devicefingerprintmobile,

        [Boolean]$clientipexpression,

        [Boolean]$kmjavascriptname,

        [Boolean]$kmdetection,

        [Boolean]$kmeventspostbodylimit,

        [Boolean]$verboseloglevel 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('signature') ) { $payload.Add('signature', $signature) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('trapurl') ) { $payload.Add('trapurl', $trapurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_white_list') ) { $payload.Add('bot_enable_white_list', $bot_enable_white_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_black_list') ) { $payload.Add('bot_enable_black_list', $bot_enable_black_list) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_rate_limit') ) { $payload.Add('bot_enable_rate_limit', $bot_enable_rate_limit) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprint') ) { $payload.Add('devicefingerprint', $devicefingerprint) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintaction') ) { $payload.Add('devicefingerprintaction', $devicefingerprintaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_ip_reputation') ) { $payload.Add('bot_enable_ip_reputation', $bot_enable_ip_reputation) }
            if ( $PSBoundParameters.ContainsKey('trap') ) { $payload.Add('trap', $trap) }
            if ( $PSBoundParameters.ContainsKey('signaturenouseragentheaderaction') ) { $payload.Add('signaturenouseragentheaderaction', $signaturenouseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('signaturemultipleuseragentheaderaction') ) { $payload.Add('signaturemultipleuseragentheaderaction', $signaturemultipleuseragentheaderaction) }
            if ( $PSBoundParameters.ContainsKey('trapaction') ) { $payload.Add('trapaction', $trapaction) }
            if ( $PSBoundParameters.ContainsKey('bot_enable_tps') ) { $payload.Add('bot_enable_tps', $bot_enable_tps) }
            if ( $PSBoundParameters.ContainsKey('devicefingerprintmobile') ) { $payload.Add('devicefingerprintmobile', $devicefingerprintmobile) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('kmjavascriptname') ) { $payload.Add('kmjavascriptname', $kmjavascriptname) }
            if ( $PSBoundParameters.ContainsKey('kmdetection') ) { $payload.Add('kmdetection', $kmdetection) }
            if ( $PSBoundParameters.ContainsKey('kmeventspostbodylimit') ) { $payload.Add('kmeventspostbodylimit', $kmeventspostbodylimit) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofile -Name <string>
        An example how to delete botprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        Write-Verbose "Invoke-ADCDeleteBotprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Configuration for Bot profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile object(s).
    .PARAMETER Count
        If specified, the count of the botprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofile -GetAll 
        Get all botprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofile -Count 
        Get the number of botprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofile -name <string>
        Get botprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofile -Filter @{ 'name'='<value>' }
        Get botprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile/
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
        [ValidateLength(1, 31)]
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
        Write-Verbose "Invoke-ADCGetBotprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to botprofile.
    .PARAMETER Name 
        Name of the bot management profile. 
    .PARAMETER GetAll 
        Retrieve all botprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofilebinding -GetAll 
        Get all botprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilebinding -name <string>
        Get botprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilebinding -Filter @{ 'name'='<value>' }
        Get botprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetBotprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_blacklist 
        Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection. 
    .PARAMETER Bot_blacklist_type 
        Type of the black-list entry. 
        Possible values = IPv4, SUBNET, EXPRESSION 
    .PARAMETER Bot_blacklist_value 
        Value of the bot black-list entry. 
    .PARAMETER Bot_blacklist_action 
        One or more actions to be taken if bot is detected based on this Blacklist binding. Only LOG action can be combined with DROP or RESET action. 
        Possible values = NONE, LOG, DROP, RESET, REDIRECT 
    .PARAMETER Bot_blacklist_enabled 
        Enabled or disbaled black-list binding. 
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_blacklist_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofileblacklistbinding -name <string>
        An example how to add botprofile_blacklist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofileblacklistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_blacklist,

        [ValidateSet('IPv4', 'SUBNET', 'EXPRESSION')]
        [string]$Bot_blacklist_type,

        [string]$Bot_blacklist_value,

        [ValidateSet('NONE', 'LOG', 'DROP', 'RESET', 'REDIRECT')]
        [string[]]$Bot_blacklist_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_blacklist_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileblacklistbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist') ) { $payload.Add('bot_blacklist', $bot_blacklist) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_type') ) { $payload.Add('bot_blacklist_type', $bot_blacklist_type) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_value') ) { $payload.Add('bot_blacklist_value', $bot_blacklist_value) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_action') ) { $payload.Add('bot_blacklist_action', $bot_blacklist_action) }
            if ( $PSBoundParameters.ContainsKey('bot_blacklist_enabled') ) { $payload.Add('bot_blacklist_enabled', $bot_blacklist_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_blacklist_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_blacklist_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofileblacklistbinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_blacklist 
        Blacklist binding. Maximum 32 bindings can be configured per profile for Blacklist detection. 
    .PARAMETER Bot_blacklist_value 
        Value of the bot black-list entry.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofileblacklistbinding -Name <string>
        An example how to delete botprofile_blacklist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileblacklistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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

        [boolean]$Bot_blacklist,

        [string]$Bot_blacklist_value 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileblacklistbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_blacklist') ) { $arguments.Add('bot_blacklist', $Bot_blacklist) }
            if ( $PSBoundParameters.ContainsKey('Bot_blacklist_value') ) { $arguments.Add('bot_blacklist_value', $Bot_blacklist_value) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the blacklist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_blacklist_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_blacklist_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileblacklistbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileblacklistbinding -GetAll 
        Get all botprofile_blacklist_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileblacklistbinding -Count 
        Get the number of botprofile_blacklist_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileblacklistbinding -name <string>
        Get botprofile_blacklist_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileblacklistbinding -Filter @{ 'name'='<value>' }
        Get botprofile_blacklist_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofileblacklistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_blacklist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_blacklist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_blacklist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_blacklist_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_blacklist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Captcharesource 
        Captcha action binding. For each URL, only one binding is allowed. To update the values of an existing URL binding, user has to first unbind that binding, and then needs to bind the URL again with new values. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_captcha_url 
        URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied. 
    .PARAMETER Waittime 
        Wait time in seconds for which ADC needs to wait for the Captcha response. This is to avoid DOS attacks. 
    .PARAMETER Graceperiod 
        Time (in seconds) duration for which no new captcha challenge is sent after current captcha challenge has been answered successfully. 
    .PARAMETER Muteperiod 
        Time (in seconds) duration for which client which failed captcha need to wait until allowed to try again. The requests from this client are silently dropped during the mute period. 
    .PARAMETER Requestsizelimit 
        Length of body request (in Bytes) up to (equal or less than) which captcha challenge will be provided to client. Above this length threshold the request will be dropped. This is to avoid DOS and DDOS attacks. 
    .PARAMETER Retryattempts 
        Number of times client can retry solving the captcha. 
    .PARAMETER Bot_captcha_action 
        One or more actions to be taken when client fails captcha challenge. Only, log action can be configured with DROP, REDIRECT or RESET action. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_captcha_enabled 
        Enable or disable the captcha binding. 
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_captcha_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofilecaptchabinding -name <string>
        An example how to add botprofile_captcha_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofilecaptchabinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Captcharesource,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_captcha_url,

        [ValidateRange(10, 60)]
        [double]$Waittime = '15',

        [ValidateRange(60, 900)]
        [double]$Graceperiod = '900',

        [ValidateRange(60, 900)]
        [double]$Muteperiod = '300',

        [ValidateRange(10, 30000)]
        [double]$Requestsizelimit = '8000',

        [ValidateRange(1, 10)]
        [double]$Retryattempts = '3',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Bot_captcha_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_captcha_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofilecaptchabinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('captcharesource') ) { $payload.Add('captcharesource', $captcharesource) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_url') ) { $payload.Add('bot_captcha_url', $bot_captcha_url) }
            if ( $PSBoundParameters.ContainsKey('waittime') ) { $payload.Add('waittime', $waittime) }
            if ( $PSBoundParameters.ContainsKey('graceperiod') ) { $payload.Add('graceperiod', $graceperiod) }
            if ( $PSBoundParameters.ContainsKey('muteperiod') ) { $payload.Add('muteperiod', $muteperiod) }
            if ( $PSBoundParameters.ContainsKey('requestsizelimit') ) { $payload.Add('requestsizelimit', $requestsizelimit) }
            if ( $PSBoundParameters.ContainsKey('retryattempts') ) { $payload.Add('retryattempts', $retryattempts) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_action') ) { $payload.Add('bot_captcha_action', $bot_captcha_action) }
            if ( $PSBoundParameters.ContainsKey('bot_captcha_enabled') ) { $payload.Add('bot_captcha_enabled', $bot_captcha_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_captcha_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_captcha_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofilecaptchabinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Captcharesource 
        Captcha action binding. For each URL, only one binding is allowed. To update the values of an existing URL binding, user has to first unbind that binding, and then needs to bind the URL again with new values. Maximum 30 bindings can be configured per profile. 
    .PARAMETER Bot_captcha_url 
        URL for which the Captcha action, if configured under IP reputation, TPS or device fingerprint, need to be applied.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofilecaptchabinding -Name <string>
        An example how to delete botprofile_captcha_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofilecaptchabinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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

        [boolean]$Captcharesource,

        [string]$Bot_captcha_url 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofilecaptchabinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Captcharesource') ) { $arguments.Add('captcharesource', $Captcharesource) }
            if ( $PSBoundParameters.ContainsKey('Bot_captcha_url') ) { $arguments.Add('bot_captcha_url', $Bot_captcha_url) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the captcha that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_captcha_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_captcha_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilecaptchabinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofilecaptchabinding -GetAll 
        Get all botprofile_captcha_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofilecaptchabinding -Count 
        Get the number of botprofile_captcha_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilecaptchabinding -name <string>
        Get botprofile_captcha_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilecaptchabinding -Filter @{ 'name'='<value>' }
        Get botprofile_captcha_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofilecaptchabinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_captcha_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_captcha_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_captcha_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_captcha_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_captcha_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ipreputation 
        IP reputation binding. For each category, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with the new values. 
    .PARAMETER Category 
        IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices. 
        Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS 
    .PARAMETER Bot_iprep_enabled 
        Enabled or disabled IP-repuation binding. 
        Possible values = ON, OFF 
    .PARAMETER Bot_iprep_action 
        One or more actions to be taken if bot is detected based on this IP Reputation binding. Only LOG action can be combinded with DROP, RESET, REDIRECT or MITIGATION action. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_ipreputation_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofileipreputationbinding -name <string>
        An example how to add botprofile_ipreputation_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofileipreputationbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_ipreputation,

        [ValidateSet('IP', 'BOTNETS', 'SPAM_SOURCES', 'SCANNERS', 'DOS', 'REPUTATION', 'PHISHING', 'PROXY', 'NETWORK', 'MOBILE_THREATS')]
        [string]$Category,

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_iprep_enabled = 'OFF',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Bot_iprep_action = 'NONE',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileipreputationbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_ipreputation') ) { $payload.Add('bot_ipreputation', $bot_ipreputation) }
            if ( $PSBoundParameters.ContainsKey('category') ) { $payload.Add('category', $category) }
            if ( $PSBoundParameters.ContainsKey('bot_iprep_enabled') ) { $payload.Add('bot_iprep_enabled', $bot_iprep_enabled) }
            if ( $PSBoundParameters.ContainsKey('bot_iprep_action') ) { $payload.Add('bot_iprep_action', $bot_iprep_action) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_ipreputation_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ipreputation_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofileipreputationbinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ipreputation 
        IP reputation binding. For each category, only one binding is allowed. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with the new values. 
    .PARAMETER Category 
        IP Repuation category. Following IP Reuputation categories are allowed: *IP_BASED - This category checks whether client IP is malicious or not. *BOTNET - This category includes Botnet C;C channels, and infected zombie machines controlled by Bot master. *SPAM_SOURCES - This category includes tunneling spam messages through a proxy, anomalous SMTP activities, and forum spam activities. *SCANNERS - This category includes all reconnaissance such as probes, host scan, domain scan, and password brute force attack. *DOS - This category includes DOS, DDOS, anomalous sync flood, and anomalous traffic detection. *REPUTATION - This category denies access from IP addresses currently known to be infected with malware. This category also includes IPs with average low Webroot Reputation Index score. Enabling this category will prevent access from sources identified to contact malware distribution points. *PHISHING - This category includes IP addresses hosting phishing sites and other kinds of fraud activities such as ad click fraud or gaming fraud. *PROXY - This category includes IP addresses providing proxy services. *NETWORK - IPs providing proxy and anonymization services including The Onion Router aka TOR or darknet. *MOBILE_THREATS - This category checks client IP with the list of IPs harmful for mobile devices. 
        Possible values = IP, BOTNETS, SPAM_SOURCES, SCANNERS, DOS, REPUTATION, PHISHING, PROXY, NETWORK, MOBILE_THREATS
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofileipreputationbinding -Name <string>
        An example how to delete botprofile_ipreputation_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileipreputationbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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

        [boolean]$Bot_ipreputation,

        [string]$Category 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileipreputationbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_ipreputation') ) { $arguments.Add('bot_ipreputation', $Bot_ipreputation) }
            if ( $PSBoundParameters.ContainsKey('Category') ) { $arguments.Add('category', $Category) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the ipreputation that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_ipreputation_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_ipreputation_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileipreputationbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileipreputationbinding -GetAll 
        Get all botprofile_ipreputation_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileipreputationbinding -Count 
        Get the number of botprofile_ipreputation_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileipreputationbinding -name <string>
        Get botprofile_ipreputation_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileipreputationbinding -Filter @{ 'name'='<value>' }
        Get botprofile_ipreputation_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofileipreputationbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ipreputation_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_ipreputation_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ipreputation_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ipreputation_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ipreputation_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ratelimit 
        Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SOURCE_IP type, only one binding can be configured, and for URL type, only one binding is allowed per URL, and for SESSION type, only one binding is allowed for a cookie name. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_rate_limit_type 
        Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL. 
        Possible values = SESSION, SOURCE_IP, URL 
    .PARAMETER Bot_rate_limit_url 
        URL for the resource based rate-limiting. 
    .PARAMETER Cookiename 
        Cookie name which is used to identify the session for session rate-limiting. 
    .PARAMETER Rate 
        Maximum number of requests that are allowed in this session in the given period time. 
    .PARAMETER Timeslice 
        Time interval during which requests are tracked to check if they cross the given rate. 
    .PARAMETER Bot_rate_limit_action 
        One or more actions to be taken when the current rate becomes more than the configured rate. Only LOG action can be combined with DROP, REDIRECT or RESET action. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET 
    .PARAMETER Bot_rate_limit_enabled 
        Enable or disable rate-limit binding. 
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_ratelimit_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofileratelimitbinding -name <string>
        An example how to add botprofile_ratelimit_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofileratelimitbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_ratelimit,

        [ValidateSet('SESSION', 'SOURCE_IP', 'URL')]
        [string]$Bot_rate_limit_type,

        [string]$Bot_rate_limit_url,

        [string]$Cookiename,

        [double]$Rate = '1',

        [double]$Timeslice = '1000',

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET')]
        [string[]]$Bot_rate_limit_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_rate_limit_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofileratelimitbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_ratelimit') ) { $payload.Add('bot_ratelimit', $bot_ratelimit) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_type') ) { $payload.Add('bot_rate_limit_type', $bot_rate_limit_type) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_url') ) { $payload.Add('bot_rate_limit_url', $bot_rate_limit_url) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('timeslice') ) { $payload.Add('timeslice', $timeslice) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_action') ) { $payload.Add('bot_rate_limit_action', $bot_rate_limit_action) }
            if ( $PSBoundParameters.ContainsKey('bot_rate_limit_enabled') ) { $payload.Add('bot_rate_limit_enabled', $bot_rate_limit_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_ratelimit_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_ratelimit_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofileratelimitbinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_ratelimit 
        Rate-limit binding. Maximum 30 bindings can be configured per profile for rate-limit detection. For SOURCE_IP type, only one binding can be configured, and for URL type, only one binding is allowed per URL, and for SESSION type, only one binding is allowed for a cookie name. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_rate_limit_type 
        Rate-limiting type Following rate-limiting types are allowed: *SOURCE_IP - Rate-limiting based on the client IP. *SESSION - Rate-limiting based on the configured cookie name. *URL - Rate-limiting based on the configured URL. 
        Possible values = SESSION, SOURCE_IP, URL 
    .PARAMETER Bot_rate_limit_url 
        URL for the resource based rate-limiting. 
    .PARAMETER Cookiename 
        Cookie name which is used to identify the session for session rate-limiting.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofileratelimitbinding -Name <string>
        An example how to delete botprofile_ratelimit_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofileratelimitbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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

        [boolean]$Bot_ratelimit,

        [string]$Bot_rate_limit_type,

        [string]$Bot_rate_limit_url,

        [string]$Cookiename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofileratelimitbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_ratelimit') ) { $arguments.Add('bot_ratelimit', $Bot_ratelimit) }
            if ( $PSBoundParameters.ContainsKey('Bot_rate_limit_type') ) { $arguments.Add('bot_rate_limit_type', $Bot_rate_limit_type) }
            if ( $PSBoundParameters.ContainsKey('Bot_rate_limit_url') ) { $arguments.Add('bot_rate_limit_url', $Bot_rate_limit_url) }
            if ( $PSBoundParameters.ContainsKey('Cookiename') ) { $arguments.Add('cookiename', $Cookiename) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the ratelimit that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_ratelimit_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_ratelimit_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileratelimitbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileratelimitbinding -GetAll 
        Get all botprofile_ratelimit_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofileratelimitbinding -Count 
        Get the number of botprofile_ratelimit_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileratelimitbinding -name <string>
        Get botprofile_ratelimit_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofileratelimitbinding -Filter @{ 'name'='<value>' }
        Get botprofile_ratelimit_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofileratelimitbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_ratelimit_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_ratelimit_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_ratelimit_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_ratelimit_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_ratelimit_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_tps 
        TPS binding. For each type only binding can be configured. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_tps_type 
        Type of TPS binding. 
        Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host 
    .PARAMETER Threshold 
        Maximum number of requests that are allowed from (or to) a IP, Geolocation, URL or Host in 1 second time interval. 
    .PARAMETER Percentage 
        Maximum percentage increase in the requests from (or to) a IP, Geolocation, URL or Host in 30 minutes interval. 
    .PARAMETER Bot_tps_action 
        One to more actions to be taken if bot is detected based on this TPS binding. Only LOG action can be combined with DROP, RESET, REDIRECT, or MITIGIATION action. 
        Possible values = NONE, LOG, DROP, REDIRECT, RESET, MITIGATION 
    .PARAMETER Bot_tps_enabled 
        Enabled or disabled TPS binding. 
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_tps_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofiletpsbinding -name <string>
        An example how to add botprofile_tps_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofiletpsbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_tps,

        [ValidateSet('SOURCE_IP', 'GEOLOCATION', 'REQUEST_URL', 'Host')]
        [string]$Bot_tps_type,

        [double]$Threshold,

        [double]$Percentage,

        [ValidateSet('NONE', 'LOG', 'DROP', 'REDIRECT', 'RESET', 'MITIGATION')]
        [string[]]$Bot_tps_action = 'NONE',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_tps_enabled = 'ON',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofiletpsbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_tps') ) { $payload.Add('bot_tps', $bot_tps) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_type') ) { $payload.Add('bot_tps_type', $bot_tps_type) }
            if ( $PSBoundParameters.ContainsKey('threshold') ) { $payload.Add('threshold', $threshold) }
            if ( $PSBoundParameters.ContainsKey('percentage') ) { $payload.Add('percentage', $percentage) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_action') ) { $payload.Add('bot_tps_action', $bot_tps_action) }
            if ( $PSBoundParameters.ContainsKey('bot_tps_enabled') ) { $payload.Add('bot_tps_enabled', $bot_tps_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_tps_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_tps_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofiletpsbinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_tps 
        TPS binding. For each type only binding can be configured. To update the values of an existing binding, user has to first unbind that binding, and then needs to bind again with new values. 
    .PARAMETER Bot_tps_type 
        Type of TPS binding. 
        Possible values = SOURCE_IP, GEOLOCATION, REQUEST_URL, Host
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofiletpsbinding -Name <string>
        An example how to delete botprofile_tps_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofiletpsbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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

        [boolean]$Bot_tps,

        [string]$Bot_tps_type 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofiletpsbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_tps') ) { $arguments.Add('bot_tps', $Bot_tps) }
            if ( $PSBoundParameters.ContainsKey('Bot_tps_type') ) { $arguments.Add('bot_tps_type', $Bot_tps_type) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the tps that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_tps_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_tps_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofiletpsbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofiletpsbinding -GetAll 
        Get all botprofile_tps_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofiletpsbinding -Count 
        Get the number of botprofile_tps_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofiletpsbinding -name <string>
        Get botprofile_tps_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofiletpsbinding -Filter @{ 'name'='<value>' }
        Get botprofile_tps_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofiletpsbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_tps_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_tps_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_tps_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_tps_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_tps_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_tps_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_tps_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Bot configuration Object.
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_whitelist 
        Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection. 
    .PARAMETER Bot_whitelist_type 
        Type of the white-list entry. 
        Possible values = IPv4, SUBNET, EXPRESSION 
    .PARAMETER Bot_whitelist_value 
        Value of bot white-list entry. 
    .PARAMETER Log 
        Enable logging for Whitelist binding. 
        Possible values = ON, OFF 
    .PARAMETER Bot_whitelist_enabled 
        Enabled or disabled white-list binding. 
        Possible values = ON, OFF 
    .PARAMETER Logmessage 
        Message to be logged for this binding. 
    .PARAMETER Bot_bind_comment 
        Any comments about this binding. 
    .PARAMETER PassThru 
        Return details about the created botprofile_whitelist_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddBotprofilewhitelistbinding -name <string>
        An example how to add botprofile_whitelist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddBotprofilewhitelistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [boolean]$Bot_whitelist,

        [ValidateSet('IPv4', 'SUBNET', 'EXPRESSION')]
        [string]$Bot_whitelist_type,

        [string]$Bot_whitelist_value,

        [ValidateSet('ON', 'OFF')]
        [string]$Log = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Bot_whitelist_enabled = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Logmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Bot_bind_comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddBotprofilewhitelistbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist') ) { $payload.Add('bot_whitelist', $bot_whitelist) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_type') ) { $payload.Add('bot_whitelist_type', $bot_whitelist_type) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_value') ) { $payload.Add('bot_whitelist_value', $bot_whitelist_value) }
            if ( $PSBoundParameters.ContainsKey('log') ) { $payload.Add('log', $log) }
            if ( $PSBoundParameters.ContainsKey('bot_whitelist_enabled') ) { $payload.Add('bot_whitelist_enabled', $bot_whitelist_enabled) }
            if ( $PSBoundParameters.ContainsKey('logmessage') ) { $payload.Add('logmessage', $logmessage) }
            if ( $PSBoundParameters.ContainsKey('bot_bind_comment') ) { $payload.Add('bot_bind_comment', $bot_bind_comment) }
            if ( $PSCmdlet.ShouldProcess("botprofile_whitelist_binding", "Add Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botprofile_whitelist_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotprofilewhitelistbinding -Filter $payload)
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Bot_whitelist 
        Whitelist binding. Maximum 32 bindings can be configured per profile for Whitelist detection. 
    .PARAMETER Bot_whitelist_value 
        Value of bot white-list entry.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotprofilewhitelistbinding -Name <string>
        An example how to delete botprofile_whitelist_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotprofilewhitelistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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

        [boolean]$Bot_whitelist,

        [string]$Bot_whitelist_value 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteBotprofilewhitelistbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Bot_whitelist') ) { $arguments.Add('bot_whitelist', $Bot_whitelist) }
            if ( $PSBoundParameters.ContainsKey('Bot_whitelist_value') ) { $arguments.Add('bot_whitelist_value', $Bot_whitelist_value) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Binding object showing the whitelist that can be bound to botprofile.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all botprofile_whitelist_binding object(s).
    .PARAMETER Count
        If specified, the count of the botprofile_whitelist_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilewhitelistbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofilewhitelistbinding -GetAll 
        Get all botprofile_whitelist_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotprofilewhitelistbinding -Count 
        Get the number of botprofile_whitelist_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilewhitelistbinding -name <string>
        Get botprofile_whitelist_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotprofilewhitelistbinding -Filter @{ 'name'='<value>' }
        Get botprofile_whitelist_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotprofilewhitelistbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botprofile_whitelist_binding/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all botprofile_whitelist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botprofile_whitelist_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botprofile_whitelist_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botprofile_whitelist_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Update Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Javascriptname 
        Name of the JavaScript that the Bot Management feature uses in response. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable bot auto update signatures. 
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the bot signature mapping file from server. 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Trapurlautogenerate 
        Enable/disable trap URL auto generation. When enabled, trap URL is updated within the configured interval. 
        Possible values = ON, OFF 
    .PARAMETER Trapurlinterval 
        Time in seconds after which trap URL is updated. 
    .PARAMETER Trapurllength 
        Length of the auto-generated trap URL.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateBotsettings 
        An example how to update botsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateBotsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings/
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
        [string]$Defaultprofile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Javascriptname,

        [ValidateRange(1, 65535)]
        [double]$Sessiontimeout,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sessioncookiename,

        [double]$Dfprequestlimit,

        [ValidateSet('ON', 'OFF')]
        [string]$Signatureautoupdate,

        [string]$Signatureurl,

        [string]$Proxyserver,

        [ValidateRange(1, 65535)]
        [int]$Proxyport,

        [ValidateSet('ON', 'OFF')]
        [string]$Trapurlautogenerate,

        [ValidateRange(300, 86400)]
        [double]$Trapurlinterval,

        [ValidateRange(10, 255)]
        [double]$Trapurllength 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateBotsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('javascriptname') ) { $payload.Add('javascriptname', $javascriptname) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSBoundParameters.ContainsKey('trapurlautogenerate') ) { $payload.Add('trapurlautogenerate', $trapurlautogenerate) }
            if ( $PSBoundParameters.ContainsKey('trapurlinterval') ) { $payload.Add('trapurlinterval', $trapurlinterval) }
            if ( $PSBoundParameters.ContainsKey('trapurllength') ) { $payload.Add('trapurllength', $trapurllength) }
            if ( $PSCmdlet.ShouldProcess("botsettings", "Update Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type botsettings -Payload $payload -GetWarning
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
        Unset Bot configuration Object.
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is " ", which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Javascriptname 
        Name of the JavaScript that the Bot Management feature uses in response. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. 
    .PARAMETER Sessioncookiename 
        Name of the SessionCookie that the Bot Management feature uses for tracking. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Dfprequestlimit 
        Number of requests to allow without bot session cookie if device fingerprint is enabled. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable bot auto update signatures. 
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the bot signature mapping file from server. 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Trapurlautogenerate 
        Enable/disable trap URL auto generation. When enabled, trap URL is updated within the configured interval. 
        Possible values = ON, OFF 
    .PARAMETER Trapurlinterval 
        Time in seconds after which trap URL is updated. 
    .PARAMETER Trapurllength 
        Length of the auto-generated trap URL.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetBotsettings 
        An example how to unset botsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetBotsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings
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

        [Boolean]$defaultprofile,

        [Boolean]$javascriptname,

        [Boolean]$sessiontimeout,

        [Boolean]$sessioncookiename,

        [Boolean]$dfprequestlimit,

        [Boolean]$signatureautoupdate,

        [Boolean]$signatureurl,

        [Boolean]$proxyserver,

        [Boolean]$proxyport,

        [Boolean]$trapurlautogenerate,

        [Boolean]$trapurlinterval,

        [Boolean]$trapurllength 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetBotsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('javascriptname') ) { $payload.Add('javascriptname', $javascriptname) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('dfprequestlimit') ) { $payload.Add('dfprequestlimit', $dfprequestlimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSBoundParameters.ContainsKey('trapurlautogenerate') ) { $payload.Add('trapurlautogenerate', $trapurlautogenerate) }
            if ( $PSBoundParameters.ContainsKey('trapurlinterval') ) { $payload.Add('trapurlinterval', $trapurlinterval) }
            if ( $PSBoundParameters.ContainsKey('trapurllength') ) { $payload.Add('trapurllength', $trapurllength) }
            if ( $PSCmdlet.ShouldProcess("botsettings", "Unset Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type botsettings -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Configuration for Bot engine settings resource.
    .PARAMETER GetAll 
        Retrieve all botsettings object(s).
    .PARAMETER Count
        If specified, the count of the botsettings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsettings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotsettings -GetAll 
        Get all botsettings data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsettings -name <string>
        Get botsettings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsettings -Filter @{ 'name'='<value>' }
        Get botsettings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsettings/
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
        Write-Verbose "Invoke-ADCGetBotsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsettings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving botsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Import Bot configuration Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Src 
        Local path to and name of, or URL (protocol, host, path, and file name) for, the file in which to store the imported signature file. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER Comment 
        Any comments to preserve information about the signature file object. 
    .PARAMETER Overwrite 
        Overwrites the existing file.
    .EXAMPLE
        PS C:\>Invoke-ADCImportBotsignature -name <string>
        An example how to import botsignature configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportBotsignature
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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

        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateLength(1, 31)]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportBotsignature: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('src') ) { $payload.Add('src', $src) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action import -Payload $payload -GetWarning
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
        Delete Bot configuration Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteBotsignature -Name <string>
        An example how to delete botsignature configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteBotsignature
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        Write-Verbose "Invoke-ADCDeleteBotsignature: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Bot configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type botsignature -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Change Bot configuration Object.
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER PassThru 
        Return details about the created botsignature item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeBotsignature -name <string>
        An example how to change botsignature configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeBotsignature
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        [ValidateLength(1, 31)]
        [string]$Name,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeBotsignature: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("botsignature", "Change Bot configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type botsignature -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetBotsignature -Filter $payload)
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
        Get Bot configuration object(s).
    .DESCRIPTION
        Configuration for bot signatures resource.
    .PARAMETER Name 
        Name to assign to the bot signature file object on the Citrix ADC. 
    .PARAMETER GetAll 
        Retrieve all botsignature object(s).
    .PARAMETER Count
        If specified, the count of the botsignature object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsignature
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetBotsignature -GetAll 
        Get all botsignature data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsignature -name <string>
        Get botsignature object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetBotsignature -Filter @{ 'name'='<value>' }
        Get botsignature data with a filter.
    .NOTES
        File Name : Invoke-ADCGetBotsignature
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/bot/botsignature/
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
        [ValidateLength(1, 31)]
        [string]$Name,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all botsignature objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for botsignature objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving botsignature objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving botsignature configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving botsignature configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type botsignature -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


