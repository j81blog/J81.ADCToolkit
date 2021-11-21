function Invoke-ADCDeleteAuditmessageaction {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditmessageaction -Name <string>
        An example how to delete auditmessageaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditmessageaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditmessageaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditmessageaction: Finished"
    }
}

function Invoke-ADCUpdateAuditmessageaction {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the severity level of the log message being generated.. 
        The following loglevels are valid: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditmessageaction -name <string>
        An example how to update auditmessageaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditmessageaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Loglevel,

        [string]$Stringbuilderexpr,

        [ValidateSet('YES', 'NO')]
        [string]$Logtonewnslog,

        [ValidateSet('YES', 'NO')]
        [string]$Bypasssafetycheck,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('stringbuilderexpr') ) { $payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("auditmessageaction", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditmessageaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditmessageaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAuditmessageaction: Finished"
    }
}

function Invoke-ADCUnsetAuditmessageaction {
    <#
    .SYNOPSIS
        Unset Audit configuration Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
        Possible values = YES, NO
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAuditmessageaction -name <string>
        An example how to unset auditmessageaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAuditmessageaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction
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

        [Boolean]$logtonewnslog,

        [Boolean]$bypasssafetycheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditmessageaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAuditmessageaction: Finished"
    }
}

function Invoke-ADCAddAuditmessageaction {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the severity level of the log message being generated.. 
        The following loglevels are valid: 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER Logtonewnslog 
        Send the message to the new nslog. 
        Possible values = YES, NO 
    .PARAMETER Bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions. 
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditmessageaction -name <string> -loglevel <string> -stringbuilderexpr <string>
        An example how to add auditmessageaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditmessageaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$Loglevel,

        [Parameter(Mandatory)]
        [string]$Stringbuilderexpr,

        [ValidateSet('YES', 'NO')]
        [string]$Logtonewnslog,

        [ValidateSet('YES', 'NO')]
        [string]$Bypasssafetycheck = 'NO',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditmessageaction: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                loglevel          = $loglevel
                stringbuilderexpr = $stringbuilderexpr
            }
            if ( $PSBoundParameters.ContainsKey('logtonewnslog') ) { $payload.Add('logtonewnslog', $logtonewnslog) }
            if ( $PSBoundParameters.ContainsKey('bypasssafetycheck') ) { $payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ( $PSCmdlet.ShouldProcess("auditmessageaction", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditmessageaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditmessageaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditmessageaction: Finished"
    }
}

function Invoke-ADCGetAuditmessageaction {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for message action resource.
    .PARAMETER Name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER GetAll 
        Retrieve all auditmessageaction object(s).
    .PARAMETER Count
        If specified, the count of the auditmessageaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessageaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditmessageaction -GetAll 
        Get all auditmessageaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditmessageaction -Count 
        Get the number of auditmessageaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessageaction -name <string>
        Get auditmessageaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessageaction -Filter @{ 'name'='<value>' }
        Get auditmessageaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditmessageaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-ADCGetAuditmessageaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditmessageaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessageaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessageaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessageaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditmessageaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditmessageaction: Ended"
    }
}

function Invoke-ADCGetAuditmessages {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for audit message resource.
    .PARAMETER Loglevel 
        Audit log level filter, which specifies the types of events to display. 
        The following loglevels are valid: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG 
    .PARAMETER Numofmesgs 
        Number of log messages to be displayed. 
    .PARAMETER GetAll 
        Retrieve all auditmessages object(s).
    .PARAMETER Count
        If specified, the count of the auditmessages object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessages
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditmessages -GetAll 
        Get all auditmessages data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditmessages -Count 
        Get the number of auditmessages objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessages -name <string>
        Get auditmessages object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditmessages -Filter @{ 'name'='<value>' }
        Get auditmessages data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditmessages
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessages/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string[]]$Loglevel,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(1, 256)]
        [double]$Numofmesgs,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAuditmessages: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditmessages objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessages objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessages objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('loglevel') ) { $arguments.Add('loglevel', $loglevel) } 
                if ( $PSBoundParameters.ContainsKey('numofmesgs') ) { $arguments.Add('numofmesgs', $numofmesgs) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessages configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditmessages configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditmessages: Ended"
    }
}

