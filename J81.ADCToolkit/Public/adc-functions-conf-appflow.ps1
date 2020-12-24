function Invoke-ADCAddAppflowaction {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER collectors 
        Name(s) of collector(s) to be associated with the AppFlow action.  
        Minimum length = 1 
    .PARAMETER clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER metricslog 
        If only the stats records are to be exported, turn on this option. 
    .PARAMETER transactionlog 
        Log ANOMALOUS or ALL transactions.  
        Default value: ALL  
        Possible values = ALL, ANOMALOUS 
    .PARAMETER comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.).  
        Maximum length = 256 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        Invoke-ADCAddAppflowaction -name <string> -collectors <string[]>
    .NOTES
        File Name : Invoke-ADCAddAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$collectors ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientsidemeasurements = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pagetracking = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$webinsight = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$securityinsight = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$botinsight = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ciinsight = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$videoanalytics = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$distributionalgorithm = 'DISABLED' ,

        [boolean]$metricslog ,

        [ValidateSet('ALL', 'ANOMALOUS')]
        [string]$transactionlog = 'ALL' ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                collectors = $collectors
            }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('pagetracking')) { $Payload.Add('pagetracking', $pagetracking) }
            if ($PSBoundParameters.ContainsKey('webinsight')) { $Payload.Add('webinsight', $webinsight) }
            if ($PSBoundParameters.ContainsKey('securityinsight')) { $Payload.Add('securityinsight', $securityinsight) }
            if ($PSBoundParameters.ContainsKey('botinsight')) { $Payload.Add('botinsight', $botinsight) }
            if ($PSBoundParameters.ContainsKey('ciinsight')) { $Payload.Add('ciinsight', $ciinsight) }
            if ($PSBoundParameters.ContainsKey('videoanalytics')) { $Payload.Add('videoanalytics', $videoanalytics) }
            if ($PSBoundParameters.ContainsKey('distributionalgorithm')) { $Payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ($PSBoundParameters.ContainsKey('metricslog')) { $Payload.Add('metricslog', $metricslog) }
            if ($PSBoundParameters.ContainsKey('transactionlog')) { $Payload.Add('transactionlog', $transactionlog) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("appflowaction", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowaction: Finished"
    }
}

function Invoke-ADCDeleteAppflowaction {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER name 
       Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteAppflowaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        Write-Verbose "Invoke-ADCDeleteAppflowaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowaction -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowaction: Finished"
    }
}

function Invoke-ADCUpdateAppflowaction {
<#
    .SYNOPSIS
        Update Appflow configuration Object
    .DESCRIPTION
        Update Appflow configuration Object 
    .PARAMETER name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER collectors 
        Name(s) of collector(s) to be associated with the AppFlow action.  
        Minimum length = 1 
    .PARAMETER clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.).  
        Maximum length = 256 
    .PARAMETER pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        Invoke-ADCUpdateAppflowaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$collectors ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$clientsidemeasurements ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pagetracking ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$webinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$securityinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$botinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ciinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$videoanalytics ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$distributionalgorithm ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('collectors')) { $Payload.Add('collectors', $collectors) }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('pagetracking')) { $Payload.Add('pagetracking', $pagetracking) }
            if ($PSBoundParameters.ContainsKey('webinsight')) { $Payload.Add('webinsight', $webinsight) }
            if ($PSBoundParameters.ContainsKey('securityinsight')) { $Payload.Add('securityinsight', $securityinsight) }
            if ($PSBoundParameters.ContainsKey('botinsight')) { $Payload.Add('botinsight', $botinsight) }
            if ($PSBoundParameters.ContainsKey('ciinsight')) { $Payload.Add('ciinsight', $ciinsight) }
            if ($PSBoundParameters.ContainsKey('videoanalytics')) { $Payload.Add('videoanalytics', $videoanalytics) }
            if ($PSBoundParameters.ContainsKey('distributionalgorithm')) { $Payload.Add('distributionalgorithm', $distributionalgorithm) }
 
            if ($PSCmdlet.ShouldProcess("appflowaction", "Update Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppflowaction: Finished"
    }
}

function Invoke-ADCUnsetAppflowaction {
<#
    .SYNOPSIS
        Unset Appflow configuration Object
    .DESCRIPTION
        Unset Appflow configuration Object 
   .PARAMETER name 
       Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
   .PARAMETER clientsidemeasurements 
       On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER comment 
       Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
   .PARAMETER pagetracking 
       On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER webinsight 
       On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER securityinsight 
       On enabling this option, the Citrix ADC will send the security insight records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER botinsight 
       On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ciinsight 
       On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER videoanalytics 
       On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER distributionalgorithm 
       On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAppflowaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction
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
        [string]$name ,

        [Boolean]$clientsidemeasurements ,

        [Boolean]$comment ,

        [Boolean]$pagetracking ,

        [Boolean]$webinsight ,

        [Boolean]$securityinsight ,

        [Boolean]$botinsight ,

        [Boolean]$ciinsight ,

        [Boolean]$videoanalytics ,

        [Boolean]$distributionalgorithm 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('clientsidemeasurements')) { $Payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('pagetracking')) { $Payload.Add('pagetracking', $pagetracking) }
            if ($PSBoundParameters.ContainsKey('webinsight')) { $Payload.Add('webinsight', $webinsight) }
            if ($PSBoundParameters.ContainsKey('securityinsight')) { $Payload.Add('securityinsight', $securityinsight) }
            if ($PSBoundParameters.ContainsKey('botinsight')) { $Payload.Add('botinsight', $botinsight) }
            if ($PSBoundParameters.ContainsKey('ciinsight')) { $Payload.Add('ciinsight', $ciinsight) }
            if ($PSBoundParameters.ContainsKey('videoanalytics')) { $Payload.Add('videoanalytics', $videoanalytics) }
            if ($PSBoundParameters.ContainsKey('distributionalgorithm')) { $Payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowaction -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppflowaction: Finished"
    }
}

