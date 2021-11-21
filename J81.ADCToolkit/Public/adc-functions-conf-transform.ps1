function Invoke-ADCAddTransformaction {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Configuration for transform action resource.
    .PARAMETER Name 
        Name for the URL transformation action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL Transformation action is added. 
    .PARAMETER Profilename 
        Name of the URL Transformation profile with which to associate this action. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the action within the profile. A lower number specifies a higher priority. Must be unique within the list of actions bound to the profile. Policies are evaluated in the order of their priority numbers, and the first policy that matches is applied. 
    .PARAMETER State 
        Enable or disable this action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created transformaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformaction -name <string> -profilename <string> -priority <double>
        An example how to add transformaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformaction/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Profilename,

        [Parameter(Mandatory)]
        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                profilename    = $profilename
                priority       = $priority
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSCmdlet.ShouldProcess("transformaction", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformaction: Finished"
    }
}

function Invoke-ADCDeleteTransformaction {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Configuration for transform action resource.
    .PARAMETER Name 
        Name for the URL transformation action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL Transformation action is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformaction -Name <string>
        An example how to delete transformaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformaction/
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
        Write-Verbose "Invoke-ADCDeleteTransformaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformaction: Finished"
    }
}

function Invoke-ADCUpdateTransformaction {
    <#
    .SYNOPSIS
        Update Transform configuration Object.
    .DESCRIPTION
        Configuration for transform action resource.
    .PARAMETER Name 
        Name for the URL transformation action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL Transformation action is added. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the action within the profile. A lower number specifies a higher priority. Must be unique within the list of actions bound to the profile. Policies are evaluated in the order of their priority numbers, and the first policy that matches is applied. 
    .PARAMETER Requrlfrom 
        PCRE-format regular expression that describes the request URL pattern to be transformed. 
    .PARAMETER Requrlinto 
        PCRE-format regular expression that describes the transformation to be performed on URLs that match the reqUrlFrom pattern. 
    .PARAMETER Resurlfrom 
        PCRE-format regular expression that describes the response URL pattern to be transformed. 
    .PARAMETER Resurlinto 
        PCRE-format regular expression that describes the transformation to be performed on URLs that match the resUrlFrom pattern. 
    .PARAMETER Cookiedomainfrom 
        Pattern that matches the domain to be transformed in Set-Cookie headers. 
    .PARAMETER Cookiedomaininto 
        PCRE-format regular expression that describes the transformation to be performed on cookie domains that match the cookieDomainFrom pattern. 
        NOTE: The cookie domain to be transformed is extracted from the request. 
    .PARAMETER State 
        Enable or disable this action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation action. 
    .PARAMETER PassThru 
        Return details about the created transformaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTransformaction -name <string>
        An example how to update transformaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTransformaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformaction/
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

        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Requrlfrom,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Requrlinto,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resurlfrom,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resurlinto,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomainfrom,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomaininto,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTransformaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('requrlfrom') ) { $payload.Add('requrlfrom', $requrlfrom) }
            if ( $PSBoundParameters.ContainsKey('requrlinto') ) { $payload.Add('requrlinto', $requrlinto) }
            if ( $PSBoundParameters.ContainsKey('resurlfrom') ) { $payload.Add('resurlfrom', $resurlfrom) }
            if ( $PSBoundParameters.ContainsKey('resurlinto') ) { $payload.Add('resurlinto', $resurlinto) }
            if ( $PSBoundParameters.ContainsKey('cookiedomainfrom') ) { $payload.Add('cookiedomainfrom', $cookiedomainfrom) }
            if ( $PSBoundParameters.ContainsKey('cookiedomaininto') ) { $payload.Add('cookiedomaininto', $cookiedomaininto) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("transformaction", "Update Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type transformaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTransformaction: Finished"
    }
}

