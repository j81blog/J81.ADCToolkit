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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCArCOwOJgNkwLnB
# sCRLN0rpRewf+FnNblMfk0XgF7Fk6aCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgYG4aDhsi6FtJrR14l2l3nO8qi8BEItJna5jZyh/mVp4wDQYJKoZIhvcNAQEB
# BQAEggEAPR6YXdrqs4K5sYCk1L3SlMH3aa83mcHqW+TGtExk12kv0cPX2ZFVS4w9
# EEBNNBzlqNRRRfmJCOmpSCakFhgyhCNuUkIFq9ET+xE87lIjWDJB5IFjGa82Lqxi
# ZzS5xXSaGtiBWtKgUNjsB/z0WUVb8iyeBWM8bZITlI6mZDdjSSbGC5cr0eXfxnlx
# 1h40LyBYkWWRfIBMv0gnm1NBrP2esCE9P/MScqRtccTKetp5UqkIoPIP3utiMDLh
# CwmhNgkeiNn4do3YbAr2CxMDXpjJ+mMnHplJkFWknbQBuZ5EzXoPu7leLUdtstoK
# pKBkI3xyFpgpEPAXn4xYaqfDF6DF5A==
# SIG # End signature block