function Invoke-ADCRenameAppflowaction {
<#
    .SYNOPSIS
        Rename Appflow configuration Object
    .DESCRIPTION
        Rename Appflow configuration Object 
    .PARAMETER name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER newname 
        New name for the AppFlow action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        Invoke-ADCRenameAppflowaction -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appflowaction", "Rename Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowaction -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppflowaction: Finished"
    }
}

function Invoke-ADCGetAppflowaction {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all appflowaction object(s)
    .PARAMETER Count
        If specified, the count of the appflowaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowaction
    .EXAMPLE 
        Invoke-ADCGetAppflowaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowaction -Count
    .EXAMPLE
        Invoke-ADCGetAppflowaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowaction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        Write-Verbose "Invoke-ADCGetAppflowaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appflowaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowaction: Ended"
    }
}

function Invoke-ADCAddAppflowactionanalyticsprofilebinding {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER analyticsprofile 
        Analytics profile to be bound to the appflow action. 
    .PARAMETER PassThru 
        Return details about the created appflowaction_analyticsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddAppflowactionanalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppflowactionanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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
        [string]$name ,

        [string]$analyticsprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowactionanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
 
            if ($PSCmdlet.ShouldProcess("appflowaction_analyticsprofile_binding", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowaction_analyticsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowactionanalyticsprofilebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowactionanalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteAppflowactionanalyticsprofilebinding {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER name 
       Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.    .PARAMETER analyticsprofile 
       Analytics profile to be bound to the appflow action.
    .EXAMPLE
        Invoke-ADCDeleteAppflowactionanalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowactionanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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

        [string]$analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppflowactionanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Arguments.Add('analyticsprofile', $analyticsprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowaction_analyticsprofile_binding -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowactionanalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCGetAppflowactionanalyticsprofilebinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all appflowaction_analyticsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowaction_analyticsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowactionanalyticsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetAppflowactionanalyticsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowactionanalyticsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowactionanalyticsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowactionanalyticsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowactionanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAppflowactionanalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowaction_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowactionanalyticsprofilebinding: Ended"
    }
}

function Invoke-ADCGetAppflowactionbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the action about which to display information. 
    .PARAMETER GetAll 
        Retreive all appflowaction_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowaction_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowactionbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowactionbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppflowactionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowactionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowactionbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowactionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowactionbinding: Ended"
    }
}

function Invoke-ADCAddAppflowcollector {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters.  
        Only four collectors can be configured. 
    .PARAMETER ipaddress 
        IPv4 address of the collector. 
    .PARAMETER port 
        Port on which the collector listens. 
    .PARAMETER netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address.  
        Maximum length = 128 
    .PARAMETER transport 
        Type of collector: either logstream or ipfix or rest.  
        Default value: ipfix,  
        Possible values = ipfix, logstream, rest 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        Invoke-ADCAddAppflowcollector -name <string> -ipaddress <string>
    .NOTES
        File Name : Invoke-ADCAddAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [string]$ipaddress ,

        [int]$port ,

        [string]$netprofile ,

        [ValidateSet('ipfix', 'logstream', 'rest')]
        [string]$transport = 'ipfix' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowcollector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                ipaddress = $ipaddress
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('transport')) { $Payload.Add('transport', $transport) }
 
            if ($PSCmdlet.ShouldProcess("appflowcollector", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowcollector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowcollector: Finished"
    }
}

function Invoke-ADCUpdateAppflowcollector {
<#
    .SYNOPSIS
        Update Appflow configuration Object
    .DESCRIPTION
        Update Appflow configuration Object 
    .PARAMETER name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters.  
        Only four collectors can be configured. 
    .PARAMETER ipaddress 
        IPv4 address of the collector. 
    .PARAMETER port 
        Port on which the collector listens. 
    .PARAMETER netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address.  
        Maximum length = 128 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        Invoke-ADCUpdateAppflowcollector -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [string]$ipaddress ,

        [int]$port ,

        [string]$netprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowcollector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
 
            if ($PSCmdlet.ShouldProcess("appflowcollector", "Update Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowcollector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppflowcollector: Finished"
    }
}

function Invoke-ADCUnsetAppflowcollector {
<#
    .SYNOPSIS
        Unset Appflow configuration Object
    .DESCRIPTION
        Unset Appflow configuration Object 
   .PARAMETER name 
       Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters.  
       Only four collectors can be configured. 
   .PARAMETER ipaddress 
       IPv4 address of the collector. 
   .PARAMETER port 
       Port on which the collector listens. 
   .PARAMETER netprofile 
       Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address.
    .EXAMPLE
        Invoke-ADCUnsetAppflowcollector -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$ipaddress ,

        [Boolean]$port ,

        [Boolean]$netprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowcollector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipaddress')) { $Payload.Add('ipaddress', $ipaddress) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowcollector -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppflowcollector: Finished"
    }
}

function Invoke-ADCDeleteAppflowcollector {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER name 
       Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters.  
       Only four collectors can be configured. 
    .EXAMPLE
        Invoke-ADCDeleteAppflowcollector -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        Write-Verbose "Invoke-ADCDeleteAppflowcollector: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowcollector -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowcollector: Finished"
    }
}