function Invoke-ADCUnsetTransformaction {
    <#
    .SYNOPSIS
        Unset Transform configuration Object.
    .DESCRIPTION
        Configuration for transform action resource.
    .PARAMETER Name 
        Name for the URL transformation action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL Transformation action is added. 
    .PARAMETER Requrlfrom 
        PCRE-format regular expression that describes the request URL pattern to be transformed. 
    .PARAMETER Requrlinto 
        PCRE-format regular expression that describes the transformation to be performed on URLs that match the reqUrlFrom pattern. 
    .PARAMETER Resurlfrom 
        PCRE-format regular expression that describes the response URL pattern to be transformed. 
    .PARAMETER Resurlinto 
        PCRE-format regular expression that describes the transformation to be performed on URLs that match the resUrlFrom pattern. 
    .PARAMETER Cookiedomainfrom 
        Pattern that matches the domain to be transformed in Set-Cookie headers. 
    .PARAMETER Cookiedomaininto 
        PCRE-format regular expression that describes the transformation to be performed on cookie domains that match the cookieDomainFrom pattern. 
        NOTE: The cookie domain to be transformed is extracted from the request. 
    .PARAMETER State 
        Enable or disable this action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTransformaction -name <string>
        An example how to unset transformaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTransformaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformaction
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

        [Boolean]$requrlfrom,

        [Boolean]$requrlinto,

        [Boolean]$resurlfrom,

        [Boolean]$resurlinto,

        [Boolean]$cookiedomainfrom,

        [Boolean]$cookiedomaininto,

        [Boolean]$state,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTransformaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('requrlfrom') ) { $payload.Add('requrlfrom', $requrlfrom) }
            if ( $PSBoundParameters.ContainsKey('requrlinto') ) { $payload.Add('requrlinto', $requrlinto) }
            if ( $PSBoundParameters.ContainsKey('resurlfrom') ) { $payload.Add('resurlfrom', $resurlfrom) }
            if ( $PSBoundParameters.ContainsKey('resurlinto') ) { $payload.Add('resurlinto', $resurlinto) }
            if ( $PSBoundParameters.ContainsKey('cookiedomainfrom') ) { $payload.Add('cookiedomainfrom', $cookiedomainfrom) }
            if ( $PSBoundParameters.ContainsKey('cookiedomaininto') ) { $payload.Add('cookiedomaininto', $cookiedomaininto) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type transformaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTransformaction: Finished"
    }
}

function Invoke-ADCGetTransformaction {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Configuration for transform action resource.
    .PARAMETER Name 
        Name for the URL transformation action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL Transformation action is added. 
    .PARAMETER GetAll 
        Retrieve all transformaction object(s).
    .PARAMETER Count
        If specified, the count of the transformaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformaction -GetAll 
        Get all transformaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformaction -Count 
        Get the number of transformaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformaction -name <string>
        Get transformaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformaction -Filter @{ 'name'='<value>' }
        Get transformaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformaction/
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
        Write-Verbose "Invoke-ADCGetTransformaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all transformaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformaction: Ended"
    }
}

function Invoke-ADCGetTransformglobalbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to transformglobal.
    .PARAMETER GetAll 
        Retrieve all transformglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformglobalbinding -GetAll 
        Get all transformglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobalbinding -name <string>
        Get transformglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobalbinding -Filter @{ 'name'='<value>' }
        Get transformglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTransformglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving transformglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformglobalbinding: Ended"
    }
}

