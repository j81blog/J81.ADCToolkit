function Invoke-ADCAddContentinspectionaction {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER type 
        Type of operation this action is going to perform. following actions are available to configure:  
        * ICAP - forward the incoming request or response to an ICAP server for modification.  
        * INLINEINSPECTION - forward the incoming or outgoing packets to IPS server for Intrusion Prevention.  
        * MIRROR - Forwards cloned packets for Intrusion Detection.  
        * NOINSPECTION - This does not forward incoming and outgoing packets to the Inspection device.  
        * NSTRACE - capture current and further incoming packets on this transaction.  
        Possible values = ICAP, INLINEINSPECTION, MIRROR, NOINSPECTION 
    .PARAMETER servername 
        Name of the LB vserver or service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER serverip 
        IP address of remoteService.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port of remoteService.  
        Default value: 1344  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER icapprofilename 
        Name of the ICAP profile to be attached to the contentInspection action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ifserverdown 
        Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are:  
        * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired.  
        * DROP - Drop the request without sending a response to the user.  
        * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server.  
        Default value: RESET  
        Possible values = CONTINUE, DROP, RESET 
    .PARAMETER PassThru 
        Return details about the created contentinspectionaction item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionaction -name <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        [ValidateSet('ICAP', 'INLINEINSPECTION', 'MIRROR', 'NOINSPECTION')]
        [string]$type ,

        [ValidateLength(1, 127)]
        [string]$servername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [ValidateRange(1, 65535)]
        [double]$serverport = '1344' ,

        [ValidateLength(1, 127)]
        [string]$icapprofilename ,

        [ValidateSet('CONTINUE', 'DROP', 'RESET')]
        [string]$ifserverdown = 'RESET' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('icapprofilename')) { $Payload.Add('icapprofilename', $icapprofilename) }
            if ($PSBoundParameters.ContainsKey('ifserverdown')) { $Payload.Add('ifserverdown', $ifserverdown) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionaction", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionaction: Finished"
    }
}

function Invoke-ADCUpdateContentinspectionaction {
<#
    .SYNOPSIS
        Update CI configuration Object
    .DESCRIPTION
        Update CI configuration Object 
    .PARAMETER name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER servername 
        Name of the LB vserver or service.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER serverip 
        IP address of remoteService.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port of remoteService.  
        Default value: 1344  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER icapprofilename 
        Name of the ICAP profile to be attached to the contentInspection action.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ifserverdown 
        Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are:  
        * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired.  
        * DROP - Drop the request without sending a response to the user.  
        * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server.  
        Default value: RESET  
        Possible values = CONTINUE, DROP, RESET 
    .PARAMETER PassThru 
        Return details about the created contentinspectionaction item.
    .EXAMPLE
        Invoke-ADCUpdateContentinspectionaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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

        [ValidateLength(1, 127)]
        [string]$servername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [ValidateRange(1, 65535)]
        [double]$serverport ,

        [ValidateLength(1, 127)]
        [string]$icapprofilename ,

        [ValidateSet('CONTINUE', 'DROP', 'RESET')]
        [string]$ifserverdown ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('icapprofilename')) { $Payload.Add('icapprofilename', $icapprofilename) }
            if ($PSBoundParameters.ContainsKey('ifserverdown')) { $Payload.Add('ifserverdown', $ifserverdown) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionaction", "Update CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionaction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateContentinspectionaction: Finished"
    }
}

function Invoke-ADCUnsetContentinspectionaction {
<#
    .SYNOPSIS
        Unset CI configuration Object
    .DESCRIPTION
        Unset CI configuration Object 
   .PARAMETER name 
       Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
   .PARAMETER serverport 
       Port of remoteService. 
   .PARAMETER ifserverdown 
       Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are:  
       * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired.  
       * DROP - Drop the request without sending a response to the user.  
       * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server.  
       Possible values = CONTINUE, DROP, RESET
    .EXAMPLE
        Invoke-ADCUnsetContentinspectionaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction
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

        [Boolean]$serverport ,

        [Boolean]$ifserverdown 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('ifserverdown')) { $Payload.Add('ifserverdown', $ifserverdown) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetContentinspectionaction: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionaction {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER name 
       Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionaction: Finished"
    }
}

function Invoke-ADCGetContentinspectionaction {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all contentinspectionaction object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionaction
    .EXAMPLE 
        Invoke-ADCGetContentinspectionaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionaction -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionaction -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        Write-Verbose "Invoke-ADCGetContentinspectionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionaction: Ended"
    }
}