function Invoke-ADCRenameAppflowcollector {
<#
    .SYNOPSIS
        Rename Appflow configuration Object
    .DESCRIPTION
        Rename Appflow configuration Object 
    .PARAMETER name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters.  
        Only four collectors can be configured. 
    .PARAMETER newname 
        New name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must  
        contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at(@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        Invoke-ADCRenameAppflowcollector -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowcollector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appflowcollector", "Rename Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowcollector -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppflowcollector: Finished"
    }
}

function Invoke-ADCGetAppflowcollector {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters.  
       Only four collectors can be configured. 
    .PARAMETER GetAll 
        Retreive all appflowcollector object(s)
    .PARAMETER Count
        If specified, the count of the appflowcollector object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowcollector
    .EXAMPLE 
        Invoke-ADCGetAppflowcollector -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowcollector -Count
    .EXAMPLE
        Invoke-ADCGetAppflowcollector -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowcollector -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowcollector
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetAppflowcollector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appflowcollector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowcollector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowcollector objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowcollector configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowcollector configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowcollector: Ended"
    }
}

function Invoke-ADCAddAppflowglobalappflowpolicybinding {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER policyname 
        Name of the AppFlow policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        Global bind point for which to show detailed information about the policies bound to the bind point.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER labeltype 
        Type of policy label to invoke. Specify vserver for a policy label associated with a virtual server, or policylabel for a user-defined policy label.  
        Possible values = vserver, policylabel 
    .PARAMETER labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowglobal_appflowpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppflowglobalappflowpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppflowglobalappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'OVERRIDE', 'DEFAULT', 'OTHERTCP_REQ_OVERRIDE', 'OTHERTCP_REQ_DEFAULT', 'MSSQL_REQ_OVERRIDE', 'MSSQL_REQ_DEFAULT', 'MYSQL_REQ_OVERRIDE', 'MYSQL_REQ_DEFAULT', 'ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT', 'ORACLE_REQ_OVERRIDE', 'ORACLE_REQ_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('vserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowglobalappflowpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowglobal_appflowpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowglobalappflowpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowglobalappflowpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppflowglobalappflowpolicybinding {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
     .PARAMETER policyname 
       Name of the AppFlow policy.    .PARAMETER type 
       Global bind point for which to show detailed information about the policies bound to the bind point.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteAppflowglobalappflowpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAppflowglobalappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppflowglobalappflowpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowglobal_appflowpolicy_binding -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowglobalappflowpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppflowglobalappflowpolicybinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER GetAll 
        Retreive all appflowglobal_appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowglobal_appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowglobalappflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppflowglobalappflowpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowglobalappflowpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowglobalappflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowglobalappflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowglobalappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowglobalappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowglobalappflowpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppflowglobalbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER GetAll 
        Retreive all appflowglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppflowglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowglobalbinding: Ended"
    }
}

