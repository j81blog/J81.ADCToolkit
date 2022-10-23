function Invoke-ADCAddFilteraction {
    <#
    .SYNOPSIS
        Add Filter configuration Object.
    .DESCRIPTION
        Configuration for filter action resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Qual 
        Qualifier, which is the action to be performed. The qualifier cannot be changed after it is set. The available options function as follows: 
        ADD - Adds the specified HTTP header. 
        RESET - Terminates the connection, sending the appropriate termination notice to the user's browser. 
        FORWARD - Redirects the request to the designated service. You must specify either a service name or a page, but not both. 
        DROP - Silently deletes the request, without sending a response to the user's browser. 
        CORRUPT - Modifies the designated HTTP header to prevent it from performing the function it was intended to perform, then sends the request/response to the server/browser. 
        ERRORCODE. Returns the designated HTTP error code to the user's browser (for example, 404, the standard HTTP code for a non-existent Web page). 
        Possible values = reset, add, corrupt, forward, errorcode, drop 
    .PARAMETER Servicename 
        Service to which to forward HTTP requests. Required if the qualifier is FORWARD. 
    .PARAMETER Value 
        String containing the header_name and header_value. If the qualifier is ADD, specify <header_name>:<header_value>. If the qualifier is CORRUPT, specify only the header_name. 
    .PARAMETER Respcode 
        Response code to be returned for HTTP requests (for use with the ERRORCODE qualifier). 
    .PARAMETER Page 
        HTML page to return for HTTP requests (For use with the ERRORCODE qualifier). 
    .PARAMETER PassThru 
        Return details about the created filteraction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddFilteraction -name <string> -qual <string>
        An example how to add filteraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddFilteraction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction.md/
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
        [ValidateSet('reset', 'add', 'corrupt', 'forward', 'errorcode', 'drop')]
        [string]$Qual,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Value,

        [double]$Respcode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Page,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddFilteraction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                qual           = $qual
            }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSBoundParameters.ContainsKey('respcode') ) { $payload.Add('respcode', $respcode) }
            if ( $PSBoundParameters.ContainsKey('page') ) { $payload.Add('page', $page) }
            if ( $PSCmdlet.ShouldProcess("filteraction", "Add Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filteraction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilteraction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddFilteraction: Finished"
    }
}

function Invoke-ADCDeleteFilteraction {
    <#
    .SYNOPSIS
        Delete Filter configuration Object.
    .DESCRIPTION
        Configuration for filter action resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteFilteraction -Name <string>
        An example how to delete filteraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteFilteraction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction.md/
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
        Write-Verbose "Invoke-ADCDeleteFilteraction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filteraction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteFilteraction: Finished"
    }
}

function Invoke-ADCUpdateFilteraction {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for filter action resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Servicename 
        Service to which to forward HTTP requests. Required if the qualifier is FORWARD. 
    .PARAMETER Value 
        String containing the header_name and header_value. If the qualifier is ADD, specify <header_name>:<header_value>. If the qualifier is CORRUPT, specify only the header_name. 
    .PARAMETER Respcode 
        Response code to be returned for HTTP requests (for use with the ERRORCODE qualifier). 
    .PARAMETER Page 
        HTML page to return for HTTP requests (For use with the ERRORCODE qualifier). 
    .PARAMETER PassThru 
        Return details about the created filteraction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilteraction -name <string>
        An example how to update filteraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilteraction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction.md/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Servicename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Value,

        [double]$Respcode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Page,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilteraction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servicename') ) { $payload.Add('servicename', $servicename) }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSBoundParameters.ContainsKey('respcode') ) { $payload.Add('respcode', $respcode) }
            if ( $PSBoundParameters.ContainsKey('page') ) { $payload.Add('page', $page) }
            if ( $PSCmdlet.ShouldProcess("filteraction", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filteraction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilteraction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateFilteraction: Finished"
    }
}

function Invoke-ADCUnsetFilteraction {
    <#
    .SYNOPSIS
        Unset Filter configuration Object.
    .DESCRIPTION
        Configuration for filter action resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER Page 
        HTML page to return for HTTP requests (For use with the ERRORCODE qualifier).
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetFilteraction -name <string>
        An example how to unset filteraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetFilteraction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction.md
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

        [Boolean]$page 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilteraction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('page') ) { $payload.Add('page', $page) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filteraction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFilteraction: Finished"
    }
}

