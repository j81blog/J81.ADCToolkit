function Invoke-ADCUnsetAppqoeaction {
    <#
    .SYNOPSIS
        Unset Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
    .PARAMETER Numretries 
        Retry count.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppqoeaction -name <string>
        An example how to unset appqoeaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppqoeaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction
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

        [Boolean]$priority,

        [Boolean]$altcontentsvcname,

        [Boolean]$altcontentpath,

        [Boolean]$polqdepth,

        [Boolean]$priqdepth,

        [Boolean]$maxconn,

        [Boolean]$delay,

        [Boolean]$dosaction,

        [Boolean]$tcpprofile,

        [Boolean]$retryonreset,

        [Boolean]$retryontimeout,

        [Boolean]$numretries 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Appqoe configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appqoeaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppqoeaction: Finished"
    }
}

function Invoke-ADCDeleteAppqoeaction {
    <#
    .SYNOPSIS
        Delete Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppqoeaction -Name <string>
        An example how to delete appqoeaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppqoeaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-ADCDeleteAppqoeaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAppqoeaction: Finished"
    }
}

function Invoke-ADCUpdateAppqoeaction {
    <#
    .SYNOPSIS
        Update Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
    .PARAMETER Dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
    .PARAMETER Numretries 
        Retry count. 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppqoeaction -name <string>
        An example how to update appqoeaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppqoeaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$Priority,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(4, 127)]
        [string]$Altcontentpath,

        [ValidateRange(0, 4294967294)]
        [double]$Polqdepth,

        [ValidateRange(0, 4294967294)]
        [double]$Priqdepth,

        [ValidateRange(1, 4294967294)]
        [double]$Maxconn,

        [ValidateRange(1, 599999999)]
        [double]$Delay,

        [string]$Dostrigexpression,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$Dosaction,

        [ValidateLength(1, 127)]
        [string]$Tcpprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Retryonreset,

        [ValidateRange(30, 2000)]
        [double]$Retryontimeout,

        [ValidateRange(0, 7)]
        [double]$Numretries,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dostrigexpression') ) { $payload.Add('dostrigexpression', $dostrigexpression) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("appqoeaction", "Update Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoeaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppqoeaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAppqoeaction: Finished"
    }
}

function Invoke-ADCAddAppqoeaction {
    <#
    .SYNOPSIS
        Add Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER Priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request. 
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER Respondwith 
        Responder action to be taken when the threshold is reached. Available settings function as follows: 
        ACS - Serve content from an alternative content service 
        Threshold : maxConn or delay 
        NS - Serve from the Citrix ADC (built-in response) 
        Threshold : maxConn or delay. 
        Possible values = ACS, NS 
    .PARAMETER Customfile 
        name of the HTML page object to use as the response. 
    .PARAMETER Altcontentsvcname 
        Name of the alternative content service to be used in the ACS. 
    .PARAMETER Altcontentpath 
        Path to the alternative content service to be used in the ACS. 
    .PARAMETER Polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
    .PARAMETER Maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule. 
    .PARAMETER Delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
    .PARAMETER Dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER Dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention. 
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER Tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters. 
    .PARAMETER Retryonreset 
        Retry on TCP Reset. 
        Possible values = YES, NO 
    .PARAMETER Retryontimeout 
        Retry on request Timeout(in millisec) upon sending request to backend servers. 
    .PARAMETER Numretries 
        Retry count. 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppqoeaction -name <string>
        An example how to add appqoeaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppqoeaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$Priority,

        [ValidateSet('ACS', 'NS')]
        [string]$Respondwith,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customfile,

        [ValidateLength(1, 127)]
        [string]$Altcontentsvcname,

        [ValidateLength(4, 127)]
        [string]$Altcontentpath,

        [ValidateRange(0, 4294967294)]
        [double]$Polqdepth,

        [ValidateRange(0, 4294967294)]
        [double]$Priqdepth,

        [ValidateRange(1, 4294967294)]
        [double]$Maxconn,

        [ValidateRange(1, 599999999)]
        [double]$Delay,

        [string]$Dostrigexpression,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$Dosaction,

        [ValidateLength(1, 127)]
        [string]$Tcpprofile,

        [ValidateSet('YES', 'NO')]
        [string]$Retryonreset = 'NO',

        [ValidateRange(30, 2000)]
        [double]$Retryontimeout,

        [ValidateRange(0, 7)]
        [double]$Numretries = '3',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppqoeaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('respondwith') ) { $payload.Add('respondwith', $respondwith) }
            if ( $PSBoundParameters.ContainsKey('customfile') ) { $payload.Add('customfile', $customfile) }
            if ( $PSBoundParameters.ContainsKey('altcontentsvcname') ) { $payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ( $PSBoundParameters.ContainsKey('altcontentpath') ) { $payload.Add('altcontentpath', $altcontentpath) }
            if ( $PSBoundParameters.ContainsKey('polqdepth') ) { $payload.Add('polqdepth', $polqdepth) }
            if ( $PSBoundParameters.ContainsKey('priqdepth') ) { $payload.Add('priqdepth', $priqdepth) }
            if ( $PSBoundParameters.ContainsKey('maxconn') ) { $payload.Add('maxconn', $maxconn) }
            if ( $PSBoundParameters.ContainsKey('delay') ) { $payload.Add('delay', $delay) }
            if ( $PSBoundParameters.ContainsKey('dostrigexpression') ) { $payload.Add('dostrigexpression', $dostrigexpression) }
            if ( $PSBoundParameters.ContainsKey('dosaction') ) { $payload.Add('dosaction', $dosaction) }
            if ( $PSBoundParameters.ContainsKey('tcpprofile') ) { $payload.Add('tcpprofile', $tcpprofile) }
            if ( $PSBoundParameters.ContainsKey('retryonreset') ) { $payload.Add('retryonreset', $retryonreset) }
            if ( $PSBoundParameters.ContainsKey('retryontimeout') ) { $payload.Add('retryontimeout', $retryontimeout) }
            if ( $PSBoundParameters.ContainsKey('numretries') ) { $payload.Add('numretries', $numretries) }
            if ( $PSCmdlet.ShouldProcess("appqoeaction", "Add Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoeaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppqoeaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAppqoeaction: Finished"
    }
}

function Invoke-ADCGetAppqoeaction {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Configuration for AppQoS action resource.
    .PARAMETER Name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER GetAll 
        Retrieve all appqoeaction object(s).
    .PARAMETER Count
        If specified, the count of the appqoeaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoeaction -GetAll 
        Get all appqoeaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoeaction -Count 
        Get the number of appqoeaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeaction -name <string>
        Get appqoeaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeaction -Filter @{ 'name'='<value>' }
        Get appqoeaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoeaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-ADCGetAppqoeaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoeaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoeaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoeaction: Ended"
    }
}

