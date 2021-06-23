function Invoke-ADCUpdateScparameter {
<#
    .SYNOPSIS
        Update Sure Connect configuration Object
    .DESCRIPTION
        Update Sure Connect configuration Object 
    .PARAMETER sessionlife 
        Time, in seconds, between the first time and the next time the SureConnect alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session.  
        Default value: 300  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER vsr 
        File containing the customized response to be displayed when the ACTION in the SureConnect policy is set to NS.  
        Default value: "DEFAULT"  
        Minimum length = 1
    .EXAMPLE
        Invoke-ADCUpdateScparameter 
    .NOTES
        File Name : Invoke-ADCUpdateScparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter/
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

        [ValidateRange(1, 4294967294)]
        [double]$sessionlife ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vsr 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateScparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sessionlife')) { $Payload.Add('sessionlife', $sessionlife) }
            if ($PSBoundParameters.ContainsKey('vsr')) { $Payload.Add('vsr', $vsr) }
 
            if ($PSCmdlet.ShouldProcess("scparameter", "Update Sure Connect configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type scparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateScparameter: Finished"
    }
}

function Invoke-ADCUnsetScparameter {
<#
    .SYNOPSIS
        Unset Sure Connect configuration Object
    .DESCRIPTION
        Unset Sure Connect configuration Object 
   .PARAMETER sessionlife 
       Time, in seconds, between the first time and the next time the SureConnect alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
   .PARAMETER vsr 
       File containing the customized response to be displayed when the ACTION in the SureConnect policy is set to NS.
    .EXAMPLE
        Invoke-ADCUnsetScparameter 
    .NOTES
        File Name : Invoke-ADCUnsetScparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter
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

        [Boolean]$sessionlife ,

        [Boolean]$vsr 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetScparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sessionlife')) { $Payload.Add('sessionlife', $sessionlife) }
            if ($PSBoundParameters.ContainsKey('vsr')) { $Payload.Add('vsr', $vsr) }
            if ($PSCmdlet.ShouldProcess("scparameter", "Unset Sure Connect configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type scparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetScparameter: Finished"
    }
}

function Invoke-ADCGetScparameter {
<#
    .SYNOPSIS
        Get Sure Connect configuration object(s)
    .DESCRIPTION
        Get Sure Connect configuration object(s)
    .PARAMETER GetAll 
        Retreive all scparameter object(s)
    .PARAMETER Count
        If specified, the count of the scparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetScparameter
    .EXAMPLE 
        Invoke-ADCGetScparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetScparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetScparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetScparameter
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter/
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
        Write-Verbose "Invoke-ADCGetScparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all scparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for scparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving scparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving scparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving scparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetScparameter: Ended"
    }
}

function Invoke-ADCAddScpolicy {
<#
    .SYNOPSIS
        Add Sure Connect configuration Object
    .DESCRIPTION
        Add Sure Connect configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER url 
        URL against which to match incoming client request.  
        Maximum length = 127 
    .PARAMETER rule 
        Expression against which the traffic is evaluated.  
        Maximum length of a string literal in the expression is 255 characters. A longer string can be split into smaller strings of up to 255 characters each, and the smaller strings concatenated with the + operator. For example, you can create a 500-character string as follows: '"<string of 255 characters>" + "<string of 245 characters>"'  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Maximum length = 1499 
    .PARAMETER delay 
        Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request.  
        Minimum value = 1  
        Maximum value = 599999999 
    .PARAMETER maxconn 
        Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule.  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER action 
        Action to be taken when the delay or maximum-connections threshold is reached. Available settings function as follows:  
        ACS - Serve content from an alternative content service.  
        NS - Serve alternative content from the Citrix ADC.  
        NO ACTION - Serve no alternative content. However, delay statistics are still collected for the configured URLs, and, if the Maximum Client Connections parameter is set, the number of connections is limited to the value specified by that parameter. (However, alternative content is not served even if the maxConn threshold is met).  
        Possible values = ACS, NS, NOACTION 
    .PARAMETER altcontentsvcname 
        Name of the alternative content service to be used in the ACS action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER altcontentpath 
        Path to the alternative content service to be used in the ACS action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created scpolicy item.
    .EXAMPLE
        Invoke-ADCAddScpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCAddScpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$url ,

        [string]$rule ,

        [ValidateRange(1, 599999999)]
        [double]$delay ,

        [ValidateRange(1, 4294967294)]
        [double]$maxconn ,

        [ValidateSet('ACS', 'NS', 'NOACTION')]
        [string]$action ,

        [ValidateLength(1, 127)]
        [string]$altcontentsvcname ,

        [ValidateLength(1, 127)]
        [string]$altcontentpath ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddScpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('altcontentsvcname')) { $Payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ($PSBoundParameters.ContainsKey('altcontentpath')) { $Payload.Add('altcontentpath', $altcontentpath) }
 
            if ($PSCmdlet.ShouldProcess("scpolicy", "Add Sure Connect configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type scpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetScpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddScpolicy: Finished"
    }
}

function Invoke-ADCDeleteScpolicy {
<#
    .SYNOPSIS
        Delete Sure Connect configuration Object
    .DESCRIPTION
        Delete Sure Connect configuration Object
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteScpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteScpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy/
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
        Write-Verbose "Invoke-ADCDeleteScpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Sure Connect configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type scpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteScpolicy: Finished"
    }
}

function Invoke-ADCUpdateScpolicy {
<#
    .SYNOPSIS
        Update Sure Connect configuration Object
    .DESCRIPTION
        Update Sure Connect configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER url 
        URL against which to match incoming client request.  
        Maximum length = 127 
    .PARAMETER rule 
        Expression against which the traffic is evaluated.  
        Maximum length of a string literal in the expression is 255 characters. A longer string can be split into smaller strings of up to 255 characters each, and the smaller strings concatenated with the + operator. For example, you can create a 500-character string as follows: '"<string of 255 characters>" + "<string of 245 characters>"'  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks.  
        Maximum length = 1499 
    .PARAMETER delay 
        Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request.  
        Minimum value = 1  
        Maximum value = 599999999 
    .PARAMETER maxconn 
        Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule.  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER action 
        Action to be taken when the delay or maximum-connections threshold is reached. Available settings function as follows:  
        ACS - Serve content from an alternative content service.  
        NS - Serve alternative content from the Citrix ADC.  
        NO ACTION - Serve no alternative content. However, delay statistics are still collected for the configured URLs, and, if the Maximum Client Connections parameter is set, the number of connections is limited to the value specified by that parameter. (However, alternative content is not served even if the maxConn threshold is met).  
        Possible values = ACS, NS, NOACTION 
    .PARAMETER altcontentsvcname 
        Name of the alternative content service to be used in the ACS action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER altcontentpath 
        Path to the alternative content service to be used in the ACS action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER PassThru 
        Return details about the created scpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateScpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateScpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$url ,

        [string]$rule ,

        [ValidateRange(1, 599999999)]
        [double]$delay ,

        [ValidateRange(1, 4294967294)]
        [double]$maxconn ,

        [ValidateSet('ACS', 'NS', 'NOACTION')]
        [string]$action ,

        [ValidateLength(1, 127)]
        [string]$altcontentsvcname ,

        [ValidateLength(1, 127)]
        [string]$altcontentpath ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateScpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('altcontentsvcname')) { $Payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ($PSBoundParameters.ContainsKey('altcontentpath')) { $Payload.Add('altcontentpath', $altcontentpath) }
 
            if ($PSCmdlet.ShouldProcess("scpolicy", "Update Sure Connect configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type scpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetScpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateScpolicy: Finished"
    }
}

function Invoke-ADCUnsetScpolicy {
<#
    .SYNOPSIS
        Unset Sure Connect configuration Object
    .DESCRIPTION
        Unset Sure Connect configuration Object 
   .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
   .PARAMETER delay 
       Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request. 
   .PARAMETER maxconn 
       Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule.
    .EXAMPLE
        Invoke-ADCUnsetScpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetScpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 31)]
        [string]$name ,

        [Boolean]$delay ,

        [Boolean]$maxconn 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetScpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Sure Connect configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type scpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetScpolicy: Finished"
    }
}

function Invoke-ADCGetScpolicy {
<#
    .SYNOPSIS
        Get Sure Connect configuration object(s)
    .DESCRIPTION
        Get Sure Connect configuration object(s)
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all scpolicy object(s)
    .PARAMETER Count
        If specified, the count of the scpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetScpolicy
    .EXAMPLE 
        Invoke-ADCGetScpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetScpolicy -Count
    .EXAMPLE
        Invoke-ADCGetScpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetScpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetScpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetScpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all scpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for scpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving scpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving scpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving scpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetScpolicy: Ended"
    }
}