function Invoke-ADCAddContentinspectioncallout {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout.  
        Minimum length = 1 
    .PARAMETER type 
        Type of the Content Inspection callout. It must be one of the following:  
        * ICAP - Sends ICAP request to the configured ICAP server.  
        Possible values = ICAP 
    .PARAMETER profilename 
        Name of the Content Inspection profile. The type of the configured profile must match the type specified using -type argument.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER servername 
        Name of the load balancing or content switching virtual server or service to which the Content Inspection request is issued. Mutually exclusive with server IP address and port parameters. The service type must be TCP or SSL_TCP. If there are vservers and services with the same name, then vserver is selected.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER serverip 
        IP address of Content Inspection server. Mutually exclusive with the server name parameter.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port of the Content Inspection server.  
        Default value: 1344  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER returntype 
        Type of data that the target callout agent returns in response to the callout.  
        Available settings function as follows:  
        * TEXT - Treat the returned value as a text string.  
        * NUM - Treat the returned value as a number.  
        * BOOL - Treat the returned value as a Boolean value.  
        Note: You cannot change the return type after it is set.  
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER resultexpr 
        Expression that extracts the callout results from the response sent by the CI callout agent. Must be a response based expression, that is, it must begin with ICAP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression, as in the following example: icap.res.header("ISTag").  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments to preserve information about this Content Inspection callout. 
    .PARAMETER PassThru 
        Return details about the created contentinspectioncallout item.
    .EXAMPLE
        Invoke-ADCAddContentinspectioncallout -name <string> -type <string> -returntype <string> -resultexpr <string>
    .NOTES
        File Name : Invoke-ADCAddContentinspectioncallout
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('ICAP')]
        [string]$type ,

        [ValidateLength(1, 127)]
        [string]$profilename ,

        [ValidateLength(1, 127)]
        [string]$servername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [ValidateRange(1, 65535)]
        [double]$serverport = '1344' ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$returntype ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resultexpr ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectioncallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
                returntype = $returntype
                resultexpr = $resultexpr
            }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Payload.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectioncallout", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectioncallout -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectioncallout -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectioncallout: Finished"
    }
}

function Invoke-ADCDeleteContentinspectioncallout {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER name 
       Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteContentinspectioncallout -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectioncallout
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectioncallout: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectioncallout -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectioncallout: Finished"
    }
}

function Invoke-ADCUpdateContentinspectioncallout {
<#
    .SYNOPSIS
        Update CI configuration Object
    .DESCRIPTION
        Update CI configuration Object 
    .PARAMETER name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout.  
        Minimum length = 1 
    .PARAMETER servername 
        Name of the load balancing or content switching virtual server or service to which the Content Inspection request is issued. Mutually exclusive with server IP address and port parameters. The service type must be TCP or SSL_TCP. If there are vservers and services with the same name, then vserver is selected.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER serverip 
        IP address of Content Inspection server. Mutually exclusive with the server name parameter.  
        Minimum length = 1 
    .PARAMETER serverport 
        Port of the Content Inspection server.  
        Default value: 1344  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER profilename 
        Name of the Content Inspection profile. The type of the configured profile must match the type specified using -type argument.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER returntype 
        Type of data that the target callout agent returns in response to the callout.  
        Available settings function as follows:  
        * TEXT - Treat the returned value as a text string.  
        * NUM - Treat the returned value as a number.  
        * BOOL - Treat the returned value as a Boolean value.  
        Note: You cannot change the return type after it is set.  
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER resultexpr 
        Expression that extracts the callout results from the response sent by the CI callout agent. Must be a response based expression, that is, it must begin with ICAP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression, as in the following example: icap.res.header("ISTag").  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments to preserve information about this Content Inspection callout. 
    .PARAMETER PassThru 
        Return details about the created contentinspectioncallout item.
    .EXAMPLE
        Invoke-ADCUpdateContentinspectioncallout -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectioncallout
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateLength(1, 127)]
        [string]$servername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [ValidateRange(1, 65535)]
        [double]$serverport ,

        [ValidateLength(1, 127)]
        [string]$profilename ,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$returntype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$resultexpr ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectioncallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Payload.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('returntype')) { $Payload.Add('returntype', $returntype) }
            if ($PSBoundParameters.ContainsKey('resultexpr')) { $Payload.Add('resultexpr', $resultexpr) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectioncallout", "Update CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectioncallout -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectioncallout -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateContentinspectioncallout: Finished"
    }
}

