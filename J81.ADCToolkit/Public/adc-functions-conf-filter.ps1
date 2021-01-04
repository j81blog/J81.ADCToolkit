function Invoke-ADCAddFilteraction {
<#
    .SYNOPSIS
        Add Filter configuration Object
    .DESCRIPTION
        Add Filter configuration Object 
    .PARAMETER name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
        Minimum length = 1 
    .PARAMETER qual 
        Qualifier, which is the action to be performed. The qualifier cannot be changed after it is set. The available options function as follows:  
        ADD - Adds the specified HTTP header.  
        RESET - Terminates the connection, sending the appropriate termination notice to the user's browser.  
        FORWARD - Redirects the request to the designated service. You must specify either a service name or a page, but not both.  
        DROP - Silently deletes the request, without sending a response to the user's browser.  
        CORRUPT - Modifies the designated HTTP header to prevent it from performing the function it was intended to perform, then sends the request/response to the server/browser.  
        ERRORCODE. Returns the designated HTTP error code to the user's browser (for example, 404, the standard HTTP code for a non-existent Web page).  
        Possible values = reset, add, corrupt, forward, errorcode, drop 
    .PARAMETER servicename 
        Service to which to forward HTTP requests. Required if the qualifier is FORWARD.  
        Minimum length = 1 
    .PARAMETER value 
        String containing the header_name and header_value. If the qualifier is ADD, specify <header_name>:<header_value>. If the qualifier is CORRUPT, specify only the header_name.  
        Minimum length = 1 
    .PARAMETER respcode 
        Response code to be returned for HTTP requests (for use with the ERRORCODE qualifier).  
        Minimum value = 1 
    .PARAMETER page 
        HTML page to return for HTTP requests (For use with the ERRORCODE qualifier).  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created filteraction item.
    .EXAMPLE
        Invoke-ADCAddFilteraction -name <string> -qual <string>
    .NOTES
        File Name : Invoke-ADCAddFilteraction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction/
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
        [ValidateSet('reset', 'add', 'corrupt', 'forward', 'errorcode', 'drop')]
        [string]$qual ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$value ,

        [double]$respcode ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$page ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFilteraction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                qual = $qual
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Payload.Add('respcode', $respcode) }
            if ($PSBoundParameters.ContainsKey('page')) { $Payload.Add('page', $page) }
 
            if ($PSCmdlet.ShouldProcess("filteraction", "Add Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filteraction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilteraction -Filter $Payload)
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
        Delete Filter configuration Object
    .DESCRIPTION
        Delete Filter configuration Object
    .PARAMETER name 
       Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteFilteraction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteFilteraction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction/
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
        Write-Verbose "Invoke-ADCDeleteFilteraction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filteraction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action').  
        Minimum length = 1 
    .PARAMETER servicename 
        Service to which to forward HTTP requests. Required if the qualifier is FORWARD.  
        Minimum length = 1 
    .PARAMETER value 
        String containing the header_name and header_value. If the qualifier is ADD, specify <header_name>:<header_value>. If the qualifier is CORRUPT, specify only the header_name.  
        Minimum length = 1 
    .PARAMETER respcode 
        Response code to be returned for HTTP requests (for use with the ERRORCODE qualifier).  
        Minimum value = 1 
    .PARAMETER page 
        HTML page to return for HTTP requests (For use with the ERRORCODE qualifier).  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created filteraction item.
    .EXAMPLE
        Invoke-ADCUpdateFilteraction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateFilteraction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$servicename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$value ,

        [double]$respcode ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$page ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilteraction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servicename')) { $Payload.Add('servicename', $servicename) }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
            if ($PSBoundParameters.ContainsKey('respcode')) { $Payload.Add('respcode', $respcode) }
            if ($PSBoundParameters.ContainsKey('page')) { $Payload.Add('page', $page) }
 
            if ($PSCmdlet.ShouldProcess("filteraction", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filteraction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilteraction -Filter $Payload)
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
        Unset Filter configuration Object
    .DESCRIPTION
        Unset Filter configuration Object 
   .PARAMETER name 
       Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
   .PARAMETER page 
       HTML page to return for HTTP requests (For use with the ERRORCODE qualifier).
    .EXAMPLE
        Invoke-ADCUnsetFilteraction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetFilteraction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction
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

        [Boolean]$page 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilteraction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('page')) { $Payload.Add('page', $page) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filteraction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at sign (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name of a filter action cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my action" or 'my action'). 
    .PARAMETER GetAll 
        Retreive all filteraction object(s)
    .PARAMETER Count
        If specified, the count of the filteraction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilteraction
    .EXAMPLE 
        Invoke-ADCGetFilteraction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilteraction -Count
    .EXAMPLE
        Invoke-ADCGetFilteraction -name <string>
    .EXAMPLE
        Invoke-ADCGetFilteraction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilteraction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filteraction/
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
        Write-Verbose "Invoke-ADCGetFilteraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filteraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filteraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filteraction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filteraction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filteraction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filteraction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER GetAll 
        Retreive all filterglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterglobalbinding
    .EXAMPLE 
        Invoke-ADCGetFilterglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetFilterglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_binding/
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
        Write-Verbose "Invoke-ADCGetFilterglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Filter configuration Object
    .DESCRIPTION
        Add Filter configuration Object 
    .PARAMETER policyname 
        The name of the filter policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER state 
        State of the binding.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created filterglobal_filterpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddFilterglobalfilterpolicybinding -policyname <string>
    .NOTES
        File Name : Invoke-ADCAddFilterglobalfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding/
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

        [double]$priority ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterglobalfilterpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
 
            if ($PSCmdlet.ShouldProcess("filterglobal_filterpolicy_binding", "Add Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterglobal_filterpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilterglobalfilterpolicybinding -Filter $Payload)
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
        Delete Filter configuration Object
    .DESCRIPTION
        Delete Filter configuration Object
     .PARAMETER policyname 
       The name of the filter policy.
    .EXAMPLE
        Invoke-ADCDeleteFilterglobalfilterpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteFilterglobalfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteFilterglobalfilterpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("filterglobal_filterpolicy_binding", "Delete Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER GetAll 
        Retreive all filterglobal_filterpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterglobal_filterpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterglobalfilterpolicybinding
    .EXAMPLE 
        Invoke-ADCGetFilterglobalfilterpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterglobalfilterpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetFilterglobalfilterpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterglobalfilterpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterglobalfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterglobal_filterpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetFilterglobalfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterglobal_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterglobal_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterglobal_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterglobal_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER rate 
        For a rate of x, HTML injection is done for 1 out of x policy matches.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER frequency 
        For a frequency of x, HTML injection is done at least once per x milliseconds.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER strict 
        Searching for <html> tag. If this parameter is enabled, HTML injection does not insert the prebody or postbody content unless the <html> tag is found.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER htmlsearchlen 
        Number of characters, in the HTTP body, in which to search for the <html> tag if strict mode is set.  
        Default value: 1024  
        Minimum value = 1
    .EXAMPLE
        Invoke-ADCUpdateFilterhtmlinjectionparameter 
    .NOTES
        File Name : Invoke-ADCUpdateFilterhtmlinjectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter/
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

        [double]$rate ,

        [double]$frequency ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$strict ,

        [double]$htmlsearchlen 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rate')) { $Payload.Add('rate', $rate) }
            if ($PSBoundParameters.ContainsKey('frequency')) { $Payload.Add('frequency', $frequency) }
            if ($PSBoundParameters.ContainsKey('strict')) { $Payload.Add('strict', $strict) }
            if ($PSBoundParameters.ContainsKey('htmlsearchlen')) { $Payload.Add('htmlsearchlen', $htmlsearchlen) }
 
            if ($PSCmdlet.ShouldProcess("filterhtmlinjectionparameter", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterhtmlinjectionparameter -Payload $Payload -GetWarning
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
        Unset Filter configuration Object
    .DESCRIPTION
        Unset Filter configuration Object 
   .PARAMETER rate 
       For a rate of x, HTML injection is done for 1 out of x policy matches. 
   .PARAMETER frequency 
       For a frequency of x, HTML injection is done at least once per x milliseconds. 
   .PARAMETER strict 
       Searching for <html> tag. If this parameter is enabled, HTML injection does not insert the prebody or postbody content unless the <html> tag is found.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER htmlsearchlen 
       Number of characters, in the HTTP body, in which to search for the <html> tag if strict mode is set.
    .EXAMPLE
        Invoke-ADCUnsetFilterhtmlinjectionparameter 
    .NOTES
        File Name : Invoke-ADCUnsetFilterhtmlinjectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter
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

        [Boolean]$rate ,

        [Boolean]$frequency ,

        [Boolean]$strict ,

        [Boolean]$htmlsearchlen 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('rate')) { $Payload.Add('rate', $rate) }
            if ($PSBoundParameters.ContainsKey('frequency')) { $Payload.Add('frequency', $frequency) }
            if ($PSBoundParameters.ContainsKey('strict')) { $Payload.Add('strict', $strict) }
            if ($PSBoundParameters.ContainsKey('htmlsearchlen')) { $Payload.Add('htmlsearchlen', $htmlsearchlen) }
            if ($PSCmdlet.ShouldProcess("filterhtmlinjectionparameter", "Unset Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER GetAll 
        Retreive all filterhtmlinjectionparameter object(s)
    .PARAMETER Count
        If specified, the count of the filterhtmlinjectionparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionparameter
    .EXAMPLE 
        Invoke-ADCGetFilterhtmlinjectionparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterhtmlinjectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionparameter/
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
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filterhtmlinjectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterhtmlinjectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterhtmlinjectionparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterhtmlinjectionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterhtmlinjectionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Filter configuration Object
    .DESCRIPTION
        Add Filter configuration Object 
    .PARAMETER variable 
        Name for the HTML injection variable to be added.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER value 
        Value to be assigned to the new variable.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created filterhtmlinjectionvariable item.
    .EXAMPLE
        Invoke-ADCAddFilterhtmlinjectionvariable -variable <string>
    .NOTES
        File Name : Invoke-ADCAddFilterhtmlinjectionvariable
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable/
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
        [string]$variable ,

        [ValidateLength(1, 31)]
        [string]$value ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $Payload = @{
                variable = $variable
            }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
 
            if ($PSCmdlet.ShouldProcess("filterhtmlinjectionvariable", "Add Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filterhtmlinjectionvariable -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilterhtmlinjectionvariable -Filter $Payload)
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
        Delete Filter configuration Object
    .DESCRIPTION
        Delete Filter configuration Object
    .PARAMETER variable 
       Name for the HTML injection variable to be added.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteFilterhtmlinjectionvariable -variable <string>
    .NOTES
        File Name : Invoke-ADCDeleteFilterhtmlinjectionvariable
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable/
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
        [string]$variable 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$variable", "Delete Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Resource $variable -Arguments $Arguments
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER variable 
        Name for the HTML injection variable to be added.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER value 
        Value to be assigned to the new variable.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created filterhtmlinjectionvariable item.
    .EXAMPLE
        Invoke-ADCUpdateFilterhtmlinjectionvariable -variable <string>
    .NOTES
        File Name : Invoke-ADCUpdateFilterhtmlinjectionvariable
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable/
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
        [string]$variable ,

        [ValidateLength(1, 31)]
        [string]$value ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $Payload = @{
                variable = $variable
            }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
 
            if ($PSCmdlet.ShouldProcess("filterhtmlinjectionvariable", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterhtmlinjectionvariable -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilterhtmlinjectionvariable -Filter $Payload)
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
        Unset Filter configuration Object
    .DESCRIPTION
        Unset Filter configuration Object 
   .PARAMETER variable 
       Name for the HTML injection variable to be added. 
   .PARAMETER value 
       Value to be assigned to the new variable.
    .EXAMPLE
        Invoke-ADCUnsetFilterhtmlinjectionvariable -variable <string>
    .NOTES
        File Name : Invoke-ADCUnsetFilterhtmlinjectionvariable
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable
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
        [string]$variable ,

        [Boolean]$value 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterhtmlinjectionvariable: Starting"
    }
    process {
        try {
            $Payload = @{
                variable = $variable
            }
            if ($PSBoundParameters.ContainsKey('value')) { $Payload.Add('value', $value) }
            if ($PSCmdlet.ShouldProcess("$variable", "Unset Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER variable 
       Name for the HTML injection variable to be added. 
    .PARAMETER GetAll 
        Retreive all filterhtmlinjectionvariable object(s)
    .PARAMETER Count
        If specified, the count of the filterhtmlinjectionvariable object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionvariable
    .EXAMPLE 
        Invoke-ADCGetFilterhtmlinjectionvariable -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterhtmlinjectionvariable -Count
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionvariable -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterhtmlinjectionvariable -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterhtmlinjectionvariable
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterhtmlinjectionvariable/
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
        [string]$variable,

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
        Write-Verbose "Invoke-ADCGetFilterhtmlinjectionvariable: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filterhtmlinjectionvariable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterhtmlinjectionvariable objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterhtmlinjectionvariable objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterhtmlinjectionvariable configuration for property 'variable'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Resource $variable -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterhtmlinjectionvariable configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterhtmlinjectionvariable -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Filter configuration Object
    .DESCRIPTION
        Add Filter configuration Object 
    .PARAMETER name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
        Minimum length = 1 
    .PARAMETER rule 
        Citrix ADC classic expression specifying the type of connections that match this policy.  
        Minimum length = 1 
    .PARAMETER reqaction 
        Name of the action to be performed on requests that match the policy. Cannot be specified if the rule includes condition to be evaluated for responses.  
        Minimum length = 1 
    .PARAMETER resaction 
        The action to be performed on the response. The string value can be a filter action created filter action or a built-in action.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created filterpolicy item.
    .EXAMPLE
        Invoke-ADCAddFilterpolicy -name <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddFilterpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reqaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddFilterpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('reqaction')) { $Payload.Add('reqaction', $reqaction) }
            if ($PSBoundParameters.ContainsKey('resaction')) { $Payload.Add('resaction', $resaction) }
 
            if ($PSCmdlet.ShouldProcess("filterpolicy", "Add Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type filterpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilterpolicy -Filter $Payload)
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
        Delete Filter configuration Object
    .DESCRIPTION
        Delete Filter configuration Object
    .PARAMETER name 
       Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteFilterpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteFilterpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy/
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
        Write-Verbose "Invoke-ADCDeleteFilterpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type filterpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER name 
        Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy').  
        Minimum length = 1 
    .PARAMETER rule 
        Citrix ADC classic expression specifying the type of connections that match this policy.  
        Minimum length = 1 
    .PARAMETER reqaction 
        Name of the action to be performed on requests that match the policy. Cannot be specified if the rule includes condition to be evaluated for responses.  
        Minimum length = 1 
    .PARAMETER resaction 
        The action to be performed on the response. The string value can be a filter action created filter action or a built-in action.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created filterpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateFilterpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateFilterpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$reqaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('reqaction')) { $Payload.Add('reqaction', $reqaction) }
            if ($PSBoundParameters.ContainsKey('resaction')) { $Payload.Add('resaction', $resaction) }
 
            if ($PSCmdlet.ShouldProcess("filterpolicy", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetFilterpolicy -Filter $Payload)
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name for the filtering action. Must begin with a letter, number, or the underscore character (_). Other characters allowed, after the first character, are the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), and colon (:) characters. Choose a name that helps identify the type of action. The name cannot be updated after the policy is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my policy" or 'my policy'). 
    .PARAMETER GetAll 
        Retreive all filterpolicy object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicy
    .EXAMPLE 
        Invoke-ADCGetFilterpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterpolicy -Count
    .EXAMPLE
        Invoke-ADCGetFilterpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy/
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
        Write-Verbose "Invoke-ADCGetFilterpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filterpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retreive all filterpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicybinding
    .EXAMPLE 
        Invoke-ADCGetFilterpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetFilterpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetFilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retreive all filterpolicy_crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy_crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicycrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetFilterpolicycrvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterpolicycrvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetFilterpolicycrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicycrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicycrvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_crvserver_binding/
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
        Write-Verbose "Invoke-ADCGetFilterpolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retreive all filterpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetFilterpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetFilterpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetFilterpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retreive all filterpolicy_filterglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy_filterglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicyfilterglobalbinding
    .EXAMPLE 
        Invoke-ADCGetFilterpolicyfilterglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterpolicyfilterglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetFilterpolicyfilterglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicyfilterglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicyfilterglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_filterglobal_binding/
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
        Write-Verbose "Invoke-ADCGetFilterpolicyfilterglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterpolicy_filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_filterglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_filterglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_filterglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER name 
       Name of the filter policy to be displayed. If a name is not provided, information about all the filter policies is shown. 
    .PARAMETER GetAll 
        Retreive all filterpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the filterpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetFilterpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetFilterpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetFilterpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetFilterpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all filterpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving filterpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER postbody 
        Name of file whose contents are to be inserted after the response body.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateFilterpostbodyinjection -postbody <string>
    .NOTES
        File Name : Invoke-ADCUpdateFilterpostbodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection/
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
        [string]$postbody 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterpostbodyinjection: Starting"
    }
    process {
        try {
            $Payload = @{
                postbody = $postbody
            }

 
            if ($PSCmdlet.ShouldProcess("filterpostbodyinjection", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterpostbodyinjection -Payload $Payload -GetWarning
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
        Unset Filter configuration Object
    .DESCRIPTION
        Unset Filter configuration Object 
   .PARAMETER postbody 
       Name of file whose contents are to be inserted after the response body.
    .EXAMPLE
        Invoke-ADCUnsetFilterpostbodyinjection 
    .NOTES
        File Name : Invoke-ADCUnsetFilterpostbodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection
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

        [Boolean]$postbody 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterpostbodyinjection: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('postbody')) { $Payload.Add('postbody', $postbody) }
            if ($PSCmdlet.ShouldProcess("filterpostbodyinjection", "Unset Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterpostbodyinjection -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER GetAll 
        Retreive all filterpostbodyinjection object(s)
    .PARAMETER Count
        If specified, the count of the filterpostbodyinjection object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterpostbodyinjection
    .EXAMPLE 
        Invoke-ADCGetFilterpostbodyinjection -GetAll
    .EXAMPLE
        Invoke-ADCGetFilterpostbodyinjection -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterpostbodyinjection -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterpostbodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterpostbodyinjection/
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
        Write-Verbose "Invoke-ADCGetFilterpostbodyinjection: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filterpostbodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterpostbodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterpostbodyinjection objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterpostbodyinjection configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterpostbodyinjection configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterpostbodyinjection -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Filter configuration Object
    .DESCRIPTION
        Update Filter configuration Object 
    .PARAMETER prebody 
        Name of file whose contents are to be inserted before the response body.  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateFilterprebodyinjection -prebody <string>
    .NOTES
        File Name : Invoke-ADCUpdateFilterprebodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection/
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
        [string]$prebody 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateFilterprebodyinjection: Starting"
    }
    process {
        try {
            $Payload = @{
                prebody = $prebody
            }

 
            if ($PSCmdlet.ShouldProcess("filterprebodyinjection", "Update Filter configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type filterprebodyinjection -Payload $Payload -GetWarning
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
        Unset Filter configuration Object
    .DESCRIPTION
        Unset Filter configuration Object 
   .PARAMETER prebody 
       Name of file whose contents are to be inserted before the response body.
    .EXAMPLE
        Invoke-ADCUnsetFilterprebodyinjection 
    .NOTES
        File Name : Invoke-ADCUnsetFilterprebodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection
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

        [Boolean]$prebody 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetFilterprebodyinjection: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('prebody')) { $Payload.Add('prebody', $prebody) }
            if ($PSCmdlet.ShouldProcess("filterprebodyinjection", "Unset Filter configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type filterprebodyinjection -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Filter configuration object(s)
    .DESCRIPTION
        Get Filter configuration object(s)
    .PARAMETER GetAll 
        Retreive all filterprebodyinjection object(s)
    .PARAMETER Count
        If specified, the count of the filterprebodyinjection object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetFilterprebodyinjection
    .EXAMPLE 
        Invoke-ADCGetFilterprebodyinjection -GetAll
    .EXAMPLE
        Invoke-ADCGetFilterprebodyinjection -name <string>
    .EXAMPLE
        Invoke-ADCGetFilterprebodyinjection -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetFilterprebodyinjection
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/filter/filterprebodyinjection/
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
        Write-Verbose "Invoke-ADCGetFilterprebodyinjection: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all filterprebodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for filterprebodyinjection objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving filterprebodyinjection objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving filterprebodyinjection configuration for property ''"

            } else {
                Write-Verbose "Retrieving filterprebodyinjection configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type filterprebodyinjection -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


