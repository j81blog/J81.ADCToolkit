function Invoke-ADCAddAuditmessageaction {
<#
    .SYNOPSIS
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER loglevel 
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
    .PARAMETER stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER logtonewnslog 
        Send the message to the new nslog.  
        Possible values = YES, NO 
    .PARAMETER bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        Invoke-ADCAddAuditmessageaction -name <string> -loglevel <string> -stringbuilderexpr <string>
    .NOTES
        File Name : Invoke-ADCAddAuditmessageaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$loglevel ,

        [Parameter(Mandatory = $true)]
        [string]$stringbuilderexpr ,

        [ValidateSet('YES', 'NO')]
        [string]$logtonewnslog ,

        [ValidateSet('YES', 'NO')]
        [string]$bypasssafetycheck = 'NO' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditmessageaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                loglevel = $loglevel
                stringbuilderexpr = $stringbuilderexpr
            }
            if ($PSBoundParameters.ContainsKey('logtonewnslog')) { $Payload.Add('logtonewnslog', $logtonewnslog) }
            if ($PSBoundParameters.ContainsKey('bypasssafetycheck')) { $Payload.Add('bypasssafetycheck', $bypasssafetycheck) }
 
            if ($PSCmdlet.ShouldProcess("auditmessageaction", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditmessageaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditmessageaction -Filter $Payload)
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

function Invoke-ADCDeleteAuditmessageaction {
<#
    .SYNOPSIS
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
    .PARAMETER name 
       Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .EXAMPLE
        Invoke-ADCDeleteAuditmessageaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAuditmessageaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditmessageaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER name 
        Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER loglevel 
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
    .PARAMETER stringbuilderexpr 
        Default-syntax expression that defines the format and content of the log message. 
    .PARAMETER logtonewnslog 
        Send the message to the new nslog.  
        Possible values = YES, NO 
    .PARAMETER bypasssafetycheck 
        Bypass the safety check and allow unsafe expressions.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER PassThru 
        Return details about the created auditmessageaction item.
    .EXAMPLE
        Invoke-ADCUpdateAuditmessageaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAuditmessageaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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

        [ValidateSet('EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string]$loglevel ,

        [string]$stringbuilderexpr ,

        [ValidateSet('YES', 'NO')]
        [string]$logtonewnslog ,

        [ValidateSet('YES', 'NO')]
        [string]$bypasssafetycheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditmessageaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('stringbuilderexpr')) { $Payload.Add('stringbuilderexpr', $stringbuilderexpr) }
            if ($PSBoundParameters.ContainsKey('logtonewnslog')) { $Payload.Add('logtonewnslog', $logtonewnslog) }
            if ($PSBoundParameters.ContainsKey('bypasssafetycheck')) { $Payload.Add('bypasssafetycheck', $bypasssafetycheck) }
 
            if ($PSCmdlet.ShouldProcess("auditmessageaction", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditmessageaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditmessageaction -Filter $Payload)
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
        Unset Audit configuration Object
    .DESCRIPTION
        Unset Audit configuration Object 
   .PARAMETER name 
       Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
   .PARAMETER logtonewnslog 
       Send the message to the new nslog.  
       Possible values = YES, NO 
   .PARAMETER bypasssafetycheck 
       Bypass the safety check and allow unsafe expressions.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetAuditmessageaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAuditmessageaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction
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

        [Boolean]$logtonewnslog ,

        [Boolean]$bypasssafetycheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditmessageaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('logtonewnslog')) { $Payload.Add('logtonewnslog', $logtonewnslog) }
            if ($PSBoundParameters.ContainsKey('bypasssafetycheck')) { $Payload.Add('bypasssafetycheck', $bypasssafetycheck) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditmessageaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAuditmessageaction {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the audit message action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the message action is added. 
    .PARAMETER GetAll 
        Retreive all auditmessageaction object(s)
    .PARAMETER Count
        If specified, the count of the auditmessageaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditmessageaction
    .EXAMPLE 
        Invoke-ADCGetAuditmessageaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditmessageaction -Count
    .EXAMPLE
        Invoke-ADCGetAuditmessageaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditmessageaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditmessageaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessageaction/
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
        Write-Verbose "Invoke-ADCGetAuditmessageaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditmessageaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessageaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessageaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessageaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditmessageaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessageaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER loglevel 
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
    .PARAMETER numofmesgs 
       Number of log messages to be displayed. 
    .PARAMETER GetAll 
        Retreive all auditmessages object(s)
    .PARAMETER Count
        If specified, the count of the auditmessages object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditmessages
    .EXAMPLE 
        Invoke-ADCGetAuditmessages -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditmessages -Count
    .EXAMPLE
        Invoke-ADCGetAuditmessages -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditmessages -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditmessages
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditmessages/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG')]
        [string[]]$loglevel ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(1, 256)]
        [double]$numofmesgs,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditmessages objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditmessages objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditmessages objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('loglevel')) { $Arguments.Add('loglevel', $loglevel) } 
                if ($PSBoundParameters.ContainsKey('numofmesgs')) { $Arguments.Add('numofmesgs', $numofmesgs) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditmessages configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditmessages configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditmessages -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddAuditnslogaction {
<#
    .SYNOPSIS
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER serverip 
        IP address of the nslog server.  
        Minimum length = 1 
    .PARAMETER serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER serverport 
        Port on which the nslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER loglevel 
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
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY - U.S. style month/date/year format.  
        * DDMMYYYY - European style date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Available settings function as follows:  
        * GMT_TIME. Coordinated Universal Time.  
        * LOCAL_TIME. The server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to nslog.  
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log the LSN messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log the ALG messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Log SSL Interception event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        Invoke-ADCAddAuditnslogaction -name <string> -loglevel <string[]>
    .NOTES
        File Name : Invoke-ADCAddAuditnslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        [string]$serverip ,

        [ValidateLength(1, 255)]
        [string]$serverdomainname ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry = '5' ,

        [int]$serverport ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                loglevel = $loglevel
            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverdomainname')) { $Payload.Add('serverdomainname', $serverdomainname) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
 
            if ($PSCmdlet.ShouldProcess("auditnslogaction", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditnslogaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditnslogaction -Filter $Payload)
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

function Invoke-ADCDeleteAuditnslogaction {
<#
    .SYNOPSIS
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
    .PARAMETER name 
       Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .EXAMPLE
        Invoke-ADCDeleteAuditnslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER name 
        Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER serverip 
        IP address of the nslog server.  
        Minimum length = 1 
    .PARAMETER serverdomainname 
        Auditserver name as a FQDN. Mutually exclusive with serverIP.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the audit server if the last query failed.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER serverport 
        Port on which the nslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER loglevel 
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
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY - U.S. style month/date/year format.  
        * DDMMYYYY - European style date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Available settings function as follows:  
        * GMT_TIME. Coordinated Universal Time.  
        * LOCAL_TIME. The server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to nslog.  
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log the LSN messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log the ALG messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Log SSL Interception event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditnslogaction item.
    .EXAMPLE
        Invoke-ADCUpdateAuditnslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        [string]$serverip ,

        [ValidateLength(1, 255)]
        [string]$serverdomainname ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry ,

        [boolean]$domainresolvenow ,

        [int]$serverport ,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverdomainname')) { $Payload.Add('serverdomainname', $serverdomainname) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('domainresolvenow')) { $Payload.Add('domainresolvenow', $domainresolvenow) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
 
            if ($PSCmdlet.ShouldProcess("auditnslogaction", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditnslogaction -Filter $Payload)
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

function Invoke-ADCUnsetAuditnslogaction {
<#
    .SYNOPSIS
        Unset Audit configuration Object
    .DESCRIPTION
        Unset Audit configuration Object 
   .PARAMETER name 
       Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
   .PARAMETER serverport 
       Port on which the nslog server accepts connections. 
   .PARAMETER loglevel 
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
   .PARAMETER dateformat 
       Format of dates in the logs.  
       Supported formats are:  
       * MMDDYYYY - U.S. style month/date/year format.  
       * DDMMYYYY - European style date/month/year format.  
       * YYYYMMDD - ISO style year/month/date format.  
       Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
   .PARAMETER logfacility 
       Facility value, as defined in RFC 3164, assigned to the log message.  
       Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
       Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
   .PARAMETER tcp 
       Log TCP messages.  
       Possible values = NONE, ALL 
   .PARAMETER acl 
       Log access control list (ACL) messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER timezone 
       Time zone used for date and timestamps in the logs.  
       Available settings function as follows:  
       * GMT_TIME. Coordinated Universal Time.  
       * LOCAL_TIME. The server's timezone setting.  
       Possible values = GMT_TIME, LOCAL_TIME 
   .PARAMETER userdefinedauditlog 
       Log user-configurable log messages to nslog.  
       Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
       Possible values = YES, NO 
   .PARAMETER appflowexport 
       Export log messages to AppFlow collectors.  
       Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER lsn 
       Log the LSN messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER alg 
       Log the ALG messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberlog 
       Log subscriber session event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslinterception 
       Log SSL Interception event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER contentinspectionlog 
       Log Content Inspection event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlfiltering 
       Log URL filtering event information.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAuditnslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAuditnslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction
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

        [Boolean]$serverport ,

        [Boolean]$loglevel ,

        [Boolean]$dateformat ,

        [Boolean]$logfacility ,

        [Boolean]$tcp ,

        [Boolean]$acl ,

        [Boolean]$timezone ,

        [Boolean]$userdefinedauditlog ,

        [Boolean]$appflowexport ,

        [Boolean]$lsn ,

        [Boolean]$alg ,

        [Boolean]$subscriberlog ,

        [Boolean]$sslinterception ,

        [Boolean]$contentinspectionlog ,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditnslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditnslogaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAuditnslogaction {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the nslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog action is added. 
    .PARAMETER GetAll 
        Retreive all auditnslogaction object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogaction
    .EXAMPLE 
        Invoke-ADCGetAuditnslogaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogaction -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogaction/
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
        Write-Verbose "Invoke-ADCGetAuditnslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditnslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER policyname 
        Name of the audit nslog policy. 
    .PARAMETER priority 
        Specifies the priority of the policy.  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER globalbindtype 
        .  
        Default value: SYSTEM_GLOBAL  
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditnslogglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        [ValidateRange(1, 2147483647)]
        [double]$priority ,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL')]
        [string]$globalbindtype = 'SYSTEM_GLOBAL' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('globalbindtype')) { $Payload.Add('globalbindtype', $globalbindtype) }
 
            if ($PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogglobal_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Filter $Payload)
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
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
     .PARAMETER policyname 
       Name of the audit nslog policy.    .PARAMETER globalbindtype 
       .  
       Default value: SYSTEM_GLOBAL  
       Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL
    .EXAMPLE
        Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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

        [string]$globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAuditnslogglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('globalbindtype')) { $Arguments.Add('globalbindtype', $globalbindtype) }
            if ($PSCmdlet.ShouldProcess("auditnslogglobal_auditnslogpolicy_binding", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditnslogglobal_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditnslogglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCUpdateAuditnslogparams {
<#
    .SYNOPSIS
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER serverip 
        IP address of the nslog server.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port on which the nslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY - U.S. style month/date/year format.  
        * DDMMYYYY - European style date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER loglevel 
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
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Configure auditing to log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Configure auditing to log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Supported settings are:  
        * GMT_TIME - Coordinated Universal Time.  
        * LOCAL_TIME - Use the server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to nslog.  
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log the LSN messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log the ALG messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Log SSL Interception event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event information.  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateAuditnslogparams 
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [int]$serverport ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
 
            if ($PSCmdlet.ShouldProcess("auditnslogparams", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogparams -Payload $Payload -GetWarning
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

function Invoke-ADCUnsetAuditnslogparams {
<#
    .SYNOPSIS
        Unset Audit configuration Object
    .DESCRIPTION
        Unset Audit configuration Object 
   .PARAMETER serverip 
       IP address of the nslog server. 
   .PARAMETER serverport 
       Port on which the nslog server accepts connections. 
   .PARAMETER loglevel 
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
   .PARAMETER dateformat 
       Format of dates in the logs.  
       Supported formats are:  
       * MMDDYYYY - U.S. style month/date/year format.  
       * DDMMYYYY - European style date/month/year format.  
       * YYYYMMDD - ISO style year/month/date format.  
       Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
   .PARAMETER logfacility 
       Facility value, as defined in RFC 3164, assigned to the log message.  
       Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
       Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
   .PARAMETER tcp 
       Configure auditing to log TCP messages.  
       Possible values = NONE, ALL 
   .PARAMETER acl 
       Configure auditing to log access control list (ACL) messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER timezone 
       Time zone used for date and timestamps in the logs.  
       Supported settings are:  
       * GMT_TIME - Coordinated Universal Time.  
       * LOCAL_TIME - Use the server's timezone setting.  
       Possible values = GMT_TIME, LOCAL_TIME 
   .PARAMETER userdefinedauditlog 
       Log user-configurable log messages to nslog.  
       Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
       Possible values = YES, NO 
   .PARAMETER appflowexport 
       Export log messages to AppFlow collectors.  
       Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER lsn 
       Log the LSN messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER alg 
       Log the ALG messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberlog 
       Log subscriber session event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslinterception 
       Log SSL Interception event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlfiltering 
       Log URL filtering event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER contentinspectionlog 
       Log Content Inspection event information.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAuditnslogparams 
    .NOTES
        File Name : Invoke-ADCUnsetAuditnslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams
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

        [Boolean]$serverip ,

        [Boolean]$serverport ,

        [Boolean]$loglevel ,

        [Boolean]$dateformat ,

        [Boolean]$logfacility ,

        [Boolean]$tcp ,

        [Boolean]$acl ,

        [Boolean]$timezone ,

        [Boolean]$userdefinedauditlog ,

        [Boolean]$appflowexport ,

        [Boolean]$lsn ,

        [Boolean]$alg ,

        [Boolean]$subscriberlog ,

        [Boolean]$sslinterception ,

        [Boolean]$urlfiltering ,

        [Boolean]$contentinspectionlog 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditnslogparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSCmdlet.ShouldProcess("auditnslogparams", "Unset Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditnslogparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAuditnslogparams {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditnslogparams object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogparams
    .EXAMPLE 
        Invoke-ADCGetAuditnslogparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditnslogparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogparams/
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
        Write-Verbose "Invoke-ADCGetAuditnslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditnslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditnslogparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server.  
        Minimum length = 1 
    .PARAMETER action 
        Nslog server action that is performed when this policy matches.  
        NOTE: An nslog server action must be associated with an nslog audit policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        Invoke-ADCAddAuditnslogpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddAuditnslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditnslogpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("auditnslogpolicy", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditnslogpolicy -Filter $Payload)
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
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .EXAMPLE
        Invoke-ADCDeleteAuditnslogpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAuditnslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAuditnslogpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the nslog server.  
        Minimum length = 1 
    .PARAMETER action 
        Nslog server action that is performed when this policy matches.  
        NOTE: An nslog server action must be associated with an nslog audit policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created auditnslogpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAuditnslogpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAuditnslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditnslogpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("auditnslogpolicy", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditnslogpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditnslogpolicy -Filter $Payload)
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the nslog policy is added. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicy
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicy -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditnslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_aaagroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaagroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaagroupbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyaaagroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyaaagroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaagroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyaaagroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_aaauser_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_aaauser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaauserbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyaaauserbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyaaauserbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaauserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyaaauserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyaaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_appfwglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_appfwglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyappfwglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyappfwglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyappfwglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyappfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_auditnslogglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_auditnslogglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_auditnslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauditnslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_auditnslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_auditnslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_auditnslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_authenticationvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_authenticationvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_systemglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_systemglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicysystemglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicysystemglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicysystemglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicysystemglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicysystemglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicysystemglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicysystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_tmglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_tmglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicytmglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicytmglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicytmglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicytmglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicytmglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicytmglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_vpnglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyvpnglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditnslogpolicy_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditnslogpolicy_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditnslogpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditnslogpolicyvpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditnslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditnslogpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditnslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditnslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditnslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddAuditsyslogaction {
<#
    .SYNOPSIS
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER serverip 
        IP address of the syslog server.  
        Minimum length = 1 
    .PARAMETER serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER serverport 
        Port on which the syslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER loglevel 
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
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY. -U.S. style month/date/year format.  
        * DDMMYYYY - European style date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Supported settings are:  
        * GMT_TIME. Coordinated Universal time.  
        * LOCAL_TIME. Use the server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to syslog.  
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log lsn info.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log alg info.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER transport 
        Transport type used to send auditlogs to syslog server. Default type is UDP.  
        Possible values = TCP, UDP 
    .PARAMETER tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info.  
        Default value: 500  
        Minimum value = 50  
        Maximum value = 25600 
    .PARAMETER dns 
        Log DNS related syslog messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Name of the network profile.  
        The SNIP configured in the network profile will be used as source IP while sending log messages.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sslinterception 
        Log SSL Interception event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        Invoke-ADCAddAuditsyslogaction -name <string> -loglevel <string[]>
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        [string]$serverip ,

        [ValidateLength(1, 255)]
        [string]$serverdomainname ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry = '5' ,

        [ValidateLength(1, 127)]
        [string]$lbvservername ,

        [int]$serverport ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateSet('TCP', 'UDP')]
        [string]$transport ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateRange(50, 25600)]
        [double]$maxlogdatasizetohold = '500' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dns ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                loglevel = $loglevel
            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverdomainname')) { $Payload.Add('serverdomainname', $serverdomainname) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('lbvservername')) { $Payload.Add('lbvservername', $lbvservername) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('transport')) { $Payload.Add('transport', $transport) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('maxlogdatasizetohold')) { $Payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ($PSBoundParameters.ContainsKey('dns')) { $Payload.Add('dns', $dns) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
 
            if ($PSCmdlet.ShouldProcess("auditsyslogaction", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditsyslogaction -Filter $Payload)
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

function Invoke-ADCDeleteAuditsyslogaction {
<#
    .SYNOPSIS
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
    .PARAMETER name 
       Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .EXAMPLE
        Invoke-ADCDeleteAuditsyslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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

function Invoke-ADCUpdateAuditsyslogaction {
<#
    .SYNOPSIS
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER name 
        Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER serverip 
        IP address of the syslog server.  
        Minimum length = 1 
    .PARAMETER serverdomainname 
        SYSLOG server name as a FQDN. Mutually exclusive with serverIP/lbVserverName.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER lbvservername 
        Name of the LB vserver. Mutually exclusive with syslog serverIP/serverName.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER domainresolveretry 
        Time, in seconds, for which the Citrix ADC waits before sending another DNS query to resolve the host name of the syslog server if the last query failed.  
        Default value: 5  
        Minimum value = 5  
        Maximum value = 20939 
    .PARAMETER domainresolvenow 
        Immediately send a DNS query to resolve the server's domain name. 
    .PARAMETER serverport 
        Port on which the syslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER loglevel 
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
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY. -U.S. style month/date/year format.  
        * DDMMYYYY - European style date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Supported settings are:  
        * GMT_TIME. Coordinated Universal time.  
        * LOCAL_TIME. Use the server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to syslog.  
        Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log lsn info.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log alg info.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpprofilename 
        Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER maxlogdatasizetohold 
        Max size of log data that can be held in NSB chain of server info.  
        Default value: 500  
        Minimum value = 50  
        Maximum value = 25600 
    .PARAMETER dns 
        Log DNS related syslog messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Name of the network profile.  
        The SNIP configured in the network profile will be used as source IP while sending log messages.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER sslinterception 
        Log SSL Interception event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created auditsyslogaction item.
    .EXAMPLE
        Invoke-ADCUpdateAuditsyslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        [string]$serverip ,

        [ValidateLength(1, 255)]
        [string]$serverdomainname ,

        [ValidateLength(1, 127)]
        [string]$lbvservername ,

        [ValidateRange(5, 20939)]
        [int]$domainresolveretry ,

        [boolean]$domainresolvenow ,

        [int]$serverport ,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateRange(50, 25600)]
        [double]$maxlogdatasizetohold ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dns ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverdomainname')) { $Payload.Add('serverdomainname', $serverdomainname) }
            if ($PSBoundParameters.ContainsKey('lbvservername')) { $Payload.Add('lbvservername', $lbvservername) }
            if ($PSBoundParameters.ContainsKey('domainresolveretry')) { $Payload.Add('domainresolveretry', $domainresolveretry) }
            if ($PSBoundParameters.ContainsKey('domainresolvenow')) { $Payload.Add('domainresolvenow', $domainresolvenow) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('maxlogdatasizetohold')) { $Payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ($PSBoundParameters.ContainsKey('dns')) { $Payload.Add('dns', $dns) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
 
            if ($PSCmdlet.ShouldProcess("auditsyslogaction", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditsyslogaction -Filter $Payload)
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

function Invoke-ADCUnsetAuditsyslogaction {
<#
    .SYNOPSIS
        Unset Audit configuration Object
    .DESCRIPTION
        Unset Audit configuration Object 
   .PARAMETER name 
       Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
   .PARAMETER serverport 
       Port on which the syslog server accepts connections. 
   .PARAMETER loglevel 
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
   .PARAMETER dateformat 
       Format of dates in the logs.  
       Supported formats are:  
       * MMDDYYYY. -U.S. style month/date/year format.  
       * DDMMYYYY - European style date/month/year format.  
       * YYYYMMDD - ISO style year/month/date format.  
       Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
   .PARAMETER logfacility 
       Facility value, as defined in RFC 3164, assigned to the log message.  
       Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
       Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
   .PARAMETER tcp 
       Log TCP messages.  
       Possible values = NONE, ALL 
   .PARAMETER acl 
       Log access control list (ACL) messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER timezone 
       Time zone used for date and timestamps in the logs.  
       Supported settings are:  
       * GMT_TIME. Coordinated Universal time.  
       * LOCAL_TIME. Use the server's timezone setting.  
       Possible values = GMT_TIME, LOCAL_TIME 
   .PARAMETER userdefinedauditlog 
       Log user-configurable log messages to syslog.  
       Setting this parameter to NO causes auditing to ignore all user-configured message actions. Setting this parameter to YES causes auditing to log user-configured message actions that meet the other logging criteria.  
       Possible values = YES, NO 
   .PARAMETER appflowexport 
       Export log messages to AppFlow collectors.  
       Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER lsn 
       Log lsn info.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER alg 
       Log alg info.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberlog 
       Log subscriber session event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tcpprofilename 
       Name of the TCP profile whose settings are to be applied to the audit server info to tune the TCP connection parameters. 
   .PARAMETER maxlogdatasizetohold 
       Max size of log data that can be held in NSB chain of server info. 
   .PARAMETER dns 
       Log DNS related syslog messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER contentinspectionlog 
       Log Content Inspection event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       Name of the network profile.  
       The SNIP configured in the network profile will be used as source IP while sending log messages. 
   .PARAMETER sslinterception 
       Log SSL Interception event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlfiltering 
       Log URL filtering event information.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAuditsyslogaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAuditsyslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction
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

        [Boolean]$serverport ,

        [Boolean]$loglevel ,

        [Boolean]$dateformat ,

        [Boolean]$logfacility ,

        [Boolean]$tcp ,

        [Boolean]$acl ,

        [Boolean]$timezone ,

        [Boolean]$userdefinedauditlog ,

        [Boolean]$appflowexport ,

        [Boolean]$lsn ,

        [Boolean]$alg ,

        [Boolean]$subscriberlog ,

        [Boolean]$tcpprofilename ,

        [Boolean]$maxlogdatasizetohold ,

        [Boolean]$dns ,

        [Boolean]$contentinspectionlog ,

        [Boolean]$netprofile ,

        [Boolean]$sslinterception ,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditsyslogaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('maxlogdatasizetohold')) { $Payload.Add('maxlogdatasizetohold', $maxlogdatasizetohold) }
            if ($PSBoundParameters.ContainsKey('dns')) { $Payload.Add('dns', $dns) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditsyslogaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAuditsyslogaction {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the syslog action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog action is added. 
    .PARAMETER GetAll 
        Retreive all auditsyslogaction object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogaction
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogaction -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogaction/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditsyslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER policyname 
        Name of the audit syslog policy. 
    .PARAMETER priority 
        Specifies the priority of the policy.  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER globalbindtype 
        .  
        Default value: SYSTEM_GLOBAL  
        Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL 
    .PARAMETER PassThru 
        Return details about the created auditsyslogglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        [ValidateRange(1, 2147483647)]
        [double]$priority ,

        [ValidateSet('SYSTEM_GLOBAL', 'VPN_GLOBAL', 'RNAT_GLOBAL')]
        [string]$globalbindtype = 'SYSTEM_GLOBAL' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('globalbindtype')) { $Payload.Add('globalbindtype', $globalbindtype) }
 
            if ($PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogglobal_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Filter $Payload)
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
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
     .PARAMETER policyname 
       Name of the audit syslog policy.    .PARAMETER globalbindtype 
       .  
       Default value: SYSTEM_GLOBAL  
       Possible values = SYSTEM_GLOBAL, VPN_GLOBAL, RNAT_GLOBAL
    .EXAMPLE
        Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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

        [string]$globalbindtype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAuditsyslogglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('globalbindtype')) { $Arguments.Add('globalbindtype', $globalbindtype) }
            if ($PSCmdlet.ShouldProcess("auditsyslogglobal_auditsyslogpolicy_binding", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditsyslogglobal_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditsyslogglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCUpdateAuditsyslogparams {
<#
    .SYNOPSIS
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER serverip 
        IP address of the syslog server.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port on which the syslog server accepts connections.  
        Minimum value = 1 
    .PARAMETER dateformat 
        Format of dates in the logs.  
        Supported formats are:  
        * MMDDYYYY - U.S. style month/date/year format.  
        * DDMMYYYY. European style -date/month/year format.  
        * YYYYMMDD - ISO style year/month/date format.  
        Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
    .PARAMETER loglevel 
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
    .PARAMETER logfacility 
        Facility value, as defined in RFC 3164, assigned to the log message.  
        Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
        Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
    .PARAMETER tcp 
        Log TCP messages.  
        Possible values = NONE, ALL 
    .PARAMETER acl 
        Log access control list (ACL) messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER timezone 
        Time zone used for date and timestamps in the logs.  
        Available settings function as follows:  
        * GMT_TIME - Coordinated Universal Time.  
        * LOCAL_TIME Use the server's timezone setting.  
        Possible values = GMT_TIME, LOCAL_TIME 
    .PARAMETER userdefinedauditlog 
        Log user-configurable log messages to syslog.  
        Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria.  
        Possible values = YES, NO 
    .PARAMETER appflowexport 
        Export log messages to AppFlow collectors.  
        Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER lsn 
        Log the LSN messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER alg 
        Log the ALG messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscriberlog 
        Log subscriber session event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER dns 
        Log DNS related syslog messages.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sslinterception 
        Log SSL Interceptionn event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlfiltering 
        Log URL filtering event information.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contentinspectionlog 
        Log Content Inspection event ifnormation.  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateAuditsyslogparams 
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [int]$serverport ,

        [ValidateSet('MMDDYYYY', 'DDMMYYYY', 'YYYYMMDD')]
        [string]$dateformat ,

        [ValidateSet('ALL', 'EMERGENCY', 'ALERT', 'CRITICAL', 'ERROR', 'WARNING', 'NOTICE', 'INFORMATIONAL', 'DEBUG', 'NONE')]
        [string[]]$loglevel ,

        [ValidateSet('LOCAL0', 'LOCAL1', 'LOCAL2', 'LOCAL3', 'LOCAL4', 'LOCAL5', 'LOCAL6', 'LOCAL7')]
        [string]$logfacility ,

        [ValidateSet('NONE', 'ALL')]
        [string]$tcp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$acl ,

        [ValidateSet('GMT_TIME', 'LOCAL_TIME')]
        [string]$timezone ,

        [ValidateSet('YES', 'NO')]
        [string]$userdefinedauditlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowexport ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$lsn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$alg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscriberlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$dns ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sslinterception ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlfiltering ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$contentinspectionlog 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('dns')) { $Payload.Add('dns', $dns) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
 
            if ($PSCmdlet.ShouldProcess("auditsyslogparams", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogparams -Payload $Payload -GetWarning
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

function Invoke-ADCUnsetAuditsyslogparams {
<#
    .SYNOPSIS
        Unset Audit configuration Object
    .DESCRIPTION
        Unset Audit configuration Object 
   .PARAMETER serverip 
       IP address of the syslog server. 
   .PARAMETER serverport 
       Port on which the syslog server accepts connections. 
   .PARAMETER loglevel 
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
   .PARAMETER dateformat 
       Format of dates in the logs.  
       Supported formats are:  
       * MMDDYYYY - U.S. style month/date/year format.  
       * DDMMYYYY. European style -date/month/year format.  
       * YYYYMMDD - ISO style year/month/date format.  
       Possible values = MMDDYYYY, DDMMYYYY, YYYYMMDD 
   .PARAMETER logfacility 
       Facility value, as defined in RFC 3164, assigned to the log message.  
       Log facility values are numbers 0 to 7 (LOCAL0 through LOCAL7). Each number indicates where a specific message originated from, such as the Citrix ADC itself, the VPN, or external.  
       Possible values = LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7 
   .PARAMETER tcp 
       Log TCP messages.  
       Possible values = NONE, ALL 
   .PARAMETER acl 
       Log access control list (ACL) messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER timezone 
       Time zone used for date and timestamps in the logs.  
       Available settings function as follows:  
       * GMT_TIME - Coordinated Universal Time.  
       * LOCAL_TIME Use the server's timezone setting.  
       Possible values = GMT_TIME, LOCAL_TIME 
   .PARAMETER userdefinedauditlog 
       Log user-configurable log messages to syslog.  
       Setting this parameter to NO causes audit to ignore all user-configured message actions. Setting this parameter to YES causes audit to log user-configured message actions that meet the other logging criteria.  
       Possible values = YES, NO 
   .PARAMETER appflowexport 
       Export log messages to AppFlow collectors.  
       Appflow collectors are entities to which log messages can be sent so that some action can be performed on them.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER lsn 
       Log the LSN messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER alg 
       Log the ALG messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscriberlog 
       Log subscriber session event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER dns 
       Log DNS related syslog messages.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER contentinspectionlog 
       Log Content Inspection event ifnormation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sslinterception 
       Log SSL Interceptionn event information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlfiltering 
       Log URL filtering event information.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAuditsyslogparams 
    .NOTES
        File Name : Invoke-ADCUnsetAuditsyslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams
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

        [Boolean]$serverip ,

        [Boolean]$serverport ,

        [Boolean]$loglevel ,

        [Boolean]$dateformat ,

        [Boolean]$logfacility ,

        [Boolean]$tcp ,

        [Boolean]$acl ,

        [Boolean]$timezone ,

        [Boolean]$userdefinedauditlog ,

        [Boolean]$appflowexport ,

        [Boolean]$lsn ,

        [Boolean]$alg ,

        [Boolean]$subscriberlog ,

        [Boolean]$dns ,

        [Boolean]$contentinspectionlog ,

        [Boolean]$sslinterception ,

        [Boolean]$urlfiltering 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAuditsyslogparams: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('loglevel')) { $Payload.Add('loglevel', $loglevel) }
            if ($PSBoundParameters.ContainsKey('dateformat')) { $Payload.Add('dateformat', $dateformat) }
            if ($PSBoundParameters.ContainsKey('logfacility')) { $Payload.Add('logfacility', $logfacility) }
            if ($PSBoundParameters.ContainsKey('tcp')) { $Payload.Add('tcp', $tcp) }
            if ($PSBoundParameters.ContainsKey('acl')) { $Payload.Add('acl', $acl) }
            if ($PSBoundParameters.ContainsKey('timezone')) { $Payload.Add('timezone', $timezone) }
            if ($PSBoundParameters.ContainsKey('userdefinedauditlog')) { $Payload.Add('userdefinedauditlog', $userdefinedauditlog) }
            if ($PSBoundParameters.ContainsKey('appflowexport')) { $Payload.Add('appflowexport', $appflowexport) }
            if ($PSBoundParameters.ContainsKey('lsn')) { $Payload.Add('lsn', $lsn) }
            if ($PSBoundParameters.ContainsKey('alg')) { $Payload.Add('alg', $alg) }
            if ($PSBoundParameters.ContainsKey('subscriberlog')) { $Payload.Add('subscriberlog', $subscriberlog) }
            if ($PSBoundParameters.ContainsKey('dns')) { $Payload.Add('dns', $dns) }
            if ($PSBoundParameters.ContainsKey('contentinspectionlog')) { $Payload.Add('contentinspectionlog', $contentinspectionlog) }
            if ($PSBoundParameters.ContainsKey('sslinterception')) { $Payload.Add('sslinterception', $sslinterception) }
            if ($PSBoundParameters.ContainsKey('urlfiltering')) { $Payload.Add('urlfiltering', $urlfiltering) }
            if ($PSCmdlet.ShouldProcess("auditsyslogparams", "Unset Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type auditsyslogparams -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCGetAuditsyslogparams {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER GetAll 
        Retreive all auditsyslogparams object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogparams object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogparams
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogparams -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditsyslogparams -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogparams -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogparams
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogparams/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogparams: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditsyslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogparams objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogparams objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogparams configuration for property ''"

            } else {
                Write-Verbose "Retrieving auditsyslogparams configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogparams -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddAuditsyslogpolicy {
<#
    .SYNOPSIS
        Add Audit configuration Object
    .DESCRIPTION
        Add Audit configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server.  
        Minimum length = 1 
    .PARAMETER action 
        Syslog server action to perform when this policy matches traffic.  
        NOTE: A syslog server action must be associated with a syslog audit policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        Invoke-ADCAddAuditsyslogpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddAuditsyslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("auditsyslogpolicy", "Add Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditsyslogpolicy -Filter $Payload)
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
        Delete Audit configuration Object
    .DESCRIPTION
        Delete Audit configuration Object
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .EXAMPLE
        Invoke-ADCDeleteAuditsyslogpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAuditsyslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Audit configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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

function Invoke-ADCUpdateAuditsyslogpolicy {
<#
    .SYNOPSIS
        Update Audit configuration Object
    .DESCRIPTION
        Update Audit configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or an expression, that defines the messages to be logged to the syslog server.  
        Minimum length = 1 
    .PARAMETER action 
        Syslog server action to perform when this policy matches traffic.  
        NOTE: A syslog server action must be associated with a syslog audit policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created auditsyslogpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAuditsyslogpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAuditsyslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAuditsyslogpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
 
            if ($PSCmdlet.ShouldProcess("auditsyslogpolicy", "Update Audit configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type auditsyslogpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAuditsyslogpolicy -Filter $Payload)
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

function Invoke-ADCGetAuditsyslogpolicy {
<#
    .SYNOPSIS
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character (_), and must consist only of letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at sign (@), equals (=), colon (:), and underscore characters. Cannot be changed after the syslog policy is added. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicy
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicy -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all auditsyslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_aaagroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaagroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaagroupbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaagroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyaaagroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_aaagroup_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaagroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaagroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaagroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaagroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_aaauser_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_aaauser_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaauserbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyaaauserbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyaaauserbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaauserbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyaaauserbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyaaauserbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_aaauser_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyaaauserbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_aaauser_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_aaauser_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_aaauser_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_auditsyslogglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_auditsyslogglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_auditsyslogglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauditsyslogglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_auditsyslogglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_auditsyslogglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_auditsyslogglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_authenticationvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_authenticationvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_authenticationvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyauthenticationvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_authenticationvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_authenticationvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_authenticationvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_rnatglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_rnatglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_rnatglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyrnatglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_rnatglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_rnatglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_rnatglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_systemglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_systemglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicysystemglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicysystemglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicysystemglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_systemglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicysystemglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_systemglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_systemglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_systemglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_tmglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_tmglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicytmglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicytmglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicytmglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicytmglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicytmglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicytmglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_tmglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicytmglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_tmglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_tmglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_tmglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_vpnglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_vpnglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Audit configuration object(s)
    .DESCRIPTION
        Get Audit configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all auditsyslogpolicy_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the auditsyslogpolicy_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/audit/auditsyslogpolicy_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAuditsyslogpolicyvpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for auditsyslogpolicy_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving auditsyslogpolicy_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type auditsyslogpolicy_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


