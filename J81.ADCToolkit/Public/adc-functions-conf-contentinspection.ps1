function Invoke-ADCAddContentinspectionaction {
    <#
    .SYNOPSIS
        Add CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection action resource.
    .PARAMETER Name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Type 
        Type of operation this action is going to perform. following actions are available to configure: 
        * ICAP - forward the incoming request or response to an ICAP server for modification. 
        * INLINEINSPECTION - forward the incoming or outgoing packets to IPS server for Intrusion Prevention. 
        * MIRROR - Forwards cloned packets for Intrusion Detection. 
        * NOINSPECTION - This does not forward incoming and outgoing packets to the Inspection device. 
        * NSTRACE - capture current and further incoming packets on this transaction. 
        Possible values = ICAP, INLINEINSPECTION, MIRROR, NOINSPECTION 
    .PARAMETER Servername 
        Name of the LB vserver or service. 
    .PARAMETER Serverip 
        IP address of remoteService. 
    .PARAMETER Serverport 
        Port of remoteService. 
    .PARAMETER Icapprofilename 
        Name of the ICAP profile to be attached to the contentInspection action. 
    .PARAMETER Ifserverdown 
        Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are: 
        * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
        * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server. 
        Possible values = CONTINUE, DROP, RESET 
    .PARAMETER PassThru 
        Return details about the created contentinspectionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionaction -name <string> -type <string>
        An example how to add contentinspectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('ICAP', 'INLINEINSPECTION', 'MIRROR', 'NOINSPECTION')]
        [string]$Type,

        [ValidateLength(1, 127)]
        [string]$Servername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [ValidateRange(1, 65535)]
        [double]$Serverport = '1344',

        [ValidateLength(1, 127)]
        [string]$Icapprofilename,

        [ValidateSet('CONTINUE', 'DROP', 'RESET')]
        [string]$Ifserverdown = 'RESET',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('icapprofilename') ) { $payload.Add('icapprofilename', $icapprofilename) }
            if ( $PSBoundParameters.ContainsKey('ifserverdown') ) { $payload.Add('ifserverdown', $ifserverdown) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionaction", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionaction -Filter $payload)
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
        Update CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection action resource.
    .PARAMETER Name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Servername 
        Name of the LB vserver or service. 
    .PARAMETER Serverip 
        IP address of remoteService. 
    .PARAMETER Serverport 
        Port of remoteService. 
    .PARAMETER Icapprofilename 
        Name of the ICAP profile to be attached to the contentInspection action. 
    .PARAMETER Ifserverdown 
        Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are: 
        * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
        * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server. 
        Possible values = CONTINUE, DROP, RESET 
    .PARAMETER PassThru 
        Return details about the created contentinspectionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateContentinspectionaction -name <string>
        An example how to update contentinspectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        [string]$Name,

        [ValidateLength(1, 127)]
        [string]$Servername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [ValidateRange(1, 65535)]
        [double]$Serverport,

        [ValidateLength(1, 127)]
        [string]$Icapprofilename,

        [ValidateSet('CONTINUE', 'DROP', 'RESET')]
        [string]$Ifserverdown,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('icapprofilename') ) { $payload.Add('icapprofilename', $icapprofilename) }
            if ( $PSBoundParameters.ContainsKey('ifserverdown') ) { $payload.Add('ifserverdown', $ifserverdown) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionaction", "Update CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionaction -Filter $payload)
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
        Unset CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection action resource.
    .PARAMETER Name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Serverport 
        Port of remoteService. 
    .PARAMETER Ifserverdown 
        Name of the action to perform if the Vserver representing the remote service is not UP. This is not supported for NOINSPECTION Type. The Supported actions are: 
        * RESET - Reset the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
        * CONTINUE - It bypasses the ContentIsnpection and Continues/resumes the Traffic-Flow to Client/Server. 
        Possible values = CONTINUE, DROP, RESET
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetContentinspectionaction -name <string>
        An example how to unset contentinspectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction
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
        [string]$Name,

        [Boolean]$serverport,

        [Boolean]$ifserverdown 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('ifserverdown') ) { $payload.Add('ifserverdown', $ifserverdown) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection action resource.
    .PARAMETER Name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionaction -Name <string>
        An example how to delete contentinspectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for Content Inspection action resource.
    .PARAMETER Name 
        Name of the remote service action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionaction object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionaction -GetAll 
        Get all contentinspectionaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionaction -Count 
        Get the number of contentinspectionaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionaction -name <string>
        Get contentinspectionaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionaction -Filter @{ 'name'='<value>' }
        Get contentinspectionaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionaction
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionaction/
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
        Write-Verbose "Invoke-ADCGetContentinspectionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection callout resource.
    .PARAMETER Name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
    .PARAMETER Type 
        Type of the Content Inspection callout. It must be one of the following: 
        * ICAP - Sends ICAP request to the configured ICAP server. 
        Possible values = ICAP 
    .PARAMETER Profilename 
        Name of the Content Inspection profile. The type of the configured profile must match the type specified using -type argument. 
    .PARAMETER Servername 
        Name of the load balancing or content switching virtual server or service to which the Content Inspection request is issued. Mutually exclusive with server IP address and port parameters. The service type must be TCP or SSL_TCP. If there are vservers and services with the same name, then vserver is selected. 
    .PARAMETER Serverip 
        IP address of Content Inspection server. Mutually exclusive with the server name parameter. 
    .PARAMETER Serverport 
        Port of the Content Inspection server. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the CI callout agent. Must be a response based expression, that is, it must begin with ICAP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression, as in the following example: icap.res.header("ISTag"). 
    .PARAMETER Comment 
        Any comments to preserve information about this Content Inspection callout. 
    .PARAMETER PassThru 
        Return details about the created contentinspectioncallout item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectioncallout -name <string> -type <string> -returntype <string> -resultexpr <string>
        An example how to add contentinspectioncallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectioncallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('ICAP')]
        [string]$Type,

        [ValidateLength(1, 127)]
        [string]$Profilename,

        [ValidateLength(1, 127)]
        [string]$Servername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [ValidateRange(1, 65535)]
        [double]$Serverport = '1344',

        [Parameter(Mandatory)]
        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectioncallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
                returntype     = $returntype
                resultexpr     = $resultexpr
            }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("contentinspectioncallout", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectioncallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectioncallout -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection callout resource.
    .PARAMETER Name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectioncallout -Name <string>
        An example how to delete contentinspectioncallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectioncallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectioncallout: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectioncallout -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection callout resource.
    .PARAMETER Name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
    .PARAMETER Servername 
        Name of the load balancing or content switching virtual server or service to which the Content Inspection request is issued. Mutually exclusive with server IP address and port parameters. The service type must be TCP or SSL_TCP. If there are vservers and services with the same name, then vserver is selected. 
    .PARAMETER Serverip 
        IP address of Content Inspection server. Mutually exclusive with the server name parameter. 
    .PARAMETER Serverport 
        Port of the Content Inspection server. 
    .PARAMETER Profilename 
        Name of the Content Inspection profile. The type of the configured profile must match the type specified using -type argument. 
    .PARAMETER Returntype 
        Type of data that the target callout agent returns in response to the callout. 
        Available settings function as follows: 
        * TEXT - Treat the returned value as a text string. 
        * NUM - Treat the returned value as a number. 
        * BOOL - Treat the returned value as a Boolean value. 
        Note: You cannot change the return type after it is set. 
        Possible values = BOOL, NUM, TEXT 
    .PARAMETER Resultexpr 
        Expression that extracts the callout results from the response sent by the CI callout agent. Must be a response based expression, that is, it must begin with ICAP.RES. The operations in this expression must match the return type. For example, if you configure a return type of TEXT, the result expression must be a text based expression, as in the following example: icap.res.header("ISTag"). 
    .PARAMETER Comment 
        Any comments to preserve information about this Content Inspection callout. 
    .PARAMETER PassThru 
        Return details about the created contentinspectioncallout item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateContentinspectioncallout -name <string>
        An example how to update contentinspectioncallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectioncallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [ValidateLength(1, 127)]
        [string]$Servername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [ValidateRange(1, 65535)]
        [double]$Serverport,

        [ValidateLength(1, 127)]
        [string]$Profilename,

        [ValidateSet('BOOL', 'NUM', 'TEXT')]
        [string]$Returntype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Resultexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectioncallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('returntype') ) { $payload.Add('returntype', $returntype) }
            if ( $PSBoundParameters.ContainsKey('resultexpr') ) { $payload.Add('resultexpr', $resultexpr) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("contentinspectioncallout", "Update CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectioncallout -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectioncallout -Filter $payload)
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
        Unset CI configuration Object.
    .DESCRIPTION
        Configuration for Content Inspection callout resource.
    .PARAMETER Name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
    .PARAMETER Serverport 
        Port of the Content Inspection server. 
    .PARAMETER Comment 
        Any comments to preserve information about this Content Inspection callout.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetContentinspectioncallout -name <string>
        An example how to unset contentinspectioncallout configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectioncallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$serverport,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectioncallout: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('serverport') ) { $payload.Add('serverport', $serverport) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectioncallout -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for Content Inspection callout resource.
    .PARAMETER Name 
        Name for the Content Inspection callout. Not case sensitive. Must begin with an ASCII letter or underscore (_) character, and must consist only of ASCII alphanumeric or underscore characters. Must not begin with 're' or 'xp' or be a word reserved for use as an expression qualifier prefix (such as HTTP) or enumeration value (such as ASCII). Must not be the name of an existing named expression, pattern set, dataset, stringmap, or callout. 
    .PARAMETER GetAll 
        Retrieve all contentinspectioncallout object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectioncallout object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectioncallout
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectioncallout -GetAll 
        Get all contentinspectioncallout data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectioncallout -Count 
        Get the number of contentinspectioncallout objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectioncallout -name <string>
        Get contentinspectioncallout object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectioncallout -Filter @{ 'name'='<value>' }
        Get contentinspectioncallout data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectioncallout
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectioncallout/
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
        Write-Verbose "Invoke-ADCGetContentinspectioncallout: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectioncallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectioncallout objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectioncallout objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectioncallout configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectioncallout configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectioncallout -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to contentinspectionglobal.
    .PARAMETER GetAll 
        Retrieve all contentinspectionglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionglobalbinding -GetAll 
        Get all contentinspectionglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalbinding -name <string>
        Get contentinspectionglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionglobal.
    .PARAMETER Policyname 
        Name of the contentInspection policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        The bindpoint to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        Terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request of response. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionglobal_contentinspectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding -policyname <string> -priority <double>
        An example how to add contentinspectionglobal_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionglobalcontentinspectionpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("contentinspectionglobal_contentinspectionpolicy_binding", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionglobal_contentinspectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionglobal.
    .PARAMETER Policyname 
        Name of the contentInspection policy. 
    .PARAMETER Type 
        The bindpoint to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding 
        An example how to delete contentinspectionglobal_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionglobalcontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionglobal_contentinspectionpolicy_binding", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionglobal.
    .PARAMETER GetAll 
        Retrieve all contentinspectionglobal_contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionglobal_contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -GetAll 
        Get all contentinspectionglobal_contentinspectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Count 
        Get the number of contentinspectionglobal_contentinspectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -name <string>
        Get contentinspectionglobal_contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
        Get contentinspectionglobal_contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionglobal_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionglobalcontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionglobal_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionglobal_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionglobal_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionglobal_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Update CI configuration Object.
    .DESCRIPTION
        Configuration for Contentinspection parameter resource.
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression. 
        Available settings function as follows: 
        * NOINSPECTION - Do not Inspect the traffic. 
        * RESET - Reset the connection and notify the user's browser, so that the user can resend the request. 
        * DROP - Drop the message without sending a response to the user.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateContentinspectionparameter 
        An example how to update contentinspectionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter/
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

        [string]$Undefaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionparameter", "Update CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionparameter -Payload $payload -GetWarning
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
        Unset CI configuration Object.
    .DESCRIPTION
        Configuration for Contentinspection parameter resource.
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an error condition in evaluating the expression. 
        Available settings function as follows: 
        * NOINSPECTION - Do not Inspect the traffic. 
        * RESET - Reset the connection and notify the user's browser, so that the user can resend the request. 
        * DROP - Drop the message without sending a response to the user.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetContentinspectionparameter 
        An example how to unset contentinspectionparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter
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

        [Boolean]$undefaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionparameter", "Unset CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for Contentinspection parameter resource.
    .PARAMETER GetAll 
        Retrieve all contentinspectionparameter object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionparameter -GetAll 
        Get all contentinspectionparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionparameter -name <string>
        Get contentinspectionparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionparameter -Filter @{ 'name'='<value>' }
        Get contentinspectionparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionparameter/
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
        Write-Verbose "Invoke-ADCGetContentinspectionparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving contentinspectionparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to execute the specified action. 
    .PARAMETER Action 
        Name of the contentInspection action to perform if the request matches this contentInspection policy. 
        There are also some built-in actions which can be used. These are: 
        * NOINSPECTION - Send the request from the client to the server or response from the server to the client without sending it to Inspection device for Content Inspection. 
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this contentInspection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionpolicy -name <string> -rule <string> -action <string>
        An example how to add contentinspectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicy", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionpolicy -Name <string>
        An example how to delete contentinspectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER Rule 
        Expression that the policy uses to determine whether to execute the specified action. 
    .PARAMETER Action 
        Name of the contentInspection action to perform if the request matches this contentInspection policy. 
        There are also some built-in actions which can be used. These are: 
        * NOINSPECTION - Send the request from the client to the server or response from the server to the client without sending it to Inspection device for Content Inspection. 
        * RESET - Resets the client connection by closing it. The client program, such as a browser, will handle this and may inform the user. The client may then resend the request if desired. 
        * DROP - Drop the request without sending a response to the user. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this contentInspection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateContentinspectionpolicy -name <string>
        An example how to update contentinspectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicy", "Update CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $payload)
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
        Unset CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this contentInspection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetContentinspectionpolicy -name <string>
        An example how to unset contentinspectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy
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

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER Newname 
        New name for the contentInspection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameContentinspectionpolicy -name <string> -newname <string>
        An example how to rename contentinspectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicy", "Rename CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicy -Filter $payload)
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for ContentInspection policy resource.
    .PARAMETER Name 
        Name for the contentInspection policy. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the contentInspection policy is added. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicy -GetAll 
        Get all contentinspectionpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicy -Count 
        Get the number of contentinspectionpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicy -name <string>
        Get contentinspectionpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicy -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicy
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy label resource.
    .PARAMETER Labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER Type 
        Type of packets (request or response packets) against which to match the policies bound to this policy label. 
        Possible values = REQ, RES 
    .PARAMETER Comment 
        Any comments to preserve information about this contentInspection policy label. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionpolicylabel -labelname <string> -type <string>
        An example how to add contentinspectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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

        [Parameter(Mandatory)]
        [ValidateSet('REQ', 'RES')]
        [string]$Type,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                type                = $type
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicylabel", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabel -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy label resource.
    .PARAMETER Labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionpolicylabel -Labelname <string>
        An example how to delete contentinspectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Rename CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection policy label resource.
    .PARAMETER Labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER Newname 
        New name for the contentInspection policy label. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameContentinspectionpolicylabel -labelname <string> -newname <string>
        An example how to rename contentinspectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameContentinspectionpolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameContentinspectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicylabel", "Rename CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabel -Filter $payload)
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for ContentInspection policy label resource.
    .PARAMETER Labelname 
        Name for the contentInspection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the contentInspection policy label is added. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabel -GetAll 
        Get all contentinspectionpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabel -Count 
        Get the number of contentinspectionpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabel -name <string>
        Get contentinspectionpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabel -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabel
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to contentinspectionpolicylabel.
    .PARAMETER Labelname 
        Name of the contentInspection policy label. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelbinding -GetAll 
        Get all contentinspectionpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelbinding -name <string>
        Get contentinspectionpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionpolicylabel.
    .PARAMETER Labelname 
        Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the contentInspection policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        Suspend evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation. Available settings function as follows: * reqvserver - Forward the request to the specified request virtual server. * resvserver - Forward the response to the specified response virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server to which to forward the request or response. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionpolicylabel_contentinspectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add contentinspectionpolicylabel_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionpolicylabelcontentinspectionpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("contentinspectionpolicylabel_contentinspectionpolicy_binding", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionpolicylabel.
    .PARAMETER Labelname 
        Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the contentInspection policy to bind to the policy label. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding -Labelname <string>
        An example how to delete contentinspectionpolicylabel_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionpolicylabelcontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to contentinspectionpolicylabel.
    .PARAMETER Labelname 
        Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicylabel_contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -GetAll 
        Get all contentinspectionpolicylabel_contentinspectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Count 
        Get the number of contentinspectionpolicylabel_contentinspectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -name <string>
        Get contentinspectionpolicylabel_contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicylabel_contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelcontentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_contentinspectionpolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to contentinspectionpolicylabel.
    .PARAMETER Labelname 
        Name of the contentInspection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -GetAll 
        Get all contentinspectionpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -Count 
        Get the number of contentinspectionpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -name <string>
        Get contentinspectionpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylabelpolicybindingbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicylabel_policybinding_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to contentinspectionpolicy.
    .PARAMETER Name 
        Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicybinding -GetAll 
        Get all contentinspectionpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicybinding -name <string>
        Get contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicybinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicybinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionglobal that can be bound to contentinspectionpolicy.
    .PARAMETER Name 
        Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy_contentinspectionglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_contentinspectionglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -GetAll 
        Get all contentinspectionpolicy_contentinspectionglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -Count 
        Get the number of contentinspectionpolicy_contentinspectionglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -name <string>
        Get contentinspectionpolicy_contentinspectionglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy_contentinspectionglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_contentinspectionglobal_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicy_contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_contentinspectionglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicylabel that can be bound to contentinspectionpolicy.
    .PARAMETER Name 
        Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy_contentinspectionpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_contentinspectionpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -GetAll 
        Get all contentinspectionpolicy_contentinspectionpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -Count 
        Get the number of contentinspectionpolicy_contentinspectionpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -name <string>
        Get contentinspectionpolicy_contentinspectionpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy_contentinspectionpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_contentinspectionpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycontentinspectionpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicy_contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_contentinspectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_contentinspectionpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_contentinspectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to contentinspectionpolicy.
    .PARAMETER Name 
        Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycsvserverbinding -GetAll 
        Get all contentinspectionpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicycsvserverbinding -Count 
        Get the number of contentinspectionpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycsvserverbinding -name <string>
        Get contentinspectionpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicycsvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to contentinspectionpolicy.
    .PARAMETER Name 
        Name of the contentInspection policy for which to display settings. 
    .PARAMETER GetAll 
        Retrieve all contentinspectionpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylbvserverbinding -GetAll 
        Get all contentinspectionpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionpolicylbvserverbinding -Count 
        Get the number of contentinspectionpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylbvserverbinding -name <string>
        Get contentinspectionpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get contentinspectionpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionpolicylbvserverbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetContentinspectionpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all contentinspectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection profile resource.
    .PARAMETER Name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
    .PARAMETER Type 
        Type of ContentInspection profile. Following types are available to configure: 
        INLINEINSPECTION : To inspect the packets/requests using IPS. 
        MIRROR : To forward cloned packets. 
        Possible values = InlineInspection, Mirror 
    .PARAMETER Ingressinterface 
        Ingress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of IPS type. 
    .PARAMETER Ingressvlan 
        Ingress Vlan for CI. 
    .PARAMETER Egressinterface 
        Egress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of type INLINEINSPECTION or MIRROR. 
    .PARAMETER Iptunnel 
        IP Tunnel for CI profile. It is used while creating a ContentInspection profile of type MIRROR when the IDS device is in a different network. 
    .PARAMETER Egressvlan 
        Egress Vlan for CI. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddContentinspectionprofile -name <string> -type <string>
        An example how to add contentinspectionprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddContentinspectionprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        [ValidateSet('InlineInspection', 'Mirror')]
        [string]$Type,

        [string]$Ingressinterface,

        [double]$Ingressvlan,

        [string]$Egressinterface,

        [ValidateLength(1, 31)]
        [string]$Iptunnel,

        [double]$Egressvlan,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddContentinspectionprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('ingressinterface') ) { $payload.Add('ingressinterface', $ingressinterface) }
            if ( $PSBoundParameters.ContainsKey('ingressvlan') ) { $payload.Add('ingressvlan', $ingressvlan) }
            if ( $PSBoundParameters.ContainsKey('egressinterface') ) { $payload.Add('egressinterface', $egressinterface) }
            if ( $PSBoundParameters.ContainsKey('iptunnel') ) { $payload.Add('iptunnel', $iptunnel) }
            if ( $PSBoundParameters.ContainsKey('egressvlan') ) { $payload.Add('egressvlan', $egressvlan) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionprofile", "Add CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type contentinspectionprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionprofile -Filter $payload)
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
        Delete CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection profile resource.
    .PARAMETER Name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\).
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteContentinspectionprofile -Name <string>
        An example how to delete contentinspectionprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteContentinspectionprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        Write-Verbose "Invoke-ADCDeleteContentinspectionprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type contentinspectionprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection profile resource.
    .PARAMETER Name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
    .PARAMETER Egressinterface 
        Egress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of type INLINEINSPECTION or MIRROR. 
    .PARAMETER Ingressinterface 
        Ingress interface for CI profile.It is a mandatory argument while creating an ContentInspection profile of IPS type. 
    .PARAMETER Egressvlan 
        Egress Vlan for CI. 
    .PARAMETER Ingressvlan 
        Ingress Vlan for CI. 
    .PARAMETER Iptunnel 
        IP Tunnel for CI profile. It is used while creating a ContentInspection profile of type MIRROR when the IDS device is in a different network. 
    .PARAMETER PassThru 
        Return details about the created contentinspectionprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateContentinspectionprofile -name <string>
        An example how to update contentinspectionprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateContentinspectionprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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

        [string]$Egressinterface,

        [string]$Ingressinterface,

        [double]$Egressvlan,

        [double]$Ingressvlan,

        [ValidateLength(1, 31)]
        [string]$Iptunnel,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateContentinspectionprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('egressinterface') ) { $payload.Add('egressinterface', $egressinterface) }
            if ( $PSBoundParameters.ContainsKey('ingressinterface') ) { $payload.Add('ingressinterface', $ingressinterface) }
            if ( $PSBoundParameters.ContainsKey('egressvlan') ) { $payload.Add('egressvlan', $egressvlan) }
            if ( $PSBoundParameters.ContainsKey('ingressvlan') ) { $payload.Add('ingressvlan', $ingressvlan) }
            if ( $PSBoundParameters.ContainsKey('iptunnel') ) { $payload.Add('iptunnel', $iptunnel) }
            if ( $PSCmdlet.ShouldProcess("contentinspectionprofile", "Update CI configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type contentinspectionprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetContentinspectionprofile -Filter $payload)
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
        Unset CI configuration Object.
    .DESCRIPTION
        Configuration for ContentInspection profile resource.
    .PARAMETER Name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
    .PARAMETER Egressvlan 
        Egress Vlan for CI. 
    .PARAMETER Ingressvlan 
        Ingress Vlan for CI.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetContentinspectionprofile -name <string>
        An example how to unset contentinspectionprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetContentinspectionprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile
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

        [Boolean]$egressvlan,

        [Boolean]$ingressvlan 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetContentinspectionprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('egressvlan') ) { $payload.Add('egressvlan', $egressvlan) }
            if ( $PSBoundParameters.ContainsKey('ingressvlan') ) { $payload.Add('ingressvlan', $ingressvlan) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset CI configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type contentinspectionprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get CI configuration object(s).
    .DESCRIPTION
        Configuration for ContentInspection profile resource.
    .PARAMETER Name 
        Name of a ContentInspection profile. Must begin with a letter, number, or the underscore \(_\) character. Other characters allowed, after the first character, are the hyphen \(-\), period \(.\), hash \(\#\), space \( \), at \(@\), colon \(:\), and equal \(=\) characters. The name of a IPS profile cannot be changed after it is created. 
        CLI Users: If the name includes one or more spaces, enclose the name in double or single quotation marks \(for example, "my ips profile" or 'my ips profile'\). 
    .PARAMETER GetAll 
        Retrieve all contentinspectionprofile object(s).
    .PARAMETER Count
        If specified, the count of the contentinspectionprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionprofile -GetAll 
        Get all contentinspectionprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetContentinspectionprofile -Count 
        Get the number of contentinspectionprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionprofile -name <string>
        Get contentinspectionprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetContentinspectionprofile -Filter @{ 'name'='<value>' }
        Get contentinspectionprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetContentinspectionprofile
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/contentinspection/contentinspectionprofile/
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
        Write-Verbose "Invoke-ADCGetContentinspectionprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all contentinspectionprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for contentinspectionprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving contentinspectionprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving contentinspectionprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving contentinspectionprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type contentinspectionprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