function Invoke-ADCAddTransformglobaltransformpolicybinding {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformglobal.
    .PARAMETER Policyname 
        Name of the transform policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point to which to bind the policy. Available settings function as follows: * REQ_OVERRIDE. Request override. Binds the policy to the priority request queue. * REQ_DEFAULT. Binds the policy to the default request queue. * HTTPQUIC_REQ_OVERRIDE - Binds the policy to the HTTP_QUIC override request queue. * HTTPQUIC_REQ_DEFAULT - Binds the policy to the HTTP_QUIC default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forwards the request or response to the specified virtual server or evaluates the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Send the request to the specified request virtual server. * resvserver - Send the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and the label type is Policy Label. 
    .PARAMETER PassThru 
        Return details about the created transformglobal_transformpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformglobaltransformpolicybinding -policyname <string> -priority <double>
        An example how to add transformglobal_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformglobaltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformglobal_transformpolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformglobaltransformpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("transformglobal_transformpolicy_binding", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type transformglobal_transformpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformglobaltransformpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformglobaltransformpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTransformglobaltransformpolicybinding {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformglobal.
    .PARAMETER Policyname 
        Name of the transform policy. 
    .PARAMETER Type 
        Specifies the bind point to which to bind the policy. Available settings function as follows: * REQ_OVERRIDE. Request override. Binds the policy to the priority request queue. * REQ_DEFAULT. Binds the policy to the default request queue. * HTTPQUIC_REQ_OVERRIDE - Binds the policy to the HTTP_QUIC override request queue. * HTTPQUIC_REQ_DEFAULT - Binds the policy to the HTTP_QUIC default request queue. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformglobaltransformpolicybinding 
        An example how to delete transformglobal_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformglobaltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformglobal_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteTransformglobaltransformpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("transformglobal_transformpolicy_binding", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformglobal_transformpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformglobaltransformpolicybinding: Finished"
    }
}

function Invoke-ADCGetTransformglobaltransformpolicybinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformglobal.
    .PARAMETER GetAll 
        Retrieve all transformglobal_transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformglobal_transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobaltransformpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformglobaltransformpolicybinding -GetAll 
        Get all transformglobal_transformpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformglobaltransformpolicybinding -Count 
        Get the number of transformglobal_transformpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobaltransformpolicybinding -name <string>
        Get transformglobal_transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformglobaltransformpolicybinding -Filter @{ 'name'='<value>' }
        Get transformglobal_transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformglobaltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformglobal_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTransformglobaltransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformglobal_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformglobal_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformglobal_transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformglobal_transformpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving transformglobal_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformglobal_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformglobaltransformpolicybinding: Ended"
    }
}

function Invoke-ADCAddTransformpolicy {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which to evaluate traffic. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Profilename 
        Name of the URL Transformation profile to use to transform requests and responses that match the policy. 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation policy. 
    .PARAMETER Logaction 
        Log server to use to log connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created transformpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformpolicy -name <string> -rule <string> -profilename <string>
        An example how to add transformpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Profilename,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                profilename    = $profilename
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("transformpolicy", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformpolicy: Finished"
    }
}

function Invoke-ADCDeleteTransformpolicy {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformpolicy -Name <string>
        An example how to delete transformpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy/
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicy: Finished"
    }
}

function Invoke-ADCUpdateTransformpolicy {
    <#
    .SYNOPSIS
        Update Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which to evaluate traffic. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes blank spaces, the entire expression must be enclosed in double quotation marks. 
        * If the expression itself includes double quotation marks, you must escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Profilename 
        Name of the URL Transformation profile to use to transform requests and responses that match the policy. 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation policy. 
    .PARAMETER Logaction 
        Log server to use to log connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created transformpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTransformpolicy -name <string>
        An example how to update transformpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy/
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
        [string]$Profilename,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTransformpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("transformpolicy", "Update Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type transformpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTransformpolicy: Finished"
    }
}

function Invoke-ADCUnsetTransformpolicy {
    <#
    .SYNOPSIS
        Unset Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added. 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation policy. 
    .PARAMETER Logaction 
        Log server to use to log connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTransformpolicy -name <string>
        An example how to unset transformpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy
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

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTransformpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type transformpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTransformpolicy: Finished"
    }
}

function Invoke-ADCRenameTransformpolicy {
    <#
    .SYNOPSIS
        Rename Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added. 
    .PARAMETER Newname 
        New name for the policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created transformpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameTransformpolicy -name <string> -newname <string>
        An example how to rename transformpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameTransformpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("transformpolicy", "Rename Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameTransformpolicy: Finished"
    }
}

function Invoke-ADCGetTransformpolicy {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Configuration for URL Transformation policy resource.
    .PARAMETER Name 
        Name for the URL Transformation policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy is added. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicy -GetAll 
        Get all transformpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicy -Count 
        Get the number of transformpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicy -name <string>
        Get transformpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicy -Filter @{ 'name'='<value>' }
        Get transformpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy/
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
        Write-Verbose "Invoke-ADCGetTransformpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all transformpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicy: Ended"
    }
}

