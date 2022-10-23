function Invoke-ADCUpdateScparameter {
    <#
    .SYNOPSIS
        Update Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SC parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the SureConnect alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
    .PARAMETER Vsr 
        File containing the customized response to be displayed when the ACTION in the SureConnect policy is set to NS.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateScparameter 
        An example how to update scparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateScparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter.md/
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

        [ValidateRange(1, 4294967294)]
        [double]$Sessionlife,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vsr 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateScparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('vsr') ) { $payload.Add('vsr', $vsr) }
            if ( $PSCmdlet.ShouldProcess("scparameter", "Update Sure Connect configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type scparameter -Payload $payload -GetWarning
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
        Unset Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SC parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the SureConnect alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
    .PARAMETER Vsr 
        File containing the customized response to be displayed when the ACTION in the SureConnect policy is set to NS.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetScparameter 
        An example how to unset scparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetScparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter.md
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

        [Boolean]$sessionlife,

        [Boolean]$vsr 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetScparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('vsr') ) { $payload.Add('vsr', $vsr) }
            if ( $PSCmdlet.ShouldProcess("scparameter", "Unset Sure Connect configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type scparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Sure Connect configuration object(s).
    .DESCRIPTION
        Configuration for SC parameter resource.
    .PARAMETER GetAll 
        Retrieve all scparameter object(s).
    .PARAMETER Count
        If specified, the count of the scparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetScparameter -GetAll 
        Get all scparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScparameter -name <string>
        Get scparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScparameter -Filter @{ 'name'='<value>' }
        Get scparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetScparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scparameter.md/
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
        Write-Verbose "Invoke-ADCGetScparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all scparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for scparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving scparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving scparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving scparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SureConnect policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Url 
        URL against which to match incoming client request. 
    .PARAMETER Rule 
        Expression against which the traffic is evaluated. 
        Maximum length of a string literal in the expression is 255 characters. A longer string can be split into smaller strings of up to 255 characters each, and the smaller strings concatenated with the + operator. For example, you can create a 500-character string as follows: '"<string of 255 characters>" + "<string of 245 characters>"' 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule. 
    .PARAMETER Action 
        Action to be taken when the delay or maximum-connections threshold is reached. Available settings function as follows: 
        ACS - Serve content from an alternative content service. 
        NS - Serve alternative content from the Citrix ADC. 
        NO ACTION - Serve no alternative content. However, delay statistics are still collected for the configured URLs, and, if the Maximum Client Connections parameter is set, the number of connections is limited to the value specified by that parameter. (However, alternative content is not served even if the maxConn threshold is met). 
        Possible values = ACS, NS, NOACTION 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS action. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS action. 
    .PARAMETER PassThru 
        Return details about the created scpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddScpolicy -name <string>
        An example how to add scpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddScpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy.md/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [string]$Url,

        [string]$Rule,

        [ValidateRange(1, 599999999)]
        [double]$Delay,

        [ValidateRange(1, 4294967294)]
        [double]$Maxconn,

        [ValidateSet('ACS', 'NS', 'NOACTION')]
        [string]$Action,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(1, 127)]
        [string]$Altcontentpath,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddScpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSCmdlet.ShouldProcess("scpolicy", "Add Sure Connect configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type scpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetScpolicy -Filter $payload)
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
        Delete Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SureConnect policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteScpolicy -Name <string>
        An example how to delete scpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteScpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy.md/
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
        Write-Verbose "Invoke-ADCDeleteScpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Sure Connect configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type scpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SureConnect policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Url 
        URL against which to match incoming client request. 
    .PARAMETER Rule 
        Expression against which the traffic is evaluated. 
        Maximum length of a string literal in the expression is 255 characters. A longer string can be split into smaller strings of up to 255 characters each, and the smaller strings concatenated with the + operator. For example, you can create a 500-character string as follows: '"<string of 255 characters>" + "<string of 245 characters>"' 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule. 
    .PARAMETER Action 
        Action to be taken when the delay or maximum-connections threshold is reached. Available settings function as follows: 
        ACS - Serve content from an alternative content service. 
        NS - Serve alternative content from the Citrix ADC. 
        NO ACTION - Serve no alternative content. However, delay statistics are still collected for the configured URLs, and, if the Maximum Client Connections parameter is set, the number of connections is limited to the value specified by that parameter. (However, alternative content is not served even if the maxConn threshold is met). 
        Possible values = ACS, NS, NOACTION 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS action. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS action. 
    .PARAMETER PassThru 
        Return details about the created scpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateScpolicy -name <string>
        An example how to update scpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateScpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy.md/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [string]$Url,

        [string]$Rule,

        [ValidateRange(1, 599999999)]
        [double]$Delay,

        [ValidateRange(1, 4294967294)]
        [double]$Maxconn,

        [ValidateSet('ACS', 'NS', 'NOACTION')]
        [string]$Action,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(1, 127)]
        [string]$Altcontentpath,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateScpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSCmdlet.ShouldProcess("scpolicy", "Update Sure Connect configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type scpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetScpolicy -Filter $payload)
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
        Unset Sure Connect configuration Object.
    .DESCRIPTION
        Configuration for SureConnect policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's URL or rule. If the delay statistics gathered for the matching request exceed the specified delay, SureConnect is triggered for that request. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that match the policy's URL or rule.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetScpolicy -name <string>
        An example how to unset scpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetScpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy.md
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
        [ValidateLength(1, 31)]
        [string]$Name,

        [Boolean]$delay,

        [Boolean]$maxconn 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetScpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Sure Connect configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type scpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Sure Connect configuration object(s).
    .DESCRIPTION
        Configuration for SureConnect policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all scpolicy object(s).
    .PARAMETER Count
        If specified, the count of the scpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetScpolicy -GetAll 
        Get all scpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetScpolicy -Count 
        Get the number of scpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScpolicy -name <string>
        Get scpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetScpolicy -Filter @{ 'name'='<value>' }
        Get scpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetScpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/sc/scpolicy.md/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][ ]|[:]|[@]|[=]|[-])+)$')]
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
        Write-Verbose "Invoke-ADCGetScpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all scpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for scpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving scpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving scpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving scpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type scpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