function Invoke-ADCUnsetContentinspectioncallout {
<#
    .SYNOPSIS
        Unset CI configuration Object
    .DESCRIPTION
        Unset CI configuration Object 
   .PARAMETER name 
       Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
   .PARAMETER serverport 
       Port of the Content Inspection server. 
   .PARAMETER comment 
       Any comments to preserve information about this Content Inspection callout.
    .EXAMPLE
        Invoke-ADCUnsetContentinspectioncallout -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectioncallout
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$serverport ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectioncallout: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('serverport')) { $Payload.Add('serverport', $serverport) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectioncallout -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetContentinspectioncallout: Finished"
    }
}

function Invoke-ADCGetContentinspectioncallout {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
    .PARAMETER GetAll 
        Retreive all contentinspectioncallout object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectioncallout object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectioncallout
    .EXAMPLE 
        Invoke-ADCGetContentinspectioncallout -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectioncallout -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectioncallout -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectioncallout -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectioncallout
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        Write-Verbose "Invoke-ADCGetContentinspectioncallout: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectioncallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectioncallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectioncallout objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectioncallout configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectioncallout configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectioncallout: Ended"
    }
}

function Invoke-ADCGetContentinspectionglobalbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER GetAll 
        Retreive all contentinspectionglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionglobalbinding: Ended"
    }
}

function Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER policyname 
        Name of the contentInspection policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        The bindpoint to which to policy is bound.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER invoke 
        Terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request of response. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionglobal_contentinspectionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("contentinspectionglobal_contentinspectionpolicy_binding", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionglobal_contentinspectionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
     .PARAMETER policyname 
       Name of the contentInspection policy.    .PARAMETER type 
       The bindpoint to which to policy is bound.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("contentinspectionglobal_contentinspectionpolicy_binding", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER GetAll 
        Retreive all contentinspectionglobal_contentinspectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionglobal_contentinspectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionglobal_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionglobal_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding: Ended"
    }
}

function Invoke-ADCUpdateContentinspectionparameter {
<#
    .SYNOPSIS
        Update CI configuration Object
    .DESCRIPTION
        Update CI configuration Object 
    .PARAMETER undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression.  
        Available settings function as follows:  
        * NOINSPECTION - Do not Inspect the traffic.  
        * RESET - Reset the connection and notify the user's browser, so that the user can resend the request.  
        * DROP - Drop the message without sending a response to the user.  
        Default value: "NOINSPECTION"
    .EXAMPLE
        Invoke-ADCUpdateContentinspectionparameter 
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter/
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

        [string]$undefaction 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionparameter", "Update CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionparameter -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateContentinspectionparameter: Finished"
    }
}

function Invoke-ADCUnsetContentinspectionparameter {
<#
    .SYNOPSIS
        Unset CI configuration Object
    .DESCRIPTION
        Unset CI configuration Object 
   .PARAMETER undefaction 
       Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression.  
       Available settings function as follows:  
       * NOINSPECTION - Do not Inspect the traffic.  
       * RESET - Reset the connection and notify the user's browser, so that the user can resend the request.  
       * DROP - Drop the message without sending a response to the user.
    .EXAMPLE
        Invoke-ADCUnsetContentinspectionparameter 
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter
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

        [Boolean]$undefaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSCmdlet.ShouldProcess("contentinspectionparameter", "Unset CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetContentinspectionparameter: Finished"
    }
}

function Invoke-ADCGetContentinspectionparameter {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER GetAll 
        Retreive all contentinspectionparameter object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionparameter
    .EXAMPLE 
        Invoke-ADCGetContentinspectionparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetContentinspectionparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter/
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
        Write-Verbose "Invoke-ADCGetContentinspectionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionparameter: Ended"
    }
}

function Invoke-ADCAddContentinspectionpolicy {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER name 
        Name for the contentInspection policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER rule 
        Expression that the policy uses to determine whether to execute the specified action. 
    .PARAMETER action 
        Name of the contentInspection action to perform if the request matches this contentInspection policy.  
        There are also some built-in actions which can be used. These are:  
        * NOINSPECTION - Send the request from the client to the server or response from the server to the client without sending it to Inspection device for Content Inspection.  
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired.  
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER comment 
        Any type of information about this contentInspection policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicy: Starting"
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
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicy", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionpolicy: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionpolicy {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER name 
       Name for the contentInspection policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicy: Finished"
    }
}