function Invoke-ADCGetFilteraction {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for filter action resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER GetAll 
        Retrieve all filteraction object(s).
    .PARAMETER Count
        If specified, the count of the filteraction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilteraction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilteraction -GetAll 
        Get all filteraction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilteraction -Count 
        Get the number of filteraction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilteraction -name <string>
        Get filteraction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilteraction -Filter @{ 'name'='<value>' }
        Get filteraction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilteraction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction.md/
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
        Write-Verbose "Invoke-ADCGetFilteraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filteraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filteraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filteraction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filteraction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filteraction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilteraction: Ended"
    }
}

function Invoke-ADCGetFilterglobalbinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to filterglobal.
    .PARAMETER GetAll 
        Retrieve all filterglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterglobalbinding -GetAll 
        Get all filterglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalbinding -name <string>
        Get filterglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalbinding -Filter @{ 'name'='<value>' }
        Get filterglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterglobalbinding: Ended"
    }
}

function Invoke-ADCAddFilterglobalfilterpolicybinding {
    <#
    .SYNOPSIS
        Add Filter configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to filterglobal.
    .PARAMETER Policyname 
        The name of the filter policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER State 
        State of the binding. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created filterglobal_filterpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddFilterglobalfilterpolicybinding -policyname <string>
        An example how to add filterglobal_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddFilterglobalfilterpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding.md/
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

        [double]$Priority,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterglobalfilterpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSCmdlet.ShouldProcess("filterglobal_filterpolicy_binding", "Add Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterglobal_filterpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilterglobalfilterpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddFilterglobalfilterpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteFilterglobalfilterpolicybinding {
    <#
    .SYNOPSIS
        Delete Filter configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to filterglobal.
    .PARAMETER Policyname 
        The name of the filter policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteFilterglobalfilterpolicybinding 
        An example how to delete filterglobal_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteFilterglobalfilterpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCDeleteFilterglobalfilterpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("filterglobal_filterpolicy_binding", "Delete Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteFilterglobalfilterpolicybinding: Finished"
    }
}

function Invoke-ADCGetFilterglobalfilterpolicybinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to filterglobal.
    .PARAMETER GetAll 
        Retrieve all filterglobal_filterpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterglobal_filterpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalfilterpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterglobalfilterpolicybinding -GetAll 
        Get all filterglobal_filterpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterglobalfilterpolicybinding -Count 
        Get the number of filterglobal_filterpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalfilterpolicybinding -name <string>
        Get filterglobal_filterpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterglobalfilterpolicybinding -Filter @{ 'name'='<value>' }
        Get filterglobal_filterpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterglobalfilterpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterglobalfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterglobal_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterglobal_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterglobalfilterpolicybinding: Ended"
    }
}

function Invoke-ADCUpdateFilterhtmlinjectionparameter {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection parameter resource.
    .PARAMETER Rate 
        For a rate of x, HTML injection is done for 1 out of x policy matches. 
    .PARAMETER Frequency 
        For a frequency of x, HTML injection is done at least once per x milliseconds. 
    .PARAMETER Strict 
        Searching for <html> tag. If this parameter is enabled, HTML injection does not insert the prebody or postbody content unless the <html> tag is found. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Htmlsearchlen 
        Number of characters, in the HTTP body, in which to search for the <html> tag if strict mode is set.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilterhtmlinjectionparameter 
        An example how to update filterhtmlinjectionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilterhtmlinjectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter.md/
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

        [double]$Rate,

        [double]$Frequency,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Strict,

        [double]$Htmlsearchlen 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('frequency') ) { $payload.Add('frequency', $frequency) }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('htmlsearchlen') ) { $payload.Add('htmlsearchlen', $htmlsearchlen) }
            if ( $PSCmdlet.ShouldProcess("filterhtmlinjectionparameter", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterhtmlinjectionparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionparameter: Finished"
    }
}

