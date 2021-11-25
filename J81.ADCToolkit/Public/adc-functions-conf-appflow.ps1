function Invoke-ADCRenameAppflowaction {
    <#
    .SYNOPSIS
        Rename Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the AppFlow action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppflowaction -name <string> -newname <string>
        An example how to rename appflowaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowaction", "Rename Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $payload)
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

function Invoke-ADCUnsetAppflowaction {
    <#
    .SYNOPSIS
        Unset Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppflowaction -name <string>
        An example how to unset appflowaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$clientsidemeasurements,

        [Boolean]$comment,

        [Boolean]$pagetracking,

        [Boolean]$webinsight,

        [Boolean]$securityinsight,

        [Boolean]$botinsight,

        [Boolean]$ciinsight,

        [Boolean]$videoanalytics,

        [Boolean]$distributionalgorithm 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppflowaction {
    <#
    .SYNOPSIS
        Delete Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowaction -Name <string>
        An example how to delete appflowaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        Write-Verbose "Invoke-ADCDeleteAppflowaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        Name(s) of collector(s) to be associated with the AppFlow action. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppflowaction -name <string>
        An example how to update appflowaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Collectors,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clientsidemeasurements,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pagetracking,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Webinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Botinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ciinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoanalytics,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributionalgorithm,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('collectors') ) { $payload.Add('collectors', $collectors) }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSCmdlet.ShouldProcess("appflowaction", "Update Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $payload)
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

function Invoke-ADCAddAppflowaction {
    <#
    .SYNOPSIS
        Add Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        Name(s) of collector(s) to be associated with the AppFlow action. 
    .PARAMETER Clientsidemeasurements 
        On enabling this option, the Citrix ADC will collect the time required to load and render the mainpage on the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pagetracking 
        On enabling this option, the Citrix ADC will start tracking the page for waterfall chart by inserting a NS_ESNS cookie in the response. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Webinsight 
        On enabling this option, the Citrix ADC will send the webinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsight 
        On enabling this option, the Citrix ADC will send the security insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Botinsight 
        On enabling this option, the Citrix ADC will send the bot insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ciinsight 
        On enabling this option, the Citrix ADC will send the ContentInspection Insight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoanalytics 
        On enabling this option, the Citrix ADC will send the videoinsight records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Distributionalgorithm 
        On enabling this option, the Citrix ADC will distribute records among the collectors. Else, all records will be sent to all the collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metricslog 
        If only the stats records are to be exported, turn on this option. 
    .PARAMETER Transactionlog 
        Log ANOMALOUS or ALL transactions. 
        Possible values = ALL, ANOMALOUS 
    .PARAMETER Comment 
        Any comments about this action. In the CLI, if including spaces between words, enclose the comment in quotation marks. (The quotation marks are not required in the configuration utility.). 
    .PARAMETER PassThru 
        Return details about the created appflowaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowaction -name <string> -collectors <string[]>
        An example how to add appflowaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Collectors,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Clientsidemeasurements = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pagetracking = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Webinsight = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Botinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ciinsight = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoanalytics = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributionalgorithm = 'DISABLED',

        [boolean]$Metricslog,

        [ValidateSet('ALL', 'ANOMALOUS')]
        [string]$Transactionlog = 'ALL',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                collectors     = $collectors
            }
            if ( $PSBoundParameters.ContainsKey('clientsidemeasurements') ) { $payload.Add('clientsidemeasurements', $clientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('pagetracking') ) { $payload.Add('pagetracking', $pagetracking) }
            if ( $PSBoundParameters.ContainsKey('webinsight') ) { $payload.Add('webinsight', $webinsight) }
            if ( $PSBoundParameters.ContainsKey('securityinsight') ) { $payload.Add('securityinsight', $securityinsight) }
            if ( $PSBoundParameters.ContainsKey('botinsight') ) { $payload.Add('botinsight', $botinsight) }
            if ( $PSBoundParameters.ContainsKey('ciinsight') ) { $payload.Add('ciinsight', $ciinsight) }
            if ( $PSBoundParameters.ContainsKey('videoanalytics') ) { $payload.Add('videoanalytics', $videoanalytics) }
            if ( $PSBoundParameters.ContainsKey('distributionalgorithm') ) { $payload.Add('distributionalgorithm', $distributionalgorithm) }
            if ( $PSBoundParameters.ContainsKey('metricslog') ) { $payload.Add('metricslog', $metricslog) }
            if ( $PSBoundParameters.ContainsKey('transactionlog') ) { $payload.Add('transactionlog', $transactionlog) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowaction", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowaction -Filter $payload)
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

function Invoke-ADCGetAppflowaction {
    <#
    .SYNOPSIS
        Get Appflow configuration object(s).
    .DESCRIPTION
        Configuration for AppFlow action resource.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowaction object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowaction -GetAll 
        Get all appflowaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowaction -Count 
        Get the number of appflowaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowaction -name <string>
        Get appflowaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowaction -Filter @{ 'name'='<value>' }
        Get appflowaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Write-Verbose "Invoke-ADCGetAppflowaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Analyticsprofile 
        Analytics profile to be bound to the appflow action. 
    .PARAMETER PassThru 
        Return details about the created appflowaction_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowactionanalyticsprofilebinding -name <string>
        An example how to add appflowaction_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowactionanalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowactionanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("appflowaction_analyticsprofile_binding", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowaction_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowactionanalyticsprofilebinding -Filter $payload)
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
        Delete Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Analyticsprofile 
        Analytics profile to be bound to the appflow action.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowactionanalyticsprofilebinding -Name <string>
        An example how to delete appflowaction_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowactionanalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppflowactionanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to appflowaction.
    .PARAMETER Name 
        Name for the action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowaction_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionanalyticsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowactionanalyticsprofilebinding -GetAll 
        Get all appflowaction_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowactionanalyticsprofilebinding -Count 
        Get the number of appflowaction_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionanalyticsprofilebinding -name <string>
        Get appflowaction_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionanalyticsprofilebinding -Filter @{ 'name'='<value>' }
        Get appflowaction_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowactionanalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_analyticsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowaction_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowaction.
    .PARAMETER Name 
        Name of the action about which to display information. 
    .PARAMETER GetAll 
        Retrieve all appflowaction_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowaction_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowactionbinding -GetAll 
        Get all appflowaction_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionbinding -name <string>
        Get appflowaction_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowactionbinding -Filter @{ 'name'='<value>' }
        Get appflowaction_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowactionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowaction_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowactionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowaction_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowaction_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowaction_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowaction_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowaction_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRenameAppflowcollector {
    <#
    .SYNOPSIS
        Rename Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Newname 
        New name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must 
        contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at(@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppflowcollector -name <string> -newname <string>
        An example how to rename appflowcollector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Rename Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowcollector -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $payload)
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

function Invoke-ADCUnsetAppflowcollector {
    <#
    .SYNOPSIS
        Unset Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppflowcollector -name <string>
        An example how to unset appflowcollector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector
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

        [ValidateLength(1, 127)]
        [string]$Name,

        [Boolean]$ipaddress,

        [Boolean]$port,

        [Boolean]$netprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowcollector -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowcollector -Name <string>
        An example how to delete appflowcollector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        Write-Verbose "Invoke-ADCDeleteAppflowcollector: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowcollector -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCAddAppflowcollector {
    <#
    .SYNOPSIS
        Add Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address. 
    .PARAMETER Transport 
        Type of collector: either logstream or ipfix or rest. 
        Possible values = ipfix, logstream, rest 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowcollector -name <string> -ipaddress <string>
        An example how to add appflowcollector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Ipaddress,

        [int]$Port,

        [string]$Netprofile,

        [ValidateSet('ipfix', 'logstream', 'rest')]
        [string]$Transport = 'ipfix',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                ipaddress      = $ipaddress
            }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('transport') ) { $payload.Add('transport', $transport) }
            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowcollector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $payload)
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
        Update Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER Ipaddress 
        IPv4 address of the collector. 
    .PARAMETER Port 
        Port on which the collector listens. 
    .PARAMETER Netprofile 
        Netprofile to associate with the collector. The IP address defined in the profile is used as the source IP address for AppFlow traffic for this collector. If you do not set this parameter, the Citrix ADC IP (NSIP) address is used as the source IP address. 
    .PARAMETER PassThru 
        Return details about the created appflowcollector item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppflowcollector -name <string>
        An example how to update appflowcollector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
        [string]$Name,

        [string]$Ipaddress,

        [int]$Port,

        [string]$Netprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowcollector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipaddress') ) { $payload.Add('ipaddress', $ipaddress) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSCmdlet.ShouldProcess("appflowcollector", "Update Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowcollector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowcollector -Filter $payload)
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

function Invoke-ADCGetAppflowcollector {
    <#
    .SYNOPSIS
        Get Appflow configuration object(s).
    .DESCRIPTION
        Configuration for AppFlow collector resource.
    .PARAMETER Name 
        Name for the collector. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Only four collectors can be configured. 
    .PARAMETER GetAll 
        Retrieve all appflowcollector object(s).
    .PARAMETER Count
        If specified, the count of the appflowcollector object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowcollector
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowcollector -GetAll 
        Get all appflowcollector data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowcollector -Count 
        Get the number of appflowcollector objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowcollector -name <string>
        Get appflowcollector object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowcollector -Filter @{ 'name'='<value>' }
        Get appflowcollector data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowcollector
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowcollector/
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
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetAppflowcollector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowcollector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowcollector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowcollector objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowcollector configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowcollector configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowcollector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Specify vserver for a policy label associated with a virtual server, or policylabel for a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowglobal_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowglobalappflowpolicybinding -policyname <string> -priority <double>
        An example how to add appflowglobal_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowglobalappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'OVERRIDE', 'DEFAULT', 'OTHERTCP_REQ_OVERRIDE', 'OTHERTCP_REQ_DEFAULT', 'MSSQL_REQ_OVERRIDE', 'MSSQL_REQ_DEFAULT', 'MYSQL_REQ_OVERRIDE', 'MYSQL_REQ_DEFAULT', 'ICA_REQ_OVERRIDE', 'ICA_REQ_DEFAULT', 'ORACLE_REQ_OVERRIDE', 'ORACLE_REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowglobalappflowpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowglobal_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowglobalappflowpolicybinding -Filter $payload)
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
        Delete Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Type 
        Global bind point for which to show detailed information about the policies bound to the bind point. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, OVERRIDE, DEFAULT, OTHERTCP_REQ_OVERRIDE, OTHERTCP_REQ_DEFAULT, MSSQL_REQ_OVERRIDE, MSSQL_REQ_DEFAULT, MYSQL_REQ_OVERRIDE, MYSQL_REQ_DEFAULT, ICA_REQ_OVERRIDE, ICA_REQ_DEFAULT, ORACLE_REQ_OVERRIDE, ORACLE_REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowglobalappflowpolicybinding 
        An example how to delete appflowglobal_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowglobalappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppflowglobalappflowpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("appflowglobal_appflowpolicy_binding", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowglobal.
    .PARAMETER GetAll 
        Retrieve all appflowglobal_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowglobal_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalappflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowglobalappflowpolicybinding -GetAll 
        Get all appflowglobal_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowglobalappflowpolicybinding -Count 
        Get the number of appflowglobal_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalappflowpolicybinding -name <string>
        Get appflowglobal_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalappflowpolicybinding -Filter @{ 'name'='<value>' }
        Get appflowglobal_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowglobalappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowglobalappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowglobal.
    .PARAMETER GetAll 
        Retrieve all appflowglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowglobalbinding -GetAll 
        Get all appflowglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalbinding -name <string>
        Get appflowglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowglobalbinding -Filter @{ 'name'='<value>' }
        Get appflowglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAppflowparam {
    <#
    .SYNOPSIS
        Unset Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER Templaterefresh 
        Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals. 
    .PARAMETER Appnamerefresh 
        Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC. 
    .PARAMETER Flowrecordinterval 
        Interval, in seconds, at which to send flow records to the configured collectors. 
    .PARAMETER Securityinsightrecordinterval 
        Interval, in seconds, at which to send security insight flow records to the configured collectors. 
    .PARAMETER Udppmtu 
        MTU, in bytes, for IPFIX UDP packets. 
    .PARAMETER Httpurl 
        Include the http URL that the Citrix ADC received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Aaausername 
        Enable AppFlow AAA Username logging. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        Include the cookie that was in the HTTP request the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        Include the web page that was last visited by the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        Include the method that was specified in the HTTP request that the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        Include the host identified in the HTTP request that the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        Include the client application through which the HTTP request was received by the Citrix ADC. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clienttrafficonly 
        Generate AppFlow records for only the traffic from the client. 
        Possible values = YES, NO 
    .PARAMETER Httpcontenttype 
        Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthorization 
        Include the HTTP Authorization header information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        Include the httpVia header which contains the IP address of proxy server through which the client accessed the server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedfor 
        Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        Include the HTTP location headers returned from the HTTP responses. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connectionchaining 
        Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomain 
        Include the http domain request to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Skipcacheredirectionhttptransaction 
        Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiername 
        Include the stream identifier name to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiersessionname 
        Include the stream identifier session name to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationdomainid 
        An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group. 
    .PARAMETER Observationdomainname 
        Name of the Observation Domain defined by the observation domain ID. 
    .PARAMETER Subscriberawareness 
        Enable this option for logging end user MSISDN in L4/L7 appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscation 
        Enable this option for obfuscating MSISDN in L4/L7 appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscationalgo 
        Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN. 
        Possible values = MD5, SHA256 
    .PARAMETER Gxsessionreporting 
        Enable this option for Gx session reporting. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsighttraffic 
        Enable/disable the feature individually on appflow action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheinsight 
        Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoinsight 
        Enable/disable the feature individually on appflow action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpquerywithurl 
        Include the HTTP query segment along with the URL that the Citrix ADC received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        Include the URL category record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsnlogging 
        On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        TCP CQA reporting enable/disable knob. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Emailaddress 
        Enable AppFlow user email-id logging. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usagerecordinterval 
        On enabling this option, the NGS will send bandwidth usage record to configured collectors. 
    .PARAMETER Websaasappusagereporting 
        On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metrics 
        Enable Citrix ADC Stats to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        Enable Events to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        Enable Auditlogs to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationpointid 
        An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID. 
    .PARAMETER Distributedtracing 
        Enable generation of the distributed tracing templates in the Appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disttracingsamplingrate 
        Sampling rate for Distributed Tracing. 
    .PARAMETER Tcpattackcounterinterval 
        Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent. 
    .PARAMETER Logstreamovernsip 
        To use the Citrix ADC IP to send Logstream records instead of the SNIP. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsauthtoken 
        Authentication token to be set by the agent. 
    .PARAMETER Timeseriesovernsip 
        To use the Citrix ADC IP to send Time series data such as metrics and events, instead of the SNIP. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppflowparam 
        An example how to unset appflowparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppflowparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam
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

        [Boolean]$templaterefresh,

        [Boolean]$appnamerefresh,

        [Boolean]$flowrecordinterval,

        [Boolean]$securityinsightrecordinterval,

        [Boolean]$udppmtu,

        [Boolean]$httpurl,

        [Boolean]$aaausername,

        [Boolean]$httpcookie,

        [Boolean]$httpreferer,

        [Boolean]$httpmethod,

        [Boolean]$httphost,

        [Boolean]$httpuseragent,

        [Boolean]$clienttrafficonly,

        [Boolean]$httpcontenttype,

        [Boolean]$httpauthorization,

        [Boolean]$httpvia,

        [Boolean]$httpxforwardedfor,

        [Boolean]$httplocation,

        [Boolean]$httpsetcookie,

        [Boolean]$httpsetcookie2,

        [Boolean]$connectionchaining,

        [Boolean]$httpdomain,

        [Boolean]$skipcacheredirectionhttptransaction,

        [Boolean]$identifiername,

        [Boolean]$identifiersessionname,

        [Boolean]$observationdomainid,

        [Boolean]$observationdomainname,

        [Boolean]$subscriberawareness,

        [Boolean]$subscriberidobfuscation,

        [Boolean]$subscriberidobfuscationalgo,

        [Boolean]$gxsessionreporting,

        [Boolean]$securityinsighttraffic,

        [Boolean]$cacheinsight,

        [Boolean]$videoinsight,

        [Boolean]$httpquerywithurl,

        [Boolean]$urlcategory,

        [Boolean]$lsnlogging,

        [Boolean]$cqareporting,

        [Boolean]$emailaddress,

        [Boolean]$usagerecordinterval,

        [Boolean]$websaasappusagereporting,

        [Boolean]$metrics,

        [Boolean]$events,

        [Boolean]$auditlogs,

        [Boolean]$observationpointid,

        [Boolean]$distributedtracing,

        [Boolean]$disttracingsamplingrate,

        [Boolean]$tcpattackcounterinterval,

        [Boolean]$logstreamovernsip,

        [Boolean]$analyticsauthtoken,

        [Boolean]$timeseriesovernsip 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('templaterefresh') ) { $payload.Add('templaterefresh', $templaterefresh) }
            if ( $PSBoundParameters.ContainsKey('appnamerefresh') ) { $payload.Add('appnamerefresh', $appnamerefresh) }
            if ( $PSBoundParameters.ContainsKey('flowrecordinterval') ) { $payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('securityinsightrecordinterval') ) { $payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('udppmtu') ) { $payload.Add('udppmtu', $udppmtu) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('aaausername') ) { $payload.Add('aaausername', $aaausername) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('clienttrafficonly') ) { $payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthorization') ) { $payload.Add('httpauthorization', $httpauthorization) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedfor') ) { $payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('connectionchaining') ) { $payload.Add('connectionchaining', $connectionchaining) }
            if ( $PSBoundParameters.ContainsKey('httpdomain') ) { $payload.Add('httpdomain', $httpdomain) }
            if ( $PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction') ) { $payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSBoundParameters.ContainsKey('identifiersessionname') ) { $payload.Add('identifiersessionname', $identifiersessionname) }
            if ( $PSBoundParameters.ContainsKey('observationdomainid') ) { $payload.Add('observationdomainid', $observationdomainid) }
            if ( $PSBoundParameters.ContainsKey('observationdomainname') ) { $payload.Add('observationdomainname', $observationdomainname) }
            if ( $PSBoundParameters.ContainsKey('subscriberawareness') ) { $payload.Add('subscriberawareness', $subscriberawareness) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscation') ) { $payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscationalgo') ) { $payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ( $PSBoundParameters.ContainsKey('gxsessionreporting') ) { $payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ( $PSBoundParameters.ContainsKey('securityinsighttraffic') ) { $payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ( $PSBoundParameters.ContainsKey('cacheinsight') ) { $payload.Add('cacheinsight', $cacheinsight) }
            if ( $PSBoundParameters.ContainsKey('videoinsight') ) { $payload.Add('videoinsight', $videoinsight) }
            if ( $PSBoundParameters.ContainsKey('httpquerywithurl') ) { $payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('lsnlogging') ) { $payload.Add('lsnlogging', $lsnlogging) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('usagerecordinterval') ) { $payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ( $PSBoundParameters.ContainsKey('websaasappusagereporting') ) { $payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSBoundParameters.ContainsKey('observationpointid') ) { $payload.Add('observationpointid', $observationpointid) }
            if ( $PSBoundParameters.ContainsKey('distributedtracing') ) { $payload.Add('distributedtracing', $distributedtracing) }
            if ( $PSBoundParameters.ContainsKey('disttracingsamplingrate') ) { $payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ( $PSBoundParameters.ContainsKey('tcpattackcounterinterval') ) { $payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ( $PSBoundParameters.ContainsKey('logstreamovernsip') ) { $payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ( $PSBoundParameters.ContainsKey('analyticsauthtoken') ) { $payload.Add('analyticsauthtoken', $analyticsauthtoken) }
            if ( $PSBoundParameters.ContainsKey('timeseriesovernsip') ) { $payload.Add('timeseriesovernsip', $timeseriesovernsip) }
            if ( $PSCmdlet.ShouldProcess("appflowparam", "Unset Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAppflowparam {
    <#
    .SYNOPSIS
        Update Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER Templaterefresh 
        Refresh interval, in seconds, at which to export the template data. Because data transmission is in UDP, the templates must be resent at regular intervals. 
    .PARAMETER Appnamerefresh 
        Interval, in seconds, at which to send Appnames to the configured collectors. Appname refers to the name of an entity (virtual server, service, or service group) in the Citrix ADC. 
    .PARAMETER Flowrecordinterval 
        Interval, in seconds, at which to send flow records to the configured collectors. 
    .PARAMETER Securityinsightrecordinterval 
        Interval, in seconds, at which to send security insight flow records to the configured collectors. 
    .PARAMETER Udppmtu 
        MTU, in bytes, for IPFIX UDP packets. 
    .PARAMETER Httpurl 
        Include the http URL that the Citrix ADC received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Aaausername 
        Enable AppFlow AAA Username logging. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        Include the cookie that was in the HTTP request the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        Include the web page that was last visited by the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        Include the method that was specified in the HTTP request that the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        Include the host identified in the HTTP request that the appliance received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        Include the client application through which the HTTP request was received by the Citrix ADC. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Clienttrafficonly 
        Generate AppFlow records for only the traffic from the client. 
        Possible values = YES, NO 
    .PARAMETER Httpcontenttype 
        Include the HTTP Content-Type header sent from the server to the client to determine the type of the content sent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthorization 
        Include the HTTP Authorization header information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        Include the httpVia header which contains the IP address of proxy server through which the client accessed the server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedfor 
        Include the httpXForwardedFor header, which contains the original IP Address of the client using a proxy server to access the server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        Include the HTTP location headers returned from the HTTP responses. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        Include the Set-cookie header sent from the server to the client in response to a HTTP request. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Connectionchaining 
        Enable connection chaining so that the client server flows of a connection are linked. Also the connection chain ID is propagated across Citrix ADCs, so that in a multi-hop environment the flows belonging to the same logical connection are linked. This id is also logged as part of appflow record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomain 
        Include the http domain request to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Skipcacheredirectionhttptransaction 
        Skip Cache http transaction. This HTTP transaction is specific to Cache Redirection module. In Case of Cache Miss there will be another HTTP transaction initiated by the cache server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiername 
        Include the stream identifier name to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Identifiersessionname 
        Include the stream identifier session name to be exported. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationdomainid 
        An observation domain groups a set of Citrix ADCs based on deployment: cluster, HA etc. A unique Observation Domain ID is required to be assigned to each such group. 
    .PARAMETER Observationdomainname 
        Name of the Observation Domain defined by the observation domain ID. 
    .PARAMETER Subscriberawareness 
        Enable this option for logging end user MSISDN in L4/L7 appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscation 
        Enable this option for obfuscating MSISDN in L4/L7 appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberidobfuscationalgo 
        Algorithm(MD5 or SHA256) to be used for obfuscating MSISDN. 
        Possible values = MD5, SHA256 
    .PARAMETER Gxsessionreporting 
        Enable this option for Gx session reporting. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Securityinsighttraffic 
        Enable/disable the feature individually on appflow action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cacheinsight 
        Flag to determine whether cache records need to be exported or not. If this flag is true and IC is enabled, cache records are exported instead of L7 HTTP records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Videoinsight 
        Enable/disable the feature individually on appflow action. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpquerywithurl 
        Include the HTTP query segment along with the URL that the Citrix ADC received from the client. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        Include the URL category record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsnlogging 
        On enabling this option, the Citrix ADC will send the Large Scale Nat(LSN) records to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        TCP CQA reporting enable/disable knob. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Emailaddress 
        Enable AppFlow user email-id logging. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Usagerecordinterval 
        On enabling this option, the NGS will send bandwidth usage record to configured collectors. 
    .PARAMETER Websaasappusagereporting 
        On enabling this option, NGS will send data used by Web/saas app at the end of every HTTP transaction to configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Metrics 
        Enable Citrix ADC Stats to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        Enable Events to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        Enable Auditlogs to be sent to the Telemetry Agent. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Observationpointid 
        An observation point ID is identifier for the NetScaler from which appflow records are being exported. By default, the NetScaler IP is the observation point ID. 
    .PARAMETER Distributedtracing 
        Enable generation of the distributed tracing templates in the Appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disttracingsamplingrate 
        Sampling rate for Distributed Tracing. 
    .PARAMETER Tcpattackcounterinterval 
        Interval, in seconds, at which to send tcp attack counters to the configured collectors. If 0 is configured, the record is not sent. 
    .PARAMETER Logstreamovernsip 
        To use the Citrix ADC IP to send Logstream records instead of the SNIP. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsauthtoken 
        Authentication token to be set by the agent. 
    .PARAMETER Timeseriesovernsip 
        To use the Citrix ADC IP to send Time series data such as metrics and events, instead of the SNIP. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppflowparam 
        An example how to update appflowparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppflowparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam/
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

        [ValidateRange(60, 3600)]
        [double]$Templaterefresh,

        [ValidateRange(60, 3600)]
        [double]$Appnamerefresh,

        [ValidateRange(60, 3600)]
        [double]$Flowrecordinterval,

        [ValidateRange(60, 3600)]
        [double]$Securityinsightrecordinterval,

        [ValidateRange(128, 1472)]
        [double]$Udppmtu,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Aaausername,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpreferer,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpmethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httphost,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpuseragent,

        [ValidateSet('YES', 'NO')]
        [string]$Clienttrafficonly,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcontenttype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpauthorization,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpvia,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpxforwardedfor,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httplocation,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie2,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Connectionchaining,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpdomain,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Skipcacheredirectionhttptransaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Identifiername,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Identifiersessionname,

        [double]$Observationdomainid,

        [string]$Observationdomainname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberawareness,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberidobfuscation,

        [ValidateSet('MD5', 'SHA256')]
        [string]$Subscriberidobfuscationalgo,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Gxsessionreporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Securityinsighttraffic,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cacheinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Videoinsight,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpquerywithurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlcategory,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsnlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cqareporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Emailaddress,

        [ValidateRange(0, 7200)]
        [double]$Usagerecordinterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Websaasappusagereporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metrics,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Events,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Auditlogs,

        [double]$Observationpointid,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Distributedtracing,

        [ValidateRange(0, 100)]
        [double]$Disttracingsamplingrate,

        [ValidateRange(0, 3600)]
        [double]$Tcpattackcounterinterval,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logstreamovernsip,

        [string]$Analyticsauthtoken,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Timeseriesovernsip 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('templaterefresh') ) { $payload.Add('templaterefresh', $templaterefresh) }
            if ( $PSBoundParameters.ContainsKey('appnamerefresh') ) { $payload.Add('appnamerefresh', $appnamerefresh) }
            if ( $PSBoundParameters.ContainsKey('flowrecordinterval') ) { $payload.Add('flowrecordinterval', $flowrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('securityinsightrecordinterval') ) { $payload.Add('securityinsightrecordinterval', $securityinsightrecordinterval) }
            if ( $PSBoundParameters.ContainsKey('udppmtu') ) { $payload.Add('udppmtu', $udppmtu) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('aaausername') ) { $payload.Add('aaausername', $aaausername) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('clienttrafficonly') ) { $payload.Add('clienttrafficonly', $clienttrafficonly) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthorization') ) { $payload.Add('httpauthorization', $httpauthorization) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedfor') ) { $payload.Add('httpxforwardedfor', $httpxforwardedfor) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('connectionchaining') ) { $payload.Add('connectionchaining', $connectionchaining) }
            if ( $PSBoundParameters.ContainsKey('httpdomain') ) { $payload.Add('httpdomain', $httpdomain) }
            if ( $PSBoundParameters.ContainsKey('skipcacheredirectionhttptransaction') ) { $payload.Add('skipcacheredirectionhttptransaction', $skipcacheredirectionhttptransaction) }
            if ( $PSBoundParameters.ContainsKey('identifiername') ) { $payload.Add('identifiername', $identifiername) }
            if ( $PSBoundParameters.ContainsKey('identifiersessionname') ) { $payload.Add('identifiersessionname', $identifiersessionname) }
            if ( $PSBoundParameters.ContainsKey('observationdomainid') ) { $payload.Add('observationdomainid', $observationdomainid) }
            if ( $PSBoundParameters.ContainsKey('observationdomainname') ) { $payload.Add('observationdomainname', $observationdomainname) }
            if ( $PSBoundParameters.ContainsKey('subscriberawareness') ) { $payload.Add('subscriberawareness', $subscriberawareness) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscation') ) { $payload.Add('subscriberidobfuscation', $subscriberidobfuscation) }
            if ( $PSBoundParameters.ContainsKey('subscriberidobfuscationalgo') ) { $payload.Add('subscriberidobfuscationalgo', $subscriberidobfuscationalgo) }
            if ( $PSBoundParameters.ContainsKey('gxsessionreporting') ) { $payload.Add('gxsessionreporting', $gxsessionreporting) }
            if ( $PSBoundParameters.ContainsKey('securityinsighttraffic') ) { $payload.Add('securityinsighttraffic', $securityinsighttraffic) }
            if ( $PSBoundParameters.ContainsKey('cacheinsight') ) { $payload.Add('cacheinsight', $cacheinsight) }
            if ( $PSBoundParameters.ContainsKey('videoinsight') ) { $payload.Add('videoinsight', $videoinsight) }
            if ( $PSBoundParameters.ContainsKey('httpquerywithurl') ) { $payload.Add('httpquerywithurl', $httpquerywithurl) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('lsnlogging') ) { $payload.Add('lsnlogging', $lsnlogging) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('emailaddress') ) { $payload.Add('emailaddress', $emailaddress) }
            if ( $PSBoundParameters.ContainsKey('usagerecordinterval') ) { $payload.Add('usagerecordinterval', $usagerecordinterval) }
            if ( $PSBoundParameters.ContainsKey('websaasappusagereporting') ) { $payload.Add('websaasappusagereporting', $websaasappusagereporting) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSBoundParameters.ContainsKey('observationpointid') ) { $payload.Add('observationpointid', $observationpointid) }
            if ( $PSBoundParameters.ContainsKey('distributedtracing') ) { $payload.Add('distributedtracing', $distributedtracing) }
            if ( $PSBoundParameters.ContainsKey('disttracingsamplingrate') ) { $payload.Add('disttracingsamplingrate', $disttracingsamplingrate) }
            if ( $PSBoundParameters.ContainsKey('tcpattackcounterinterval') ) { $payload.Add('tcpattackcounterinterval', $tcpattackcounterinterval) }
            if ( $PSBoundParameters.ContainsKey('logstreamovernsip') ) { $payload.Add('logstreamovernsip', $logstreamovernsip) }
            if ( $PSBoundParameters.ContainsKey('analyticsauthtoken') ) { $payload.Add('analyticsauthtoken', $analyticsauthtoken) }
            if ( $PSBoundParameters.ContainsKey('timeseriesovernsip') ) { $payload.Add('timeseriesovernsip', $timeseriesovernsip) }
            if ( $PSCmdlet.ShouldProcess("appflowparam", "Update Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowparam -Payload $payload -GetWarning
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

function Invoke-ADCGetAppflowparam {
    <#
    .SYNOPSIS
        Get Appflow configuration object(s).
    .DESCRIPTION
        Configuration for AppFlow parameter resource.
    .PARAMETER GetAll 
        Retrieve all appflowparam object(s).
    .PARAMETER Count
        If specified, the count of the appflowparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowparam -GetAll 
        Get all appflowparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowparam -name <string>
        Get appflowparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowparam -Filter @{ 'name'='<value>' }
        Get appflowparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowparam/
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
        Write-Verbose "Invoke-ADCGetAppflowparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving appflowparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRenameAppflowpolicy {
    <#
    .SYNOPSIS
        Rename Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy. Must begin with an ASCII alphabetic or underscore (_)character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppflowpolicy -name <string> -newname <string>
        An example how to rename appflowpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Rename Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $payload)
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

function Invoke-ADCDeleteAppflowpolicy {
    <#
    .SYNOPSIS
        Delete Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowpolicy -Name <string>
        An example how to delete appflowpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the action to be associated with this policy. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppflowpolicy -name <string>
        An example how to update appflowpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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

        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Update Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $payload)
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
        Unset Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppflowpolicy -name <string>
        An example how to unset appflowpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appflowpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCAddAppflowpolicy {
    <#
    .SYNOPSIS
        Add Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Rule 
        Expression or other value against which the traffic is evaluated. Must be a Boolean expression. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the action to be associated with this policy. 
    .PARAMETER Undefaction 
        Name of the appflow action to be associated with this policy when an undef event occurs. 
    .PARAMETER Comment 
        Any comments about this policy. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowpolicy -name <string> -rule <string> -action <string>
        An example how to add appflowpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        [string]$Action,

        [string]$Undefaction,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicy", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicy -Filter $payload)
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

function Invoke-ADCGetAppflowpolicy {
    <#
    .SYNOPSIS
        Get Appflow configuration object(s).
    .DESCRIPTION
        Configuration for AppFlow policy resource.
    .PARAMETER Name 
        Name for the policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicy -GetAll 
        Get all appflowpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicy -Count 
        Get the number of appflowpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicy -name <string>
        Get appflowpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicy -Filter @{ 'name'='<value>' }
        Get appflowpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRenameAppflowpolicylabel {
    <#
    .SYNOPSIS
        Rename Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Newname 
        New name for the policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppflowpolicylabel -labelname <string> -newname <string>
        An example how to rename appflowpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppflowpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppflowpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel", "Rename Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabel -Filter $payload)
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

function Invoke-ADCAddAppflowpolicylabel {
    <#
    .SYNOPSIS
        Add Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Policylabeltype 
        Type of traffic evaluated by the policies bound to the policy label. 
        Possible values = HTTP, OTHERTCP, HTTP_QUIC 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowpolicylabel -labelname <string>
        An example how to add appflowpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        [string]$Labelname,

        [ValidateSet('HTTP', 'OTHERTCP', 'HTTP_QUIC')]
        [string]$Policylabeltype = 'HTTP',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppflowpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appflowpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabel -Filter $payload)
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
        Delete Appflow configuration Object.
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowpolicylabel -Labelname <string>
        An example how to delete appflowpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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

function Invoke-ADCGetAppflowpolicylabel {
    <#
    .SYNOPSIS
        Get Appflow configuration object(s).
    .DESCRIPTION
        Configuration for AppFlow policy label resource.
    .PARAMETER Labelname 
        Name of the AppFlow policy label. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylabel -GetAll 
        Get all appflowpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylabel -Count 
        Get the number of appflowpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabel -name <string>
        Get appflowpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabel -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appflowpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Invoke policies bound to a virtual server or a user-defined policy label. After the invoked policies are evaluated, the flow returns to the policy with the next priority. 
    .PARAMETER Labeltype 
        Type of policy label to be invoked. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created appflowpolicylabel_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppflowpolicylabelappflowpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add appflowpolicylabel_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppflowpolicylabelappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCAddAppflowpolicylabelappflowpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("appflowpolicylabel_appflowpolicy_binding", "Add Appflow configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appflowpolicylabel_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Filter $payload)
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
        Delete Appflow configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the AppFlow policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding -Labelname <string>
        An example how to delete appflowpolicylabel_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppflowpolicylabelappflowpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Appflow configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelappflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -GetAll 
        Get all appflowpolicylabel_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Count 
        Get the number of appflowpolicylabel_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -name <string>
        Get appflowpolicylabel_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelappflowpolicybinding -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabelappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_appflowpolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowpolicylabel.
    .PARAMETER Labelname 
        Name of the policy label about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylabelbinding -GetAll 
        Get all appflowpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelbinding -name <string>
        Get appflowpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetAppflowpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowglobal that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_appflowglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyappflowglobalbinding -GetAll 
        Get all appflowpolicy_appflowglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyappflowglobalbinding -Count 
        Get the number of appflowpolicy_appflowglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowglobalbinding -name <string>
        Get appflowpolicy_appflowglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowglobalbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_appflowglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyappflowglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_appflowglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicylabel that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_appflowpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_appflowpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -GetAll 
        Get all appflowpolicy_appflowpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -Count 
        Get the number of appflowpolicy_appflowpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -name <string>
        Get appflowpolicy_appflowpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_appflowpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_appflowpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyappflowpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_appflowpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_appflowpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_appflowpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicybinding -GetAll 
        Get all appflowpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicybinding -name <string>
        Get appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicybinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicycsvserverbinding -GetAll 
        Get all appflowpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicycsvserverbinding -Count 
        Get the number of appflowpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicycsvserverbinding -name <string>
        Get appflowpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicycsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylbvserverbinding -GetAll 
        Get all appflowpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicylbvserverbinding -Count 
        Get the number of appflowpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylbvserverbinding -name <string>
        Get appflowpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicylbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Appflow configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to appflowpolicy.
    .PARAMETER Name 
        Name of the policy about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all appflowpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appflowpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyvpnvserverbinding -GetAll 
        Get all appflowpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppflowpolicyvpnvserverbinding -Count 
        Get the number of appflowpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyvpnvserverbinding -name <string>
        Get appflowpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppflowpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get appflowpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppflowpolicyvpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appflow/appflowpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppflowpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appflowpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appflowpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appflowpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