function Invoke-ADCUpdateContentinspectionpolicy {
<#
    .SYNOPSIS
        Update CI configuration Object
    .DESCRIPTION
        Update CI configuration Object 
    .PARAMETER name 
        Name for the contentInspection policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER rule 
        Expression that the policy uses to determine whether to execute the specified action. 
    .PARAMETER action 
        Name of the contentInspection action to perform if the request matches this contentInspection policy.  
        There are also some built-in actions which can be used. These are:  
        * NOINSPECTION - Send the request from the client to the server or response from the server to the client without sending it to Inspection device for Content Inspection.  
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired.  
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER comment 
        Any type of information about this contentInspection policy. 
    .PARAMETER logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateContentinspectionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionpolicy: Starting"
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
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicy", "Update CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateContentinspectionpolicy: Finished"
    }
}

function Invoke-ADCUnsetContentinspectionpolicy {
<#
    .SYNOPSIS
        Unset CI configuration Object
    .DESCRIPTION
        Unset CI configuration Object 
   .PARAMETER name 
       Name for the contentInspection policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
   .PARAMETER undefaction 
       Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
   .PARAMETER comment 
       Any type of information about this contentInspection policy. 
   .PARAMETER logaction 
       Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetContentinspectionpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy
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

        [Boolean]$comment ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetContentinspectionpolicy: Finished"
    }
}

function Invoke-ADCRenameContentinspectionpolicy {
<#
    .SYNOPSIS
        Rename CI configuration Object
    .DESCRIPTION
        Rename CI configuration Object 
    .PARAMETER name 
        Name for the contentInspection policy.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER newname 
        New name for the contentInspection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        Invoke-ADCRenameContentinspectionpolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicy", "Rename CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicy: Finished"
    }
}

function Invoke-ADCGetContentinspectionpolicy {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name for the contentInspection policy.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicy
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicy -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicy: Ended"
    }
}

function Invoke-ADCAddContentinspectionpolicylabel {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER type 
        Type of packets (request or response packets) against which to match the policies bound to this policy label.  
        Possible values = REQ, RES 
    .PARAMETER comment 
        Any comments to preserve information about this contentInspection policy label. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionpolicylabel -labelname <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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

        [Parameter(Mandatory = $true)]
        [ValidateSet('REQ', 'RES')]
        [string]$type ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicylabel", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionpolicylabel {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER labelname 
       Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabel: Finished"
    }
}

function Invoke-ADCRenameContentinspectionpolicylabel {
<#
    .SYNOPSIS
        Rename CI configuration Object
    .DESCRIPTION
        Rename CI configuration Object 
    .PARAMETER labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER newname 
        New name for the contentInspection policy label.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameContentinspectionpolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameContentinspectionpolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicylabel", "Rename CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicylabel: Finished"
    }
}

function Invoke-ADCGetContentinspectionpolicylabel {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER labelname 
       Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabel
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabel: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicylabelbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER labelname 
       Name of the contentInspection policy label. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER labelname 
        Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER policyname 
        Name of the contentInspection policy to bind to the policy label. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        Suspend evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request or response. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel_contentinspectionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("contentinspectionpolicylabel_contentinspectionpolicy_binding", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER labelname 
       Name of the contentInspection policy label to which to bind the policy.    .PARAMETER policyname 
       Name of the contentInspection policy to bind to the policy label.    .PARAMETER priority 
       Specifies the priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER labelname 
       Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicylabel_contentinspectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_contentinspectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER labelname 
       Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicylabel_policybinding_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_policybinding_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_policybinding_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicybinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy_contentinspectionglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_contentinspectionglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_contentinspectionglobal_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicy_contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy_contentinspectionpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_contentinspectionpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_contentinspectionpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicy_contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetContentinspectionpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retreive all contentinspectionpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all contentinspectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCAddContentinspectionprofile {
<#
    .SYNOPSIS
        Add CI configuration Object
    .DESCRIPTION
        Add CI configuration Object 
    .PARAMETER name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\).  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER type 
        Type of ContentInspection profile. Following types are available to configure:  
        INLINEINSPECTION : To inspect the packets/requests using IPS.  
        MIRROR : To forward cloned packets.  
        Possible values = InlineInspection, Mirror 
    .PARAMETER ingressinterface 
        Ingress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of IPS type. 
    .PARAMETER ingressvlan 
        Ingress Vlan for CI. 
    .PARAMETER egressinterface 
        Egress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of type INLINEINSPECTION or MIRROR. 
    .PARAMETER iptunnel 
        IP Tunnel for CI profile. It is used while creating a ContentInspection profile of type MIRROR when the IDS device is in a different network.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER egressvlan 
        Egress Vlan for CI. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionprofile item.
    .EXAMPLE
        Invoke-ADCAddContentinspectionprofile -name <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddContentinspectionprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        [ValidateSet('InlineInspection', 'Mirror')]
        [string]$type ,

        [string]$ingressinterface ,

        [double]$ingressvlan ,

        [string]$egressinterface ,

        [ValidateLength(1, 31)]
        [string]$iptunnel ,

        [double]$egressvlan ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('ingressinterface')) { $Payload.Add('ingressinterface', $ingressinterface) }
            if ($PSBoundParameters.ContainsKey('ingressvlan')) { $Payload.Add('ingressvlan', $ingressvlan) }
            if ($PSBoundParameters.ContainsKey('egressinterface')) { $Payload.Add('egressinterface', $egressinterface) }
            if ($PSBoundParameters.ContainsKey('iptunnel')) { $Payload.Add('iptunnel', $iptunnel) }
            if ($PSBoundParameters.ContainsKey('egressvlan')) { $Payload.Add('egressvlan', $egressvlan) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionprofile", "Add CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddContentinspectionprofile: Finished"
    }
}