function Invoke-ADCUnsetAuditnslogaction {
    <#
    .SYNOPSIS
        Unset Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAuditnslogaction -name <string>
        An example how to unset auditnslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAuditnslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction
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

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$sslinterception,

        [Boolean]$contentinspectionlog,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditnslogaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAuditnslogaction: Finished"
    }
}

function Invoke-ADCDeleteAuditnslogaction {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditnslogaction -Name <string>
        An example how to delete auditnslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogaction: Finished"
    }
}

function Invoke-ADCUpdateAuditnslogaction {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed. 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditnslogaction -name <string>
        An example how to update auditnslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry,

        [boolean]$Domainresolvenow,

        [int]$Serverport,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogaction", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditnslogaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAuditnslogaction: Finished"
    }
}

function Invoke-ADCAddAuditnslogaction {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME. Coordinated Universal Time. 
        * LOCAL_TIME. The server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditnslogaction -name <string> -loglevel <string[]>
        An example how to add auditnslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditnslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry = '5',

        [int]$Serverport,

        [Parameter(Mandatory)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                loglevel       = $loglevel
            }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogaction", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditnslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditnslogaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditnslogaction: Finished"
    }
}

function Invoke-ADCGetAuditnslogaction {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for ns log action resource.
    .PARAMETER Name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER GetAll 
        Retrieve all auditnslogaction object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogaction -GetAll 
        Get all auditnslogaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogaction -Count 
        Get the number of auditnslogaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogaction -name <string>
        Get auditnslogaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogaction -Filter @{ 'name'='<value>' }
        Get auditnslogaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-ADCGetAuditnslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogaction: Ended"
    }
}

function Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER Policyname 
        Name of the audit nslog policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Globalbindtype 
        . 
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditnslogglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding -policyname <string> -priority <double>
        An example how to add auditnslogglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL')]
        [string]$Globalbindtype = 'SYSTEM_GLOBAL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('globalbindtype') ) { $payload.Add('globalbindtype', $globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER Policyname 
        Name of the audit nslog policy. 
    .PARAMETER Globalbindtype 
        . 
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding 
        An example how to delete auditnslogglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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

        [string]$Globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Globalbindtype') ) { $arguments.Add('globalbindtype', $Globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to auditnslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditnslogglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -GetAll 
        Get all auditnslogglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Count 
        Get the number of auditnslogglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -name <string>
        Get auditnslogglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get auditnslogglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditnslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditnslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogglobalbinding -GetAll 
        Get all auditnslogglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalbinding -name <string>
        Get auditnslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogglobalbinding: Ended"
    }
}

function Invoke-ADCUnsetAuditnslogparams {
    <#
    .SYNOPSIS
        Unset Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Configure auditing to log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Configure auditing to log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME - Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAuditnslogparams 
        An example how to unset auditnslogparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAuditnslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams
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

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering,

        [Boolean]$contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditnslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogparams", "Unset Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditnslogparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAuditnslogparams: Finished"
    }
}

function Invoke-ADCUpdateAuditnslogparams {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER Serverip 
        IP address of the nslog server. 
    .PARAMETER Serverport 
        Port on which the nslog server accepts connections. 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Configure auditing to log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Configure auditing to log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME - Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to nslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditnslogparams 
        An example how to update auditnslogparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams/
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
        [string]$Serverip,

        [int]$Serverport,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditnslogparams", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogparams -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAuditnslogparams: Finished"
    }
}