function Invoke-ADCAddTransformpolicylabel {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Configuration for transform policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy label is added. 
    .PARAMETER Policylabeltype 
        Types of transformations allowed by the policies bound to the label. For URL transformation, always http_req (HTTP Request). 
        Possible values = http_req, httpquic_req 
    .PARAMETER PassThru 
        Return details about the created transformpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformpolicylabel -labelname <string> -policylabeltype <string>
        An example how to add transformpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel/
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
        [ValidateSet('http_req', 'httpquic_req')]
        [string]$Policylabeltype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policylabeltype     = $policylabeltype
            }

            if ( $PSCmdlet.ShouldProcess("transformpolicylabel", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteTransformpolicylabel {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Configuration for transform policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformpolicylabel -Labelname <string>
        An example how to delete transformpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicylabel: Finished"
    }
}

function Invoke-ADCRenameTransformpolicylabel {
    <#
    .SYNOPSIS
        Rename Transform configuration Object.
    .DESCRIPTION
        Configuration for transform policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy label is added. 
    .PARAMETER Newname 
        New name for the policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created transformpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameTransformpolicylabel -labelname <string> -newname <string>
        An example how to rename transformpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameTransformpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel/
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
        Write-Verbose "Invoke-ADCRenameTransformpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("transformpolicylabel", "Rename Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameTransformpolicylabel: Finished"
    }
}

function Invoke-ADCGetTransformpolicylabel {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Configuration for transform policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy label is added. 
    .PARAMETER GetAll 
        Retrieve all transformpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabel -GetAll 
        Get all transformpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabel -Count 
        Get the number of transformpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabel -name <string>
        Get transformpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabel -Filter @{ 'name'='<value>' }
        Get transformpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicylabel
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel/
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
        Write-Verbose "Invoke-ADCGetTransformpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all transformpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicylabel: Ended"
    }
}

function Invoke-ADCGetTransformpolicylabelbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to transformpolicylabel.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the URL Transformation policy label is added. 
    .PARAMETER GetAll 
        Retrieve all transformpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabelbinding -GetAll 
        Get all transformpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelbinding -name <string>
        Get transformpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get transformpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicylabelbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicylabelpolicybindingbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to transformpolicylabel.
    .PARAMETER Labelname 
        Name of the URL Transformation policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabelpolicybindingbinding -GetAll 
        Get all transformpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabelpolicybindingbinding -Count 
        Get the number of transformpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelpolicybindingbinding -name <string>
        Get transformpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get transformpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicylabelpolicybindingbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCAddTransformpolicylabeltransformpolicybinding {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformpolicylabel.
    .PARAMETER Labelname 
        Name of the URL Transformation policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the URL Transformation policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the policy label. 
    .PARAMETER PassThru 
        Return details about the created transformpolicylabel_transformpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformpolicylabeltransformpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add transformpolicylabel_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformpolicylabeltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel_transformpolicy_binding/
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

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformpolicylabeltransformpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("transformpolicylabel_transformpolicy_binding", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type transformpolicylabel_transformpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformpolicylabeltransformpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformpolicylabeltransformpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteTransformpolicylabeltransformpolicybinding {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformpolicylabel.
    .PARAMETER Labelname 
        Name of the URL Transformation policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the URL Transformation policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformpolicylabeltransformpolicybinding -Labelname <string>
        An example how to delete transformpolicylabel_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformpolicylabeltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicylabeltransformpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformpolicylabeltransformpolicybinding: Finished"
    }
}

function Invoke-ADCGetTransformpolicylabeltransformpolicybinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to transformpolicylabel.
    .PARAMETER Labelname 
        Name of the URL Transformation policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicylabel_transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicylabel_transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabeltransformpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabeltransformpolicybinding -GetAll 
        Get all transformpolicylabel_transformpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylabeltransformpolicybinding -Count 
        Get the number of transformpolicylabel_transformpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabeltransformpolicybinding -name <string>
        Get transformpolicylabel_transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylabeltransformpolicybinding -Filter @{ 'name'='<value>' }
        Get transformpolicylabel_transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicylabeltransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicylabel_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicylabeltransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicylabel_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicylabel_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicylabel_transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicylabel_transformpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicylabel_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicylabel_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicylabeltransformpolicybinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicybinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to transformpolicy.
    .PARAMETER Name 
        Name of the URL Transformation policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicybinding -GetAll 
        Get all transformpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicybinding -name <string>
        Get transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicybinding -Filter @{ 'name'='<value>' }
        Get transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicybinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to transformpolicy.
    .PARAMETER Name 
        Name of the URL Transformation policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicycsvserverbinding -GetAll 
        Get all transformpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicycsvserverbinding -Count 
        Get the number of transformpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicycsvserverbinding -name <string>
        Get transformpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get transformpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicycsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to transformpolicy.
    .PARAMETER Name 
        Name of the URL Transformation policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylbvserverbinding -GetAll 
        Get all transformpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicylbvserverbinding -Count 
        Get the number of transformpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylbvserverbinding -name <string>
        Get transformpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get transformpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicylbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicytransformglobalbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the transformglobal that can be bound to transformpolicy.
    .PARAMETER Name 
        Name of the URL Transformation policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy_transformglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy_transformglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicytransformglobalbinding -GetAll 
        Get all transformpolicy_transformglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicytransformglobalbinding -Count 
        Get the number of transformpolicy_transformglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformglobalbinding -name <string>
        Get transformpolicy_transformglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformglobalbinding -Filter @{ 'name'='<value>' }
        Get transformpolicy_transformglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicytransformglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy_transformglobal_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicytransformglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicy_transformglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy_transformglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy_transformglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy_transformglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy_transformglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicytransformglobalbinding: Ended"
    }
}