function Invoke-ADCChangeAppqoecustomresp {
    <#
    .SYNOPSIS
        Change Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeAppqoecustomresp -name <string>
        An example how to change appqoecustomresp configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeAppqoecustomresp
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppqoecustomresp: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("appqoecustomresp", "Change Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action update -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCChangeAppqoecustomresp: Finished"
    }
}

function Invoke-ADCDeleteAppqoecustomresp {
    <#
    .SYNOPSIS
        Delete Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppqoecustomresp -Name <string>
        An example how to delete appqoecustomresp configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppqoecustomresp
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        Write-Verbose "Invoke-ADCDeleteAppqoecustomresp: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoecustomresp -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAppqoecustomresp: Finished"
    }
}

function Invoke-ADCImportAppqoecustomresp {
    <#
    .SYNOPSIS
        Import Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER Src 
        . 
    .PARAMETER Name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppqoecustomresp -name <string>
        An example how to import appqoecustomresp configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppqoecustomresp
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppqoecustomresp: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('src') ) { $payload.Add('src', $src) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action import -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppqoecustomresp: Finished"
    }
}

function Invoke-ADCGetAppqoecustomresp {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Configuration for AppQoE custom response page resource.
    .PARAMETER GetAll 
        Retrieve all appqoecustomresp object(s).
    .PARAMETER Count
        If specified, the count of the appqoecustomresp object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoecustomresp
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoecustomresp -GetAll 
        Get all appqoecustomresp data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoecustomresp -Count 
        Get the number of appqoecustomresp objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoecustomresp -name <string>
        Get appqoecustomresp object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoecustomresp -Filter @{ 'name'='<value>' }
        Get appqoecustomresp data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoecustomresp
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppqoecustomresp: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoecustomresp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoecustomresp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoecustomresp objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoecustomresp configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoecustomresp configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoecustomresp: Ended"
    }
}