function Invoke-ADCGetAuditnslogparams {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for ns log parameters resource.
    .PARAMETER GetAll 
        Retrieve all auditnslogparams object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogparams -GetAll 
        Get all auditnslogparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogparams -name <string>
        Get auditnslogparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogparams -Filter @{ 'name'='<value>' }
        Get auditnslogparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams/
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
        Write-Verbose "Invoke-ADCGetAuditnslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogparams: Ended"
    }
}

function Invoke-ADCAddAuditnslogpolicy {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server. 
    .PARAMETER Action 
        Nslog server action that is performed when this policy matches. 
        NOTE: An nslog server action must be associated with an nslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditnslogpolicy -name <string> -rule <string> -action <string>
        An example how to add auditnslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditnslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("auditnslogpolicy", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditnslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditnslogpolicy: Finished"
    }
}

function Invoke-ADCDeleteAuditnslogpolicy {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditnslogpolicy -Name <string>
        An example how to delete auditnslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogpolicy: Finished"
    }
}

function Invoke-ADCUpdateAuditnslogpolicy {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server. 
    .PARAMETER Action 
        Nslog server action that is performed when this policy matches. 
        NOTE: An nslog server action must be associated with an nslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditnslogpolicy -name <string>
        An example how to update auditnslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("auditnslogpolicy", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditnslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAuditnslogpolicy: Finished"
    }
}

function Invoke-ADCGetAuditnslogpolicy {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for ns log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicy -GetAll 
        Get all auditnslogpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicy -Count 
        Get the number of auditnslogpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicy -name <string>
        Get auditnslogpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicy -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditnslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicy: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyaaagroupbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaagroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaagroupbinding -GetAll 
        Get all auditnslogpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaagroupbinding -Count 
        Get the number of auditnslogpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaagroupbinding -name <string>
        Get auditnslogpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyaaagroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaagroupbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyaaauserbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaauserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaauserbinding -GetAll 
        Get all auditnslogpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaauserbinding -Count 
        Get the number of auditnslogpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaauserbinding -name <string>
        Get auditnslogpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyaaauserbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyaaauserbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaauserbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyappfwglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_appfwglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_appfwglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyappfwglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -GetAll 
        Get all auditnslogpolicy_appfwglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -Count 
        Get the number of auditnslogpolicy_appfwglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -name <string>
        Get auditnslogpolicy_appfwglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_appfwglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyappfwglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyappfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyappfwglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_auditnslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_auditnslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -GetAll 
        Get all auditnslogpolicy_auditnslogglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -Count 
        Get the number of auditnslogpolicy_auditnslogglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -name <string>
        Get auditnslogpolicy_auditnslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_auditnslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_auditnslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -GetAll 
        Get all auditnslogpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -Count 
        Get the number of auditnslogpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -name <string>
        Get auditnslogpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicybinding -GetAll 
        Get all auditnslogpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicybinding -name <string>
        Get auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicycsvserverbinding -GetAll 
        Get all auditnslogpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicycsvserverbinding -Count 
        Get the number of auditnslogpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicycsvserverbinding -name <string>
        Get auditnslogpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicycsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicylbvserverbinding -GetAll 
        Get all auditnslogpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicylbvserverbinding -Count 
        Get the number of auditnslogpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicylbvserverbinding -name <string>
        Get auditnslogpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicylbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicysystemglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the systemglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicysystemglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicysystemglobalbinding -GetAll 
        Get all auditnslogpolicy_systemglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicysystemglobalbinding -Count 
        Get the number of auditnslogpolicy_systemglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicysystemglobalbinding -name <string>
        Get auditnslogpolicy_systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicysystemglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicysystemglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicysystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicysystemglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicytmglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicytmglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicytmglobalbinding -GetAll 
        Get all auditnslogpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicytmglobalbinding -Count 
        Get the number of auditnslogpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicytmglobalbinding -name <string>
        Get auditnslogpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicytmglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicytmglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicytmglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyvpnglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnglobal that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_vpnglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -GetAll 
        Get all auditnslogpolicy_vpnglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -Count 
        Get the number of auditnslogpolicy_vpnglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -name <string>
        Get auditnslogpolicy_vpnglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_vpnglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyvpnglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditnslogpolicyvpnvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to auditnslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditnslogpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -GetAll 
        Get all auditnslogpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -Count 
        Get the number of auditnslogpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -name <string>
        Get auditnslogpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get auditnslogpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyvpnvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnvserverbinding: Ended"
    }
}