function Invoke-ADCGetTransformpolicytransformpolicylabelbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the transformpolicylabel that can be bound to transformpolicy.
    .PARAMETER Name 
        Name of the URL Transformation policy. 
    .PARAMETER GetAll 
        Retrieve all transformpolicy_transformpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformpolicy_transformpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicytransformpolicylabelbinding -GetAll 
        Get all transformpolicy_transformpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformpolicytransformpolicylabelbinding -Count 
        Get the number of transformpolicy_transformpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformpolicylabelbinding -name <string>
        Get transformpolicy_transformpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformpolicytransformpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get transformpolicy_transformpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformpolicytransformpolicylabelbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformpolicy_transformpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetTransformpolicytransformpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformpolicy_transformpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformpolicy_transformpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformpolicy_transformpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformpolicy_transformpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformpolicy_transformpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformpolicy_transformpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformpolicytransformpolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddTransformprofile {
    <#
    .SYNOPSIS
        Add Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation profile resource.
    .PARAMETER Name 
        Name for the URL transformation profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL transformation profile is added. 
    .PARAMETER Type 
        Type of transformation. Always URL for URL Transformation profiles. 
        Possible values = URL 
    .PARAMETER PassThru 
        Return details about the created transformprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddTransformprofile -name <string>
        An example how to add transformprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddTransformprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile/
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

        [ValidateSet('URL')]
        [string]$Type,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddTransformprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSCmdlet.ShouldProcess("transformprofile", "Add Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type transformprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddTransformprofile: Finished"
    }
}

function Invoke-ADCDeleteTransformprofile {
    <#
    .SYNOPSIS
        Delete Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation profile resource.
    .PARAMETER Name 
        Name for the URL transformation profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL transformation profile is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteTransformprofile -Name <string>
        An example how to delete transformprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteTransformprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile/
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
        Write-Verbose "Invoke-ADCDeleteTransformprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type transformprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteTransformprofile: Finished"
    }
}

function Invoke-ADCUpdateTransformprofile {
    <#
    .SYNOPSIS
        Update Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation profile resource.
    .PARAMETER Name 
        Name for the URL transformation profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL transformation profile is added. 
    .PARAMETER Type 
        Type of transformation. Always URL for URL Transformation profiles. 
        Possible values = URL 
    .PARAMETER Onlytransformabsurlinbody 
        In the HTTP body, transform only absolute URLs. Relative URLs are ignored. 
        Possible values = ON, OFF 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation profile. 
    .PARAMETER PassThru 
        Return details about the created transformprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateTransformprofile -name <string>
        An example how to update transformprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateTransformprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile/
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

        [ValidateSet('URL')]
        [string]$Type,

        [ValidateSet('ON', 'OFF')]
        [string]$Onlytransformabsurlinbody,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateTransformprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('onlytransformabsurlinbody') ) { $payload.Add('onlytransformabsurlinbody', $onlytransformabsurlinbody) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("transformprofile", "Update Transform configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type transformprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetTransformprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateTransformprofile: Finished"
    }
}