function Invoke-ADCUnsetFilterhtmlinjectionparameter {
    <#
    .SYNOPSIS
        Unset Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection parameter resource.
    .PARAMETER Rate 
        For a rate of x, HTML injection is done for 1 out of x policy matches. 
    .PARAMETER Frequency 
        For a frequency of x, HTML injection is done at least once per x milliseconds. 
    .PARAMETER Strict 
        Searching for <html> tag. If this parameter is enabled, HTML injection does not insert the prebody or postbody content unless the <html> tag is found. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Htmlsearchlen 
        Number of characters, in the HTTP body, in which to search for the <html> tag if strict mode is set.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetFilterhtmlinjectionparameter 
        An example how to unset filterhtmlinjectionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetFilterhtmlinjectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter.md
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

        [Boolean]$rate,

        [Boolean]$frequency,

        [Boolean]$strict,

        [Boolean]$htmlsearchlen 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('frequency') ) { $payload.Add('frequency', $frequency) }
            if ( $PSBoundParameters.ContainsKey('strict') ) { $payload.Add('strict', $strict) }
            if ( $PSBoundParameters.ContainsKey('htmlsearchlen') ) { $payload.Add('htmlsearchlen', $htmlsearchlen) }
            if ( $PSCmdlet.ShouldProcess("filterhtmlinjectionparameter", "Unset Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionparameter: Finished"
    }
}

function Invoke-ADCGetFilterhtmlinjectionparameter {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for HTML injection parameter resource.
    .PARAMETER GetAll 
        Retrieve all filterhtmlinjectionparameter object(s).
    .PARAMETER Count
        If specified, the count of the filterhtmlinjectionparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterhtmlinjectionparameter -GetAll 
        Get all filterhtmlinjectionparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionparameter -name <string>
        Get filterhtmlinjectionparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionparameter -Filter @{ 'name'='<value>' }
        Get filterhtmlinjectionparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterhtmlinjectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter.md/
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
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filterhtmlinjectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterhtmlinjectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterhtmlinjectionparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterhtmlinjectionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterhtmlinjectionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionparameter: Ended"
    }
}

function Invoke-ADCAddFilterhtmlinjectionvariable {
    <#
    .SYNOPSIS
        Add Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection variable resource.
    .PARAMETER Variable 
        Name for the HTML injection variable to be added. 
    .PARAMETER Value 
        Value to be assigned to the new variable. 
    .PARAMETER PassThru 
        Return details about the created filterhtmlinjectionvariable item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddFilterhtmlinjectionvariable -variable <string>
        An example how to add filterhtmlinjectionvariable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddFilterhtmlinjectionvariable
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable.md/
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
        [string]$Variable,

        [ValidateLength(1, 31)]
        [string]$Value,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $payload = @{ variable = $variable }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSCmdlet.ShouldProcess("filterhtmlinjectionvariable", "Add Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filterhtmlinjectionvariable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilterhtmlinjectionvariable -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddFilterhtmlinjectionvariable: Finished"
    }
}

function Invoke-ADCDeleteFilterhtmlinjectionvariable {
    <#
    .SYNOPSIS
        Delete Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection variable resource.
    .PARAMETER Variable 
        Name for the HTML injection variable to be added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteFilterhtmlinjectionvariable -Variable <string>
        An example how to delete filterhtmlinjectionvariable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteFilterhtmlinjectionvariable
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable.md/
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
        [string]$Variable 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$variable", "Delete Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Resource $variable -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteFilterhtmlinjectionvariable: Finished"
    }
}