function Invoke-ADCUnsetAuditsyslogaction {
    <#
    .SYNOPSIS
        Unset Audit configuration Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAuditsyslogaction -name <string>
        An example how to unset auditsyslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAuditsyslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction
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

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$tcpprofilename,

        [Boolean]$maxlogdatasizetohold,

        [Boolean]$dns,

        [Boolean]$contentinspectionlog,

        [Boolean]$netprofile,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditsyslogaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAuditsyslogaction: Finished"
    }
}

function Invoke-ADCUpdateAuditsyslogaction {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName. 
    .PARAMETER Lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed. 
    .PARAMETER Domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditsyslogaction -name <string>
        An example how to update auditsyslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [ValidateLength(1, 127)]
        [string]$Lbvservername,

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry,

        [boolean]$Domainresolvenow,

        [int]$Serverport,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateRange(50, 25600)]
        [double]$Maxlogdatasizetohold,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('lbvservername') ) { $payload.Add('lbvservername', $lbvservername) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('domainresolvenow') ) { $payload.Add('domainresolvenow', $domainresolvenow) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogaction", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditsyslogaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAuditsyslogaction: Finished"
    }
}

function Invoke-ADCDeleteAuditsyslogaction {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditsyslogaction -Name <string>
        An example how to delete auditsyslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogaction: Finished"
    }
}

function Invoke-ADCAddAuditsyslogaction {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName. 
    .PARAMETER Domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed. 
    .PARAMETER Lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Audit log level, which specifies the types of events to log. 
        Available values function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY. -U.S. style month/date/year format. 
        * DDMMYYYY - European style date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Supported settings are: 
        * GMT_TIME. Coordinated Universal time. 
        * LOCAL_TIME. Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log lsn info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log alg info. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Transport 
        Transport type used to send auditlogs to syslog server. Default type is UDP. 
        Possible values = TCP, UDP 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
    .PARAMETER Maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info. 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile. 
        The SNIP configured in the network profile will be used as source IP while sending log messages. 
    .PARAMETER Sslinterception 
        Log SSL Interception event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditsyslogaction -name <string> -loglevel <string[]>
        An example how to add auditsyslogaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        [string]$Serverip,

        [ValidateLength(1, 255)]
        [string]$Serverdomainname,

        [ValidateRange(5, 20939)]
        [int]$Domainresolveretry = '5',

        [ValidateLength(1, 127)]
        [string]$Lbvservername,

        [int]$Serverport,

        [Parameter(Mandatory)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('TCP', 'UDP')]
        [string]$Transport,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateRange(50, 25600)]
        [double]$Maxlogdatasizetohold = '500',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                loglevel       = $loglevel
            }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverdomainname') ) { $payload.Add('serverdomainname', $serverdomainname) }
            if ( $PSBoundParameters.ContainsKey('domainresolveretry') ) { $payload.Add('domainresolveretry', $domainresolveretry) }
            if ( $PSBoundParameters.ContainsKey('lbvservername') ) { $payload.Add('lbvservername', $lbvservername) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('transport') ) { $payload.Add('transport', $transport) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('maxlogdatasizetohold') ) { $payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogaction", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditsyslogaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditsyslogaction: Finished"
    }
}

function Invoke-ADCGetAuditsyslogaction {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for system log action resource.
    .PARAMETER Name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogaction object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogaction -GetAll 
        Get all auditsyslogaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogaction -Count 
        Get the number of auditsyslogaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogaction -name <string>
        Get auditsyslogaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogaction -Filter @{ 'name'='<value>' }
        Get auditsyslogaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogaction: Ended"
    }
}

function Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER Policyname 
        Name of the audit syslog policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Globalbindtype 
        . 
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditsyslogglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding -policyname <string> -priority <double>
        An example how to add auditsyslogglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        [ValidateRange(1, 2147483647)]
        [double]$Priority,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL')]
        [string]$Globalbindtype = 'SYSTEM_GLOBAL',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('globalbindtype') ) { $payload.Add('globalbindtype', $globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER Policyname 
        Name of the audit syslog policy. 
    .PARAMETER Globalbindtype 
        . 
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding 
        An example how to delete auditsyslogglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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

        [string]$Globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Globalbindtype') ) { $arguments.Add('globalbindtype', $Globalbindtype) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to auditsyslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditsyslogglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -GetAll 
        Get all auditsyslogglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Count 
        Get the number of auditsyslogglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -name <string>
        Get auditsyslogglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get auditsyslogglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditsyslogglobal.
    .PARAMETER GetAll 
        Retrieve all auditsyslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogglobalbinding -GetAll 
        Get all auditsyslogglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalbinding -name <string>
        Get auditsyslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalbinding: Ended"
    }
}

function Invoke-ADCUnsetAuditsyslogparams {
    <#
    .SYNOPSIS
        Unset Audit configuration Object.
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY. European style -date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event ifnormation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interceptionn event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAuditsyslogparams 
        An example how to unset auditsyslogparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAuditsyslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams
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

        [Boolean]$serverip,

        [Boolean]$serverport,

        [Boolean]$loglevel,

        [Boolean]$dateformat,

        [Boolean]$logfacility,

        [Boolean]$tcp,

        [Boolean]$acl,

        [Boolean]$timezone,

        [Boolean]$userdefinedauditlog,

        [Boolean]$appflowexport,

        [Boolean]$lsn,

        [Boolean]$alg,

        [Boolean]$subscriberlog,

        [Boolean]$dns,

        [Boolean]$contentinspectionlog,

        [Boolean]$sslinterception,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditsyslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogparams", "Unset Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditsyslogparams -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAuditsyslogparams: Finished"
    }
}