function Invoke-ADCUnsetTransformprofile {
    <#
    .SYNOPSIS
        Unset Transform configuration Object.
    .DESCRIPTION
        Configuration for URL Transformation profile resource.
    .PARAMETER Name 
        Name for the URL transformation profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL transformation profile is added. 
    .PARAMETER Type 
        Type of transformation. Always URL for URL Transformation profiles. 
        Possible values = URL 
    .PARAMETER Onlytransformabsurlinbody 
        In the HTTP body, transform only absolute URLs. Relative URLs are ignored. 
        Possible values = ON, OFF 
    .PARAMETER Comment 
        Any comments to preserve information about this URL Transformation profile.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetTransformprofile -name <string>
        An example how to unset transformprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetTransformprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile
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

        [Boolean]$type,

        [Boolean]$onlytransformabsurlinbody,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetTransformprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('onlytransformabsurlinbody') ) { $payload.Add('onlytransformabsurlinbody', $onlytransformabsurlinbody) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Transform configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type transformprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetTransformprofile: Finished"
    }
}

function Invoke-ADCGetTransformprofile {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Configuration for URL Transformation profile resource.
    .PARAMETER Name 
        Name for the URL transformation profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the URL transformation profile is added. 
    .PARAMETER GetAll 
        Retrieve all transformprofile object(s).
    .PARAMETER Count
        If specified, the count of the transformprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformprofile -GetAll 
        Get all transformprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformprofile -Count 
        Get the number of transformprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofile -name <string>
        Get transformprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofile -Filter @{ 'name'='<value>' }
        Get transformprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile/
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
        Write-Verbose "Invoke-ADCGetTransformprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all transformprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformprofile: Ended"
    }
}

function Invoke-ADCGetTransformprofilebinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to transformprofile.
    .PARAMETER Name 
        Name of the profile. 
    .PARAMETER GetAll 
        Retrieve all transformprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformprofilebinding -GetAll 
        Get all transformprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofilebinding -name <string>
        Get transformprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofilebinding -Filter @{ 'name'='<value>' }
        Get transformprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile_binding/
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
        Write-Verbose "Invoke-ADCGetTransformprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformprofilebinding: Ended"
    }
}

function Invoke-ADCGetTransformprofiletransformactionbinding {
    <#
    .SYNOPSIS
        Get Transform configuration object(s).
    .DESCRIPTION
        Binding object showing the transformaction that can be bound to transformprofile.
    .PARAMETER Name 
        Name of the profile. 
    .PARAMETER GetAll 
        Retrieve all transformprofile_transformaction_binding object(s).
    .PARAMETER Count
        If specified, the count of the transformprofile_transformaction_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofiletransformactionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformprofiletransformactionbinding -GetAll 
        Get all transformprofile_transformaction_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetTransformprofiletransformactionbinding -Count 
        Get the number of transformprofile_transformaction_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofiletransformactionbinding -name <string>
        Get transformprofile_transformaction_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetTransformprofiletransformactionbinding -Filter @{ 'name'='<value>' }
        Get transformprofile_transformaction_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetTransformprofiletransformactionbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/transform/transformprofile_transformaction_binding/
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
        Write-Verbose "Invoke-ADCGetTransformprofiletransformactionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all transformprofile_transformaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_transformaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for transformprofile_transformaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_transformaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving transformprofile_transformaction_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_transformaction_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving transformprofile_transformaction_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_transformaction_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving transformprofile_transformaction_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type transformprofile_transformaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetTransformprofiletransformactionbinding: Ended"
    }
}