function Invoke-ADCUpdateFilterhtmlinjectionvariable {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection variable resource.
    .PARAMETER Variable 
        Name for the HTML injection variable to be added. 
    .PARAMETER Value 
        Value to be assigned to the new variable. 
    .PARAMETER PassThru 
        Return details about the created filterhtmlinjectionvariable item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilterhtmlinjectionvariable -variable <string>
        An example how to update filterhtmlinjectionvariable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilterhtmlinjectionvariable
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable.md/
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
        [string]$Variable,

        [ValidateLength(1, 31)]
        [string]$Value,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $payload = @{ variable = $variable }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSCmdlet.ShouldProcess("filterhtmlinjectionvariable", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterhtmlinjectionvariable -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilterhtmlinjectionvariable -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionvariable: Finished"
    }
}

function Invoke-ADCUnsetFilterhtmlinjectionvariable {
    <#
    .SYNOPSIS
        Unset Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML injection variable resource.
    .PARAMETER Variable 
        Name for the HTML injection variable to be added. 
    .PARAMETER Value 
        Value to be assigned to the new variable.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetFilterhtmlinjectionvariable -variable <string>
        An example how to unset filterhtmlinjectionvariable configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetFilterhtmlinjectionvariable
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable.md
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
        [string]$Variable,

        [Boolean]$value 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $payload = @{ variable = $variable }
            if ( $PSBoundParameters.ContainsKey('value') ) { $payload.Add('value', $value) }
            if ( $PSCmdlet.ShouldProcess("$variable", "Unset Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionvariable: Finished"
    }
}

function Invoke-ADCGetFilterhtmlinjectionvariable {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for HTML injection variable resource.
    .PARAMETER Variable 
        Name for the HTML injection variable to be added. 
    .PARAMETER GetAll 
        Retrieve all filterhtmlinjectionvariable object(s).
    .PARAMETER Count
        If specified, the count of the filterhtmlinjectionvariable object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionvariable
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterhtmlinjectionvariable -GetAll 
        Get all filterhtmlinjectionvariable data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterhtmlinjectionvariable -Count 
        Get the number of filterhtmlinjectionvariable objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionvariable -name <string>
        Get filterhtmlinjectionvariable object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterhtmlinjectionvariable -Filter @{ 'name'='<value>' }
        Get filterhtmlinjectionvariable data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterhtmlinjectionvariable
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable.md/
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
        [string]$Variable,

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
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionvariable: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filterhtmlinjectionvariable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterhtmlinjectionvariable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterhtmlinjectionvariable objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterhtmlinjectionvariable configuration for property 'variable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Resource $variable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterhtmlinjectionvariable configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionvariable: Ended"
    }
}

function Invoke-ADCAddFilterpolicy {
    <#
    .SYNOPSIS
        Add Filter configuration Object.
    .DESCRIPTION
        Configuration for filter policy resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Rule 
        Citrix ADC classic expression specifying the type of connections that match this policy. 
    .PARAMETER Reqaction 
        Name of the action to be performed on requests that match the policy. Cannot be specified if the rule includes condition to be evaluated for responses. 
    .PARAMETER Resaction 
        The action to be performed on the response. The string value can be a filter action created filter action or a built-in action. 
    .PARAMETER PassThru 
        Return details about the created filterpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddFilterpolicy -name <string> -rule <string>
        An example how to add filterpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddFilterpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy.md/
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
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSBoundParameters.ContainsKey('resaction') ) { $payload.Add('resaction', $resaction) }
            if ( $PSCmdlet.ShouldProcess("filterpolicy", "Add Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filterpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilterpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddFilterpolicy: Finished"
    }
}

function Invoke-ADCDeleteFilterpolicy {
    <#
    .SYNOPSIS
        Delete Filter configuration Object.
    .DESCRIPTION
        Configuration for filter policy resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteFilterpolicy -Name <string>
        An example how to delete filterpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteFilterpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy.md/
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
        Write-Verbose "Invoke-ADCDeleteFilterpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteFilterpolicy: Finished"
    }
}