function Invoke-ADCUpdateAuditsyslogparams {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER Serverip 
        IP address of the syslog server. 
    .PARAMETER Serverport 
        Port on which the syslog server accepts connections. 
    .PARAMETER Dateformat 
        Format of dates in the logs. 
        Supported formats are: 
        * MMDDYYYY - U.S. style month/date/year format. 
        * DDMMYYYY. European style -date/month/year format. 
        * YYYYMMDD - ISO style year/month/date format. 
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER Loglevel 
        Types of information to be logged. 
        Available settings function as follows: 
        * ALL - All events. 
        * EMERGENCY - Events that indicate an immediate crisis on the server. 
        * ALERT - Events that might require action. 
        * CRITICAL - Events that indicate an imminent server crisis. 
        * ERROR - Events that indicate some type of error. 
        * WARNING - Events that require action in the near future. 
        * NOTICE - Events that the administrator should know about. 
        * INFORMATIONAL - All but low-level events. 
        * DEBUG - All events, in extreme detail. 
        * NONE - No events. 
        Possible values = ALL, EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFORMATIONAL, DEBUG, NONE 
    .PARAMETER Logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message. 
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external. 
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER Tcp 
        Log TCP messages. 
        Possible values = NONE, ALL 
    .PARAMETER Acl 
        Log access control list (ACL) messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Timezone 
        Time zone used for date and timestamps in the logs. 
        Available settings function as follows: 
        * GMT_TIME - Coordinated Universal Time. 
        * LOCAL_TIME Use the server's timezone setting. 
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER Userdefinedauditlog 
        Log user-configurable log messages to syslog. 
        Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria. 
        Possible values = YES, NO 
    .PARAMETER Appflowexport 
        Export log messages to AppFlow collectors. 
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Lsn 
        Log the LSN messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Alg 
        Log the ALG messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscriberlog 
        Log subscriber session event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Dns 
        Log DNS related syslog messages. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sslinterception 
        Log SSL Interceptionn event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlfiltering 
        Log URL filtering event information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contentinspectionlog 
        Log Content Inspection event ifnormation. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditsyslogparams 
        An example how to update auditsyslogparams configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams/
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
        [string]$Serverip,

        [int]$Serverport,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$Dateformat,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$Loglevel,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$Logfacility,

        [ValidateSet('NONE', 'ALL')]
        [string]$Tcp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Acl,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$Timezone,

        [ValidateSet('YES', 'NO')]
        [string]$Userdefinedauditlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowexport,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Lsn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Alg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscriberlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Dns,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sslinterception,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlfiltering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogparams: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('dateformat') ) { $payload.Add('dateformat', $dateformat) }
            if ( $PSBoundParameters.ContainsKey('loglevel') ) { $payload.Add('loglevel', $loglevel) }
            if ( $PSBoundParameters.ContainsKey('logfacility') ) { $payload.Add('logfacility', $logfacility) }
            if ( $PSBoundParameters.ContainsKey('tcp') ) { $payload.Add('tcp', $tcp) }
            if ( $PSBoundParameters.ContainsKey('acl') ) { $payload.Add('acl', $acl) }
            if ( $PSBoundParameters.ContainsKey('timezone') ) { $payload.Add('timezone', $timezone) }
            if ( $PSBoundParameters.ContainsKey('userdefinedauditlog') ) { $payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ( $PSBoundParameters.ContainsKey('appflowexport') ) { $payload.Add('appflowexport', $appflowexport) }
            if ( $PSBoundParameters.ContainsKey('lsn') ) { $payload.Add('lsn', $lsn) }
            if ( $PSBoundParameters.ContainsKey('alg') ) { $payload.Add('alg', $alg) }
            if ( $PSBoundParameters.ContainsKey('subscriberlog') ) { $payload.Add('subscriberlog', $subscriberlog) }
            if ( $PSBoundParameters.ContainsKey('dns') ) { $payload.Add('dns', $dns) }
            if ( $PSBoundParameters.ContainsKey('sslinterception') ) { $payload.Add('sslinterception', $sslinterception) }
            if ( $PSBoundParameters.ContainsKey('urlfiltering') ) { $payload.Add('urlfiltering', $urlfiltering) }
            if ( $PSBoundParameters.ContainsKey('contentinspectionlog') ) { $payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogparams", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogparams -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAuditsyslogparams: Finished"
    }
}

function Invoke-ADCGetAuditsyslogparams {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for system log parameters resource.
    .PARAMETER GetAll 
        Retrieve all auditsyslogparams object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogparams object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogparams
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogparams -GetAll 
        Get all auditsyslogparams data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogparams -name <string>
        Get auditsyslogparams object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogparams -Filter @{ 'name'='<value>' }
        Get auditsyslogparams data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogparams
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogparams objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogparams: Ended"
    }
}

function Invoke-ADCUpdateAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Update Audit configuration Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server. 
    .PARAMETER Action 
        Syslog server action to perform when this policy matches traffic. 
        NOTE: A syslog server action must be associated with a syslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAuditsyslogpolicy -name <string>
        An example how to update auditsyslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSCmdlet.ShouldProcess("auditsyslogpolicy", "Update Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditsyslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAuditsyslogpolicy: Finished"
    }
}

function Invoke-ADCAddAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Add Audit configuration Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server. 
    .PARAMETER Action 
        Syslog server action to perform when this policy matches traffic. 
        NOTE: A syslog server action must be associated with a syslog audit policy. 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAuditsyslogpolicy -name <string> -rule <string> -action <string>
        An example how to add auditsyslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("auditsyslogpolicy", "Add Audit configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAuditsyslogpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAuditsyslogpolicy: Finished"
    }
}