function Invoke-ADCUpdateAppqoeparameter {
    <#
    .SYNOPSIS
        Update Appqoe configuration Object.
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
    .PARAMETER Avgwaitingclient 
        average number of client connections, that can sit in service waiting queue. 
    .PARAMETER Maxaltrespbandwidth 
        maximum bandwidth which will determine whether to send alternate content response. 
    .PARAMETER Dosattackthresh 
        average number of client connection that can queue up on vserver level without triggering DoS mitigation module.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppqoeparameter 
        An example how to update appqoeparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppqoeparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter/
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

        [ValidateRange(0, 4294967294)]
        [double]$Avgwaitingclient,

        [ValidateRange(1, 4294967294)]
        [double]$Maxaltrespbandwidth,

        [ValidateRange(0, 4294967294)]
        [double]$Dosattackthresh 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoeparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('avgwaitingclient') ) { $payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ( $PSBoundParameters.ContainsKey('maxaltrespbandwidth') ) { $payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ( $PSBoundParameters.ContainsKey('dosattackthresh') ) { $payload.Add('dosattackthresh', $dosattackthresh) }
            if ( $PSCmdlet.ShouldProcess("appqoeparameter", "Update Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoeparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAppqoeparameter: Finished"
    }
}

function Invoke-ADCUnsetAppqoeparameter {
    <#
    .SYNOPSIS
        Unset Appqoe configuration Object.
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER Sessionlife 
        Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
    .PARAMETER Avgwaitingclient 
        average number of client connections, that can sit in service waiting queue. 
    .PARAMETER Maxaltrespbandwidth 
        maximum bandwidth which will determine whether to send alternate content response. 
    .PARAMETER Dosattackthresh 
        average number of client connection that can queue up on vserver level without triggering DoS mitigation module.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppqoeparameter 
        An example how to unset appqoeparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppqoeparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter
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

        [Boolean]$avgwaitingclient,

        [Boolean]$maxaltrespbandwidth,

        [Boolean]$dosattackthresh 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppqoeparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('sessionlife') ) { $payload.Add('sessionlife', $sessionlife) }
            if ( $PSBoundParameters.ContainsKey('avgwaitingclient') ) { $payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ( $PSBoundParameters.ContainsKey('maxaltrespbandwidth') ) { $payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ( $PSBoundParameters.ContainsKey('dosattackthresh') ) { $payload.Add('dosattackthresh', $dosattackthresh) }
            if ( $PSCmdlet.ShouldProcess("appqoeparameter", "Unset Appqoe configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appqoeparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppqoeparameter: Finished"
    }
}

function Invoke-ADCGetAppqoeparameter {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Configuration for QOS parameter resource.
    .PARAMETER GetAll 
        Retrieve all appqoeparameter object(s).
    .PARAMETER Count
        If specified, the count of the appqoeparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoeparameter -GetAll 
        Get all appqoeparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeparameter -name <string>
        Get appqoeparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoeparameter -Filter @{ 'name'='<value>' }
        Get appqoeparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoeparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter/
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
        Write-Verbose "Invoke-ADCGetAppqoeparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoeparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoeparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoeparameter: Ended"
    }
}

function Invoke-ADCDeleteAppqoepolicy {
    <#
    .SYNOPSIS
        Delete Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        .
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppqoepolicy -Name <string>
        An example how to delete appqoepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppqoepolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppqoepolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAppqoepolicy: Finished"
    }
}

function Invoke-ADCUpdateAppqoepolicy {
    <#
    .SYNOPSIS
        Update Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER Rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER Action 
        Configured AppQoE action to trigger. 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppqoepolicy -name <string>
        An example how to update appqoepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppqoepolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("appqoepolicy", "Update Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppqoepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAppqoepolicy: Finished"
    }
}

function Invoke-ADCAddAppqoepolicy {
    <#
    .SYNOPSIS
        Add Appqoe configuration Object.
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER Rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER Action 
        Configured AppQoE action to trigger. 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppqoepolicy -name <string> -rule <string> -action <string>
        An example how to add appqoepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppqoepolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppqoepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("appqoepolicy", "Add Appqoe configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppqoepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAppqoepolicy: Finished"
    }
}

function Invoke-ADCGetAppqoepolicy {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Configuration for AppQoS policy resource.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoepolicy -GetAll 
        Get all appqoepolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoepolicy -Count 
        Get the number of appqoepolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicy -name <string>
        Get appqoepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicy -Filter @{ 'name'='<value>' }
        Get appqoepolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appqoepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoepolicy: Ended"
    }
}

function Invoke-ADCGetAppqoepolicybinding {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appqoepolicy.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoepolicybinding -GetAll 
        Get all appqoepolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicybinding -name <string>
        Get appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicybinding -Filter @{ 'name'='<value>' }
        Get appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoepolicybinding: Ended"
    }
}

function Invoke-ADCGetAppqoepolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Appqoe configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to appqoepolicy.
    .PARAMETER Name 
        . 
    .PARAMETER GetAll 
        Retrieve all appqoepolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appqoepolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoepolicylbvserverbinding -GetAll 
        Get all appqoepolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppqoepolicylbvserverbinding -Count 
        Get the number of appqoepolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicylbvserverbinding -name <string>
        Get appqoepolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppqoepolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get appqoepolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicylbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appqoepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppqoepolicylbvserverbinding: Ended"
    }
}