function Invoke-ADCUpdateFilterpolicy {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for filter policy resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER Rule 
        Citrix ADC classic expression specifying the type of connections that match this policy. 
    .PARAMETER Reqaction 
        Name of the action to be performed on requests that match the policy. Cannot be specified if the rule includes condition to be evaluated for responses. 
    .PARAMETER Resaction 
        The action to be performed on the response. The string value can be a filter action created filter action or a built-in action. 
    .PARAMETER PassThru 
        Return details about the created filterpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilterpolicy -name <string>
        An example how to update filterpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilterpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy.md/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Reqaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('reqaction') ) { $payload.Add('reqaction', $reqaction) }
            if ( $PSBoundParameters.ContainsKey('resaction') ) { $payload.Add('resaction', $resaction) }
            if ( $PSCmdlet.ShouldProcess("filterpolicy", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetFilterpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateFilterpolicy: Finished"
    }
}

function Invoke-ADCGetFilterpolicy {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for filter policy resource.
    .PARAMETER Name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER GetAll 
        Retrieve all filterpolicy object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicy -GetAll 
        Get all filterpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicy -Count 
        Get the number of filterpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicy -name <string>
        Get filterpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicy -Filter @{ 'name'='<value>' }
        Get filterpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filterpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicy: Ended"
    }
}

function Invoke-ADCGetFilterpolicybinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to filterpolicy.
    .PARAMETER Name 
        Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retrieve all filterpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicybinding -GetAll 
        Get all filterpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicybinding -name <string>
        Get filterpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicybinding -Filter @{ 'name'='<value>' }
        Get filterpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicybinding: Ended"
    }
}

function Invoke-ADCGetFilterpolicycrvserverbinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to filterpolicy.
    .PARAMETER Name 
        Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retrieve all filterpolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicycrvserverbinding -GetAll 
        Get all filterpolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicycrvserverbinding -Count 
        Get the number of filterpolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycrvserverbinding -name <string>
        Get filterpolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycrvserverbinding -Filter @{ 'name'='<value>' }
        Get filterpolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicycrvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_crvserver_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicycrvserverbinding: Ended"
    }
}

function Invoke-ADCGetFilterpolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to filterpolicy.
    .PARAMETER Name 
        Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retrieve all filterpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicycsvserverbinding -GetAll 
        Get all filterpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicycsvserverbinding -Count 
        Get the number of filterpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycsvserverbinding -name <string>
        Get filterpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get filterpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicycsvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_csvserver_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetFilterpolicyfilterglobalbinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object showing the filterglobal that can be bound to filterpolicy.
    .PARAMETER Name 
        Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retrieve all filterpolicy_filterglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy_filterglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicyfilterglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicyfilterglobalbinding -GetAll 
        Get all filterpolicy_filterglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicyfilterglobalbinding -Count 
        Get the number of filterpolicy_filterglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicyfilterglobalbinding -name <string>
        Get filterpolicy_filterglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicyfilterglobalbinding -Filter @{ 'name'='<value>' }
        Get filterpolicy_filterglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicyfilterglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_filterglobal_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicyfilterglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterpolicy_filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicyfilterglobalbinding: Ended"
    }
}