function Invoke-ADCUpdateAppflowparam {
<#
    .SYNOPSIS
        Update Appflow configuration Object
    .DESCRIPTION
        Update Appflow configuration Object 
    .PARAMETER templaterefresh 
        Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals.  
        Default value: 600  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER appnamerefresh 
        Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC.  
        Default value: 600  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER flowrecordinterval 
        Interval, in seconds, at which to send flow records to the configured collectors.  
        Default value: 60  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER securityinsightrecordinterval 
        Interval, in seconds, at which to send security insight flow records to the configured collectors.  
        Default value: 600  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER udppmtu 
        MTU, in bytes, for IPFIX UDP packets.  
        Default value: 1472  
        Minimum value = 128  
        Maximum value = 1472 
    .PARAMETER httpurl 
        Include the http URL that the Citrix ADC received from the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER aaausername 
        Enable AppFlow AAA Username logging.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpcookie 
        Include the cookie that was in the HTTP request the appliance received from the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpreferer 
        Include the web page that was last visited by the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpmethod 
        Include the method that was specified in the HTTP request that the appliance received from the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httphost 
        Include the host identified in the HTTP request that the appliance received from the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpuseragent 
        Include the client application through which the HTTP request was received by the Citrix ADC.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER clienttrafficonly 
        Generate AppFlow records for only the traffic from the client.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER httpcontenttype 
        Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpauthorization 
        Include the HTTP Authorization header information.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpvia 
        Include the httpVia header which contains the IP address of proxy server through which the client accessed the server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpxforwardedfor 
        Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httplocation 
        Include the HTTP location headers returned from the HTTP responses.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie2 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER connectionchaining 
        Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpdomain 
        Include the http domain request to be exported.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER skipcacheredirectionhttptransaction 
        Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER identifiername 
        Include the stream identifier name to be exported.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER identifiersessionname 
        Include the stream identifier session name to be exported.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER observationdomainid 
        An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group.  
        Default value: 0  
        Minimum value = 1000 
    .PARAMETER observationdomainname 
        Name of the Observation Domain defined by the observation domain ID.  
        Maximum length = 127 
    .PARAMETER subscriberawareness 
        Enable this option for logging end user MSISDN in L4/L7 appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberidobfuscation 
        Enable this option for obfuscating MSISDN in L4/L7 appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberidobfuscationalgo 
        Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN.  
        Default value: MD5  
        Possible values = MD5, SHA256 
    .PARAMETER gxsessionreporting 
        Enable this option for Gx session reporting.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER securityinsighttraffic 
        Enable/disable the feature individually on appflow action.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cacheinsight 
        Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER videoinsight 
        Enable/disable the feature individually on appflow action.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpquerywithurl 
        Include the HTTP query segment along with the URL that the Citrix ADC received from the client.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlcategory 
        Include the URL category record.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsnlogging 
        On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cqareporting 
        TCP CQA reporting enable/disable knob.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER emailaddress 
        Enable AppFlow user email-id logging.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER usagerecordinterval 
        On enabling this option, the NGS will send bandwidth usage record to configured collectors.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 7200 
    .PARAMETER websaasappusagereporting 
        On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER metrics 
        Enable Citrix ADC Stats to be sent to the Telemetry Agent.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER events 
        Enable Events to be sent to the Telemetry Agent.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER auditlogs 
        Enable Auditlogs to be sent to the Telemetry Agent.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER observationpointid 
        An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID.  
        Minimum value = 1 
    .PARAMETER distributedtracing 
        Enable generation of the distributed tracing templates in the Appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER disttracingsamplingrate 
        Sampling rate for Distributed Tracing.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER tcpattackcounterinterval 
        Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 3600 
    .PARAMETER logstreamovernsip 
        To use the Citrix ADC IP to send Logstream records instead of the SNIP.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER aaainsight 
        Enable/Disable AAA insights.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateAppflowparam 
    .NOTES
        File Name : Invoke-ADCUpdateAppflowparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam/
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

        [ValidateRange(60, 3600)]
        [double]$templaterefresh ,

        [ValidateRange(60, 3600)]
        [double]$appnamerefresh ,

        [ValidateRange(60, 3600)]
        [double]$flowrecordinterval ,

        [ValidateRange(60, 3600)]
        [double]$securityinsightrecordinterval ,

        [ValidateRange(128, 1472)]
        [double]$udppmtu ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$aaausername ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpreferer ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpmethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httphost ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpuseragent ,

        [ValidateSet('YES', 'NO')]
        [string]$clienttrafficonly ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcontenttype ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpauthorization ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpvia ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpxforwardedfor ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httplocation ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie2 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$connectionchaining ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpdomain ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$skipcacheredirectionhttptransaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$identifiername ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$identifiersessionname ,

        [double]$observationdomainid ,

        [string]$observationdomainname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberawareness ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberidobfuscation ,

        [ValidateSet('MD5', 'SHA256')]
        [string]$subscriberidobfuscationalgo ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$gxsessionreporting ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$securityinsighttraffic ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cacheinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$videoinsight ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpquerywithurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlcategory ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsnlogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cqareporting ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$emailaddress ,

        [ValidateRange(0, 7200)]
        [double]$usagerecordinterval ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$websaasappusagereporting ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$metrics ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$events ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$auditlogs ,

        [double]$observationpointid ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$distributedtracing ,

        [ValidateRange(0, 100)]
        [double]$disttracingsamplingrate ,

        [ValidateRange(0, 3600)]
        [double]$tcpattackcounterinterval ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logstreamovernsip ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$aaainsight 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('templaterefresh')) { $Payload.Add('templaterefresh', $templaterefresh) }
            if ($PSBoundParameters.ContainsKey('appnamerefresh')) { $Payload.Add('appnamerefresh', $appnamerefresh) }
            if ($PSBoundParameters.ContainsKey('flowrecordinterval')) { $Payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ($PSBoundParameters.ContainsKey('securityinsightrecordinterval')) { $Payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ($PSBoundParameters.ContainsKey('udppmtu')) { $Payload.Add('udppmtu', $udppmtu) }
            if ($PSBoundParameters.ContainsKey('httpurl')) { $Payload.Add('httpurl', $httpurl) }
            if ($PSBoundParameters.ContainsKey('aaausername')) { $Payload.Add('aaausername', $aaausername) }
            if ($PSBoundParameters.ContainsKey('httpcookie')) { $Payload.Add('httpcookie', $httpcookie) }
            if ($PSBoundParameters.ContainsKey('httpreferer')) { $Payload.Add('httpreferer', $httpreferer) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('httphost')) { $Payload.Add('httphost', $httphost) }
            if ($PSBoundParameters.ContainsKey('httpuseragent')) { $Payload.Add('httpuseragent', $httpuseragent) }
            if ($PSBoundParameters.ContainsKey('clienttrafficonly')) { $Payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ($PSBoundParameters.ContainsKey('httpcontenttype')) { $Payload.Add('httpcontenttype', $httpcontenttype) }
            if ($PSBoundParameters.ContainsKey('httpauthorization')) { $Payload.Add('httpauthorization', $httpauthorization) }
            if ($PSBoundParameters.ContainsKey('httpvia')) { $Payload.Add('httpvia', $httpvia) }
            if ($PSBoundParameters.ContainsKey('httpxforwardedfor')) { $Payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ($PSBoundParameters.ContainsKey('httplocation')) { $Payload.Add('httplocation', $httplocation) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie')) { $Payload.Add('httpsetcookie', $httpsetcookie) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie2')) { $Payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ($PSBoundParameters.ContainsKey('connectionchaining')) { $Payload.Add('connectionchaining', $connectionchaining) }
            if ($PSBoundParameters.ContainsKey('httpdomain')) { $Payload.Add('httpdomain', $httpdomain) }
            if ($PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction')) { $Payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Payload.Add('identifiername', $identifiername) }
            if ($PSBoundParameters.ContainsKey('identifiersessionname')) { $Payload.Add('identifiersessionname', $identifiersessionname) }
            if ($PSBoundParameters.ContainsKey('observationdomainid')) { $Payload.Add('observationdomainid', $observationdomainid) }
            if ($PSBoundParameters.ContainsKey('observationdomainname')) { $Payload.Add('observationdomainname', $observationdomainname) }
            if ($PSBoundParameters.ContainsKey('subscriberawareness')) { $Payload.Add('subscriberawareness', $subscriberawareness) }
            if ($PSBoundParameters.ContainsKey('subscriberidobfuscation')) { $Payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ($PSBoundParameters.ContainsKey('subscriberidobfuscationalgo')) { $Payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ($PSBoundParameters.ContainsKey('gxsessionreporting')) { $Payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ($PSBoundParameters.ContainsKey('securityinsighttraffic')) { $Payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ($PSBoundParameters.ContainsKey('cacheinsight')) { $Payload.Add('cacheinsight', $cacheinsight) }
            if ($PSBoundParameters.ContainsKey('videoinsight')) { $Payload.Add('videoinsight', $videoinsight) }
            if ($PSBoundParameters.ContainsKey('httpquerywithurl')) { $Payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ($PSBoundParameters.ContainsKey('urlcategory')) { $Payload.Add('urlcategory', $urlcategory) }
            if ($PSBoundParameters.ContainsKey('lsnlogging')) { $Payload.Add('lsnlogging', $lsnlogging) }
            if ($PSBoundParameters.ContainsKey('cqareporting')) { $Payload.Add('cqareporting', $cqareporting) }
            if ($PSBoundParameters.ContainsKey('emailaddress')) { $Payload.Add('emailaddress', $emailaddress) }
            if ($PSBoundParameters.ContainsKey('usagerecordinterval')) { $Payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ($PSBoundParameters.ContainsKey('websaasappusagereporting')) { $Payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ($PSBoundParameters.ContainsKey('metrics')) { $Payload.Add('metrics', $metrics) }
            if ($PSBoundParameters.ContainsKey('events')) { $Payload.Add('events', $events) }
            if ($PSBoundParameters.ContainsKey('auditlogs')) { $Payload.Add('auditlogs', $auditlogs) }
            if ($PSBoundParameters.ContainsKey('observationpointid')) { $Payload.Add('observationpointid', $observationpointid) }
            if ($PSBoundParameters.ContainsKey('distributedtracing')) { $Payload.Add('distributedtracing', $distributedtracing) }
            if ($PSBoundParameters.ContainsKey('disttracingsamplingrate')) { $Payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ($PSBoundParameters.ContainsKey('tcpattackcounterinterval')) { $Payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ($PSBoundParameters.ContainsKey('logstreamovernsip')) { $Payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ($PSBoundParameters.ContainsKey('aaainsight')) { $Payload.Add('aaainsight', $aaainsight) }
 
            if ($PSCmdlet.ShouldProcess("appflowparam", "Update Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowparam -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAppflowparam: Finished"
    }
}

function Invoke-ADCUnsetAppflowparam {
<#
    .SYNOPSIS
        Unset Appflow configuration Object
    .DESCRIPTION
        Unset Appflow configuration Object 
   .PARAMETER templaterefresh 
       Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals. 
   .PARAMETER appnamerefresh 
       Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC. 
   .PARAMETER flowrecordinterval 
       Interval, in seconds, at which to send flow records to the configured collectors. 
   .PARAMETER securityinsightrecordinterval 
       Interval, in seconds, at which to send security insight flow records to the configured collectors. 
   .PARAMETER udppmtu 
       MTU, in bytes, for IPFIX UDP packets. 
   .PARAMETER httpurl 
       Include the http URL that the Citrix ADC received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER aaausername 
       Enable AppFlow AAA Username logging.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpcookie 
       Include the cookie that was in the HTTP request the appliance received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpreferer 
       Include the web page that was last visited by the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpmethod 
       Include the method that was specified in the HTTP request that the appliance received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httphost 
       Include the host identified in the HTTP request that the appliance received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpuseragent 
       Include the client application through which the HTTP request was received by the Citrix ADC.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER clienttrafficonly 
       Generate AppFlow records for only the traffic from the client.  
       Possible values = YES, NO 
   .PARAMETER httpcontenttype 
       Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpauthorization 
       Include the HTTP Authorization header information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpvia 
       Include the httpVia header which contains the IP address of proxy server through which the client accessed the server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpxforwardedfor 
       Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httplocation 
       Include the HTTP location headers returned from the HTTP responses.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpsetcookie 
       Include the Set-cookie header sent from the server to the client in response to a HTTP request.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpsetcookie2 
       Include the Set-cookie header sent from the server to the client in response to a HTTP request.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER connectionchaining 
       Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpdomain 
       Include the http domain request to be exported.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER skipcacheredirectionhttptransaction 
       Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER identifiername 
       Include the stream identifier name to be exported.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER identifiersessionname 
       Include the stream identifier session name to be exported.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER observationdomainid 
       An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group. 
   .PARAMETER observationdomainname 
       Name of the Observation Domain defined by the observation domain ID. 
   .PARAMETER subscriberawareness 
       Enable this option for logging end user MSISDN in L4/L7 appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberidobfuscation 
       Enable this option for obfuscating MSISDN in L4/L7 appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberidobfuscationalgo 
       Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN.  
       Possible values = MD5, SHA256 
   .PARAMETER gxsessionreporting 
       Enable this option for Gx session reporting.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER securityinsighttraffic 
       Enable/disable the feature individually on appflow action.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cacheinsight 
       Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER videoinsight 
       Enable/disable the feature individually on appflow action.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpquerywithurl 
       Include the HTTP query segment along with the URL that the Citrix ADC received from the client.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlcategory 
       Include the URL category record.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER lsnlogging 
       On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cqareporting 
       TCP CQA reporting enable/disable knob.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER emailaddress 
       Enable AppFlow user email-id logging.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER usagerecordinterval 
       On enabling this option, the NGS will send bandwidth usage record to configured collectors. 
   .PARAMETER websaasappusagereporting 
       On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER metrics 
       Enable Citrix ADC Stats to be sent to the Telemetry Agent.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER events 
       Enable Events to be sent to the Telemetry Agent.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER auditlogs 
       Enable Auditlogs to be sent to the Telemetry Agent.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER observationpointid 
       An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID. 
   .PARAMETER distributedtracing 
       Enable generation of the distributed tracing templates in the Appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER disttracingsamplingrate 
       Sampling rate for Distributed Tracing. 
   .PARAMETER tcpattackcounterinterval 
       Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent. 
   .PARAMETER logstreamovernsip 
       To use the Citrix ADC IP to send Logstream records instead of the SNIP.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER aaainsight 
       Enable/Disable AAA insights.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAppflowparam 
    .NOTES
        File Name : Invoke-ADCUnsetAppflowparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam
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

        [Boolean]$templaterefresh ,

        [Boolean]$appnamerefresh ,

        [Boolean]$flowrecordinterval ,

        [Boolean]$securityinsightrecordinterval ,

        [Boolean]$udppmtu ,

        [Boolean]$httpurl ,

        [Boolean]$aaausername ,

        [Boolean]$httpcookie ,

        [Boolean]$httpreferer ,

        [Boolean]$httpmethod ,

        [Boolean]$httphost ,

        [Boolean]$httpuseragent ,

        [Boolean]$clienttrafficonly ,

        [Boolean]$httpcontenttype ,

        [Boolean]$httpauthorization ,

        [Boolean]$httpvia ,

        [Boolean]$httpxforwardedfor ,

        [Boolean]$httplocation ,

        [Boolean]$httpsetcookie ,

        [Boolean]$httpsetcookie2 ,

        [Boolean]$connectionchaining ,

        [Boolean]$httpdomain ,

        [Boolean]$skipcacheredirectionhttptransaction ,

        [Boolean]$identifiername ,

        [Boolean]$identifiersessionname ,

        [Boolean]$observationdomainid ,

        [Boolean]$observationdomainname ,

        [Boolean]$subscriberawareness ,

        [Boolean]$subscriberidobfuscation ,

        [Boolean]$subscriberidobfuscationalgo ,

        [Boolean]$gxsessionreporting ,

        [Boolean]$securityinsighttraffic ,

        [Boolean]$cacheinsight ,

        [Boolean]$videoinsight ,

        [Boolean]$httpquerywithurl ,

        [Boolean]$urlcategory ,

        [Boolean]$lsnlogging ,

        [Boolean]$cqareporting ,

        [Boolean]$emailaddress ,

        [Boolean]$usagerecordinterval ,

        [Boolean]$websaasappusagereporting ,

        [Boolean]$metrics ,

        [Boolean]$events ,

        [Boolean]$auditlogs ,

        [Boolean]$observationpointid ,

        [Boolean]$distributedtracing ,

        [Boolean]$disttracingsamplingrate ,

        [Boolean]$tcpattackcounterinterval ,

        [Boolean]$logstreamovernsip ,

        [Boolean]$aaainsight 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('templaterefresh')) { $Payload.Add('templaterefresh', $templaterefresh) }
            if ($PSBoundParameters.ContainsKey('appnamerefresh')) { $Payload.Add('appnamerefresh', $appnamerefresh) }
            if ($PSBoundParameters.ContainsKey('flowrecordinterval')) { $Payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ($PSBoundParameters.ContainsKey('securityinsightrecordinterval')) { $Payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ($PSBoundParameters.ContainsKey('udppmtu')) { $Payload.Add('udppmtu', $udppmtu) }
            if ($PSBoundParameters.ContainsKey('httpurl')) { $Payload.Add('httpurl', $httpurl) }
            if ($PSBoundParameters.ContainsKey('aaausername')) { $Payload.Add('aaausername', $aaausername) }
            if ($PSBoundParameters.ContainsKey('httpcookie')) { $Payload.Add('httpcookie', $httpcookie) }
            if ($PSBoundParameters.ContainsKey('httpreferer')) { $Payload.Add('httpreferer', $httpreferer) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('httphost')) { $Payload.Add('httphost', $httphost) }
            if ($PSBoundParameters.ContainsKey('httpuseragent')) { $Payload.Add('httpuseragent', $httpuseragent) }
            if ($PSBoundParameters.ContainsKey('clienttrafficonly')) { $Payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ($PSBoundParameters.ContainsKey('httpcontenttype')) { $Payload.Add('httpcontenttype', $httpcontenttype) }
            if ($PSBoundParameters.ContainsKey('httpauthorization')) { $Payload.Add('httpauthorization', $httpauthorization) }
            if ($PSBoundParameters.ContainsKey('httpvia')) { $Payload.Add('httpvia', $httpvia) }
            if ($PSBoundParameters.ContainsKey('httpxforwardedfor')) { $Payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ($PSBoundParameters.ContainsKey('httplocation')) { $Payload.Add('httplocation', $httplocation) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie')) { $Payload.Add('httpsetcookie', $httpsetcookie) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie2')) { $Payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ($PSBoundParameters.ContainsKey('connectionchaining')) { $Payload.Add('connectionchaining', $connectionchaining) }
            if ($PSBoundParameters.ContainsKey('httpdomain')) { $Payload.Add('httpdomain', $httpdomain) }
            if ($PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction')) { $Payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ($PSBoundParameters.ContainsKey('identifiername')) { $Payload.Add('identifiername', $identifiername) }
            if ($PSBoundParameters.ContainsKey('identifiersessionname')) { $Payload.Add('identifiersessionname', $identifiersessionname) }
            if ($PSBoundParameters.ContainsKey('observationdomainid')) { $Payload.Add('observationdomainid', $observationdomainid) }
            if ($PSBoundParameters.ContainsKey('observationdomainname')) { $Payload.Add('observationdomainname', $observationdomainname) }
            if ($PSBoundParameters.ContainsKey('subscriberawareness')) { $Payload.Add('subscriberawareness', $subscriberawareness) }
            if ($PSBoundParameters.ContainsKey('subscriberidobfuscation')) { $Payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ($PSBoundParameters.ContainsKey('subscriberidobfuscationalgo')) { $Payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ($PSBoundParameters.ContainsKey('gxsessionreporting')) { $Payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ($PSBoundParameters.ContainsKey('securityinsighttraffic')) { $Payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ($PSBoundParameters.ContainsKey('cacheinsight')) { $Payload.Add('cacheinsight', $cacheinsight) }
            if ($PSBoundParameters.ContainsKey('videoinsight')) { $Payload.Add('videoinsight', $videoinsight) }
            if ($PSBoundParameters.ContainsKey('httpquerywithurl')) { $Payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ($PSBoundParameters.ContainsKey('urlcategory')) { $Payload.Add('urlcategory', $urlcategory) }
            if ($PSBoundParameters.ContainsKey('lsnlogging')) { $Payload.Add('lsnlogging', $lsnlogging) }
            if ($PSBoundParameters.ContainsKey('cqareporting')) { $Payload.Add('cqareporting', $cqareporting) }
            if ($PSBoundParameters.ContainsKey('emailaddress')) { $Payload.Add('emailaddress', $emailaddress) }
            if ($PSBoundParameters.ContainsKey('usagerecordinterval')) { $Payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ($PSBoundParameters.ContainsKey('websaasappusagereporting')) { $Payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ($PSBoundParameters.ContainsKey('metrics')) { $Payload.Add('metrics', $metrics) }
            if ($PSBoundParameters.ContainsKey('events')) { $Payload.Add('events', $events) }
            if ($PSBoundParameters.ContainsKey('auditlogs')) { $Payload.Add('auditlogs', $auditlogs) }
            if ($PSBoundParameters.ContainsKey('observationpointid')) { $Payload.Add('observationpointid', $observationpointid) }
            if ($PSBoundParameters.ContainsKey('distributedtracing')) { $Payload.Add('distributedtracing', $distributedtracing) }
            if ($PSBoundParameters.ContainsKey('disttracingsamplingrate')) { $Payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ($PSBoundParameters.ContainsKey('tcpattackcounterinterval')) { $Payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ($PSBoundParameters.ContainsKey('logstreamovernsip')) { $Payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ($PSBoundParameters.ContainsKey('aaainsight')) { $Payload.Add('aaainsight', $aaainsight) }
            if ($PSCmdlet.ShouldProcess("appflowparam", "Unset Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowparam -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppflowparam: Finished"
    }
}

function Invoke-ADCGetAppflowparam {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER GetAll 
        Retreive all appflowparam object(s)
    .PARAMETER Count
        If specified, the count of the appflowparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowparam
    .EXAMPLE 
        Invoke-ADCGetAppflowparam -GetAll
    .EXAMPLE
        Invoke-ADCGetAppflowparam -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowparam
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam/
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
        Write-Verbose "Invoke-ADCGetAppflowparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appflowparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowparam: Ended"
    }
}

function Invoke-ADCAddAppflowpolicy {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the action to be associated with this policy. 
    .PARAMETER undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        Invoke-ADCAddAppflowpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        [string]$action ,

        [string]$undefaction ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("appflowpolicy", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowpolicy: Finished"
    }
}

function Invoke-ADCDeleteAppflowpolicy {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteAppflowpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicy -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicy: Finished"
    }
}

function Invoke-ADCUpdateAppflowpolicy {
<#
    .SYNOPSIS
        Update Appflow configuration Object
    .DESCRIPTION
        Update Appflow configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the action to be associated with this policy. 
    .PARAMETER undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAppflowpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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

        [string]$action ,

        [string]$undefaction ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("appflowpolicy", "Update Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppflowpolicy: Finished"
    }
}

function Invoke-ADCUnsetAppflowpolicy {
<#
    .SYNOPSIS
        Unset Appflow configuration Object
    .DESCRIPTION
        Unset Appflow configuration Object 
   .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
   .PARAMETER undefaction 
       Name of the appflow action to be associated with this policy when an undef event occurs. 
   .PARAMETER comment 
       Any comments about this policy.
    .EXAMPLE
        Invoke-ADCUnsetAppflowpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicy -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppflowpolicy: Finished"
    }
}

function Invoke-ADCRenameAppflowpolicy {
<#
    .SYNOPSIS
        Rename Appflow configuration Object
    .DESCRIPTION
        Rename Appflow configuration Object 
    .PARAMETER name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        Invoke-ADCRenameAppflowpolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appflowpolicy", "Rename Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppflowpolicy: Finished"
    }
}

function Invoke-ADCGetAppflowpolicy {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicy
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicy -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appflowpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicy: Ended"
    }
}

function Invoke-ADCAddAppflowpolicylabel {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER policylabeltype 
        Type of traffic evaluated by the policies bound to the policy label.  
        Default value: HTTP  
        Possible values = HTTP, OTHERTCP 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        Invoke-ADCAddAppflowpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        [string]$labelname ,

        [ValidateSet('HTTP', 'OTHERTCP')]
        [string]$policylabeltype = 'HTTP' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
            }
            if ($PSBoundParameters.ContainsKey('policylabeltype')) { $Payload.Add('policylabeltype', $policylabeltype) }
 
            if ($PSCmdlet.ShouldProcess("appflowpolicylabel", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteAppflowpolicylabel {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER labelname 
       Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteAppflowpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicylabel -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabel: Finished"
    }
}

function Invoke-ADCRenameAppflowpolicylabel {
<#
    .SYNOPSIS
        Rename Appflow configuration Object
    .DESCRIPTION
        Rename Appflow configuration Object 
    .PARAMETER labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER newname 
        New name for the policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameAppflowpolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppflowpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appflowpolicylabel", "Rename Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppflowpolicylabel: Finished"
    }
}

function Invoke-ADCGetAppflowpolicylabel {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER labelname 
       Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all appflowpolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabel
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabel
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appflowpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabel: Ended"
    }
}

function Invoke-ADCAddAppflowpolicylabelappflowpolicybinding {
<#
    .SYNOPSIS
        Add Appflow configuration Object
    .DESCRIPTION
        Add Appflow configuration Object 
    .PARAMETER labelname 
        Name of the policy label to which to bind the policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Name of the AppFlow policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER labeltype 
        Type of policy label to be invoked.  
        Possible values = vserver, policylabel 
    .PARAMETER invoke_labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel_appflowpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppflowpolicylabelappflowpolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicylabelappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCAddAppflowpolicylabelappflowpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("appflowpolicylabel_appflowpolicy_binding", "Add Appflow configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type appflowpolicylabel_appflowpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppflowpolicylabelappflowpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding {
<#
    .SYNOPSIS
        Delete Appflow configuration Object
    .DESCRIPTION
        Delete Appflow configuration Object
    .PARAMETER labelname 
       Name of the policy label to which to bind the policy.  
       Minimum length = 1    .PARAMETER policyname 
       Name of the AppFlow policy.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Appflow configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicylabel_appflowpolicy_binding -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppflowpolicylabelappflowpolicybinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER labelname 
       Name of the policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all appflowpolicylabel_appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelappflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabelappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabelappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabelappflowpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicylabelbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER labelname 
       Name of the policy label about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabelbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicyappflowglobalbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_appflowglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyappflowglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyappflowglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyappflowglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_appflowglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowglobalbinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_appflowpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_appflowpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicybinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicycsvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetAppflowpolicyvpnvserverbinding {
<#
    .SYNOPSIS
        Get Appflow configuration object(s)
    .DESCRIPTION
        Get Appflow configuration object(s)
    .PARAMETER name 
       Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all appflowpolicy_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appflowpolicy_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppflowpolicyvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppflowpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyvpnvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppflowpolicyvpnvserverbinding: Ended"
    }
}


