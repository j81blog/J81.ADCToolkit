function Invoke-ADCAddAppqoeaction {
<#
    .SYNOPSIS
        Add Appqoe configuration Object
    .DESCRIPTION
        Add Appqoe configuration Object 
    .PARAMETER name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request.  
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER respondwith 
        Responder action to be taken when the threshold is reached. Available settings function as follows:  
        ACS - Serve content from an alternative content service  
        Threshold : maxConn or delay  
        NS - Serve from the Citrix ADC (built-in response)  
        Threshold : maxConn or delay.  
        Possible values = ACS, NS 
    .PARAMETER customfile 
        name of the HTML page object to use as the response.  
        Minimum length = 1 
    .PARAMETER altcontentsvcname 
        Name of the alternative content service to be used in the ACS.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER altcontentpath 
        Path to the alternative content service to be used in the ACS.  
        Minimum length = 4  
        Maximum length = 127 
    .PARAMETER polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule.  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level.  
        Minimum value = 1  
        Maximum value = 599999999 
    .PARAMETER dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention.  
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER retryonreset 
        Retry on TCP Reset.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER numretries 
        Retry count.  
        Default value: 3  
        Minimum value = 0  
        Maximum value = 7 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        Invoke-ADCAddAppqoeaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppqoeaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$priority ,

        [ValidateSet('ACS', 'NS')]
        [string]$respondwith ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$customfile ,

        [ValidateLength(1, 127)]
        [string]$altcontentsvcname ,

        [ValidateLength(4, 127)]
        [string]$altcontentpath ,

        [ValidateRange(0, 4294967294)]
        [double]$polqdepth ,

        [ValidateRange(0, 4294967294)]
        [double]$priqdepth ,

        [ValidateRange(1, 4294967294)]
        [double]$maxconn ,

        [ValidateRange(1, 599999999)]
        [double]$delay ,

        [string]$dostrigexpression ,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$dosaction ,

        [ValidateLength(1, 127)]
        [string]$tcpprofile ,

        [ValidateSet('YES', 'NO')]
        [string]$retryonreset = 'NO' ,

        [ValidateRange(0, 7)]
        [double]$numretries = '3' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppqoeaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('respondwith')) { $Payload.Add('respondwith', $respondwith) }
            if ($PSBoundParameters.ContainsKey('customfile')) { $Payload.Add('customfile', $customfile) }
            if ($PSBoundParameters.ContainsKey('altcontentsvcname')) { $Payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ($PSBoundParameters.ContainsKey('altcontentpath')) { $Payload.Add('altcontentpath', $altcontentpath) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
            if ($PSBoundParameters.ContainsKey('priqdepth')) { $Payload.Add('priqdepth', $priqdepth) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('dostrigexpression')) { $Payload.Add('dostrigexpression', $dostrigexpression) }
            if ($PSBoundParameters.ContainsKey('dosaction')) { $Payload.Add('dosaction', $dosaction) }
            if ($PSBoundParameters.ContainsKey('tcpprofile')) { $Payload.Add('tcpprofile', $tcpprofile) }
            if ($PSBoundParameters.ContainsKey('retryonreset')) { $Payload.Add('retryonreset', $retryonreset) }
            if ($PSBoundParameters.ContainsKey('numretries')) { $Payload.Add('numretries', $numretries) }
 
            if ($PSCmdlet.ShouldProcess("appqoeaction", "Add Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoeaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppqoeaction -Filter $Payload)
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

function Invoke-ADCDeleteAppqoeaction {
<#
    .SYNOPSIS
        Delete Appqoe configuration Object
    .DESCRIPTION
        Delete Appqoe configuration Object
    .PARAMETER name 
       Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .EXAMPLE
        Invoke-ADCDeleteAppqoeaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppqoeaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-ADCDeleteAppqoeaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Appqoe configuration Object
    .DESCRIPTION
        Update Appqoe configuration Object 
    .PARAMETER name 
        Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER priority 
        Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request.  
        Possible values = HIGH, MEDIUM, LOW, LOWEST 
    .PARAMETER altcontentsvcname 
        Name of the alternative content service to be used in the ACS.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER altcontentpath 
        Path to the alternative content service to be used in the ACS.  
        Minimum length = 4  
        Maximum length = 127 
    .PARAMETER polqdepth 
        Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER priqdepth 
        Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level.  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxconn 
        Maximum number of concurrent connections that can be open for requests that matches with rule.  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER delay 
        Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level.  
        Minimum value = 1  
        Maximum value = 599999999 
    .PARAMETER dostrigexpression 
        Optional expression to add second level check to trigger DoS actions. Specifically used for Analytics based DoS response generation. 
    .PARAMETER dosaction 
        DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention.  
        Possible values = SimpleResponse, HICResponse 
    .PARAMETER tcpprofile 
        Bind TCP Profile based on L2/L3/L7 parameters.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER retryonreset 
        Retry on TCP Reset.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER numretries 
        Retry count.  
        Default value: 3  
        Minimum value = 0  
        Maximum value = 7 
    .PARAMETER PassThru 
        Return details about the created appqoeaction item.
    .EXAMPLE
        Invoke-ADCUpdateAppqoeaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppqoeaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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

        [ValidateSet('HIGH', 'MEDIUM', 'LOW', 'LOWEST')]
        [string]$priority ,

        [ValidateLength(1, 127)]
        [string]$altcontentsvcname ,

        [ValidateLength(4, 127)]
        [string]$altcontentpath ,

        [ValidateRange(0, 4294967294)]
        [double]$polqdepth ,

        [ValidateRange(0, 4294967294)]
        [double]$priqdepth ,

        [ValidateRange(1, 4294967294)]
        [double]$maxconn ,

        [ValidateRange(1, 599999999)]
        [double]$delay ,

        [string]$dostrigexpression ,

        [ValidateSet('SimpleResponse', 'HICResponse')]
        [string]$dosaction ,

        [ValidateLength(1, 127)]
        [string]$tcpprofile ,

        [ValidateSet('YES', 'NO')]
        [string]$retryonreset ,

        [ValidateRange(0, 7)]
        [double]$numretries ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoeaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('altcontentsvcname')) { $Payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ($PSBoundParameters.ContainsKey('altcontentpath')) { $Payload.Add('altcontentpath', $altcontentpath) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
            if ($PSBoundParameters.ContainsKey('priqdepth')) { $Payload.Add('priqdepth', $priqdepth) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('dostrigexpression')) { $Payload.Add('dostrigexpression', $dostrigexpression) }
            if ($PSBoundParameters.ContainsKey('dosaction')) { $Payload.Add('dosaction', $dosaction) }
            if ($PSBoundParameters.ContainsKey('tcpprofile')) { $Payload.Add('tcpprofile', $tcpprofile) }
            if ($PSBoundParameters.ContainsKey('retryonreset')) { $Payload.Add('retryonreset', $retryonreset) }
            if ($PSBoundParameters.ContainsKey('numretries')) { $Payload.Add('numretries', $numretries) }
 
            if ($PSCmdlet.ShouldProcess("appqoeaction", "Update Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoeaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppqoeaction -Filter $Payload)
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

function Invoke-ADCUnsetAppqoeaction {
<#
    .SYNOPSIS
        Unset Appqoe configuration Object
    .DESCRIPTION
        Unset Appqoe configuration Object 
   .PARAMETER name 
       Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
   .PARAMETER priority 
       Priority for queuing the request. If server resources are not available for a request that matches the configured rule, this option specifies a priority for queuing the request until the server resources are available again. If priority is not configured then Lowest priority will be used to queue the request.  
       Possible values = HIGH, MEDIUM, LOW, LOWEST 
   .PARAMETER altcontentsvcname 
       Name of the alternative content service to be used in the ACS. 
   .PARAMETER altcontentpath 
       Path to the alternative content service to be used in the ACS. 
   .PARAMETER polqdepth 
       Policy queue depth threshold value. When the policy queue size (number of requests queued for the policy binding this action is attached to) increases to the specified polqDepth value, subsequent requests are dropped to the lowest priority level. 
   .PARAMETER priqdepth 
       Queue depth threshold value per priorirty level. If the queue size (number of requests in the queue of that particular priorirty) on the virtual server to which this policy is bound, increases to the specified qDepth value, subsequent requests are dropped to the lowest priority level. 
   .PARAMETER maxconn 
       Maximum number of concurrent connections that can be open for requests that matches with rule. 
   .PARAMETER delay 
       Delay threshold, in microseconds, for requests that match the policy's rule. If the delay statistics gathered for the matching request exceed the specified delay, configured action triggered for that request, if there is no action then requests are dropped to the lowest priority level. 
   .PARAMETER dosaction 
       DoS Action to take when vserver will be considered under DoS attack and corresponding rule matches. Mandatory if AppQoE actions are to be used for DoS attack prevention.  
       Possible values = SimpleResponse, HICResponse 
   .PARAMETER tcpprofile 
       Bind TCP Profile based on L2/L3/L7 parameters. 
   .PARAMETER retryonreset 
       Retry on TCP Reset.  
       Possible values = YES, NO 
   .PARAMETER numretries 
       Retry count.
    .EXAMPLE
        Invoke-ADCUnsetAppqoeaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppqoeaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction
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

        [Boolean]$priority ,

        [Boolean]$altcontentsvcname ,

        [Boolean]$altcontentpath ,

        [Boolean]$polqdepth ,

        [Boolean]$priqdepth ,

        [Boolean]$maxconn ,

        [Boolean]$delay ,

        [Boolean]$dosaction ,

        [Boolean]$tcpprofile ,

        [Boolean]$retryonreset ,

        [Boolean]$numretries 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppqoeaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('altcontentsvcname')) { $Payload.Add('altcontentsvcname', $altcontentsvcname) }
            if ($PSBoundParameters.ContainsKey('altcontentpath')) { $Payload.Add('altcontentpath', $altcontentpath) }
            if ($PSBoundParameters.ContainsKey('polqdepth')) { $Payload.Add('polqdepth', $polqdepth) }
            if ($PSBoundParameters.ContainsKey('priqdepth')) { $Payload.Add('priqdepth', $priqdepth) }
            if ($PSBoundParameters.ContainsKey('maxconn')) { $Payload.Add('maxconn', $maxconn) }
            if ($PSBoundParameters.ContainsKey('delay')) { $Payload.Add('delay', $delay) }
            if ($PSBoundParameters.ContainsKey('dosaction')) { $Payload.Add('dosaction', $dosaction) }
            if ($PSBoundParameters.ContainsKey('tcpprofile')) { $Payload.Add('tcpprofile', $tcpprofile) }
            if ($PSBoundParameters.ContainsKey('retryonreset')) { $Payload.Add('retryonreset', $retryonreset) }
            if ($PSBoundParameters.ContainsKey('numretries')) { $Payload.Add('numretries', $numretries) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Appqoe configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appqoeaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAppqoeaction {
<#
    .SYNOPSIS
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER name 
       Name for the AppQoE action. Must begin with a letter, number, or the underscore symbol (_). Other characters allowed, after the first character, are the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), and colon (:) characters. This is a mandatory argument. 
    .PARAMETER GetAll 
        Retreive all appqoeaction object(s)
    .PARAMETER Count
        If specified, the count of the appqoeaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoeaction
    .EXAMPLE 
        Invoke-ADCGetAppqoeaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppqoeaction -Count
    .EXAMPLE
        Invoke-ADCGetAppqoeaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoeaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoeaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeaction/
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
        Write-Verbose "Invoke-ADCGetAppqoeaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appqoeaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoeaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCImportAppqoecustomresp {
<#
    .SYNOPSIS
        Import Appqoe configuration Object
    .DESCRIPTION
        Import Appqoe configuration Object 
    .PARAMETER src 
        . 
    .PARAMETER name 
        Indicates name of the custom response HTML page to import/update.
    .EXAMPLE
        Invoke-ADCImportAppqoecustomresp -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppqoecustomresp
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppqoecustomresp: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('src')) { $Payload.Add('src', $src) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action import -Payload $Payload -GetWarning
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

function Invoke-ADCDeleteAppqoecustomresp {
<#
    .SYNOPSIS
        Delete Appqoe configuration Object
    .DESCRIPTION
        Delete Appqoe configuration Object
    .PARAMETER name 
       Indicates name of the custom response HTML page to import/update.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppqoecustomresp -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppqoecustomresp
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        Write-Verbose "Invoke-ADCDeleteAppqoecustomresp: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoecustomresp -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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

function Invoke-ADCChangeAppqoecustomresp {
<#
    .SYNOPSIS
        Change Appqoe configuration Object
    .DESCRIPTION
        Change Appqoe configuration Object 
    .PARAMETER name 
        Indicates name of the custom response HTML page to import/update.  
        Minimum length = 1  
        Maximum length = 31
    .EXAMPLE
        Invoke-ADCChangeAppqoecustomresp -name <string>
    .NOTES
        File Name : Invoke-ADCChangeAppqoecustomresp
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppqoecustomresp: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("appqoecustomresp", "Change Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoecustomresp -Action update -Payload $Payload -GetWarning
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

function Invoke-ADCGetAppqoecustomresp {
<#
    .SYNOPSIS
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER GetAll 
        Retreive all appqoecustomresp object(s)
    .PARAMETER Count
        If specified, the count of the appqoecustomresp object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoecustomresp
    .EXAMPLE 
        Invoke-ADCGetAppqoecustomresp -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppqoecustomresp -Count
    .EXAMPLE
        Invoke-ADCGetAppqoecustomresp -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoecustomresp -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoecustomresp
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoecustomresp/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppqoecustomresp: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appqoecustomresp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoecustomresp objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoecustomresp objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoecustomresp configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoecustomresp configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoecustomresp -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Appqoe configuration Object
    .DESCRIPTION
        Update Appqoe configuration Object 
    .PARAMETER sessionlife 
        Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session.  
        Default value: 300  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER avgwaitingclient 
        average number of client connections, that can sit in service waiting queue.  
        Default value: 1000000  
        Minimum value = 0  
        Maximum value = 4294967294 
    .PARAMETER maxaltrespbandwidth 
        maximum bandwidth which will determine whether to send alternate content response.  
        Default value: 100  
        Minimum value = 1  
        Maximum value = 4294967294 
    .PARAMETER dosattackthresh 
        average number of client connection that can queue up on vserver level without triggering DoS mitigation module.  
        Default value: 2000  
        Minimum value = 0  
        Maximum value = 4294967294
    .EXAMPLE
        Invoke-ADCUpdateAppqoeparameter 
    .NOTES
        File Name : Invoke-ADCUpdateAppqoeparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter/
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

        [ValidateRange(0, 4294967294)]
        [double]$avgwaitingclient ,

        [ValidateRange(1, 4294967294)]
        [double]$maxaltrespbandwidth ,

        [ValidateRange(0, 4294967294)]
        [double]$dosattackthresh 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoeparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sessionlife')) { $Payload.Add('sessionlife', $sessionlife) }
            if ($PSBoundParameters.ContainsKey('avgwaitingclient')) { $Payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ($PSBoundParameters.ContainsKey('maxaltrespbandwidth')) { $Payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ($PSBoundParameters.ContainsKey('dosattackthresh')) { $Payload.Add('dosattackthresh', $dosattackthresh) }
 
            if ($PSCmdlet.ShouldProcess("appqoeparameter", "Update Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoeparameter -Payload $Payload -GetWarning
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
        Unset Appqoe configuration Object
    .DESCRIPTION
        Unset Appqoe configuration Object 
   .PARAMETER sessionlife 
       Time, in seconds, between the first time and the next time the AppQoE alternative content window is displayed. The alternative content window is displayed only once during a session for the same browser accessing a configured URL, so this parameter determines the length of a session. 
   .PARAMETER avgwaitingclient 
       average number of client connections, that can sit in service waiting queue. 
   .PARAMETER maxaltrespbandwidth 
       maximum bandwidth which will determine whether to send alternate content response. 
   .PARAMETER dosattackthresh 
       average number of client connection that can queue up on vserver level without triggering DoS mitigation module.
    .EXAMPLE
        Invoke-ADCUnsetAppqoeparameter 
    .NOTES
        File Name : Invoke-ADCUnsetAppqoeparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter
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

        [Boolean]$avgwaitingclient ,

        [Boolean]$maxaltrespbandwidth ,

        [Boolean]$dosattackthresh 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppqoeparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('sessionlife')) { $Payload.Add('sessionlife', $sessionlife) }
            if ($PSBoundParameters.ContainsKey('avgwaitingclient')) { $Payload.Add('avgwaitingclient', $avgwaitingclient) }
            if ($PSBoundParameters.ContainsKey('maxaltrespbandwidth')) { $Payload.Add('maxaltrespbandwidth', $maxaltrespbandwidth) }
            if ($PSBoundParameters.ContainsKey('dosattackthresh')) { $Payload.Add('dosattackthresh', $dosattackthresh) }
            if ($PSCmdlet.ShouldProcess("appqoeparameter", "Unset Appqoe configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appqoeparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER GetAll 
        Retreive all appqoeparameter object(s)
    .PARAMETER Count
        If specified, the count of the appqoeparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoeparameter
    .EXAMPLE 
        Invoke-ADCGetAppqoeparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetAppqoeparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoeparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoeparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoeparameter/
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
        Write-Verbose "Invoke-ADCGetAppqoeparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appqoeparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoeparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoeparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoeparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving appqoeparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoeparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddAppqoepolicy {
<#
    .SYNOPSIS
        Add Appqoe configuration Object
    .DESCRIPTION
        Add Appqoe configuration Object 
    .PARAMETER name 
        .  
        Minimum length = 1 
    .PARAMETER rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER action 
        Configured AppQoE action to trigger.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        Invoke-ADCAddAppqoepolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddAppqoepolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppqoepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("appqoepolicy", "Add Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appqoepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppqoepolicy -Filter $Payload)
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

function Invoke-ADCDeleteAppqoepolicy {
<#
    .SYNOPSIS
        Delete Appqoe configuration Object
    .DESCRIPTION
        Delete Appqoe configuration Object
    .PARAMETER name 
       .  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAppqoepolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppqoepolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppqoepolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appqoe configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Appqoe configuration Object
    .DESCRIPTION
        Update Appqoe configuration Object 
    .PARAMETER name 
        .  
        Minimum length = 1 
    .PARAMETER rule 
        Expression or name of a named expression, against which the request is evaluated. The policy is applied if the rule evaluates to true. 
    .PARAMETER action 
        Configured AppQoE action to trigger.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created appqoepolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAppqoepolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppqoepolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppqoepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("appqoepolicy", "Update Appqoe configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appqoepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppqoepolicy -Filter $Payload)
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

function Invoke-ADCGetAppqoepolicy {
<#
    .SYNOPSIS
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER name 
       . 
    .PARAMETER GetAll 
        Retreive all appqoepolicy object(s)
    .PARAMETER Count
        If specified, the count of the appqoepolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoepolicy
    .EXAMPLE 
        Invoke-ADCGetAppqoepolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppqoepolicy -Count
    .EXAMPLE
        Invoke-ADCGetAppqoepolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoepolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appqoepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER name 
       . 
    .PARAMETER GetAll 
        Retreive all appqoepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appqoepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoepolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppqoepolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppqoepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Appqoe configuration object(s)
    .DESCRIPTION
        Get Appqoe configuration object(s)
    .PARAMETER name 
       . 
    .PARAMETER GetAll 
        Retreive all appqoepolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appqoepolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppqoepolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppqoepolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppqoepolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppqoepolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppqoepolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppqoepolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appqoe/appqoepolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppqoepolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appqoepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appqoepolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appqoepolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appqoepolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