function Invoke-ADCGetFilterpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to filterpolicy.
    .PARAMETER Name 
        Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retrieve all filterpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the filterpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicylbvserverbinding -GetAll 
        Get all filterpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpolicylbvserverbinding -Count 
        Get the number of filterpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicylbvserverbinding -name <string>
        Get filterpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get filterpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpolicylbvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_lbvserver_binding.md/
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
        Write-Verbose "Invoke-ADCGetFilterpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all filterpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCUpdateFilterpostbodyinjection {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML Injection postbody resource.
    .PARAMETER Postbody 
        Name of file whose contents are to be inserted after the response body.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilterpostbodyinjection -postbody <string>
        An example how to update filterpostbodyinjection configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilterpostbodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection.md/
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
        [string]$Postbody 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterpostbodyinjection: Starting"
    }
    process {
        try {
            $payload = @{ postbody = $postbody }

            if ( $PSCmdlet.ShouldProcess("filterpostbodyinjection", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterpostbodyinjection -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateFilterpostbodyinjection: Finished"
    }
}

function Invoke-ADCUnsetFilterpostbodyinjection {
    <#
    .SYNOPSIS
        Unset Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML Injection postbody resource.
    .PARAMETER Postbody 
        Name of file whose contents are to be inserted after the response body.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetFilterpostbodyinjection 
        An example how to unset filterpostbodyinjection configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetFilterpostbodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection.md
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

        [Boolean]$postbody 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterpostbodyinjection: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('postbody') ) { $payload.Add('postbody', $postbody) }
            if ( $PSCmdlet.ShouldProcess("filterpostbodyinjection", "Unset Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterpostbodyinjection -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFilterpostbodyinjection: Finished"
    }
}

function Invoke-ADCGetFilterpostbodyinjection {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for HTML Injection postbody resource.
    .PARAMETER GetAll 
        Retrieve all filterpostbodyinjection object(s).
    .PARAMETER Count
        If specified, the count of the filterpostbodyinjection object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpostbodyinjection
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterpostbodyinjection -GetAll 
        Get all filterpostbodyinjection data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpostbodyinjection -name <string>
        Get filterpostbodyinjection object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterpostbodyinjection -Filter @{ 'name'='<value>' }
        Get filterpostbodyinjection data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterpostbodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection.md/
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
        Write-Verbose "Invoke-ADCGetFilterpostbodyinjection: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filterpostbodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpostbodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpostbodyinjection objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpostbodyinjection configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterpostbodyinjection configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterpostbodyinjection: Ended"
    }
}

function Invoke-ADCUpdateFilterprebodyinjection {
    <#
    .SYNOPSIS
        Update Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML Injection prebody resource.
    .PARAMETER Prebody 
        Name of file whose contents are to be inserted before the response body.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateFilterprebodyinjection -prebody <string>
        An example how to update filterprebodyinjection configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateFilterprebodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection.md/
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
        [string]$Prebody 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterprebodyinjection: Starting"
    }
    process {
        try {
            $payload = @{ prebody = $prebody }

            if ( $PSCmdlet.ShouldProcess("filterprebodyinjection", "Update Filter configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterprebodyinjection -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateFilterprebodyinjection: Finished"
    }
}

function Invoke-ADCUnsetFilterprebodyinjection {
    <#
    .SYNOPSIS
        Unset Filter configuration Object.
    .DESCRIPTION
        Configuration for HTML Injection prebody resource.
    .PARAMETER Prebody 
        Name of file whose contents are to be inserted before the response body.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetFilterprebodyinjection 
        An example how to unset filterprebodyinjection configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetFilterprebodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection.md
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

        [Boolean]$prebody 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterprebodyinjection: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('prebody') ) { $payload.Add('prebody', $prebody) }
            if ( $PSCmdlet.ShouldProcess("filterprebodyinjection", "Unset Filter configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterprebodyinjection -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetFilterprebodyinjection: Finished"
    }
}

function Invoke-ADCGetFilterprebodyinjection {
    <#
    .SYNOPSIS
        Get Filter configuration object(s).
    .DESCRIPTION
        Configuration for HTML Injection prebody resource.
    .PARAMETER GetAll 
        Retrieve all filterprebodyinjection object(s).
    .PARAMETER Count
        If specified, the count of the filterprebodyinjection object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterprebodyinjection
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetFilterprebodyinjection -GetAll 
        Get all filterprebodyinjection data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterprebodyinjection -name <string>
        Get filterprebodyinjection object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetFilterprebodyinjection -Filter @{ 'name'='<value>' }
        Get filterprebodyinjection data with a filter.
    .NOTES
        File Name : Invoke-ADCGetFilterprebodyinjection
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection.md/
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
        Write-Verbose "Invoke-ADCGetFilterprebodyinjection: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all filterprebodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterprebodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterprebodyinjection objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterprebodyinjection configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterprebodyinjection configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetFilterprebodyinjection: Ended"
    }
}