function Invoke-ADCDeleteContentinspectionprofile {
<#
    .SYNOPSIS
        Delete CI configuration Object
    .DESCRIPTION
        Delete CI configuration Object
    .PARAMETER name 
       Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\).  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteContentinspectionprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionprofile: Finished"
    }
}

function Invoke-ADCUpdateContentinspectionprofile {
<#
    .SYNOPSIS
        Update CI configuration Object
    .DESCRIPTION
        Update CI configuration Object 
    .PARAMETER name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created.  
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\).  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER egressinterface 
        Egress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of type INLINEINSPECTION or MIRROR. 
    .PARAMETER ingressinterface 
        Ingress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of IPS type. 
    .PARAMETER egressvlan 
        Egress Vlan for CI. 
    .PARAMETER ingressvlan 
        Ingress Vlan for CI. 
    .PARAMETER iptunnel 
        IP Tunnel for CI profile. It is used while creating a ContentInspection profile of type MIRROR when the IDS device is in a different network.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created contentinspectionprofile item.
    .EXAMPLE
        Invoke-ADCUpdateContentinspectionprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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

        [string]$egressinterface ,

        [string]$ingressinterface ,

        [double]$egressvlan ,

        [double]$ingressvlan ,

        [ValidateLength(1, 31)]
        [string]$iptunnel ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('egressinterface')) { $Payload.Add('egressinterface', $egressinterface) }
            if ($PSBoundParameters.ContainsKey('ingressinterface')) { $Payload.Add('ingressinterface', $ingressinterface) }
            if ($PSBoundParameters.ContainsKey('egressvlan')) { $Payload.Add('egressvlan', $egressvlan) }
            if ($PSBoundParameters.ContainsKey('ingressvlan')) { $Payload.Add('ingressvlan', $ingressvlan) }
            if ($PSBoundParameters.ContainsKey('iptunnel')) { $Payload.Add('iptunnel', $iptunnel) }
 
            if ($PSCmdlet.ShouldProcess("contentinspectionprofile", "Update CI configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetContentinspectionprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateContentinspectionprofile: Finished"
    }
}

function Invoke-ADCUnsetContentinspectionprofile {
<#
    .SYNOPSIS
        Unset CI configuration Object
    .DESCRIPTION
        Unset CI configuration Object 
   .PARAMETER name 
       Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
   .PARAMETER egressvlan 
       Egress Vlan for CI. 
   .PARAMETER ingressvlan 
       Ingress Vlan for CI.
    .EXAMPLE
        Invoke-ADCUnsetContentinspectionprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile
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

        [Boolean]$egressvlan ,

        [Boolean]$ingressvlan 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('egressvlan')) { $Payload.Add('egressvlan', $egressvlan) }
            if ($PSBoundParameters.ContainsKey('ingressvlan')) { $Payload.Add('ingressvlan', $ingressvlan) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetContentinspectionprofile: Finished"
    }
}

function Invoke-ADCGetContentinspectionprofile {
<#
    .SYNOPSIS
        Get CI configuration object(s)
    .DESCRIPTION
        Get CI configuration object(s)
    .PARAMETER name 
       Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created.  
       CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
    .PARAMETER GetAll 
        Retreive all contentinspectionprofile object(s)
    .PARAMETER Count
        If specified, the count of the contentinspectionprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetContentinspectionprofile
    .EXAMPLE 
        Invoke-ADCGetContentinspectionprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetContentinspectionprofile -Count
    .EXAMPLE
        Invoke-ADCGetContentinspectionprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetContentinspectionprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetContentinspectionprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        Write-Verbose "Invoke-ADCGetContentinspectionprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all contentinspectionprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetContentinspectionprofile: Ended"
    }
}