function Invoke-ADCDeleteAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Delete Audit configuration Object.
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAuditsyslogpolicy -Name <string>
        An example how to delete auditsyslogpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogpolicy: Finished"
    }
}

function Invoke-ADCGetAuditsyslogpolicy {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Configuration for system log policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicy -GetAll 
        Get all auditsyslogpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicy -Count 
        Get the number of auditsyslogpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicy -name <string>
        Get auditsyslogpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicy -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all auditsyslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicy: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyaaagroupbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the aaagroup that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_aaagroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaagroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaagroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -GetAll 
        Get all auditsyslogpolicy_aaagroup_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -Count 
        Get the number of auditsyslogpolicy_aaagroup_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -name <string>
        Get auditsyslogpolicy_aaagroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_aaagroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyaaagroupbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaagroupbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyaaauserbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the aaauser that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_aaauser_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaauser_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaauserbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaauserbinding -GetAll 
        Get all auditsyslogpolicy_aaauser_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaauserbinding -Count 
        Get the number of auditsyslogpolicy_aaauser_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaauserbinding -name <string>
        Get auditsyslogpolicy_aaauser_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyaaauserbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_aaauser_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyaaauserbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaauserbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_auditsyslogglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_auditsyslogglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -GetAll 
        Get all auditsyslogpolicy_auditsyslogglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -Count 
        Get the number of auditsyslogpolicy_auditsyslogglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -name <string>
        Get auditsyslogpolicy_auditsyslogglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_auditsyslogglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the authenticationvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_authenticationvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_authenticationvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -GetAll 
        Get all auditsyslogpolicy_authenticationvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -Count 
        Get the number of auditsyslogpolicy_authenticationvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -name <string>
        Get auditsyslogpolicy_authenticationvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_authenticationvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicybinding -GetAll 
        Get all auditsyslogpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicybinding -name <string>
        Get auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicycsvserverbinding -GetAll 
        Get all auditsyslogpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicycsvserverbinding -Count 
        Get the number of auditsyslogpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicycsvserverbinding -name <string>
        Get auditsyslogpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicycsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicylbvserverbinding -GetAll 
        Get all auditsyslogpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicylbvserverbinding -Count 
        Get the number of auditsyslogpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicylbvserverbinding -name <string>
        Get auditsyslogpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicylbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the rnatglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_rnatglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_rnatglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -GetAll 
        Get all auditsyslogpolicy_rnatglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -Count 
        Get the number of auditsyslogpolicy_rnatglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -name <string>
        Get auditsyslogpolicy_rnatglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_rnatglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_rnatglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicysystemglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the systemglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_systemglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_systemglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicysystemglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -GetAll 
        Get all auditsyslogpolicy_systemglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -Count 
        Get the number of auditsyslogpolicy_systemglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -name <string>
        Get auditsyslogpolicy_systemglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_systemglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicysystemglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicysystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicysystemglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicytmglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the tmglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_tmglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_tmglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicytmglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicytmglobalbinding -GetAll 
        Get all auditsyslogpolicy_tmglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicytmglobalbinding -Count 
        Get the number of auditsyslogpolicy_tmglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicytmglobalbinding -name <string>
        Get auditsyslogpolicy_tmglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicytmglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_tmglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicytmglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicytmglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnglobal that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_vpnglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -GetAll 
        Get all auditsyslogpolicy_vpnglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -Count 
        Get the number of auditsyslogpolicy_vpnglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -name <string>
        Get auditsyslogpolicy_vpnglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_vpnglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding: Ended"
    }
}

function Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding {
    <#
    .SYNOPSIS
        Get Audit configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to auditsyslogpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all auditsyslogpolicy_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -GetAll 
        Get all auditsyslogpolicy_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -Count 
        Get the number of auditsyslogpolicy_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -name <string>
        Get auditsyslogpolicy_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
        Get auditsyslogpolicy_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding: Ended"
    }
}


