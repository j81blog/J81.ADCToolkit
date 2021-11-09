function Invoke-ADCExportAppfwarchive {
<#
    .SYNOPSIS
        Export Application Firewall configuration Object
    .DESCRIPTION
        Export Application Firewall configuration Object 
    .PARAMETER name 
        Name of tar archive. 
    .PARAMETER target 
        Path to the file to be exported.
    .EXAMPLE
        Invoke-ADCExportAppfwarchive -name <string> -target <string>
    .NOTES
        File Name : Invoke-ADCExportAppfwarchive
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwarchive: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                target = $target
            }

            if ($PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwarchive -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportAppfwarchive: Finished"
    }
}

function Invoke-ADCImportAppfwarchive {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        Indicates the source of the tar archive file as a URL  
        of the form  
        <protocol>://<host>[:<port>][/<path>]  
        <protocol> is http or https.  
        <host> is the DNS name or IP address of the http or https server.  
        <port> is the port number of the server. If omitted, the  
        default port for http or https will be used.  
        <path> is the path of the file on the server.  
        Import will fail if an https server requires client  
        certificate authentication.  
        . 
    .PARAMETER name 
        Name of tar archive. 
    .PARAMETER comment 
        Comments associated with this archive.
    .EXAMPLE
        Invoke-ADCImportAppfwarchive -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwarchive
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwarchive: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwarchive -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwarchive: Finished"
    }
}

function Invoke-ADCDeleteAppfwarchive {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of tar archive.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwarchive -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwarchive
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        Write-Verbose "Invoke-ADCDeleteAppfwarchive: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwarchive -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwarchive: Finished"
    }
}

function Invoke-ADCGetAppfwarchive {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwarchive object(s)
    .PARAMETER Count
        If specified, the count of the appfwarchive object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwarchive
    .EXAMPLE 
        Invoke-ADCGetAppfwarchive -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwarchive -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwarchive -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwarchive
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        Write-Verbose "Invoke-ADCGetAppfwarchive: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwarchive objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwarchive objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwarchive objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwarchive configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwarchive configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwarchive: Ended"
    }
}

function Invoke-ADCAddAppfwconfidfield {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER fieldname 
        Name of the form field to designate as confidential.  
        Minimum length = 1 
    .PARAMETER url 
        URL of the web page that contains the web form.  
        Minimum length = 1 
    .PARAMETER isregex 
        Method of specifying the form field name. Available settings function as follows:  
        * REGEX. Form field is a regular expression.  
        * NOTREGEX. Form field is a literal string.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments to preserve information about the form field designation. 
    .PARAMETER state 
        Enable or disable the confidential field designation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCAddAppfwconfidfield -fieldname <string> -url <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwconfidfield
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$fieldname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex = 'NOTREGEX' ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwconfidfield: Starting"
    }
    process {
        try {
            $Payload = @{
                fieldname = $fieldname
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
 
            if ($PSCmdlet.ShouldProcess("appfwconfidfield", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwconfidfield -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
            Write-Output $result

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddAppfwconfidfield: Finished"
    }
}

function Invoke-ADCDeleteAppfwconfidfield {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER fieldname 
       Name of the form field to designate as confidential.  
       Minimum length = 1    .PARAMETER url 
       URL of the web page that contains the web form.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteAppfwconfidfield -fieldname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwconfidfield
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$fieldname ,

        [string]$url 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwconfidfield: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Arguments.Add('url', $url) }
            if ($PSCmdlet.ShouldProcess("$fieldname", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwconfidfield -NitroPath nitro/v1/config -Resource $fieldname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwconfidfield: Finished"
    }
}

function Invoke-ADCUpdateAppfwconfidfield {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER fieldname 
        Name of the form field to designate as confidential.  
        Minimum length = 1 
    .PARAMETER url 
        URL of the web page that contains the web form.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments to preserve information about the form field designation. 
    .PARAMETER isregex 
        Method of specifying the form field name. Available settings function as follows:  
        * REGEX. Form field is a regular expression.  
        * NOTREGEX. Form field is a literal string.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER state 
        Enable or disable the confidential field designation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateAppfwconfidfield -fieldname <string> -url <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppfwconfidfield
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$fieldname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [string]$comment ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwconfidfield: Starting"
    }
    process {
        try {
            $Payload = @{
                fieldname = $fieldname
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
 
            if ($PSCmdlet.ShouldProcess("appfwconfidfield", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwconfidfield -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAppfwconfidfield: Finished"
    }
}

function Invoke-ADCUnsetAppfwconfidfield {
<#
    .SYNOPSIS
        Unset Application Firewall configuration Object
    .DESCRIPTION
        Unset Application Firewall configuration Object 
   .PARAMETER fieldname 
       Name of the form field to designate as confidential. 
   .PARAMETER url 
       URL of the web page that contains the web form. 
   .PARAMETER comment 
       Any comments to preserve information about the form field designation. 
   .PARAMETER isregex 
       Method of specifying the form field name. Available settings function as follows:  
       * REGEX. Form field is a regular expression.  
       * NOTREGEX. Form field is a literal string.  
       Possible values = REGEX, NOTREGEX 
   .PARAMETER state 
       Enable or disable the confidential field designation.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAppfwconfidfield -fieldname <string> -url <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppfwconfidfield
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield
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
        [string]$fieldname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [Boolean]$comment ,

        [Boolean]$isregex ,

        [Boolean]$state 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwconfidfield: Starting"
    }
    process {
        try {
            $Payload = @{
                fieldname = $fieldname
                url = $url
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSCmdlet.ShouldProcess("$fieldname url", "Unset Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwconfidfield -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppfwconfidfield: Finished"
    }
}

function Invoke-ADCGetAppfwconfidfield {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwconfidfield object(s)
    .PARAMETER Count
        If specified, the count of the appfwconfidfield object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwconfidfield
    .EXAMPLE 
        Invoke-ADCGetAppfwconfidfield -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwconfidfield -Count
    .EXAMPLE
        Invoke-ADCGetAppfwconfidfield -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwconfidfield -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwconfidfield
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        Write-Verbose "Invoke-ADCGetAppfwconfidfield: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwconfidfield objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwconfidfield objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwconfidfield objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwconfidfield configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwconfidfield configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwconfidfield: Ended"
    }
}

function Invoke-ADCExportAppfwcustomsettings {
<#
    .SYNOPSIS
        Export Application Firewall configuration Object
    .DESCRIPTION
        Export Application Firewall configuration Object 
    .PARAMETER name 
        . 
    .PARAMETER target 
        .
    .EXAMPLE
        Invoke-ADCExportAppfwcustomsettings -name <string> -target <string>
    .NOTES
        File Name : Invoke-ADCExportAppfwcustomsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwcustomsettings/
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
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 2047)]
        [string]$target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwcustomsettings: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                target = $target
            }

            if ($PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwcustomsettings -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportAppfwcustomsettings: Finished"
    }
}

function Invoke-ADCAddAppfwfieldtype {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name for the field type.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER regex 
        PCRE - format regular expression defining the characters and length allowed for this field type.  
        Minimum length = 1 
    .PARAMETER priority 
        Positive integer specifying the priority of the field type. A lower number specifies a higher priority. Field types are checked in the order of their priority numbers.  
        Minimum value = 0  
        Maximum value = 64000 
    .PARAMETER comment 
        Comment describing the type of field that this field type is intended to match. 
    .PARAMETER PassThru 
        Return details about the created appfwfieldtype item.
    .EXAMPLE
        Invoke-ADCAddAppfwfieldtype -name <string> -regex <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppfwfieldtype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        [string]$regex ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 64000)]
        [double]$priority ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwfieldtype: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                regex = $regex
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("appfwfieldtype", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwfieldtype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwfieldtype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwfieldtype: Finished"
    }
}

function Invoke-ADCDeleteAppfwfieldtype {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name for the field type.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .EXAMPLE
        Invoke-ADCDeleteAppfwfieldtype -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwfieldtype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        Write-Verbose "Invoke-ADCDeleteAppfwfieldtype: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwfieldtype -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwfieldtype: Finished"
    }
}

function Invoke-ADCUpdateAppfwfieldtype {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER name 
        Name for the field type.  
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER regex 
        PCRE - format regular expression defining the characters and length allowed for this field type.  
        Minimum length = 1 
    .PARAMETER priority 
        Positive integer specifying the priority of the field type. A lower number specifies a higher priority. Field types are checked in the order of their priority numbers.  
        Minimum value = 0  
        Maximum value = 64000 
    .PARAMETER comment 
        Comment describing the type of field that this field type is intended to match. 
    .PARAMETER PassThru 
        Return details about the created appfwfieldtype item.
    .EXAMPLE
        Invoke-ADCUpdateAppfwfieldtype -name <string> -regex <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCUpdateAppfwfieldtype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        [string]$regex ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 64000)]
        [double]$priority ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwfieldtype: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                regex = $regex
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("appfwfieldtype", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwfieldtype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwfieldtype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppfwfieldtype: Finished"
    }
}

function Invoke-ADCGetAppfwfieldtype {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name for the field type.  
       Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER GetAll 
        Retreive all appfwfieldtype object(s)
    .PARAMETER Count
        If specified, the count of the appfwfieldtype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwfieldtype
    .EXAMPLE 
        Invoke-ADCGetAppfwfieldtype -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwfieldtype -Count
    .EXAMPLE
        Invoke-ADCGetAppfwfieldtype -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwfieldtype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwfieldtype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        Write-Verbose "Invoke-ADCGetAppfwfieldtype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwfieldtype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwfieldtype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwfieldtype objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwfieldtype configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwfieldtype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwfieldtype: Ended"
    }
}

function Invoke-ADCAddAppfwglobalappfwpolicybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER policyname 
        Name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER state 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER type 
        Bind point to which to policy is bound.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = reqvserver, policylabel 
    .PARAMETER labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_appfwpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwglobalappfwpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'NONE')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalappfwpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("appfwglobal_appfwpolicy_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_appfwpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwglobalappfwpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwglobalappfwpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwglobalappfwpolicybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
     .PARAMETER policyname 
       Name of the policy.    .PARAMETER type 
       Bind point to which to policy is bound.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE    .PARAMETER priority 
       The priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteAppfwglobalappfwpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalappfwpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("appfwglobal_appfwpolicy_binding", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalappfwpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppfwglobalappfwpolicybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwglobal_appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwglobal_appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwglobalappfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalappfwpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalappfwpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwglobalappfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwglobalappfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwglobal_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwglobalappfwpolicybinding: Ended"
    }
}

function Invoke-ADCAddAppfwglobalauditnslogpolicybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER policyname 
        Name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER state 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is smaller than the current policy's priority number. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER type 
        Bind point to which to policy is bound.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label.  
        Possible values = reqvserver, policylabel 
    .PARAMETER labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwglobalauditnslogpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'NONE')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("appfwglobal_auditnslogpolicy_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
     .PARAMETER policyname 
       Name of the policy.    .PARAMETER type 
       Bind point to which to policy is bound.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE    .PARAMETER priority 
       The priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("appfwglobal_auditnslogpolicy_binding", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppfwglobalauditnslogpolicybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwglobal_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwglobal_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalauditnslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwglobalauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddAppfwglobalauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER policyname 
        Name of the policy. 
    .PARAMETER priority 
        The priority of the policy. 
    .PARAMETER state 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is smaller than the current policy's priority number. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER type 
        Bind point to which to policy is bound.  
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label.  
        Possible values = reqvserver, policylabel 
    .PARAMETER labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwglobalauditsyslogpolicybinding -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'NONE')]
        [string]$type ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("appfwglobal_auditsyslogpolicy_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
     .PARAMETER policyname 
       Name of the policy.    .PARAMETER type 
       Bind point to which to policy is bound.  
       Possible values = REQ_OVERRIDE, REQ_DEFAULT, NONE    .PARAMETER priority 
       The priority of the policy.
    .EXAMPLE
        Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding 
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("appfwglobal_auditsyslogpolicy_binding", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppfwglobalauditsyslogpolicybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwglobal_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwglobal_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalauditsyslogpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwglobalauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppfwglobalbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwglobalbinding: Ended"
    }
}

function Invoke-ADCDeleteAppfwhtmlerrorpage {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the XML error object to remove.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwhtmlerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwhtmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwhtmlerrorpage: Finished"
    }
}

function Invoke-ADCImportAppfwhtmlerrorpage {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and name) for the location at which to store the imported HTML error object.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Name of the XML error object to remove. 
    .PARAMETER comment 
        Any comments to preserve information about the HTML error object. 
    .PARAMETER overwrite 
        Overwrite any existing HTML error object of the same name.
    .EXAMPLE
        Invoke-ADCImportAppfwhtmlerrorpage -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwhtmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwhtmlerrorpage -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwhtmlerrorpage: Finished"
    }
}

function Invoke-ADCChangeAppfwhtmlerrorpage {
<#
    .SYNOPSIS
        Change Application Firewall configuration Object
    .DESCRIPTION
        Change Application Firewall configuration Object 
    .PARAMETER name 
        Name of the XML error object to remove.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created appfwhtmlerrorpage item.
    .EXAMPLE
        Invoke-ADCChangeAppfwhtmlerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCChangeAppfwhtmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        [string]$name ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("appfwhtmlerrorpage", "Change Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwhtmlerrorpage -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwhtmlerrorpage -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeAppfwhtmlerrorpage: Finished"
    }
}

function Invoke-ADCGetAppfwhtmlerrorpage {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the XML error object to remove. 
    .PARAMETER GetAll 
        Retreive all appfwhtmlerrorpage object(s)
    .PARAMETER Count
        If specified, the count of the appfwhtmlerrorpage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwhtmlerrorpage
    .EXAMPLE 
        Invoke-ADCGetAppfwhtmlerrorpage -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwhtmlerrorpage -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwhtmlerrorpage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwhtmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwhtmlerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwhtmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwhtmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwhtmlerrorpage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwhtmlerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwhtmlerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwhtmlerrorpage: Ended"
    }
}

function Invoke-ADCAddAppfwjsoncontenttype {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER jsoncontenttypevalue 
        Content type to be classified as JSON.  
        Minimum length = 1 
    .PARAMETER isregex 
        Is json content type a regular expression?.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwjsoncontenttype item.
    .EXAMPLE
        Invoke-ADCAddAppfwjsoncontenttype -jsoncontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwjsoncontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$jsoncontenttypevalue ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex = 'NOTREGEX' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwjsoncontenttype: Starting"
    }
    process {
        try {
            $Payload = @{
                jsoncontenttypevalue = $jsoncontenttypevalue
            }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
 
            if ($PSCmdlet.ShouldProcess("appfwjsoncontenttype", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsoncontenttype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwjsoncontenttype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwjsoncontenttype: Finished"
    }
}

function Invoke-ADCDeleteAppfwjsoncontenttype {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER jsoncontenttypevalue 
       Content type to be classified as JSON.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAppfwjsoncontenttype -jsoncontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwjsoncontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$jsoncontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwjsoncontenttype: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$jsoncontenttypevalue", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Resource $jsoncontenttypevalue -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwjsoncontenttype: Finished"
    }
}

function Invoke-ADCGetAppfwjsoncontenttype {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER jsoncontenttypevalue 
       Content type to be classified as JSON. 
    .PARAMETER GetAll 
        Retreive all appfwjsoncontenttype object(s)
    .PARAMETER Count
        If specified, the count of the appfwjsoncontenttype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwjsoncontenttype
    .EXAMPLE 
        Invoke-ADCGetAppfwjsoncontenttype -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwjsoncontenttype -Count
    .EXAMPLE
        Invoke-ADCGetAppfwjsoncontenttype -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwjsoncontenttype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwjsoncontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$jsoncontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwjsoncontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwjsoncontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwjsoncontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwjsoncontenttype objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwjsoncontenttype configuration for property 'jsoncontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Resource $jsoncontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwjsoncontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwjsoncontenttype: Ended"
    }
}

function Invoke-ADCDeleteAppfwjsonerrorpage {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Indicates name of the imported json error page to be removed.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwjsonerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwjsonerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwjsonerrorpage: Finished"
    }
}

function Invoke-ADCImportAppfwjsonerrorpage {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and name) for the location at which to store the imported JSON error object.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Indicates name of the imported json error page to be removed. 
    .PARAMETER comment 
        Any comments to preserve information about the JSON error object. 
    .PARAMETER overwrite 
        Overwrite any existing JSON error object of the same name.
    .EXAMPLE
        Invoke-ADCImportAppfwjsonerrorpage -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwjsonerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsonerrorpage -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwjsonerrorpage: Finished"
    }
}

function Invoke-ADCChangeAppfwjsonerrorpage {
<#
    .SYNOPSIS
        Change Application Firewall configuration Object
    .DESCRIPTION
        Change Application Firewall configuration Object 
    .PARAMETER name 
        Indicates name of the imported json error page to be removed.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created appfwjsonerrorpage item.
    .EXAMPLE
        Invoke-ADCChangeAppfwjsonerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCChangeAppfwjsonerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        [string]$name ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("appfwjsonerrorpage", "Change Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsonerrorpage -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwjsonerrorpage -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeAppfwjsonerrorpage: Finished"
    }
}

function Invoke-ADCGetAppfwjsonerrorpage {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Indicates name of the imported json error page to be removed. 
    .PARAMETER GetAll 
        Retreive all appfwjsonerrorpage object(s)
    .PARAMETER Count
        If specified, the count of the appfwjsonerrorpage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwjsonerrorpage
    .EXAMPLE 
        Invoke-ADCGetAppfwjsonerrorpage -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwjsonerrorpage -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwjsonerrorpage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwjsonerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwjsonerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwjsonerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwjsonerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwjsonerrorpage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwjsonerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwjsonerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwjsonerrorpage: Ended"
    }
}

function Invoke-ADCDeleteAppfwlearningdata {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
     .PARAMETER profilename 
       Name of the profile.    .PARAMETER starturl 
       Start URL configuration.  
       Minimum length = 1    .PARAMETER cookieconsistency 
       Cookie Name.  
       Minimum length = 1    .PARAMETER fieldconsistency 
       Form field name.  
       Minimum length = 1    .PARAMETER formactionurl_ffc 
       Form action URL.    .PARAMETER contenttype 
       Content Type Name.  
       Minimum length = 1    .PARAMETER crosssitescripting 
       Cross-site scripting.  
       Minimum length = 1    .PARAMETER formactionurl_xss 
       Form action URL.  
       Minimum length = 1    .PARAMETER as_scan_location_xss 
       Location of cross-site scripting exception - form field, header, cookie or url.  
       Possible values = FORMFIELD, HEADER, COOKIE, URL    .PARAMETER as_value_type_xss 
       XSS value type. (Tag | Attribute | Pattern).  
       Possible values = Tag, Attribute, Pattern    .PARAMETER as_value_expr_xss 
       XSS value expressions consistituting expressions for Tag, Attribute or Pattern.    .PARAMETER sqlinjection 
       Form field name.  
       Minimum length = 1    .PARAMETER formactionurl_sql 
       Form action URL.  
       Minimum length = 1    .PARAMETER as_scan_location_sql 
       Location of sql injection exception - form field, header or cookie.  
       Possible values = FORMFIELD, HEADER, COOKIE    .PARAMETER as_value_type_sql 
       SQL value type. Keyword, SpecialString or Wildchar.  
       Possible values = Keyword, SpecialString, Wildchar    .PARAMETER as_value_expr_sql 
       SQL value expressions consistituting expressions for Keyword, SpecialString or Wildchar.    .PARAMETER fieldformat 
       Field format name.  
       Minimum length = 1    .PARAMETER formactionurl_ff 
       Form action URL.  
       Minimum length = 1    .PARAMETER csrftag 
       CSRF Form Action URL.  
       Minimum length = 1    .PARAMETER csrfformoriginurl 
       CSRF Form Origin URL.  
       Minimum length = 1    .PARAMETER creditcardnumber 
       The object expression that is to be excluded from safe commerce check.  
       Minimum length = 1    .PARAMETER creditcardnumberurl 
       The url for which the list of credit card numbers are needed to be bypassed from inspection.  
       Minimum length = 1    .PARAMETER xmldoscheck 
       XML Denial of Service check, one of  
       MaxAttributes  
       MaxAttributeNameLength  
       MaxAttributeValueLength  
       MaxElementNameLength  
       MaxFileSize  
       MinFileSize  
       MaxCDATALength  
       MaxElements  
       MaxElementDepth  
       MaxElementChildren  
       NumDTDs  
       NumProcessingInstructions  
       NumExternalEntities  
       MaxEntityExpansions  
       MaxEntityExpansionDepth  
       MaxNamespaces  
       MaxNamespaceUriLength  
       MaxSOAPArraySize  
       MaxSOAPArrayRank  
       .  
       Minimum length = 1    .PARAMETER xmlwsicheck 
       Web Services Interoperability Rule ID.  
       Minimum length = 1    .PARAMETER xmlattachmentcheck 
       XML Attachment Content-Type.  
       Minimum length = 1    .PARAMETER totalxmlrequests 
       Total XML requests.
    .EXAMPLE
        Invoke-ADCDeleteAppfwlearningdata 
    .NOTES
        File Name : Invoke-ADCDeleteAppfwlearningdata
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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

        [string]$profilename ,

        [string]$starturl ,

        [string]$cookieconsistency ,

        [string]$fieldconsistency ,

        [string]$formactionurl_ffc ,

        [string]$contenttype ,

        [string]$crosssitescripting ,

        [string]$formactionurl_xss ,

        [string]$as_scan_location_xss ,

        [string]$as_value_type_xss ,

        [string]$as_value_expr_xss ,

        [string]$sqlinjection ,

        [string]$formactionurl_sql ,

        [string]$as_scan_location_sql ,

        [string]$as_value_type_sql ,

        [string]$as_value_expr_sql ,

        [string]$fieldformat ,

        [string]$formactionurl_ff ,

        [string]$csrftag ,

        [string]$csrfformoriginurl ,

        [string]$creditcardnumber ,

        [string]$creditcardnumberurl ,

        [string]$xmldoscheck ,

        [string]$xmlwsicheck ,

        [string]$xmlattachmentcheck ,

        [boolean]$totalxmlrequests 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwlearningdata: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Arguments.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('starturl')) { $Arguments.Add('starturl', $starturl) }
            if ($PSBoundParameters.ContainsKey('cookieconsistency')) { $Arguments.Add('cookieconsistency', $cookieconsistency) }
            if ($PSBoundParameters.ContainsKey('fieldconsistency')) { $Arguments.Add('fieldconsistency', $fieldconsistency) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ffc')) { $Arguments.Add('formactionurl_ffc', $formactionurl_ffc) }
            if ($PSBoundParameters.ContainsKey('contenttype')) { $Arguments.Add('contenttype', $contenttype) }
            if ($PSBoundParameters.ContainsKey('crosssitescripting')) { $Arguments.Add('crosssitescripting', $crosssitescripting) }
            if ($PSBoundParameters.ContainsKey('formactionurl_xss')) { $Arguments.Add('formactionurl_xss', $formactionurl_xss) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xss')) { $Arguments.Add('as_scan_location_xss', $as_scan_location_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_type_xss')) { $Arguments.Add('as_value_type_xss', $as_value_type_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_xss')) { $Arguments.Add('as_value_expr_xss', $as_value_expr_xss) }
            if ($PSBoundParameters.ContainsKey('sqlinjection')) { $Arguments.Add('sqlinjection', $sqlinjection) }
            if ($PSBoundParameters.ContainsKey('formactionurl_sql')) { $Arguments.Add('formactionurl_sql', $formactionurl_sql) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_sql')) { $Arguments.Add('as_scan_location_sql', $as_scan_location_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_type_sql')) { $Arguments.Add('as_value_type_sql', $as_value_type_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_sql')) { $Arguments.Add('as_value_expr_sql', $as_value_expr_sql) }
            if ($PSBoundParameters.ContainsKey('fieldformat')) { $Arguments.Add('fieldformat', $fieldformat) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ff')) { $Arguments.Add('formactionurl_ff', $formactionurl_ff) }
            if ($PSBoundParameters.ContainsKey('csrftag')) { $Arguments.Add('csrftag', $csrftag) }
            if ($PSBoundParameters.ContainsKey('csrfformoriginurl')) { $Arguments.Add('csrfformoriginurl', $csrfformoriginurl) }
            if ($PSBoundParameters.ContainsKey('creditcardnumber')) { $Arguments.Add('creditcardnumber', $creditcardnumber) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberurl')) { $Arguments.Add('creditcardnumberurl', $creditcardnumberurl) }
            if ($PSBoundParameters.ContainsKey('xmldoscheck')) { $Arguments.Add('xmldoscheck', $xmldoscheck) }
            if ($PSBoundParameters.ContainsKey('xmlwsicheck')) { $Arguments.Add('xmlwsicheck', $xmlwsicheck) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentcheck')) { $Arguments.Add('xmlattachmentcheck', $xmlattachmentcheck) }
            if ($PSBoundParameters.ContainsKey('totalxmlrequests')) { $Arguments.Add('totalxmlrequests', $totalxmlrequests) }
            if ($PSCmdlet.ShouldProcess("appfwlearningdata", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwlearningdata -NitroPath nitro/v1/config -Resource $ -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwlearningdata: Finished"
    }
}

function Invoke-ADCResetAppfwlearningdata {
<#
    .SYNOPSIS
        Reset Application Firewall configuration Object
    .DESCRIPTION
        Reset Application Firewall configuration Object 
    .EXAMPLE
        Invoke-ADCResetAppfwlearningdata 
    .NOTES
        File Name : Invoke-ADCResetAppfwlearningdata
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCResetAppfwlearningdata: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Reset Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwlearningdata -Action reset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCResetAppfwlearningdata: Finished"
    }
}

function Invoke-ADCExportAppfwlearningdata {
<#
    .SYNOPSIS
        Export Application Firewall configuration Object
    .DESCRIPTION
        Export Application Firewall configuration Object 
    .PARAMETER profilename 
        Name of the profile. 
    .PARAMETER securitycheck 
        Name of the security check.  
        Possible values = startURL, cookieConsistency, fieldConsistency, crossSiteScripting, SQLInjection, fieldFormat, CSRFtag, XMLDoSCheck, XMLWSICheck, XMLAttachmentCheck, TotalXMLRequests, creditCardNumber, ContentType 
    .PARAMETER target 
        Target filename for data to be exported.
    .EXAMPLE
        Invoke-ADCExportAppfwlearningdata -profilename <string> -securitycheck <string>
    .NOTES
        File Name : Invoke-ADCExportAppfwlearningdata
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [string]$profilename ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('startURL', 'cookieConsistency', 'fieldConsistency', 'crossSiteScripting', 'SQLInjection', 'fieldFormat', 'CSRFtag', 'XMLDoSCheck', 'XMLWSICheck', 'XMLAttachmentCheck', 'TotalXMLRequests', 'creditCardNumber', 'ContentType')]
        [string]$securitycheck ,

        [ValidateLength(1, 127)]
        [string]$target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwlearningdata: Starting"
    }
    process {
        try {
            $Payload = @{
                profilename = $profilename
                securitycheck = $securitycheck
            }
            if ($PSBoundParameters.ContainsKey('target')) { $Payload.Add('target', $target) }
            if ($PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwlearningdata -Action export -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCExportAppfwlearningdata: Finished"
    }
}

function Invoke-ADCGetAppfwlearningdata {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER profilename 
       Name of the profile. 
    .PARAMETER securitycheck 
       Name of the security check.  
       Possible values = startURL, cookieConsistency, fieldConsistency, crossSiteScripting, SQLInjection, fieldFormat, CSRFtag, XMLDoSCheck, XMLWSICheck, XMLAttachmentCheck, TotalXMLRequests, creditCardNumber, ContentType 
    .PARAMETER GetAll 
        Retreive all appfwlearningdata object(s)
    .PARAMETER Count
        If specified, the count of the appfwlearningdata object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwlearningdata
    .EXAMPLE 
        Invoke-ADCGetAppfwlearningdata -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwlearningdata -Count
    .EXAMPLE
        Invoke-ADCGetAppfwlearningdata -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwlearningdata -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwlearningdata
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [string]$profilename ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('startURL', 'cookieConsistency', 'fieldConsistency', 'crossSiteScripting', 'SQLInjection', 'fieldFormat', 'CSRFtag', 'XMLDoSCheck', 'XMLWSICheck', 'XMLAttachmentCheck', 'TotalXMLRequests', 'creditCardNumber', 'ContentType')]
        [string]$securitycheck,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwlearningdata: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwlearningdata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwlearningdata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwlearningdata objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('profilename')) { $Arguments.Add('profilename', $profilename) } 
                if ($PSBoundParameters.ContainsKey('securitycheck')) { $Arguments.Add('securitycheck', $securitycheck) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwlearningdata configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwlearningdata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwlearningdata: Ended"
    }
}

function Invoke-ADCUpdateAppfwlearningsettings {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER profilename 
        Name of the profile.  
        Minimum length = 1 
    .PARAMETER starturlminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn start URLs.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER starturlpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular start URL pattern for the learning engine to learn that start URL.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER cookieconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cookies.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER cookieconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cookie pattern for the learning engine to learn that cookie.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER csrftagminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cross-site request forgery (CSRF) tags.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER csrftagpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular CSRF tag for the learning engine to learn that CSRF tag.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER fieldconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field consistency information.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER fieldconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular field consistency pattern for the learning engine to learn that field consistency pattern.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER crosssitescriptingminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML cross-site scripting patterns.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER crosssitescriptingpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cross-site scripting pattern for the learning engine to learn that cross-site scripting pattern.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER sqlinjectionminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML SQL injection patterns.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER sqlinjectionpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular HTML SQL injection pattern for the learning engine to learn that HTML SQL injection pattern.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER fieldformatminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field formats.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER fieldformatpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular web form field pattern for the learning engine to recommend a field format for that form field.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER creditcardnumberminthreshold 
        Minimum threshold to learn Credit Card information.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER creditcardnumberpercentthreshold 
        Minimum threshold in percent to learn Credit Card information.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER contenttypeminthreshold 
        Minimum threshold to learn Content Type information.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER contenttypepercentthreshold 
        Minimum threshold in percent to learn Content Type information.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER xmlwsiminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn web services interoperability (WSI) information.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER xmlwsipercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular pattern for the learning engine to learn a web services interoperability (WSI) pattern.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER xmlattachmentminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn XML attachment patterns.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER xmlattachmentpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular XML attachment pattern for the learning engine to learn that XML attachment pattern.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER fieldformatautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER sqlinjectionautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER crosssitescriptingautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER starturlautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER cookieconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER csrftagautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER fieldconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER contenttypeautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.  
        Default value: 10080  
        Minimum value = 5  
        Maximum value = 43200 
    .PARAMETER PassThru 
        Return details about the created appfwlearningsettings item.
    .EXAMPLE
        Invoke-ADCUpdateAppfwlearningsettings -profilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppfwlearningsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings/
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
        [string]$profilename ,

        [double]$starturlminthreshold ,

        [ValidateRange(0, 100)]
        [double]$starturlpercentthreshold ,

        [double]$cookieconsistencyminthreshold ,

        [ValidateRange(0, 100)]
        [double]$cookieconsistencypercentthreshold ,

        [double]$csrftagminthreshold ,

        [ValidateRange(0, 100)]
        [double]$csrftagpercentthreshold ,

        [double]$fieldconsistencyminthreshold ,

        [ValidateRange(0, 100)]
        [double]$fieldconsistencypercentthreshold ,

        [double]$crosssitescriptingminthreshold ,

        [ValidateRange(0, 100)]
        [double]$crosssitescriptingpercentthreshold ,

        [double]$sqlinjectionminthreshold ,

        [ValidateRange(0, 100)]
        [double]$sqlinjectionpercentthreshold ,

        [double]$fieldformatminthreshold ,

        [ValidateRange(0, 100)]
        [double]$fieldformatpercentthreshold ,

        [double]$creditcardnumberminthreshold ,

        [ValidateRange(0, 100)]
        [double]$creditcardnumberpercentthreshold ,

        [double]$contenttypeminthreshold ,

        [ValidateRange(0, 100)]
        [double]$contenttypepercentthreshold ,

        [double]$xmlwsiminthreshold ,

        [ValidateRange(0, 100)]
        [double]$xmlwsipercentthreshold ,

        [double]$xmlattachmentminthreshold ,

        [ValidateRange(0, 100)]
        [double]$xmlattachmentpercentthreshold ,

        [ValidateRange(5, 43200)]
        [double]$fieldformatautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$sqlinjectionautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$crosssitescriptingautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$starturlautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$cookieconsistencyautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$csrftagautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$fieldconsistencyautodeploygraceperiod ,

        [ValidateRange(5, 43200)]
        [double]$contenttypeautodeploygraceperiod ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwlearningsettings: Starting"
    }
    process {
        try {
            $Payload = @{
                profilename = $profilename
            }
            if ($PSBoundParameters.ContainsKey('starturlminthreshold')) { $Payload.Add('starturlminthreshold', $starturlminthreshold) }
            if ($PSBoundParameters.ContainsKey('starturlpercentthreshold')) { $Payload.Add('starturlpercentthreshold', $starturlpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyminthreshold')) { $Payload.Add('cookieconsistencyminthreshold', $cookieconsistencyminthreshold) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencypercentthreshold')) { $Payload.Add('cookieconsistencypercentthreshold', $cookieconsistencypercentthreshold) }
            if ($PSBoundParameters.ContainsKey('csrftagminthreshold')) { $Payload.Add('csrftagminthreshold', $csrftagminthreshold) }
            if ($PSBoundParameters.ContainsKey('csrftagpercentthreshold')) { $Payload.Add('csrftagpercentthreshold', $csrftagpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyminthreshold')) { $Payload.Add('fieldconsistencyminthreshold', $fieldconsistencyminthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencypercentthreshold')) { $Payload.Add('fieldconsistencypercentthreshold', $fieldconsistencypercentthreshold) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingminthreshold')) { $Payload.Add('crosssitescriptingminthreshold', $crosssitescriptingminthreshold) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingpercentthreshold')) { $Payload.Add('crosssitescriptingpercentthreshold', $crosssitescriptingpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionminthreshold')) { $Payload.Add('sqlinjectionminthreshold', $sqlinjectionminthreshold) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionpercentthreshold')) { $Payload.Add('sqlinjectionpercentthreshold', $sqlinjectionpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatminthreshold')) { $Payload.Add('fieldformatminthreshold', $fieldformatminthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatpercentthreshold')) { $Payload.Add('fieldformatpercentthreshold', $fieldformatpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberminthreshold')) { $Payload.Add('creditcardnumberminthreshold', $creditcardnumberminthreshold) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberpercentthreshold')) { $Payload.Add('creditcardnumberpercentthreshold', $creditcardnumberpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('contenttypeminthreshold')) { $Payload.Add('contenttypeminthreshold', $contenttypeminthreshold) }
            if ($PSBoundParameters.ContainsKey('contenttypepercentthreshold')) { $Payload.Add('contenttypepercentthreshold', $contenttypepercentthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlwsiminthreshold')) { $Payload.Add('xmlwsiminthreshold', $xmlwsiminthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlwsipercentthreshold')) { $Payload.Add('xmlwsipercentthreshold', $xmlwsipercentthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentminthreshold')) { $Payload.Add('xmlattachmentminthreshold', $xmlattachmentminthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentpercentthreshold')) { $Payload.Add('xmlattachmentpercentthreshold', $xmlattachmentpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatautodeploygraceperiod')) { $Payload.Add('fieldformatautodeploygraceperiod', $fieldformatautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionautodeploygraceperiod')) { $Payload.Add('sqlinjectionautodeploygraceperiod', $sqlinjectionautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingautodeploygraceperiod')) { $Payload.Add('crosssitescriptingautodeploygraceperiod', $crosssitescriptingautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('starturlautodeploygraceperiod')) { $Payload.Add('starturlautodeploygraceperiod', $starturlautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyautodeploygraceperiod')) { $Payload.Add('cookieconsistencyautodeploygraceperiod', $cookieconsistencyautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('csrftagautodeploygraceperiod')) { $Payload.Add('csrftagautodeploygraceperiod', $csrftagautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyautodeploygraceperiod')) { $Payload.Add('fieldconsistencyautodeploygraceperiod', $fieldconsistencyautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('contenttypeautodeploygraceperiod')) { $Payload.Add('contenttypeautodeploygraceperiod', $contenttypeautodeploygraceperiod) }
 
            if ($PSCmdlet.ShouldProcess("appfwlearningsettings", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwlearningsettings -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwlearningsettings -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppfwlearningsettings: Finished"
    }
}

function Invoke-ADCUnsetAppfwlearningsettings {
<#
    .SYNOPSIS
        Unset Application Firewall configuration Object
    .DESCRIPTION
        Unset Application Firewall configuration Object 
   .PARAMETER profilename 
       Name of the profile. 
   .PARAMETER starturlminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn start URLs. 
   .PARAMETER starturlpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular start URL pattern for the learning engine to learn that start URL. 
   .PARAMETER cookieconsistencyminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn cookies. 
   .PARAMETER cookieconsistencypercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular cookie pattern for the learning engine to learn that cookie. 
   .PARAMETER csrftagminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn cross-site request forgery (CSRF) tags. 
   .PARAMETER csrftagpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular CSRF tag for the learning engine to learn that CSRF tag. 
   .PARAMETER fieldconsistencyminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn field consistency information. 
   .PARAMETER fieldconsistencypercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular field consistency pattern for the learning engine to learn that field consistency pattern. 
   .PARAMETER crosssitescriptingminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn HTML cross-site scripting patterns. 
   .PARAMETER crosssitescriptingpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular cross-site scripting pattern for the learning engine to learn that cross-site scripting pattern. 
   .PARAMETER sqlinjectionminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn HTML SQL injection patterns. 
   .PARAMETER sqlinjectionpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular HTML SQL injection pattern for the learning engine to learn that HTML SQL injection pattern. 
   .PARAMETER fieldformatminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn field formats. 
   .PARAMETER fieldformatpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular web form field pattern for the learning engine to recommend a field format for that form field. 
   .PARAMETER creditcardnumberminthreshold 
       Minimum threshold to learn Credit Card information. 
   .PARAMETER creditcardnumberpercentthreshold 
       Minimum threshold in percent to learn Credit Card information. 
   .PARAMETER contenttypeminthreshold 
       Minimum threshold to learn Content Type information. 
   .PARAMETER contenttypepercentthreshold 
       Minimum threshold in percent to learn Content Type information. 
   .PARAMETER xmlwsiminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn web services interoperability (WSI) information. 
   .PARAMETER xmlwsipercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular pattern for the learning engine to learn a web services interoperability (WSI) pattern. 
   .PARAMETER xmlattachmentminthreshold 
       Minimum number of application firewall sessions that the learning engine must observe to learn XML attachment patterns. 
   .PARAMETER xmlattachmentpercentthreshold 
       Minimum percentage of application firewall sessions that must contain a particular XML attachment pattern for the learning engine to learn that XML attachment pattern. 
   .PARAMETER fieldformatautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER sqlinjectionautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER crosssitescriptingautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER starturlautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER cookieconsistencyautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER csrftagautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER fieldconsistencyautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed. 
   .PARAMETER contenttypeautodeploygraceperiod 
       The number of minutes after the threshold hit alert the learned rule will be deployed.
    .EXAMPLE
        Invoke-ADCUnsetAppfwlearningsettings -profilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppfwlearningsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings
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
        [string]$profilename ,

        [Boolean]$starturlminthreshold ,

        [Boolean]$starturlpercentthreshold ,

        [Boolean]$cookieconsistencyminthreshold ,

        [Boolean]$cookieconsistencypercentthreshold ,

        [Boolean]$csrftagminthreshold ,

        [Boolean]$csrftagpercentthreshold ,

        [Boolean]$fieldconsistencyminthreshold ,

        [Boolean]$fieldconsistencypercentthreshold ,

        [Boolean]$crosssitescriptingminthreshold ,

        [Boolean]$crosssitescriptingpercentthreshold ,

        [Boolean]$sqlinjectionminthreshold ,

        [Boolean]$sqlinjectionpercentthreshold ,

        [Boolean]$fieldformatminthreshold ,

        [Boolean]$fieldformatpercentthreshold ,

        [Boolean]$creditcardnumberminthreshold ,

        [Boolean]$creditcardnumberpercentthreshold ,

        [Boolean]$contenttypeminthreshold ,

        [Boolean]$contenttypepercentthreshold ,

        [Boolean]$xmlwsiminthreshold ,

        [Boolean]$xmlwsipercentthreshold ,

        [Boolean]$xmlattachmentminthreshold ,

        [Boolean]$xmlattachmentpercentthreshold ,

        [Boolean]$fieldformatautodeploygraceperiod ,

        [Boolean]$sqlinjectionautodeploygraceperiod ,

        [Boolean]$crosssitescriptingautodeploygraceperiod ,

        [Boolean]$starturlautodeploygraceperiod ,

        [Boolean]$cookieconsistencyautodeploygraceperiod ,

        [Boolean]$csrftagautodeploygraceperiod ,

        [Boolean]$fieldconsistencyautodeploygraceperiod ,

        [Boolean]$contenttypeautodeploygraceperiod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwlearningsettings: Starting"
    }
    process {
        try {
            $Payload = @{
                profilename = $profilename
            }
            if ($PSBoundParameters.ContainsKey('starturlminthreshold')) { $Payload.Add('starturlminthreshold', $starturlminthreshold) }
            if ($PSBoundParameters.ContainsKey('starturlpercentthreshold')) { $Payload.Add('starturlpercentthreshold', $starturlpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyminthreshold')) { $Payload.Add('cookieconsistencyminthreshold', $cookieconsistencyminthreshold) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencypercentthreshold')) { $Payload.Add('cookieconsistencypercentthreshold', $cookieconsistencypercentthreshold) }
            if ($PSBoundParameters.ContainsKey('csrftagminthreshold')) { $Payload.Add('csrftagminthreshold', $csrftagminthreshold) }
            if ($PSBoundParameters.ContainsKey('csrftagpercentthreshold')) { $Payload.Add('csrftagpercentthreshold', $csrftagpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyminthreshold')) { $Payload.Add('fieldconsistencyminthreshold', $fieldconsistencyminthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencypercentthreshold')) { $Payload.Add('fieldconsistencypercentthreshold', $fieldconsistencypercentthreshold) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingminthreshold')) { $Payload.Add('crosssitescriptingminthreshold', $crosssitescriptingminthreshold) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingpercentthreshold')) { $Payload.Add('crosssitescriptingpercentthreshold', $crosssitescriptingpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionminthreshold')) { $Payload.Add('sqlinjectionminthreshold', $sqlinjectionminthreshold) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionpercentthreshold')) { $Payload.Add('sqlinjectionpercentthreshold', $sqlinjectionpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatminthreshold')) { $Payload.Add('fieldformatminthreshold', $fieldformatminthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatpercentthreshold')) { $Payload.Add('fieldformatpercentthreshold', $fieldformatpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberminthreshold')) { $Payload.Add('creditcardnumberminthreshold', $creditcardnumberminthreshold) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberpercentthreshold')) { $Payload.Add('creditcardnumberpercentthreshold', $creditcardnumberpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('contenttypeminthreshold')) { $Payload.Add('contenttypeminthreshold', $contenttypeminthreshold) }
            if ($PSBoundParameters.ContainsKey('contenttypepercentthreshold')) { $Payload.Add('contenttypepercentthreshold', $contenttypepercentthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlwsiminthreshold')) { $Payload.Add('xmlwsiminthreshold', $xmlwsiminthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlwsipercentthreshold')) { $Payload.Add('xmlwsipercentthreshold', $xmlwsipercentthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentminthreshold')) { $Payload.Add('xmlattachmentminthreshold', $xmlattachmentminthreshold) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentpercentthreshold')) { $Payload.Add('xmlattachmentpercentthreshold', $xmlattachmentpercentthreshold) }
            if ($PSBoundParameters.ContainsKey('fieldformatautodeploygraceperiod')) { $Payload.Add('fieldformatautodeploygraceperiod', $fieldformatautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionautodeploygraceperiod')) { $Payload.Add('sqlinjectionautodeploygraceperiod', $sqlinjectionautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingautodeploygraceperiod')) { $Payload.Add('crosssitescriptingautodeploygraceperiod', $crosssitescriptingautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('starturlautodeploygraceperiod')) { $Payload.Add('starturlautodeploygraceperiod', $starturlautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyautodeploygraceperiod')) { $Payload.Add('cookieconsistencyautodeploygraceperiod', $cookieconsistencyautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('csrftagautodeploygraceperiod')) { $Payload.Add('csrftagautodeploygraceperiod', $csrftagautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyautodeploygraceperiod')) { $Payload.Add('fieldconsistencyautodeploygraceperiod', $fieldconsistencyautodeploygraceperiod) }
            if ($PSBoundParameters.ContainsKey('contenttypeautodeploygraceperiod')) { $Payload.Add('contenttypeautodeploygraceperiod', $contenttypeautodeploygraceperiod) }
            if ($PSCmdlet.ShouldProcess("$profilename", "Unset Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwlearningsettings -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppfwlearningsettings: Finished"
    }
}

function Invoke-ADCGetAppfwlearningsettings {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER profilename 
       Name of the profile. 
    .PARAMETER GetAll 
        Retreive all appfwlearningsettings object(s)
    .PARAMETER Count
        If specified, the count of the appfwlearningsettings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwlearningsettings
    .EXAMPLE 
        Invoke-ADCGetAppfwlearningsettings -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwlearningsettings -Count
    .EXAMPLE
        Invoke-ADCGetAppfwlearningsettings -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwlearningsettings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwlearningsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings/
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
        [string]$profilename,

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
        Write-Verbose "Invoke-ADCGetAppfwlearningsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwlearningsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwlearningsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwlearningsettings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwlearningsettings configuration for property 'profilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Resource $profilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwlearningsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwlearningsettings: Ended"
    }
}

function Invoke-ADCAddAppfwmultipartformcontenttype {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER multipartformcontenttypevalue 
        Content type to be classified as multipart form.  
        Minimum length = 1 
    .PARAMETER isregex 
        Is multipart_form content type a regular expression?.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwmultipartformcontenttype item.
    .EXAMPLE
        Invoke-ADCAddAppfwmultipartformcontenttype -multipartformcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwmultipartformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$multipartformcontenttypevalue ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex = 'NOTREGEX' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwmultipartformcontenttype: Starting"
    }
    process {
        try {
            $Payload = @{
                multipartformcontenttypevalue = $multipartformcontenttypevalue
            }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
 
            if ($PSCmdlet.ShouldProcess("appfwmultipartformcontenttype", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwmultipartformcontenttype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwmultipartformcontenttype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwmultipartformcontenttype: Finished"
    }
}

function Invoke-ADCDeleteAppfwmultipartformcontenttype {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER multipartformcontenttypevalue 
       Content type to be classified as multipart form.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAppfwmultipartformcontenttype -multipartformcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwmultipartformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$multipartformcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwmultipartformcontenttype: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$multipartformcontenttypevalue", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Resource $multipartformcontenttypevalue -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwmultipartformcontenttype: Finished"
    }
}

function Invoke-ADCGetAppfwmultipartformcontenttype {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER multipartformcontenttypevalue 
       Content type to be classified as multipart form. 
    .PARAMETER GetAll 
        Retreive all appfwmultipartformcontenttype object(s)
    .PARAMETER Count
        If specified, the count of the appfwmultipartformcontenttype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwmultipartformcontenttype
    .EXAMPLE 
        Invoke-ADCGetAppfwmultipartformcontenttype -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwmultipartformcontenttype -Count
    .EXAMPLE
        Invoke-ADCGetAppfwmultipartformcontenttype -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwmultipartformcontenttype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwmultipartformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$multipartformcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwmultipartformcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwmultipartformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwmultipartformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwmultipartformcontenttype objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwmultipartformcontenttype configuration for property 'multipartformcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Resource $multipartformcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwmultipartformcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwmultipartformcontenttype: Ended"
    }
}

function Invoke-ADCAddAppfwpolicy {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or a Citrix ADC expression, that the policy uses to determine whether to filter the connection through the application firewall with the designated profile. 
    .PARAMETER profilename 
        Name of the application firewall profile to use if the policy matches.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments to preserve information about the policy for later reference. 
    .PARAMETER logaction 
        Where to log information for connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        Invoke-ADCAddAppfwpolicy -name <string> -rule <string> -profilename <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$profilename ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                profilename = $profilename
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("appfwpolicy", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwpolicy: Finished"
    }
}

function Invoke-ADCDeleteAppfwpolicy {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteAppfwpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicy: Finished"
    }
}

function Invoke-ADCUpdateAppfwpolicy {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER rule 
        Name of the Citrix ADC named rule, or a Citrix ADC expression, that the policy uses to determine whether to filter the connection through the application firewall with the designated profile. 
    .PARAMETER profilename 
        Name of the application firewall profile to use if the policy matches.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments to preserve information about the policy for later reference. 
    .PARAMETER logaction 
        Where to log information for connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAppfwpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$profilename ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Payload.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("appfwpolicy", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppfwpolicy: Finished"
    }
}

function Invoke-ADCUnsetAppfwpolicy {
<#
    .SYNOPSIS
        Unset Application Firewall configuration Object
    .DESCRIPTION
        Unset Application Firewall configuration Object 
   .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
   .PARAMETER comment 
       Any comments to preserve information about the policy for later reference. 
   .PARAMETER logaction 
       Where to log information for connections that match this policy.
    .EXAMPLE
        Invoke-ADCUnsetAppfwpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy
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

        [Boolean]$comment ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppfwpolicy: Finished"
    }
}

function Invoke-ADCRenameAppfwpolicy {
<#
    .SYNOPSIS
        Rename Application Firewall configuration Object
    .DESCRIPTION
        Rename Application Firewall configuration Object 
    .PARAMETER name 
        Name for the policy.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER newname 
        New name for the policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        Invoke-ADCRenameAppfwpolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppfwpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appfwpolicy", "Rename Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppfwpolicy: Finished"
    }
}

function Invoke-ADCGetAppfwpolicy {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name for the policy.  
       Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicy
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicy -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicy: Ended"
    }
}

function Invoke-ADCAddAppfwpolicylabel {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER policylabeltype 
        Type of transformations allowed by the policies bound to the label. Always http_req for application firewall policy labels.  
        Possible values = http_req 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel item.
    .EXAMPLE
        Invoke-ADCAddAppfwpolicylabel -labelname <string> -policylabeltype <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        [ValidateSet('http_req')]
        [string]$policylabeltype ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                policylabeltype = $policylabeltype
            }

 
            if ($PSCmdlet.ShouldProcess("appfwpolicylabel", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteAppfwpolicylabel {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER labelname 
       Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .EXAMPLE
        Invoke-ADCDeleteAppfwpolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabel: Finished"
    }
}

function Invoke-ADCRenameAppfwpolicylabel {
<#
    .SYNOPSIS
        Rename Application Firewall configuration Object
    .DESCRIPTION
        Rename Application Firewall configuration Object 
    .PARAMETER labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER newname 
        The new name of the application firewall policylabel.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameAppfwpolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAppfwpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCRenameAppfwpolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("appfwpolicylabel", "Rename Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabel -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameAppfwpolicylabel: Finished"
    }
}

function Invoke-ADCGetAppfwpolicylabel {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER labelname 
       Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER GetAll 
        Retreive all appfwpolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabel
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabel
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicylabel: Ended"
    }
}

function Invoke-ADCAddAppfwpolicylabelappfwpolicybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER labelname 
        Name of the application firewall policy label. 
    .PARAMETER policyname 
        Name of the application firewall policy to bind to the policy label. 
    .PARAMETER priority 
        Positive integer specifying the priority of the policy. A lower number specifies a higher priority. Must be unique within a group of policies that are bound to the same bind point or label. Policies are evaluated in the order of their priority numbers. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label.  
        Possible values = reqvserver, policylabel 
    .PARAMETER invoke_labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel_appfwpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwpolicylabelappfwpolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicylabelappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicylabelappfwpolicybinding: Starting"
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
 
            if ($PSCmdlet.ShouldProcess("appfwpolicylabel_appfwpolicy_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwpolicylabel_appfwpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwpolicylabelappfwpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER labelname 
       Name of the application firewall policy label.    .PARAMETER policyname 
       Name of the application firewall policy to bind to the policy label.    .PARAMETER priority 
       Positive integer specifying the priority of the policy. A lower number specifies a higher priority. Must be unique within a group of policies that are bound to the same bind point or label. Policies are evaluated in the order of their priority numbers.
    .EXAMPLE
        Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding: Finished"
    }
}

function Invoke-ADCGetAppfwpolicylabelappfwpolicybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER labelname 
       Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retreive all appfwpolicylabel_appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelappfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelappfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicylabel_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelappfwpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicylabelbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER labelname 
       Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retreive all appfwpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicylabelpolicybindingbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER labelname 
       Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retreive all appfwpolicylabel_policybinding_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_policybinding_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelpolicybindingbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelpolicybindingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicyappfwglobalbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy_appfwglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy_appfwglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicyappfwglobalbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicyappfwglobalbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicyappfwglobalbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwglobalbinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy_appfwpolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy_appfwpolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_appfwpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicy_appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicybinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicycsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetAppfwpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the policy. 
    .PARAMETER GetAll 
        Retreive all appfwpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofile {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER defaults 
        Default configuration to apply to the profile. Basic defaults are intended for standard content that requires little further configuration, such as static web site content. Advanced defaults are intended for specialized content that requires significant specialized configuration, such as heavily scripted or dynamic content.  
        CLI users: When adding an application firewall profile, you can set either the defaults or the type, but not both. To set both options, create the profile by using the add appfw profile command, and then use the set appfw profile command to configure the other option.  
        Possible values = basic, advanced 
    .PARAMETER starturlaction 
        One or more Start URL actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER infercontenttypexmlpayloadaction 
        One or more infer content type payload actions. Available settings function as follows:  
        * Block - Block connections that have mismatch in content-type header and payload.  
        * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request.  
        * Stats - Generate statistics when there is mismatch in content-type header and payload.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type.  
        Possible values = block, log, stats, none 
    .PARAMETER contenttypeaction 
        One or more Content-type actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER inspectcontenttypes 
        One or more InspectContentType lists.  
        * application/x-www-form-urlencoded  
        * multipart/form-data  
        * text/x-gwt-rpc  
        CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected.  
        Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
    .PARAMETER starturlclosure 
        Toggle the state of Start URL Closure.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER denyurlaction 
        One or more Deny URL actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check.  
        CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none".  
        Possible values = none, block, log, stats 
    .PARAMETER refererheadercheck 
        Enable validation of Referer headers.  
        Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker.  
        Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks.  
        Default value: OFF  
        Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
    .PARAMETER cookieconsistencyaction 
        One or more Cookie Consistency actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER cookiehijackingaction 
        One or more actions to prevent cookie hijacking. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        NOTE: Cookie Hijacking feature is not supported for TLSv1.3  
        CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none".  
        Default value: none  
        Possible values = none, block, log, stats 
    .PARAMETER cookietransforms 
        Perform the specified type of cookie transformation.  
        Available settings function as follows:  
        * Encryption - Encrypt cookies.  
        * Proxying - Mask contents of server cookies by sending proxy cookie to users.  
        * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER cookieencryption 
        Type of cookie encryption. Available settings function as follows:  
        * None - Do not encrypt cookies.  
        * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies.  
        * Encrypt Session Only - Encrypt session cookies, but not permanent cookies.  
        * Encrypt All - Encrypt all cookies.  
        Default value: none  
        Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
    .PARAMETER cookieproxying 
        Cookie proxy setting. Available settings function as follows:  
        * None - Do not proxy cookies.  
        * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies.  
        Default value: none  
        Possible values = none, sessionOnly 
    .PARAMETER addcookieflags 
        Add the specified flags to cookies. Available settings function as follows:  
        * None - Do not add flags to cookies.  
        * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies.  
        * Secure - Add Secure flag to cookies.  
        * All - Add both HTTPOnly and Secure flags to cookies.  
        Default value: none  
        Possible values = none, httpOnly, secure, all 
    .PARAMETER fieldconsistencyaction 
        One or more Form Field Consistency actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER csrftagaction 
        One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER crosssitescriptingaction 
        One or more Cross-Site Scripting (XSS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER crosssitescriptingtransformunsafehtml 
        Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER crosssitescriptingcheckcompleteurls 
        Check complete URLs for cross-site scripts, instead of just the query portions of URLs.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectionaction 
        One or more HTML SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER cmdinjectionaction 
        Command injection action. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none".  
        Default value: none  
        Possible values = none, block, log, stats 
    .PARAMETER cmdinjectiontype 
        Available CMD injection types.  
        -CMDSplChar : Checks for CMD Special Chars  
        -CMDKeyword : Checks for CMD Keywords  
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found  
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: CMDSplCharANDKeyword  
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER sqlinjectiontransformspecialchars 
        Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special strings (characters) for injected SQL code.  
        Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER sqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER fieldformataction 
        One or more Field Format actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER defaultfieldformattype 
        Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them.  
        Minimum length = 1 
    .PARAMETER defaultfieldformatminlength 
        Minimum length, in characters, for data entered into a field that is assigned the default field type.  
        To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0).  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER defaultfieldformatmaxlength 
        Maximum length, in characters, for data entered into a field that is assigned the default field type.  
        Default value: 65535  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER bufferoverflowaction 
        One or more Buffer Overflow actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER bufferoverflowmaxurllength 
        Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked.  
        Default value: 1024  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxheaderlength 
        Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked.  
        Default value: 4096  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxcookielength 
        Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked.  
        Default value: 4096  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxquerylength 
        Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked.  
        Default value: 1024  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxtotalheaderlength 
        Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked.  
        Default value: 24820  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER creditcardaction 
        One or more Credit Card actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER creditcard 
        Credit card types that the application firewall should protect.  
        Default value: none  
        Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
    .PARAMETER creditcardmaxallowed 
        This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked.  
        Minimum value = 0  
        Maximum value = 255 
    .PARAMETER creditcardxout 
        Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.".  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER dosecurecreditcardlogging 
        Setting this option logs credit card numbers in the response when the match is found.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER streaming 
        Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging is enabled. Please make sure that the backend server accepts chunked requests before enabling this option.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trace 
        Toggle the state of trace.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER requestcontenttype 
        Default Content-Type header for requests.  
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER responsecontenttype 
        Default Content-Type header for responses.  
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER jsonerrorobject 
        Name to the imported JSON Error Object to be set on application firewall profile. 
    .PARAMETER jsondosaction 
        One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER jsonsqlinjectionaction 
        One or more JSON SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER jsonsqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER jsonxssaction 
        One or more JSON Cross-Site Scripting actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmldosaction 
        One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlformataction 
        One or more XML Format actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlsqlinjectionaction 
        One or more XML SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlsqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER xmlsqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER xmlsqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER xmlsqlinjectionparsecomments 
        Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
        * Check all - Check all content.  
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
        * ANSI Nested - Exempt content that is part of any type of comment.  
        Default value: checkall  
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER xmlxssaction 
        One or more XML Cross-Site Scripting actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlwsiaction 
        One or more Web Services Interoperability (WSI) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlattachmentaction 
        One or more XML Attachment actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlvalidationaction 
        One or more XML Validation actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlerrorobject 
        Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
    .PARAMETER customsettings 
        Object name for custom settings.  
        This check is applicable to Profile Type: HTML, XML. .  
        Minimum length = 1 
    .PARAMETER signatures 
        Object name for signatures.  
        This check is applicable to Profile Type: HTML, XML. .  
        Minimum length = 1 
    .PARAMETER xmlsoapfaultaction 
        One or more XML SOAP Fault Filtering actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        * Remove - Remove all violations for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none".  
        Possible values = none, block, log, remove, stats 
    .PARAMETER usehtmlerrorobject 
        Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER errorurl 
        URL that application firewall uses as the Error URL.  
        Minimum length = 1 
    .PARAMETER htmlerrorobject 
        Name to assign to the HTML Error Object.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
    .PARAMETER logeverypolicyhit 
        Log every profile match, regardless of security checks results.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER stripcomments 
        Strip HTML comments.  
        This check is applicable to Profile Type: HTML. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER striphtmlcomments 
        Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request.  
        Default value: none  
        Possible values = none, all, exclude_script_tag 
    .PARAMETER stripxmlcomments 
        Strip XML comments before forwarding a web page sent by a protected web site in response to a user request.  
        Default value: none  
        Possible values = none, all 
    .PARAMETER exemptclosureurlsfromsecuritychecks 
        Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER defaultcharset 
        Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are:  
        * iso-8859-1 (English US)  
        * big5 (Chinese Traditional)  
        * gb2312 (Chinese Simplified)  
        * sjis (Japanese Shift-JIS)  
        * euc-jp (Japanese EUC-JP)  
        * iso-8859-9 (Turkish)  
        * utf-8 (Unicode)  
        * euc-kr (Korean).  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER dynamiclearning 
        One or more security checks. Available options are as follows:  
        * SQLInjection - Enable dynamic learning for SQLInjection security check.  
        * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check.  
        * fieldFormat - Enable dynamic learning for fieldFormat security check.  
        * None - Disable security checks for all security checks.  
        CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none".  
        Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
    .PARAMETER postbodylimit 
        Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB.  
        Default value: 20000000 
    .PARAMETER postbodylimitaction 
        One or more Post Body Limit actions. Available settings function as follows:  
        * Block - Block connections that violate this security check. Must always be set.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled.  
        Possible values = block, log, stats 
    .PARAMETER postbodylimitsignature 
        Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile.  
        Default value: 2048 
    .PARAMETER fileuploadmaxnum 
        Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads.  
        Default value: 65535  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER canonicalizehtmlresponse 
        Perform HTML entity encoding for any special characters in responses sent by your protected web sites.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER enableformtagging 
        Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER sessionlessfieldconsistency 
        Perform sessionless Field Consistency Checks.  
        Default value: OFF  
        Possible values = OFF, ON, postOnly 
    .PARAMETER sessionlessurlclosure 
        Enable session less URL Closure Checks.  
        This check is applicable to Profile Type: HTML. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER semicolonfieldseparator 
        Allow ';' as a form field separator in URL queries and POST form bodies. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER excludefileuploadfromchecks 
        Exclude uploaded files from Form checks.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectionparsecomments 
        Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
        * Check all - Check all content.  
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
        * ANSI Nested - Exempt content that is part of any type of comment.  
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER invalidpercenthandling 
        Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows:  
        * apache_mode - Apache format.  
        * asp_mode - Microsoft ASP format.  
        * secure_mode - Secure format.  
        Default value: secure_mode  
        Possible values = apache_mode, asp_mode, secure_mode 
    .PARAMETER type 
        Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows:  
        * HTML - HTML-based web sites.  
        * XML - XML-based web sites and services.  
        * JSON - JSON-based web sites and services.  
        * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds.  
        * HTML JSON - Sites that contain both HTML and JSON content.  
        * XML JSON - Sites that contain both XML and JSON content.  
        * HTML XML JSON - Sites that contain HTML, XML and JSON content.  
        Default value: HTML  
        Possible values = HTML, XML, JSON 
    .PARAMETER checkrequestheaders 
        Check request headers as well as web forms for injected SQL and cross-site scripts.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER inspectquerycontenttypes 
        Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types.  
        Possible values = HTML, XML, JSON, OTHER 
    .PARAMETER optimizepartialreqs 
        Optimize handle of HTTP partial requests i.e. those with range headers.  
        Available settings are as follows:  
        * ON - Partial requests by the client result in partial requests to the backend server in most cases.  
        * OFF - Partial requests by the client are changed to full requests to the backend server.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER urldecoderequestcookies 
        URL Decode request cookies before subjecting them to SQL and cross-site scripting checks.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER percentdecoderecursively 
        Configure whether the application firewall should use percentage recursive decoding.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER multipleheaderaction 
        One or more multiple header actions. Available settings function as follows:  
        * Block - Block connections that have multiple headers.  
        * Log - Log connections that have multiple headers.  
        * KeepLast - Keep only last header when multiple headers are present.  
        CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled.  
        Possible values = block, keepLast, log, none 
    .PARAMETER rfcprofile 
        Object name of the rfc profile.  
        Minimum length = 1 
    .PARAMETER fileuploadtypesaction 
        One or more file upload types actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER verboseloglevel 
        Detailed Logging Verbose Log Level.  
        Default value: pattern  
        Possible values = pattern, patternPayload, patternPayloadHeader 
    .PARAMETER PassThru 
        Return details about the created appfwprofile item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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

        [ValidateSet('basic', 'advanced')]
        [string]$defaults ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$starturlaction ,

        [ValidateSet('block', 'log', 'stats', 'none')]
        [string[]]$infercontenttypexmlpayloadaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$contenttypeaction ,

        [ValidateSet('none', 'application/x-www-form-urlencoded', 'multipart/form-data', 'text/x-gwt-rpc')]
        [string[]]$inspectcontenttypes ,

        [ValidateSet('ON', 'OFF')]
        [string]$starturlclosure = 'OFF' ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$denyurlaction ,

        [ValidateSet('OFF', 'if_present', 'AlwaysExceptStartURLs', 'AlwaysExceptFirstRequest')]
        [string]$refererheadercheck = 'OFF' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$cookieconsistencyaction = 'none' ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$cookiehijackingaction = 'none' ,

        [ValidateSet('ON', 'OFF')]
        [string]$cookietransforms = 'OFF' ,

        [ValidateSet('none', 'decryptOnly', 'encryptSessionOnly', 'encryptAll')]
        [string]$cookieencryption = 'none' ,

        [ValidateSet('none', 'sessionOnly')]
        [string]$cookieproxying = 'none' ,

        [ValidateSet('none', 'httpOnly', 'secure', 'all')]
        [string]$addcookieflags = 'none' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$fieldconsistencyaction = 'none' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$csrftagaction = 'none' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$crosssitescriptingaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$crosssitescriptingtransformunsafehtml = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$crosssitescriptingcheckcompleteurls = 'OFF' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$sqlinjectionaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$cmdinjectionaction = 'none' ,

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$cmdinjectiontype = 'CMDSplCharANDKeyword' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectiontransformspecialchars = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectiononlycheckfieldswithsqlchars = 'ON' ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$sqlinjectiontype = 'SQLSplCharANDKeyword' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectionchecksqlwildchars = 'OFF' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$fieldformataction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$defaultfieldformattype ,

        [ValidateRange(0, 2147483647)]
        [double]$defaultfieldformatminlength = '0' ,

        [ValidateRange(1, 2147483647)]
        [double]$defaultfieldformatmaxlength = '65535' ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$bufferoverflowaction ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxurllength = '1024' ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxheaderlength = '4096' ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxcookielength = '4096' ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxquerylength = '1024' ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxtotalheaderlength = '24820' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$creditcardaction = 'none' ,

        [ValidateSet('none', 'visa', 'mastercard', 'discover', 'amex', 'jcb', 'dinersclub')]
        [string[]]$creditcard = 'none' ,

        [ValidateRange(0, 255)]
        [double]$creditcardmaxallowed ,

        [ValidateSet('ON', 'OFF')]
        [string]$creditcardxout = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$dosecurecreditcardlogging = 'ON' ,

        [ValidateSet('ON', 'OFF')]
        [string]$streaming = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$trace = 'OFF' ,

        [ValidateLength(1, 255)]
        [string]$requestcontenttype ,

        [ValidateLength(1, 255)]
        [string]$responsecontenttype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$jsonerrorobject ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsondosaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsonsqlinjectionaction ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$jsonsqlinjectiontype = 'SQLSplCharANDKeyword' ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsonxssaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmldosaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlformataction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlsqlinjectionaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlsqlinjectiononlycheckfieldswithsqlchars = 'ON' ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$xmlsqlinjectiontype = 'SQLSplCharANDKeyword' ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlsqlinjectionchecksqlwildchars = 'OFF' ,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$xmlsqlinjectionparsecomments = 'checkall' ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlxssaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlwsiaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlattachmentaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlvalidationaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$xmlerrorobject ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$customsettings ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signatures ,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats')]
        [string[]]$xmlsoapfaultaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$usehtmlerrorobject = 'OFF' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$errorurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$htmlerrorobject ,

        [ValidateSet('ON', 'OFF')]
        [string]$logeverypolicyhit = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$stripcomments = 'OFF' ,

        [ValidateSet('none', 'all', 'exclude_script_tag')]
        [string]$striphtmlcomments = 'none' ,

        [ValidateSet('none', 'all')]
        [string]$stripxmlcomments = 'none' ,

        [ValidateSet('ON', 'OFF')]
        [string]$exemptclosureurlsfromsecuritychecks = 'ON' ,

        [ValidateLength(1, 31)]
        [string]$defaultcharset ,

        [ValidateSet('none', 'SQLInjection', 'CrossSiteScripting', 'fieldFormat', 'startURL', 'cookieConsistency', 'fieldConsistency', 'CSRFtag', 'ContentType')]
        [string[]]$dynamiclearning ,

        [double]$postbodylimit = '20000000' ,

        [ValidateSet('block', 'log', 'stats')]
        [string[]]$postbodylimitaction ,

        [double]$postbodylimitsignature = '2048' ,

        [ValidateRange(0, 65535)]
        [double]$fileuploadmaxnum = '65535' ,

        [ValidateSet('ON', 'OFF')]
        [string]$canonicalizehtmlresponse = 'ON' ,

        [ValidateSet('ON', 'OFF')]
        [string]$enableformtagging = 'ON' ,

        [ValidateSet('OFF', 'ON', 'postOnly')]
        [string]$sessionlessfieldconsistency = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$sessionlessurlclosure = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$semicolonfieldseparator = 'OFF' ,

        [ValidateSet('ON', 'OFF')]
        [string]$excludefileuploadfromchecks = 'OFF' ,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$sqlinjectionparsecomments ,

        [ValidateSet('apache_mode', 'asp_mode', 'secure_mode')]
        [string]$invalidpercenthandling = 'secure_mode' ,

        [ValidateSet('HTML', 'XML', 'JSON')]
        [string[]]$type = 'HTML' ,

        [ValidateSet('ON', 'OFF')]
        [string]$checkrequestheaders = 'OFF' ,

        [ValidateSet('HTML', 'XML', 'JSON', 'OTHER')]
        [string[]]$inspectquerycontenttypes ,

        [ValidateSet('ON', 'OFF')]
        [string]$optimizepartialreqs = 'ON' ,

        [ValidateSet('ON', 'OFF')]
        [string]$urldecoderequestcookies = 'OFF' ,

        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$percentdecoderecursively = 'ON' ,

        [ValidateSet('block', 'keepLast', 'log', 'none')]
        [string[]]$multipleheaderaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rfcprofile ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$fileuploadtypesaction ,

        [ValidateSet('pattern', 'patternPayload', 'patternPayloadHeader')]
        [string]$verboseloglevel = 'pattern' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('defaults')) { $Payload.Add('defaults', $defaults) }
            if ($PSBoundParameters.ContainsKey('starturlaction')) { $Payload.Add('starturlaction', $starturlaction) }
            if ($PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction')) { $Payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ($PSBoundParameters.ContainsKey('contenttypeaction')) { $Payload.Add('contenttypeaction', $contenttypeaction) }
            if ($PSBoundParameters.ContainsKey('inspectcontenttypes')) { $Payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ($PSBoundParameters.ContainsKey('starturlclosure')) { $Payload.Add('starturlclosure', $starturlclosure) }
            if ($PSBoundParameters.ContainsKey('denyurlaction')) { $Payload.Add('denyurlaction', $denyurlaction) }
            if ($PSBoundParameters.ContainsKey('refererheadercheck')) { $Payload.Add('refererheadercheck', $refererheadercheck) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyaction')) { $Payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('cookiehijackingaction')) { $Payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ($PSBoundParameters.ContainsKey('cookietransforms')) { $Payload.Add('cookietransforms', $cookietransforms) }
            if ($PSBoundParameters.ContainsKey('cookieencryption')) { $Payload.Add('cookieencryption', $cookieencryption) }
            if ($PSBoundParameters.ContainsKey('cookieproxying')) { $Payload.Add('cookieproxying', $cookieproxying) }
            if ($PSBoundParameters.ContainsKey('addcookieflags')) { $Payload.Add('addcookieflags', $addcookieflags) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyaction')) { $Payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('csrftagaction')) { $Payload.Add('csrftagaction', $csrftagaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingaction')) { $Payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml')) { $Payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls')) { $Payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionaction')) { $Payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectionaction')) { $Payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectiontype')) { $Payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars')) { $Payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontype')) { $Payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars')) { $Payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('fieldformataction')) { $Payload.Add('fieldformataction', $fieldformataction) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformattype')) { $Payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatminlength')) { $Payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatmaxlength')) { $Payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowaction')) { $Payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxurllength')) { $Payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength')) { $Payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength')) { $Payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength')) { $Payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength')) { $Payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ($PSBoundParameters.ContainsKey('creditcardaction')) { $Payload.Add('creditcardaction', $creditcardaction) }
            if ($PSBoundParameters.ContainsKey('creditcard')) { $Payload.Add('creditcard', $creditcard) }
            if ($PSBoundParameters.ContainsKey('creditcardmaxallowed')) { $Payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ($PSBoundParameters.ContainsKey('creditcardxout')) { $Payload.Add('creditcardxout', $creditcardxout) }
            if ($PSBoundParameters.ContainsKey('dosecurecreditcardlogging')) { $Payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ($PSBoundParameters.ContainsKey('streaming')) { $Payload.Add('streaming', $streaming) }
            if ($PSBoundParameters.ContainsKey('trace')) { $Payload.Add('trace', $trace) }
            if ($PSBoundParameters.ContainsKey('requestcontenttype')) { $Payload.Add('requestcontenttype', $requestcontenttype) }
            if ($PSBoundParameters.ContainsKey('responsecontenttype')) { $Payload.Add('responsecontenttype', $responsecontenttype) }
            if ($PSBoundParameters.ContainsKey('jsonerrorobject')) { $Payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ($PSBoundParameters.ContainsKey('jsondosaction')) { $Payload.Add('jsondosaction', $jsondosaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectionaction')) { $Payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectiontype')) { $Payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('jsonxssaction')) { $Payload.Add('jsonxssaction', $jsonxssaction) }
            if ($PSBoundParameters.ContainsKey('xmldosaction')) { $Payload.Add('xmldosaction', $xmldosaction) }
            if ($PSBoundParameters.ContainsKey('xmlformataction')) { $Payload.Add('xmlformataction', $xmlformataction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionaction')) { $Payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiontype')) { $Payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars')) { $Payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments')) { $Payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('xmlxssaction')) { $Payload.Add('xmlxssaction', $xmlxssaction) }
            if ($PSBoundParameters.ContainsKey('xmlwsiaction')) { $Payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentaction')) { $Payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ($PSBoundParameters.ContainsKey('xmlvalidationaction')) { $Payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ($PSBoundParameters.ContainsKey('xmlerrorobject')) { $Payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('customsettings')) { $Payload.Add('customsettings', $customsettings) }
            if ($PSBoundParameters.ContainsKey('signatures')) { $Payload.Add('signatures', $signatures) }
            if ($PSBoundParameters.ContainsKey('xmlsoapfaultaction')) { $Payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ($PSBoundParameters.ContainsKey('usehtmlerrorobject')) { $Payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('htmlerrorobject')) { $Payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('logeverypolicyhit')) { $Payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ($PSBoundParameters.ContainsKey('stripcomments')) { $Payload.Add('stripcomments', $stripcomments) }
            if ($PSBoundParameters.ContainsKey('striphtmlcomments')) { $Payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ($PSBoundParameters.ContainsKey('stripxmlcomments')) { $Payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ($PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks')) { $Payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ($PSBoundParameters.ContainsKey('defaultcharset')) { $Payload.Add('defaultcharset', $defaultcharset) }
            if ($PSBoundParameters.ContainsKey('dynamiclearning')) { $Payload.Add('dynamiclearning', $dynamiclearning) }
            if ($PSBoundParameters.ContainsKey('postbodylimit')) { $Payload.Add('postbodylimit', $postbodylimit) }
            if ($PSBoundParameters.ContainsKey('postbodylimitaction')) { $Payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ($PSBoundParameters.ContainsKey('postbodylimitsignature')) { $Payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ($PSBoundParameters.ContainsKey('fileuploadmaxnum')) { $Payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ($PSBoundParameters.ContainsKey('canonicalizehtmlresponse')) { $Payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ($PSBoundParameters.ContainsKey('enableformtagging')) { $Payload.Add('enableformtagging', $enableformtagging) }
            if ($PSBoundParameters.ContainsKey('sessionlessfieldconsistency')) { $Payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ($PSBoundParameters.ContainsKey('sessionlessurlclosure')) { $Payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ($PSBoundParameters.ContainsKey('semicolonfieldseparator')) { $Payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ($PSBoundParameters.ContainsKey('excludefileuploadfromchecks')) { $Payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionparsecomments')) { $Payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('invalidpercenthandling')) { $Payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('checkrequestheaders')) { $Payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ($PSBoundParameters.ContainsKey('inspectquerycontenttypes')) { $Payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ($PSBoundParameters.ContainsKey('optimizepartialreqs')) { $Payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ($PSBoundParameters.ContainsKey('urldecoderequestcookies')) { $Payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('percentdecoderecursively')) { $Payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ($PSBoundParameters.ContainsKey('multipleheaderaction')) { $Payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ($PSBoundParameters.ContainsKey('rfcprofile')) { $Payload.Add('rfcprofile', $rfcprofile) }
            if ($PSBoundParameters.ContainsKey('fileuploadtypesaction')) { $Payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ($PSBoundParameters.ContainsKey('verboseloglevel')) { $Payload.Add('verboseloglevel', $verboseloglevel) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofile: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofile {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofile: Finished"
    }
}

function Invoke-ADCUpdateAppfwprofile {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER starturlaction 
        One or more Start URL actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER infercontenttypexmlpayloadaction 
        One or more infer content type payload actions. Available settings function as follows:  
        * Block - Block connections that have mismatch in content-type header and payload.  
        * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request.  
        * Stats - Generate statistics when there is mismatch in content-type header and payload.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type.  
        Possible values = block, log, stats, none 
    .PARAMETER contenttypeaction 
        One or more Content-type actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER inspectcontenttypes 
        One or more InspectContentType lists.  
        * application/x-www-form-urlencoded  
        * multipart/form-data  
        * text/x-gwt-rpc  
        CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected.  
        Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
    .PARAMETER starturlclosure 
        Toggle the state of Start URL Closure.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER denyurlaction 
        One or more Deny URL actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check.  
        CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none".  
        Possible values = none, block, log, stats 
    .PARAMETER refererheadercheck 
        Enable validation of Referer headers.  
        Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker.  
        Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks.  
        Default value: OFF  
        Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
    .PARAMETER cookieconsistencyaction 
        One or more Cookie Consistency actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER cookiehijackingaction 
        One or more actions to prevent cookie hijacking. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        NOTE: Cookie Hijacking feature is not supported for TLSv1.3  
        CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none".  
        Default value: none  
        Possible values = none, block, log, stats 
    .PARAMETER cookietransforms 
        Perform the specified type of cookie transformation.  
        Available settings function as follows:  
        * Encryption - Encrypt cookies.  
        * Proxying - Mask contents of server cookies by sending proxy cookie to users.  
        * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER cookieencryption 
        Type of cookie encryption. Available settings function as follows:  
        * None - Do not encrypt cookies.  
        * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies.  
        * Encrypt Session Only - Encrypt session cookies, but not permanent cookies.  
        * Encrypt All - Encrypt all cookies.  
        Default value: none  
        Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
    .PARAMETER cookieproxying 
        Cookie proxy setting. Available settings function as follows:  
        * None - Do not proxy cookies.  
        * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies.  
        Default value: none  
        Possible values = none, sessionOnly 
    .PARAMETER addcookieflags 
        Add the specified flags to cookies. Available settings function as follows:  
        * None - Do not add flags to cookies.  
        * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies.  
        * Secure - Add Secure flag to cookies.  
        * All - Add both HTTPOnly and Secure flags to cookies.  
        Default value: none  
        Possible values = none, httpOnly, secure, all 
    .PARAMETER fieldconsistencyaction 
        One or more Form Field Consistency actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER csrftagaction 
        One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER crosssitescriptingaction 
        One or more Cross-Site Scripting (XSS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER crosssitescriptingtransformunsafehtml 
        Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER crosssitescriptingcheckcompleteurls 
        Check complete URLs for cross-site scripts, instead of just the query portions of URLs.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectionaction 
        One or more HTML SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER cmdinjectionaction 
        Command injection action. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none".  
        Default value: none  
        Possible values = none, block, log, stats 
    .PARAMETER cmdinjectiontype 
        Available CMD injection types.  
        -CMDSplChar : Checks for CMD Special Chars  
        -CMDKeyword : Checks for CMD Keywords  
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found  
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: CMDSplCharANDKeyword  
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER sqlinjectiontransformspecialchars 
        Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled.  
        CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special strings (characters) for injected SQL code.  
        Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER sqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER fieldformataction 
        One or more Field Format actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER defaultfieldformattype 
        Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them.  
        Minimum length = 1 
    .PARAMETER defaultfieldformatminlength 
        Minimum length, in characters, for data entered into a field that is assigned the default field type.  
        To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0).  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER defaultfieldformatmaxlength 
        Maximum length, in characters, for data entered into a field that is assigned the default field type.  
        Default value: 65535  
        Minimum value = 1  
        Maximum value = 2147483647 
    .PARAMETER bufferoverflowaction 
        One or more Buffer Overflow actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER bufferoverflowmaxurllength 
        Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked.  
        Default value: 1024  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxheaderlength 
        Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked.  
        Default value: 4096  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxcookielength 
        Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked.  
        Default value: 4096  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxquerylength 
        Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked.  
        Default value: 1024  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER bufferoverflowmaxtotalheaderlength 
        Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked.  
        Default value: 24820  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER creditcardaction 
        One or more Credit Card actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none".  
        Default value: none  
        Possible values = none, block, learn, log, stats 
    .PARAMETER creditcard 
        Credit card types that the application firewall should protect.  
        Default value: none  
        Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
    .PARAMETER creditcardmaxallowed 
        This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked.  
        Minimum value = 0  
        Maximum value = 255 
    .PARAMETER creditcardxout 
        Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.".  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER dosecurecreditcardlogging 
        Setting this option logs credit card numbers in the response when the match is found.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER streaming 
        Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging is enabled. Please make sure that the backend server accepts chunked requests before enabling this option.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER trace 
        Toggle the state of trace.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER requestcontenttype 
        Default Content-Type header for requests.  
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER responsecontenttype 
        Default Content-Type header for responses.  
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters.  
        Minimum length = 1  
        Maximum length = 255 
    .PARAMETER jsonerrorobject 
        Name to the imported JSON Error Object to be set on application firewall profile. 
    .PARAMETER jsondosaction 
        One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER jsonsqlinjectionaction 
        One or more JSON SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER jsonsqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER jsonxssaction 
        One or more JSON Cross-Site Scripting actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmldosaction 
        One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlformataction 
        One or more XML Format actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlsqlinjectionaction 
        One or more XML SQL Injection actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlsqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER xmlsqlinjectiontype 
        Available SQL injection types.  
        -SQLSplChar : Checks for SQL Special Chars  
        -SQLKeyword : Checks for SQL Keywords  
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
        Default value: SQLSplCharANDKeyword  
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
    .PARAMETER xmlsqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER xmlsqlinjectionparsecomments 
        Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
        * Check all - Check all content.  
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
        * ANSI Nested - Exempt content that is part of any type of comment.  
        Default value: checkall  
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER xmlxssaction 
        One or more XML Cross-Site Scripting actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlwsiaction 
        One or more Web Services Interoperability (WSI) actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlattachmentaction 
        One or more XML Attachment actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Learn - Use the learning engine to generate a list of exceptions to this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none".  
        Possible values = none, block, learn, log, stats 
    .PARAMETER xmlvalidationaction 
        One or more XML Validation actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER xmlerrorobject 
        Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
    .PARAMETER customsettings 
        Object name for custom settings.  
        This check is applicable to Profile Type: HTML, XML. .  
        Minimum length = 1 
    .PARAMETER signatures 
        Object name for signatures.  
        This check is applicable to Profile Type: HTML, XML. .  
        Minimum length = 1 
    .PARAMETER xmlsoapfaultaction 
        One or more XML SOAP Fault Filtering actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        * Remove - Remove all violations for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none".  
        Possible values = none, block, log, remove, stats 
    .PARAMETER usehtmlerrorobject 
        Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER errorurl 
        URL that application firewall uses as the Error URL.  
        Minimum length = 1 
    .PARAMETER htmlerrorobject 
        Name to assign to the HTML Error Object.  
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
    .PARAMETER logeverypolicyhit 
        Log every profile match, regardless of security checks results.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER stripcomments 
        Strip HTML comments.  
        This check is applicable to Profile Type: HTML. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER striphtmlcomments 
        Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request.  
        Default value: none  
        Possible values = none, all, exclude_script_tag 
    .PARAMETER stripxmlcomments 
        Strip XML comments before forwarding a web page sent by a protected web site in response to a user request.  
        Default value: none  
        Possible values = none, all 
    .PARAMETER dynamiclearning 
        One or more security checks. Available options are as follows:  
        * SQLInjection - Enable dynamic learning for SQLInjection security check.  
        * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check.  
        * fieldFormat - Enable dynamic learning for fieldFormat security check.  
        * None - Disable security checks for all security checks.  
        CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none".  
        Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
    .PARAMETER exemptclosureurlsfromsecuritychecks 
        Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER defaultcharset 
        Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are:  
        * iso-8859-1 (English US)  
        * big5 (Chinese Traditional)  
        * gb2312 (Chinese Simplified)  
        * sjis (Japanese Shift-JIS)  
        * euc-jp (Japanese EUC-JP)  
        * iso-8859-9 (Turkish)  
        * utf-8 (Unicode)  
        * euc-kr (Korean).  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER postbodylimit 
        Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB.  
        Default value: 20000000 
    .PARAMETER postbodylimitaction 
        One or more Post Body Limit actions. Available settings function as follows:  
        * Block - Block connections that violate this security check. Must always be set.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled.  
        Possible values = block, log, stats 
    .PARAMETER postbodylimitsignature 
        Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile.  
        Default value: 2048 
    .PARAMETER fileuploadmaxnum 
        Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads.  
        Default value: 65535  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER canonicalizehtmlresponse 
        Perform HTML entity encoding for any special characters in responses sent by your protected web sites.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER enableformtagging 
        Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER sessionlessfieldconsistency 
        Perform sessionless Field Consistency Checks.  
        Default value: OFF  
        Possible values = OFF, ON, postOnly 
    .PARAMETER sessionlessurlclosure 
        Enable session less URL Closure Checks.  
        This check is applicable to Profile Type: HTML. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER semicolonfieldseparator 
        Allow ';' as a form field separator in URL queries and POST form bodies. .  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER excludefileuploadfromchecks 
        Exclude uploaded files from Form checks.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sqlinjectionparsecomments 
        Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
        * Check all - Check all content.  
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
        * ANSI Nested - Exempt content that is part of any type of comment.  
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER invalidpercenthandling 
        Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows:  
        * apache_mode - Apache format.  
        * asp_mode - Microsoft ASP format.  
        * secure_mode - Secure format.  
        Default value: secure_mode  
        Possible values = apache_mode, asp_mode, secure_mode 
    .PARAMETER type 
        Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows:  
        * HTML - HTML-based web sites.  
        * XML - XML-based web sites and services.  
        * JSON - JSON-based web sites and services.  
        * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds.  
        * HTML JSON - Sites that contain both HTML and JSON content.  
        * XML JSON - Sites that contain both XML and JSON content.  
        * HTML XML JSON - Sites that contain HTML, XML and JSON content.  
        Default value: HTML  
        Possible values = HTML, XML, JSON 
    .PARAMETER checkrequestheaders 
        Check request headers as well as web forms for injected SQL and cross-site scripts.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER inspectquerycontenttypes 
        Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types.  
        Possible values = HTML, XML, JSON, OTHER 
    .PARAMETER optimizepartialreqs 
        Optimize handle of HTTP partial requests i.e. those with range headers.  
        Available settings are as follows:  
        * ON - Partial requests by the client result in partial requests to the backend server in most cases.  
        * OFF - Partial requests by the client are changed to full requests to the backend server.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER urldecoderequestcookies 
        URL Decode request cookies before subjecting them to SQL and cross-site scripting checks.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER percentdecoderecursively 
        Configure whether the application firewall should use percentage recursive decoding.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER multipleheaderaction 
        One or more multiple header actions. Available settings function as follows:  
        * Block - Block connections that have multiple headers.  
        * Log - Log connections that have multiple headers.  
        * KeepLast - Keep only last header when multiple headers are present.  
        CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled.  
        Possible values = block, keepLast, log, none 
    .PARAMETER rfcprofile 
        Object name of the rfc profile.  
        Minimum length = 1 
    .PARAMETER fileuploadtypesaction 
        One or more file upload types actions. Available settings function as follows:  
        * Block - Block connections that violate this security check.  
        * Log - Log violations of this security check.  
        * Stats - Generate statistics for this security check.  
        * None - Disable all actions for this security check.  
        CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none".  
        Possible values = none, block, log, stats 
    .PARAMETER verboseloglevel 
        Detailed Logging Verbose Log Level.  
        Default value: pattern  
        Possible values = pattern, patternPayload, patternPayloadHeader 
    .PARAMETER PassThru 
        Return details about the created appfwprofile item.
    .EXAMPLE
        Invoke-ADCUpdateAppfwprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$starturlaction ,

        [ValidateSet('block', 'log', 'stats', 'none')]
        [string[]]$infercontenttypexmlpayloadaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$contenttypeaction ,

        [ValidateSet('none', 'application/x-www-form-urlencoded', 'multipart/form-data', 'text/x-gwt-rpc')]
        [string[]]$inspectcontenttypes ,

        [ValidateSet('ON', 'OFF')]
        [string]$starturlclosure ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$denyurlaction ,

        [ValidateSet('OFF', 'if_present', 'AlwaysExceptStartURLs', 'AlwaysExceptFirstRequest')]
        [string]$refererheadercheck ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$cookieconsistencyaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$cookiehijackingaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$cookietransforms ,

        [ValidateSet('none', 'decryptOnly', 'encryptSessionOnly', 'encryptAll')]
        [string]$cookieencryption ,

        [ValidateSet('none', 'sessionOnly')]
        [string]$cookieproxying ,

        [ValidateSet('none', 'httpOnly', 'secure', 'all')]
        [string]$addcookieflags ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$fieldconsistencyaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$csrftagaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$crosssitescriptingaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$crosssitescriptingtransformunsafehtml ,

        [ValidateSet('ON', 'OFF')]
        [string]$crosssitescriptingcheckcompleteurls ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$sqlinjectionaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$cmdinjectionaction ,

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$cmdinjectiontype ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectiontransformspecialchars ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectiononlycheckfieldswithsqlchars ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$sqlinjectiontype ,

        [ValidateSet('ON', 'OFF')]
        [string]$sqlinjectionchecksqlwildchars ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$fieldformataction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$defaultfieldformattype ,

        [ValidateRange(0, 2147483647)]
        [double]$defaultfieldformatminlength ,

        [ValidateRange(1, 2147483647)]
        [double]$defaultfieldformatmaxlength ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$bufferoverflowaction ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxurllength ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxheaderlength ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxcookielength ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxquerylength ,

        [ValidateRange(0, 65535)]
        [double]$bufferoverflowmaxtotalheaderlength ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$creditcardaction ,

        [ValidateSet('none', 'visa', 'mastercard', 'discover', 'amex', 'jcb', 'dinersclub')]
        [string[]]$creditcard ,

        [ValidateRange(0, 255)]
        [double]$creditcardmaxallowed ,

        [ValidateSet('ON', 'OFF')]
        [string]$creditcardxout ,

        [ValidateSet('ON', 'OFF')]
        [string]$dosecurecreditcardlogging ,

        [ValidateSet('ON', 'OFF')]
        [string]$streaming ,

        [ValidateSet('ON', 'OFF')]
        [string]$trace ,

        [ValidateLength(1, 255)]
        [string]$requestcontenttype ,

        [ValidateLength(1, 255)]
        [string]$responsecontenttype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$jsonerrorobject ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsondosaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsonsqlinjectionaction ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$jsonsqlinjectiontype ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$jsonxssaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmldosaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlformataction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlsqlinjectionaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlsqlinjectiononlycheckfieldswithsqlchars ,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword')]
        [string]$xmlsqlinjectiontype ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlsqlinjectionchecksqlwildchars ,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$xmlsqlinjectionparsecomments ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlxssaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlwsiaction ,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$xmlattachmentaction ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$xmlvalidationaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$xmlerrorobject ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$customsettings ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$signatures ,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats')]
        [string[]]$xmlsoapfaultaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$usehtmlerrorobject ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$errorurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$htmlerrorobject ,

        [ValidateSet('ON', 'OFF')]
        [string]$logeverypolicyhit ,

        [ValidateSet('ON', 'OFF')]
        [string]$stripcomments ,

        [ValidateSet('none', 'all', 'exclude_script_tag')]
        [string]$striphtmlcomments ,

        [ValidateSet('none', 'all')]
        [string]$stripxmlcomments ,

        [ValidateSet('none', 'SQLInjection', 'CrossSiteScripting', 'fieldFormat', 'startURL', 'cookieConsistency', 'fieldConsistency', 'CSRFtag', 'ContentType')]
        [string[]]$dynamiclearning ,

        [ValidateSet('ON', 'OFF')]
        [string]$exemptclosureurlsfromsecuritychecks ,

        [ValidateLength(1, 31)]
        [string]$defaultcharset ,

        [double]$postbodylimit ,

        [ValidateSet('block', 'log', 'stats')]
        [string[]]$postbodylimitaction ,

        [double]$postbodylimitsignature ,

        [ValidateRange(0, 65535)]
        [double]$fileuploadmaxnum ,

        [ValidateSet('ON', 'OFF')]
        [string]$canonicalizehtmlresponse ,

        [ValidateSet('ON', 'OFF')]
        [string]$enableformtagging ,

        [ValidateSet('OFF', 'ON', 'postOnly')]
        [string]$sessionlessfieldconsistency ,

        [ValidateSet('ON', 'OFF')]
        [string]$sessionlessurlclosure ,

        [ValidateSet('ON', 'OFF')]
        [string]$semicolonfieldseparator ,

        [ValidateSet('ON', 'OFF')]
        [string]$excludefileuploadfromchecks ,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$sqlinjectionparsecomments ,

        [ValidateSet('apache_mode', 'asp_mode', 'secure_mode')]
        [string]$invalidpercenthandling ,

        [ValidateSet('HTML', 'XML', 'JSON')]
        [string[]]$type ,

        [ValidateSet('ON', 'OFF')]
        [string]$checkrequestheaders ,

        [ValidateSet('HTML', 'XML', 'JSON', 'OTHER')]
        [string[]]$inspectquerycontenttypes ,

        [ValidateSet('ON', 'OFF')]
        [string]$optimizepartialreqs ,

        [ValidateSet('ON', 'OFF')]
        [string]$urldecoderequestcookies ,

        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$percentdecoderecursively ,

        [ValidateSet('block', 'keepLast', 'log', 'none')]
        [string[]]$multipleheaderaction ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$rfcprofile ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$fileuploadtypesaction ,

        [ValidateSet('pattern', 'patternPayload', 'patternPayloadHeader')]
        [string]$verboseloglevel ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('starturlaction')) { $Payload.Add('starturlaction', $starturlaction) }
            if ($PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction')) { $Payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ($PSBoundParameters.ContainsKey('contenttypeaction')) { $Payload.Add('contenttypeaction', $contenttypeaction) }
            if ($PSBoundParameters.ContainsKey('inspectcontenttypes')) { $Payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ($PSBoundParameters.ContainsKey('starturlclosure')) { $Payload.Add('starturlclosure', $starturlclosure) }
            if ($PSBoundParameters.ContainsKey('denyurlaction')) { $Payload.Add('denyurlaction', $denyurlaction) }
            if ($PSBoundParameters.ContainsKey('refererheadercheck')) { $Payload.Add('refererheadercheck', $refererheadercheck) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyaction')) { $Payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('cookiehijackingaction')) { $Payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ($PSBoundParameters.ContainsKey('cookietransforms')) { $Payload.Add('cookietransforms', $cookietransforms) }
            if ($PSBoundParameters.ContainsKey('cookieencryption')) { $Payload.Add('cookieencryption', $cookieencryption) }
            if ($PSBoundParameters.ContainsKey('cookieproxying')) { $Payload.Add('cookieproxying', $cookieproxying) }
            if ($PSBoundParameters.ContainsKey('addcookieflags')) { $Payload.Add('addcookieflags', $addcookieflags) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyaction')) { $Payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('csrftagaction')) { $Payload.Add('csrftagaction', $csrftagaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingaction')) { $Payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml')) { $Payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls')) { $Payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionaction')) { $Payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectionaction')) { $Payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectiontype')) { $Payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars')) { $Payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontype')) { $Payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars')) { $Payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('fieldformataction')) { $Payload.Add('fieldformataction', $fieldformataction) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformattype')) { $Payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatminlength')) { $Payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatmaxlength')) { $Payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowaction')) { $Payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxurllength')) { $Payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength')) { $Payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength')) { $Payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength')) { $Payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength')) { $Payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ($PSBoundParameters.ContainsKey('creditcardaction')) { $Payload.Add('creditcardaction', $creditcardaction) }
            if ($PSBoundParameters.ContainsKey('creditcard')) { $Payload.Add('creditcard', $creditcard) }
            if ($PSBoundParameters.ContainsKey('creditcardmaxallowed')) { $Payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ($PSBoundParameters.ContainsKey('creditcardxout')) { $Payload.Add('creditcardxout', $creditcardxout) }
            if ($PSBoundParameters.ContainsKey('dosecurecreditcardlogging')) { $Payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ($PSBoundParameters.ContainsKey('streaming')) { $Payload.Add('streaming', $streaming) }
            if ($PSBoundParameters.ContainsKey('trace')) { $Payload.Add('trace', $trace) }
            if ($PSBoundParameters.ContainsKey('requestcontenttype')) { $Payload.Add('requestcontenttype', $requestcontenttype) }
            if ($PSBoundParameters.ContainsKey('responsecontenttype')) { $Payload.Add('responsecontenttype', $responsecontenttype) }
            if ($PSBoundParameters.ContainsKey('jsonerrorobject')) { $Payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ($PSBoundParameters.ContainsKey('jsondosaction')) { $Payload.Add('jsondosaction', $jsondosaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectionaction')) { $Payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectiontype')) { $Payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('jsonxssaction')) { $Payload.Add('jsonxssaction', $jsonxssaction) }
            if ($PSBoundParameters.ContainsKey('xmldosaction')) { $Payload.Add('xmldosaction', $xmldosaction) }
            if ($PSBoundParameters.ContainsKey('xmlformataction')) { $Payload.Add('xmlformataction', $xmlformataction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionaction')) { $Payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiontype')) { $Payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars')) { $Payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments')) { $Payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('xmlxssaction')) { $Payload.Add('xmlxssaction', $xmlxssaction) }
            if ($PSBoundParameters.ContainsKey('xmlwsiaction')) { $Payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentaction')) { $Payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ($PSBoundParameters.ContainsKey('xmlvalidationaction')) { $Payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ($PSBoundParameters.ContainsKey('xmlerrorobject')) { $Payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('customsettings')) { $Payload.Add('customsettings', $customsettings) }
            if ($PSBoundParameters.ContainsKey('signatures')) { $Payload.Add('signatures', $signatures) }
            if ($PSBoundParameters.ContainsKey('xmlsoapfaultaction')) { $Payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ($PSBoundParameters.ContainsKey('usehtmlerrorobject')) { $Payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('htmlerrorobject')) { $Payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('logeverypolicyhit')) { $Payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ($PSBoundParameters.ContainsKey('stripcomments')) { $Payload.Add('stripcomments', $stripcomments) }
            if ($PSBoundParameters.ContainsKey('striphtmlcomments')) { $Payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ($PSBoundParameters.ContainsKey('stripxmlcomments')) { $Payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ($PSBoundParameters.ContainsKey('dynamiclearning')) { $Payload.Add('dynamiclearning', $dynamiclearning) }
            if ($PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks')) { $Payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ($PSBoundParameters.ContainsKey('defaultcharset')) { $Payload.Add('defaultcharset', $defaultcharset) }
            if ($PSBoundParameters.ContainsKey('postbodylimit')) { $Payload.Add('postbodylimit', $postbodylimit) }
            if ($PSBoundParameters.ContainsKey('postbodylimitaction')) { $Payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ($PSBoundParameters.ContainsKey('postbodylimitsignature')) { $Payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ($PSBoundParameters.ContainsKey('fileuploadmaxnum')) { $Payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ($PSBoundParameters.ContainsKey('canonicalizehtmlresponse')) { $Payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ($PSBoundParameters.ContainsKey('enableformtagging')) { $Payload.Add('enableformtagging', $enableformtagging) }
            if ($PSBoundParameters.ContainsKey('sessionlessfieldconsistency')) { $Payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ($PSBoundParameters.ContainsKey('sessionlessurlclosure')) { $Payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ($PSBoundParameters.ContainsKey('semicolonfieldseparator')) { $Payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ($PSBoundParameters.ContainsKey('excludefileuploadfromchecks')) { $Payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionparsecomments')) { $Payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('invalidpercenthandling')) { $Payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('checkrequestheaders')) { $Payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ($PSBoundParameters.ContainsKey('inspectquerycontenttypes')) { $Payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ($PSBoundParameters.ContainsKey('optimizepartialreqs')) { $Payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ($PSBoundParameters.ContainsKey('urldecoderequestcookies')) { $Payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('percentdecoderecursively')) { $Payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ($PSBoundParameters.ContainsKey('multipleheaderaction')) { $Payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ($PSBoundParameters.ContainsKey('rfcprofile')) { $Payload.Add('rfcprofile', $rfcprofile) }
            if ($PSBoundParameters.ContainsKey('fileuploadtypesaction')) { $Payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ($PSBoundParameters.ContainsKey('verboseloglevel')) { $Payload.Add('verboseloglevel', $verboseloglevel) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofile -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateAppfwprofile: Finished"
    }
}

function Invoke-ADCUnsetAppfwprofile {
<#
    .SYNOPSIS
        Unset Application Firewall configuration Object
    .DESCRIPTION
        Unset Application Firewall configuration Object 
   .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
   .PARAMETER starturlaction 
       One or more Start URL actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER infercontenttypexmlpayloadaction 
       One or more infer content type payload actions. Available settings function as follows:  
       * Block - Block connections that have mismatch in content-type header and payload.  
       * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request.  
       * Stats - Generate statistics when there is mismatch in content-type header and payload.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type.  
       Possible values = block, log, stats, none 
   .PARAMETER contenttypeaction 
       One or more Content-type actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER inspectcontenttypes 
       One or more InspectContentType lists.  
       * application/x-www-form-urlencoded  
       * multipart/form-data  
       * text/x-gwt-rpc  
       CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected.  
       Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
   .PARAMETER starturlclosure 
       Toggle the state of Start URL Closure.  
       Possible values = ON, OFF 
   .PARAMETER denyurlaction 
       One or more Deny URL actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check.  
       CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none".  
       Possible values = none, block, log, stats 
   .PARAMETER refererheadercheck 
       Enable validation of Referer headers.  
       Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker.  
       Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks.  
       Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
   .PARAMETER cookieconsistencyaction 
       One or more Cookie Consistency actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER cookiehijackingaction 
       One or more actions to prevent cookie hijacking. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       NOTE: Cookie Hijacking feature is not supported for TLSv1.3  
       CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER cookietransforms 
       Perform the specified type of cookie transformation.  
       Available settings function as follows:  
       * Encryption - Encrypt cookies.  
       * Proxying - Mask contents of server cookies by sending proxy cookie to users.  
       * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them.  
       CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings.  
       Possible values = ON, OFF 
   .PARAMETER cookieencryption 
       Type of cookie encryption. Available settings function as follows:  
       * None - Do not encrypt cookies.  
       * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies.  
       * Encrypt Session Only - Encrypt session cookies, but not permanent cookies.  
       * Encrypt All - Encrypt all cookies.  
       Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
   .PARAMETER cookieproxying 
       Cookie proxy setting. Available settings function as follows:  
       * None - Do not proxy cookies.  
       * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies.  
       Possible values = none, sessionOnly 
   .PARAMETER addcookieflags 
       Add the specified flags to cookies. Available settings function as follows:  
       * None - Do not add flags to cookies.  
       * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies.  
       * Secure - Add Secure flag to cookies.  
       * All - Add both HTTPOnly and Secure flags to cookies.  
       Possible values = none, httpOnly, secure, all 
   .PARAMETER fieldconsistencyaction 
       One or more Form Field Consistency actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER csrftagaction 
       One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER crosssitescriptingaction 
       One or more Cross-Site Scripting (XSS) actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER crosssitescriptingtransformunsafehtml 
       Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request.  
       CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings.  
       Possible values = ON, OFF 
   .PARAMETER crosssitescriptingcheckcompleteurls 
       Check complete URLs for cross-site scripts, instead of just the query portions of URLs.  
       Possible values = ON, OFF 
   .PARAMETER sqlinjectionaction 
       One or more HTML SQL Injection actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER cmdinjectionaction 
       Command injection action. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER cmdinjectiontype 
       Available CMD injection types.  
       -CMDSplChar : Checks for CMD Special Chars  
       -CMDKeyword : Checks for CMD Keywords  
       -CMDSplCharANDKeyword : Checks for both and blocks if both are found  
       -CMDSplCharORKeyword : Checks for both and blocks if anyone is found.  
       Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
   .PARAMETER sqlinjectiontransformspecialchars 
       Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled.  
       CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings.  
       Possible values = ON, OFF 
   .PARAMETER sqlinjectiononlycheckfieldswithsqlchars 
       Check only form fields that contain SQL special strings (characters) for injected SQL code.  
       Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers.  
       Possible values = ON, OFF 
   .PARAMETER sqlinjectiontype 
       Available SQL injection types.  
       -SQLSplChar : Checks for SQL Special Chars  
       -SQLKeyword : Checks for SQL Keywords  
       -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
       -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
       Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
   .PARAMETER sqlinjectionchecksqlwildchars 
       Check for form fields that contain SQL wild chars .  
       Possible values = ON, OFF 
   .PARAMETER fieldformataction 
       One or more Field Format actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER defaultfieldformattype 
       Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them. 
   .PARAMETER defaultfieldformatminlength 
       Minimum length, in characters, for data entered into a field that is assigned the default field type.  
       To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0). 
   .PARAMETER defaultfieldformatmaxlength 
       Maximum length, in characters, for data entered into a field that is assigned the default field type. 
   .PARAMETER bufferoverflowaction 
       One or more Buffer Overflow actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER bufferoverflowmaxurllength 
       Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked. 
   .PARAMETER bufferoverflowmaxheaderlength 
       Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked. 
   .PARAMETER bufferoverflowmaxcookielength 
       Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked. 
   .PARAMETER bufferoverflowmaxquerylength 
       Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked. 
   .PARAMETER bufferoverflowmaxtotalheaderlength 
       Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked. 
   .PARAMETER creditcardaction 
       One or more Credit Card actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER creditcard 
       Credit card types that the application firewall should protect.  
       Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
   .PARAMETER creditcardmaxallowed 
       This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked. 
   .PARAMETER creditcardxout 
       Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.".  
       Possible values = ON, OFF 
   .PARAMETER dosecurecreditcardlogging 
       Setting this option logs credit card numbers in the response when the match is found.  
       Possible values = ON, OFF 
   .PARAMETER streaming 
       Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging is enabled. Please make sure that the backend server accepts chunked requests before enabling this option.  
       Possible values = ON, OFF 
   .PARAMETER trace 
       Toggle the state of trace.  
       Possible values = ON, OFF 
   .PARAMETER requestcontenttype 
       Default Content-Type header for requests.  
       A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
   .PARAMETER responsecontenttype 
       Default Content-Type header for responses.  
       A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
   .PARAMETER jsonerrorobject 
       Name to the imported JSON Error Object to be set on application firewall profile. 
   .PARAMETER jsondosaction 
       One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER jsonsqlinjectionaction 
       One or more JSON SQL Injection actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER jsonsqlinjectiontype 
       Available SQL injection types.  
       -SQLSplChar : Checks for SQL Special Chars  
       -SQLKeyword : Checks for SQL Keywords  
       -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
       -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
       Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
   .PARAMETER jsonxssaction 
       One or more JSON Cross-Site Scripting actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER xmldosaction 
       One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER xmlformataction 
       One or more XML Format actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER xmlsqlinjectionaction 
       One or more XML SQL Injection actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER xmlsqlinjectiononlycheckfieldswithsqlchars 
       Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL.  
       Possible values = ON, OFF 
   .PARAMETER xmlsqlinjectiontype 
       Available SQL injection types.  
       -SQLSplChar : Checks for SQL Special Chars  
       -SQLKeyword : Checks for SQL Keywords  
       -SQLSplCharANDKeyword : Checks for both and blocks if both are found  
       -SQLSplCharORKeyword : Checks for both and blocks if anyone is found.  
       Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword 
   .PARAMETER xmlsqlinjectionchecksqlwildchars 
       Check for form fields that contain SQL wild chars .  
       Possible values = ON, OFF 
   .PARAMETER xmlsqlinjectionparsecomments 
       Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
       * Check all - Check all content.  
       * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
       * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
       * ANSI Nested - Exempt content that is part of any type of comment.  
       Possible values = checkall, ansi, nested, ansinested 
   .PARAMETER xmlxssaction 
       One or more XML Cross-Site Scripting actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER xmlwsiaction 
       One or more Web Services Interoperability (WSI) actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER xmlattachmentaction 
       One or more XML Attachment actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Learn - Use the learning engine to generate a list of exceptions to this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none".  
       Possible values = none, block, learn, log, stats 
   .PARAMETER xmlvalidationaction 
       One or more XML Validation actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER xmlerrorobject 
       Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked.  
       Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
   .PARAMETER customsettings 
       Object name for custom settings.  
       This check is applicable to Profile Type: HTML, XML. . 
   .PARAMETER signatures 
       Object name for signatures.  
       This check is applicable to Profile Type: HTML, XML. . 
   .PARAMETER xmlsoapfaultaction 
       One or more XML SOAP Fault Filtering actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       * Remove - Remove all violations for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none".  
       Possible values = none, block, log, remove, stats 
   .PARAMETER usehtmlerrorobject 
       Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL.  
       Possible values = ON, OFF 
   .PARAMETER errorurl 
       URL that application firewall uses as the Error URL. 
   .PARAMETER htmlerrorobject 
       Name to assign to the HTML Error Object.  
       Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
   .PARAMETER logeverypolicyhit 
       Log every profile match, regardless of security checks results.  
       Possible values = ON, OFF 
   .PARAMETER stripcomments 
       Strip HTML comments.  
       This check is applicable to Profile Type: HTML. .  
       Possible values = ON, OFF 
   .PARAMETER striphtmlcomments 
       Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request.  
       Possible values = none, all, exclude_script_tag 
   .PARAMETER stripxmlcomments 
       Strip XML comments before forwarding a web page sent by a protected web site in response to a user request.  
       Possible values = none, all 
   .PARAMETER dynamiclearning 
       One or more security checks. Available options are as follows:  
       * SQLInjection - Enable dynamic learning for SQLInjection security check.  
       * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check.  
       * fieldFormat - Enable dynamic learning for fieldFormat security check.  
       * None - Disable security checks for all security checks.  
       CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none".  
       Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
   .PARAMETER exemptclosureurlsfromsecuritychecks 
       Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers.  
       Possible values = ON, OFF 
   .PARAMETER defaultcharset 
       Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are:  
       * iso-8859-1 (English US)  
       * big5 (Chinese Traditional)  
       * gb2312 (Chinese Simplified)  
       * sjis (Japanese Shift-JIS)  
       * euc-jp (Japanese EUC-JP)  
       * iso-8859-9 (Turkish)  
       * utf-8 (Unicode)  
       * euc-kr (Korean). 
   .PARAMETER postbodylimit 
       Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB. 
   .PARAMETER postbodylimitaction 
       One or more Post Body Limit actions. Available settings function as follows:  
       * Block - Block connections that violate this security check. Must always be set.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled.  
       Possible values = block, log, stats 
   .PARAMETER postbodylimitsignature 
       Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile. 
   .PARAMETER fileuploadmaxnum 
       Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads. 
   .PARAMETER canonicalizehtmlresponse 
       Perform HTML entity encoding for any special characters in responses sent by your protected web sites.  
       Possible values = ON, OFF 
   .PARAMETER enableformtagging 
       Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks.  
       Possible values = ON, OFF 
   .PARAMETER sessionlessfieldconsistency 
       Perform sessionless Field Consistency Checks.  
       Possible values = OFF, ON, postOnly 
   .PARAMETER sessionlessurlclosure 
       Enable session less URL Closure Checks.  
       This check is applicable to Profile Type: HTML. .  
       Possible values = ON, OFF 
   .PARAMETER semicolonfieldseparator 
       Allow ';' as a form field separator in URL queries and POST form bodies. .  
       Possible values = ON, OFF 
   .PARAMETER excludefileuploadfromchecks 
       Exclude uploaded files from Form checks.  
       Possible values = ON, OFF 
   .PARAMETER sqlinjectionparsecomments 
       Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows:  
       * Check all - Check all content.  
       * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment.  
       * Nested - Exempt content that is part of a nested (Microsoft-style) comment.  
       * ANSI Nested - Exempt content that is part of any type of comment.  
       Possible values = checkall, ansi, nested, ansinested 
   .PARAMETER invalidpercenthandling 
       Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows:  
       * apache_mode - Apache format.  
       * asp_mode - Microsoft ASP format.  
       * secure_mode - Secure format.  
       Possible values = apache_mode, asp_mode, secure_mode 
   .PARAMETER type 
       Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows:  
       * HTML - HTML-based web sites.  
       * XML - XML-based web sites and services.  
       * JSON - JSON-based web sites and services.  
       * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds.  
       * HTML JSON - Sites that contain both HTML and JSON content.  
       * XML JSON - Sites that contain both XML and JSON content.  
       * HTML XML JSON - Sites that contain HTML, XML and JSON content.  
       Possible values = HTML, XML, JSON 
   .PARAMETER checkrequestheaders 
       Check request headers as well as web forms for injected SQL and cross-site scripts.  
       Possible values = ON, OFF 
   .PARAMETER inspectquerycontenttypes 
       Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types.  
       Possible values = HTML, XML, JSON, OTHER 
   .PARAMETER optimizepartialreqs 
       Optimize handle of HTTP partial requests i.e. those with Partial requests by the client result in partial requests to the backend server in most cases.  
       * OFF - Partial requests by the client are changed to full requests to the backend server.  
       Possible values = ON, OFF 
   .PARAMETER urldecoderequestcookies 
       URL Decode request cookies before subjecting them to SQL and cross-site scripting checks.  
       Possible values = ON, OFF 
   .PARAMETER comment 
       Any comments about the purpose of profile, or other useful information about the profile. 
   .PARAMETER percentdecoderecursively 
       Configure whether the application firewall should use percentage recursive decoding.  
       Possible values = ON, OFF 
   .PARAMETER multipleheaderaction 
       One or more multiple header actions. Available settings function as follows:  
       * Block - Block connections that have multiple headers.  
       * Log - Log connections that have multiple headers.  
       * KeepLast - Keep only last header when multiple headers are present.  
       CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled.  
       Possible values = block, keepLast, log, none 
   .PARAMETER rfcprofile 
       Object name of the rfc profile. 
   .PARAMETER fileuploadtypesaction 
       One or more file upload types actions. Available settings function as follows:  
       * Block - Block connections that violate this security check.  
       * Log - Log violations of this security check.  
       * Stats - Generate statistics for this security check.  
       * None - Disable all actions for this security check.  
       CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none".  
       Possible values = none, block, log, stats 
   .PARAMETER verboseloglevel 
       Detailed Logging Verbose Log Level.  
       Possible values = pattern, patternPayload, patternPayloadHeader
    .EXAMPLE
        Invoke-ADCUnsetAppfwprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile
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

        [Boolean]$starturlaction ,

        [Boolean]$infercontenttypexmlpayloadaction ,

        [Boolean]$contenttypeaction ,

        [Boolean]$inspectcontenttypes ,

        [Boolean]$starturlclosure ,

        [Boolean]$denyurlaction ,

        [Boolean]$refererheadercheck ,

        [Boolean]$cookieconsistencyaction ,

        [Boolean]$cookiehijackingaction ,

        [Boolean]$cookietransforms ,

        [Boolean]$cookieencryption ,

        [Boolean]$cookieproxying ,

        [Boolean]$addcookieflags ,

        [Boolean]$fieldconsistencyaction ,

        [Boolean]$csrftagaction ,

        [Boolean]$crosssitescriptingaction ,

        [Boolean]$crosssitescriptingtransformunsafehtml ,

        [Boolean]$crosssitescriptingcheckcompleteurls ,

        [Boolean]$sqlinjectionaction ,

        [Boolean]$cmdinjectionaction ,

        [Boolean]$cmdinjectiontype ,

        [Boolean]$sqlinjectiontransformspecialchars ,

        [Boolean]$sqlinjectiononlycheckfieldswithsqlchars ,

        [Boolean]$sqlinjectiontype ,

        [Boolean]$sqlinjectionchecksqlwildchars ,

        [Boolean]$fieldformataction ,

        [Boolean]$defaultfieldformattype ,

        [Boolean]$defaultfieldformatminlength ,

        [Boolean]$defaultfieldformatmaxlength ,

        [Boolean]$bufferoverflowaction ,

        [Boolean]$bufferoverflowmaxurllength ,

        [Boolean]$bufferoverflowmaxheaderlength ,

        [Boolean]$bufferoverflowmaxcookielength ,

        [Boolean]$bufferoverflowmaxquerylength ,

        [Boolean]$bufferoverflowmaxtotalheaderlength ,

        [Boolean]$creditcardaction ,

        [Boolean]$creditcard ,

        [Boolean]$creditcardmaxallowed ,

        [Boolean]$creditcardxout ,

        [Boolean]$dosecurecreditcardlogging ,

        [Boolean]$streaming ,

        [Boolean]$trace ,

        [Boolean]$requestcontenttype ,

        [Boolean]$responsecontenttype ,

        [Boolean]$jsonerrorobject ,

        [Boolean]$jsondosaction ,

        [Boolean]$jsonsqlinjectionaction ,

        [Boolean]$jsonsqlinjectiontype ,

        [Boolean]$jsonxssaction ,

        [Boolean]$xmldosaction ,

        [Boolean]$xmlformataction ,

        [Boolean]$xmlsqlinjectionaction ,

        [Boolean]$xmlsqlinjectiononlycheckfieldswithsqlchars ,

        [Boolean]$xmlsqlinjectiontype ,

        [Boolean]$xmlsqlinjectionchecksqlwildchars ,

        [Boolean]$xmlsqlinjectionparsecomments ,

        [Boolean]$xmlxssaction ,

        [Boolean]$xmlwsiaction ,

        [Boolean]$xmlattachmentaction ,

        [Boolean]$xmlvalidationaction ,

        [Boolean]$xmlerrorobject ,

        [Boolean]$customsettings ,

        [Boolean]$signatures ,

        [Boolean]$xmlsoapfaultaction ,

        [Boolean]$usehtmlerrorobject ,

        [Boolean]$errorurl ,

        [Boolean]$htmlerrorobject ,

        [Boolean]$logeverypolicyhit ,

        [Boolean]$stripcomments ,

        [Boolean]$striphtmlcomments ,

        [Boolean]$stripxmlcomments ,

        [Boolean]$dynamiclearning ,

        [Boolean]$exemptclosureurlsfromsecuritychecks ,

        [Boolean]$defaultcharset ,

        [Boolean]$postbodylimit ,

        [Boolean]$postbodylimitaction ,

        [Boolean]$postbodylimitsignature ,

        [Boolean]$fileuploadmaxnum ,

        [Boolean]$canonicalizehtmlresponse ,

        [Boolean]$enableformtagging ,

        [Boolean]$sessionlessfieldconsistency ,

        [Boolean]$sessionlessurlclosure ,

        [Boolean]$semicolonfieldseparator ,

        [Boolean]$excludefileuploadfromchecks ,

        [Boolean]$sqlinjectionparsecomments ,

        [Boolean]$invalidpercenthandling ,

        [Boolean]$type ,

        [Boolean]$checkrequestheaders ,

        [Boolean]$inspectquerycontenttypes ,

        [Boolean]$optimizepartialreqs ,

        [Boolean]$urldecoderequestcookies ,

        [Boolean]$comment ,

        [Boolean]$percentdecoderecursively ,

        [Boolean]$multipleheaderaction ,

        [Boolean]$rfcprofile ,

        [Boolean]$fileuploadtypesaction ,

        [Boolean]$verboseloglevel 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('starturlaction')) { $Payload.Add('starturlaction', $starturlaction) }
            if ($PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction')) { $Payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ($PSBoundParameters.ContainsKey('contenttypeaction')) { $Payload.Add('contenttypeaction', $contenttypeaction) }
            if ($PSBoundParameters.ContainsKey('inspectcontenttypes')) { $Payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ($PSBoundParameters.ContainsKey('starturlclosure')) { $Payload.Add('starturlclosure', $starturlclosure) }
            if ($PSBoundParameters.ContainsKey('denyurlaction')) { $Payload.Add('denyurlaction', $denyurlaction) }
            if ($PSBoundParameters.ContainsKey('refererheadercheck')) { $Payload.Add('refererheadercheck', $refererheadercheck) }
            if ($PSBoundParameters.ContainsKey('cookieconsistencyaction')) { $Payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('cookiehijackingaction')) { $Payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ($PSBoundParameters.ContainsKey('cookietransforms')) { $Payload.Add('cookietransforms', $cookietransforms) }
            if ($PSBoundParameters.ContainsKey('cookieencryption')) { $Payload.Add('cookieencryption', $cookieencryption) }
            if ($PSBoundParameters.ContainsKey('cookieproxying')) { $Payload.Add('cookieproxying', $cookieproxying) }
            if ($PSBoundParameters.ContainsKey('addcookieflags')) { $Payload.Add('addcookieflags', $addcookieflags) }
            if ($PSBoundParameters.ContainsKey('fieldconsistencyaction')) { $Payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ($PSBoundParameters.ContainsKey('csrftagaction')) { $Payload.Add('csrftagaction', $csrftagaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingaction')) { $Payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml')) { $Payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ($PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls')) { $Payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionaction')) { $Payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectionaction')) { $Payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ($PSBoundParameters.ContainsKey('cmdinjectiontype')) { $Payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars')) { $Payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('sqlinjectiontype')) { $Payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars')) { $Payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('fieldformataction')) { $Payload.Add('fieldformataction', $fieldformataction) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformattype')) { $Payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatminlength')) { $Payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ($PSBoundParameters.ContainsKey('defaultfieldformatmaxlength')) { $Payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowaction')) { $Payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxurllength')) { $Payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength')) { $Payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength')) { $Payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength')) { $Payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ($PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength')) { $Payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ($PSBoundParameters.ContainsKey('creditcardaction')) { $Payload.Add('creditcardaction', $creditcardaction) }
            if ($PSBoundParameters.ContainsKey('creditcard')) { $Payload.Add('creditcard', $creditcard) }
            if ($PSBoundParameters.ContainsKey('creditcardmaxallowed')) { $Payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ($PSBoundParameters.ContainsKey('creditcardxout')) { $Payload.Add('creditcardxout', $creditcardxout) }
            if ($PSBoundParameters.ContainsKey('dosecurecreditcardlogging')) { $Payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ($PSBoundParameters.ContainsKey('streaming')) { $Payload.Add('streaming', $streaming) }
            if ($PSBoundParameters.ContainsKey('trace')) { $Payload.Add('trace', $trace) }
            if ($PSBoundParameters.ContainsKey('requestcontenttype')) { $Payload.Add('requestcontenttype', $requestcontenttype) }
            if ($PSBoundParameters.ContainsKey('responsecontenttype')) { $Payload.Add('responsecontenttype', $responsecontenttype) }
            if ($PSBoundParameters.ContainsKey('jsonerrorobject')) { $Payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ($PSBoundParameters.ContainsKey('jsondosaction')) { $Payload.Add('jsondosaction', $jsondosaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectionaction')) { $Payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('jsonsqlinjectiontype')) { $Payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('jsonxssaction')) { $Payload.Add('jsonxssaction', $jsonxssaction) }
            if ($PSBoundParameters.ContainsKey('xmldosaction')) { $Payload.Add('xmldosaction', $xmldosaction) }
            if ($PSBoundParameters.ContainsKey('xmlformataction')) { $Payload.Add('xmlformataction', $xmlformataction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionaction')) { $Payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars')) { $Payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectiontype')) { $Payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars')) { $Payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments')) { $Payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('xmlxssaction')) { $Payload.Add('xmlxssaction', $xmlxssaction) }
            if ($PSBoundParameters.ContainsKey('xmlwsiaction')) { $Payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentaction')) { $Payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ($PSBoundParameters.ContainsKey('xmlvalidationaction')) { $Payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ($PSBoundParameters.ContainsKey('xmlerrorobject')) { $Payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('customsettings')) { $Payload.Add('customsettings', $customsettings) }
            if ($PSBoundParameters.ContainsKey('signatures')) { $Payload.Add('signatures', $signatures) }
            if ($PSBoundParameters.ContainsKey('xmlsoapfaultaction')) { $Payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ($PSBoundParameters.ContainsKey('usehtmlerrorobject')) { $Payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('errorurl')) { $Payload.Add('errorurl', $errorurl) }
            if ($PSBoundParameters.ContainsKey('htmlerrorobject')) { $Payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ($PSBoundParameters.ContainsKey('logeverypolicyhit')) { $Payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ($PSBoundParameters.ContainsKey('stripcomments')) { $Payload.Add('stripcomments', $stripcomments) }
            if ($PSBoundParameters.ContainsKey('striphtmlcomments')) { $Payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ($PSBoundParameters.ContainsKey('stripxmlcomments')) { $Payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ($PSBoundParameters.ContainsKey('dynamiclearning')) { $Payload.Add('dynamiclearning', $dynamiclearning) }
            if ($PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks')) { $Payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ($PSBoundParameters.ContainsKey('defaultcharset')) { $Payload.Add('defaultcharset', $defaultcharset) }
            if ($PSBoundParameters.ContainsKey('postbodylimit')) { $Payload.Add('postbodylimit', $postbodylimit) }
            if ($PSBoundParameters.ContainsKey('postbodylimitaction')) { $Payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ($PSBoundParameters.ContainsKey('postbodylimitsignature')) { $Payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ($PSBoundParameters.ContainsKey('fileuploadmaxnum')) { $Payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ($PSBoundParameters.ContainsKey('canonicalizehtmlresponse')) { $Payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ($PSBoundParameters.ContainsKey('enableformtagging')) { $Payload.Add('enableformtagging', $enableformtagging) }
            if ($PSBoundParameters.ContainsKey('sessionlessfieldconsistency')) { $Payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ($PSBoundParameters.ContainsKey('sessionlessurlclosure')) { $Payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ($PSBoundParameters.ContainsKey('semicolonfieldseparator')) { $Payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ($PSBoundParameters.ContainsKey('excludefileuploadfromchecks')) { $Payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ($PSBoundParameters.ContainsKey('sqlinjectionparsecomments')) { $Payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ($PSBoundParameters.ContainsKey('invalidpercenthandling')) { $Payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('checkrequestheaders')) { $Payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ($PSBoundParameters.ContainsKey('inspectquerycontenttypes')) { $Payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ($PSBoundParameters.ContainsKey('optimizepartialreqs')) { $Payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ($PSBoundParameters.ContainsKey('urldecoderequestcookies')) { $Payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('percentdecoderecursively')) { $Payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ($PSBoundParameters.ContainsKey('multipleheaderaction')) { $Payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ($PSBoundParameters.ContainsKey('rfcprofile')) { $Payload.Add('rfcprofile', $rfcprofile) }
            if ($PSBoundParameters.ContainsKey('fileuploadtypesaction')) { $Payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ($PSBoundParameters.ContainsKey('verboseloglevel')) { $Payload.Add('verboseloglevel', $verboseloglevel) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppfwprofile: Finished"
    }
}

function Invoke-ADCRestoreAppfwprofile {
<#
    .SYNOPSIS
        Restore Application Firewall configuration Object
    .DESCRIPTION
        Restore Application Firewall configuration Object 
    .PARAMETER archivename 
        Source for tar archive. 
    .PARAMETER relaxationrules 
        Import all appfw relaxation rules. 
    .PARAMETER importprofilename 
        Name of the profile which will be created/updated to associate the relaxation rules. 
    .PARAMETER matchurlstring 
        Match this action url in archived Relaxation Rules to replace. 
    .PARAMETER replaceurlstring 
        Replace matched url string with this action url string while restoring Relaxation Rules. 
    .PARAMETER overwrite 
        Purge existing Relaxation Rules and replace during import. 
    .PARAMETER augment 
        Augment Relaxation Rules during import.
    .EXAMPLE
        Invoke-ADCRestoreAppfwprofile -archivename <string>
    .NOTES
        File Name : Invoke-ADCRestoreAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        [string]$archivename ,

        [boolean]$relaxationrules ,

        [string]$importprofilename ,

        [string]$matchurlstring ,

        [string]$replaceurlstring ,

        [boolean]$overwrite ,

        [boolean]$augment 

    )
    begin {
        Write-Verbose "Invoke-ADCRestoreAppfwprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                archivename = $archivename
            }
            if ($PSBoundParameters.ContainsKey('relaxationrules')) { $Payload.Add('relaxationrules', $relaxationrules) }
            if ($PSBoundParameters.ContainsKey('importprofilename')) { $Payload.Add('importprofilename', $importprofilename) }
            if ($PSBoundParameters.ContainsKey('matchurlstring')) { $Payload.Add('matchurlstring', $matchurlstring) }
            if ($PSBoundParameters.ContainsKey('replaceurlstring')) { $Payload.Add('replaceurlstring', $replaceurlstring) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSBoundParameters.ContainsKey('augment')) { $Payload.Add('augment', $augment) }
            if ($PSCmdlet.ShouldProcess($Name, "Restore Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwprofile -Action restore -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCRestoreAppfwprofile: Finished"
    }
}

function Invoke-ADCGetAppfwprofile {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retreive all appfwprofile object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofile
    .EXAMPLE 
        Invoke-ADCGetAppfwprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofile -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        Write-Verbose "Invoke-ADCGetAppfwprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofile: Ended"
    }
}

function Invoke-ADCGetAppfwprofilebinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the application firewall profile. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilebinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilebinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecmdinjectionbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER cmdinjection 
        Name of the relaxed web form field/header/cookie. 
    .PARAMETER formactionurl_cmd 
        The web form action URL. 
    .PARAMETER isregex_cmd 
        Is the relaxed web form field name/header/cookie a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER as_scan_location_cmd 
        Location of command injection exception - form field, header or cookie.  
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER as_value_type_cmd 
        Type of the relaxed web form value.  
        Possible values = Keyword, SpecialString 
    .PARAMETER as_value_expr_cmd 
        The web form/header/cookie value expression. 
    .PARAMETER isvalueregex_cmd 
        Is the web form field/header/cookie value a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_cmdinjection_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecmdinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecmdinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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

        [string]$cmdinjection ,

        [string]$formactionurl_cmd ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_cmd ,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE')]
        [string]$as_scan_location_cmd ,

        [ValidateSet('Keyword', 'SpecialString')]
        [string]$as_value_type_cmd ,

        [string]$as_value_expr_cmd ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isvalueregex_cmd ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecmdinjectionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('cmdinjection')) { $Payload.Add('cmdinjection', $cmdinjection) }
            if ($PSBoundParameters.ContainsKey('formactionurl_cmd')) { $Payload.Add('formactionurl_cmd', $formactionurl_cmd) }
            if ($PSBoundParameters.ContainsKey('isregex_cmd')) { $Payload.Add('isregex_cmd', $isregex_cmd) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_cmd')) { $Payload.Add('as_scan_location_cmd', $as_scan_location_cmd) }
            if ($PSBoundParameters.ContainsKey('as_value_type_cmd')) { $Payload.Add('as_value_type_cmd', $as_value_type_cmd) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_cmd')) { $Payload.Add('as_value_expr_cmd', $as_value_expr_cmd) }
            if ($PSBoundParameters.ContainsKey('isvalueregex_cmd')) { $Payload.Add('isvalueregex_cmd', $isvalueregex_cmd) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_cmdinjection_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_cmdinjection_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecmdinjectionbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecmdinjectionbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecmdinjectionbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER cmdinjection 
       Name of the relaxed web form field/header/cookie.    .PARAMETER formactionurl_cmd 
       The web form action URL.    .PARAMETER as_scan_location_cmd 
       Location of command injection exception - form field, header or cookie.  
       Possible values = FORMFIELD, HEADER, COOKIE    .PARAMETER as_value_type_cmd 
       Type of the relaxed web form value.  
       Possible values = Keyword, SpecialString    .PARAMETER as_value_expr_cmd 
       The web form/header/cookie value expression.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecmdinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecmdinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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

        [string]$cmdinjection ,

        [string]$formactionurl_cmd ,

        [string]$as_scan_location_cmd ,

        [string]$as_value_type_cmd ,

        [string]$as_value_expr_cmd 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecmdinjectionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('cmdinjection')) { $Arguments.Add('cmdinjection', $cmdinjection) }
            if ($PSBoundParameters.ContainsKey('formactionurl_cmd')) { $Arguments.Add('formactionurl_cmd', $formactionurl_cmd) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_cmd')) { $Arguments.Add('as_scan_location_cmd', $as_scan_location_cmd) }
            if ($PSBoundParameters.ContainsKey('as_value_type_cmd')) { $Arguments.Add('as_value_type_cmd', $as_value_type_cmd) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_cmd')) { $Arguments.Add('as_value_expr_cmd', $as_value_expr_cmd) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecmdinjectionbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecmdinjectionbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_cmdinjection_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_cmdinjection_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecmdinjectionbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecmdinjectionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecmdinjectionbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecmdinjectionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecmdinjectionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecmdinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecmdinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_cmdinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_cmdinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecmdinjectionbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecontenttypebinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER contenttype 
        A regular expression that designates a content-type on the content-types list. 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_contenttype_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecontenttypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$contenttype ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecontenttypebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('contenttype')) { $Payload.Add('contenttype', $contenttype) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_contenttype_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_contenttype_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecontenttypebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecontenttypebinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecontenttypebinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER contenttype 
       A regular expression that designates a content-type on the content-types list.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecontenttypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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

        [string]$contenttype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecontenttypebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('contenttype')) { $Arguments.Add('contenttype', $contenttype) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecontenttypebinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecontenttypebinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_contenttype_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_contenttype_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecontenttypebinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecontenttypebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecontenttypebinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecontenttypebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecontenttypebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecontenttypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_contenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_contenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecontenttypebinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecookieconsistencybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER cookieconsistency 
        The name of the cookie to be checked. 
    .PARAMETER isregex 
        Is the cookie name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_cookieconsistency_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecookieconsistencybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecookieconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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

        [string]$cookieconsistency ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecookieconsistencybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('cookieconsistency')) { $Payload.Add('cookieconsistency', $cookieconsistency) }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_cookieconsistency_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_cookieconsistency_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecookieconsistencybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecookieconsistencybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecookieconsistencybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER cookieconsistency 
       The name of the cookie to be checked.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecookieconsistencybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecookieconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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

        [string]$cookieconsistency 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecookieconsistencybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('cookieconsistency')) { $Arguments.Add('cookieconsistency', $cookieconsistency) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecookieconsistencybinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecookieconsistencybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_cookieconsistency_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_cookieconsistency_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecookieconsistencybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecookieconsistencybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecookieconsistencybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecookieconsistencybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecookieconsistencybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecookieconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecookieconsistencybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_cookieconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_cookieconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecookieconsistencybinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecreditcardnumberbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER creditcardnumber 
        The object expression that is to be excluded from safe commerce check. 
    .PARAMETER creditcardnumberurl 
        The url for which the list of credit card numbers are needed to be bypassed from inspection. 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_creditcardnumber_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecreditcardnumberbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecreditcardnumberbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$creditcardnumber ,

        [string]$creditcardnumberurl ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecreditcardnumberbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('creditcardnumber')) { $Payload.Add('creditcardnumber', $creditcardnumber) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberurl')) { $Payload.Add('creditcardnumberurl', $creditcardnumberurl) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_creditcardnumber_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_creditcardnumber_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecreditcardnumberbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER creditcardnumber 
       The object expression that is to be excluded from safe commerce check.    .PARAMETER creditcardnumberurl 
       The url for which the list of credit card numbers are needed to be bypassed from inspection.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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

        [string]$creditcardnumber ,

        [string]$creditcardnumberurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('creditcardnumber')) { $Arguments.Add('creditcardnumber', $creditcardnumber) }
            if ($PSBoundParameters.ContainsKey('creditcardnumberurl')) { $Arguments.Add('creditcardnumberurl', $creditcardnumberurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecreditcardnumberbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_creditcardnumber_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_creditcardnumber_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecreditcardnumberbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecreditcardnumberbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecreditcardnumberbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecreditcardnumberbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecreditcardnumberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_creditcardnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_creditcardnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecreditcardnumberbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecrosssitescriptingbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER crosssitescripting 
        The web form field name. 
    .PARAMETER formactionurl_xss 
        The web form action URL. 
    .PARAMETER isregex_xss 
        Is the web form field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER as_scan_location_xss 
        Location of cross-site scripting exception - form field, header, cookie or URL.  
        Possible values = FORMFIELD, HEADER, COOKIE, URL 
    .PARAMETER as_value_type_xss 
        The web form value type.  
        Possible values = Tag, Attribute, Pattern 
    .PARAMETER as_value_expr_xss 
        The web form value expression. 
    .PARAMETER isvalueregex_xss 
        Is the web form field value a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_crosssitescripting_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecrosssitescriptingbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecrosssitescriptingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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

        [string]$crosssitescripting ,

        [string]$formactionurl_xss ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_xss ,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE', 'URL')]
        [string]$as_scan_location_xss ,

        [ValidateSet('Tag', 'Attribute', 'Pattern')]
        [string]$as_value_type_xss ,

        [string]$as_value_expr_xss ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isvalueregex_xss ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecrosssitescriptingbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('crosssitescripting')) { $Payload.Add('crosssitescripting', $crosssitescripting) }
            if ($PSBoundParameters.ContainsKey('formactionurl_xss')) { $Payload.Add('formactionurl_xss', $formactionurl_xss) }
            if ($PSBoundParameters.ContainsKey('isregex_xss')) { $Payload.Add('isregex_xss', $isregex_xss) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xss')) { $Payload.Add('as_scan_location_xss', $as_scan_location_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_type_xss')) { $Payload.Add('as_value_type_xss', $as_value_type_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_xss')) { $Payload.Add('as_value_expr_xss', $as_value_expr_xss) }
            if ($PSBoundParameters.ContainsKey('isvalueregex_xss')) { $Payload.Add('isvalueregex_xss', $isvalueregex_xss) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_crosssitescripting_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_crosssitescripting_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecrosssitescriptingbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER crosssitescripting 
       The web form field name.    .PARAMETER formactionurl_xss 
       The web form action URL.    .PARAMETER as_scan_location_xss 
       Location of cross-site scripting exception - form field, header, cookie or URL.  
       Possible values = FORMFIELD, HEADER, COOKIE, URL    .PARAMETER as_value_type_xss 
       The web form value type.  
       Possible values = Tag, Attribute, Pattern    .PARAMETER as_value_expr_xss 
       The web form value expression.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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

        [string]$crosssitescripting ,

        [string]$formactionurl_xss ,

        [string]$as_scan_location_xss ,

        [string]$as_value_type_xss ,

        [string]$as_value_expr_xss 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('crosssitescripting')) { $Arguments.Add('crosssitescripting', $crosssitescripting) }
            if ($PSBoundParameters.ContainsKey('formactionurl_xss')) { $Arguments.Add('formactionurl_xss', $formactionurl_xss) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xss')) { $Arguments.Add('as_scan_location_xss', $as_scan_location_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_type_xss')) { $Arguments.Add('as_value_type_xss', $as_value_type_xss) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_xss')) { $Arguments.Add('as_value_expr_xss', $as_value_expr_xss) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecrosssitescriptingbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_crosssitescripting_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_crosssitescripting_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecrosssitescriptingbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecrosssitescriptingbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecrosssitescriptingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_crosssitescripting_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_crosssitescripting_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecrosssitescriptingbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilecsrftagbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER csrftag 
        The web form originating URL. 
    .PARAMETER csrfformactionurl 
        The web form action URL. 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_csrftag_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilecsrftagbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecsrftagbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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

        [string]$csrftag ,

        [string]$csrfformactionurl ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecsrftagbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('csrftag')) { $Payload.Add('csrftag', $csrftag) }
            if ($PSBoundParameters.ContainsKey('csrfformactionurl')) { $Payload.Add('csrfformactionurl', $csrfformactionurl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_csrftag_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_csrftag_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilecsrftagbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilecsrftagbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilecsrftagbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER csrftag 
       The web form originating URL.    .PARAMETER csrfformactionurl 
       The web form action URL.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilecsrftagbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecsrftagbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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

        [string]$csrftag ,

        [string]$csrfformactionurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecsrftagbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('csrftag')) { $Arguments.Add('csrftag', $csrftag) }
            if ($PSBoundParameters.ContainsKey('csrfformactionurl')) { $Arguments.Add('csrfformactionurl', $csrfformactionurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecsrftagbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilecsrftagbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_csrftag_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_csrftag_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecsrftagbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecsrftagbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilecsrftagbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecsrftagbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilecsrftagbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecsrftagbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecsrftagbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_csrftag_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_csrftag_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilecsrftagbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofiledenyurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER denyurl 
        A regular expression that designates a URL on the Deny URL list. 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_denyurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofiledenyurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofiledenyurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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

        [string]$denyurl ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofiledenyurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('denyurl')) { $Payload.Add('denyurl', $denyurl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_denyurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_denyurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofiledenyurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofiledenyurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofiledenyurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER denyurl 
       A regular expression that designates a URL on the Deny URL list.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofiledenyurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofiledenyurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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

        [string]$denyurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofiledenyurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('denyurl')) { $Arguments.Add('denyurl', $denyurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofiledenyurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofiledenyurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_denyurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_denyurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofiledenyurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofiledenyurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofiledenyurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofiledenyurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofiledenyurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofiledenyurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofiledenyurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_denyurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_denyurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofiledenyurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofileexcluderescontenttypebinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER excluderescontenttype 
        A regular expression that represents the content type of the response that are to be excluded from inspection. 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_excluderescontenttype_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofileexcluderescontenttypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofileexcluderescontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$excluderescontenttype ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofileexcluderescontenttypebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('excluderescontenttype')) { $Payload.Add('excluderescontenttype', $excluderescontenttype) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_excluderescontenttype_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_excluderescontenttype_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofileexcluderescontenttypebinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER excluderescontenttype 
       A regular expression that represents the content type of the response that are to be excluded from inspection.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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

        [string]$excluderescontenttype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('excluderescontenttype')) { $Arguments.Add('excluderescontenttype', $excluderescontenttype) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofileexcluderescontenttypebinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_excluderescontenttype_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_excluderescontenttype_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofileexcluderescontenttypebinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofileexcluderescontenttypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofileexcluderescontenttypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_excluderescontenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_excluderescontenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofileexcluderescontenttypebinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilefieldconsistencybinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER fieldconsistency 
        The web form field name. 
    .PARAMETER formactionurl_ffc 
        The web form action URL. 
    .PARAMETER isregex_ffc 
        Is the web form field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fieldconsistency_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilefieldconsistencybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefieldconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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

        [string]$fieldconsistency ,

        [string]$formactionurl_ffc ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_ffc ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldconsistencybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('fieldconsistency')) { $Payload.Add('fieldconsistency', $fieldconsistency) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ffc')) { $Payload.Add('formactionurl_ffc', $formactionurl_ffc) }
            if ($PSBoundParameters.ContainsKey('isregex_ffc')) { $Payload.Add('isregex_ffc', $isregex_ffc) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_fieldconsistency_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fieldconsistency_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilefieldconsistencybinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldconsistencybinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilefieldconsistencybinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER fieldconsistency 
       The web form field name.    .PARAMETER formactionurl_ffc 
       The web form action URL.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilefieldconsistencybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefieldconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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

        [string]$fieldconsistency ,

        [string]$formactionurl_ffc 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldconsistencybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('fieldconsistency')) { $Arguments.Add('fieldconsistency', $fieldconsistency) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ffc')) { $Arguments.Add('formactionurl_ffc', $formactionurl_ffc) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldconsistencybinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilefieldconsistencybinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_fieldconsistency_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_fieldconsistency_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldconsistencybinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefieldconsistencybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefieldconsistencybinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldconsistencybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldconsistencybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefieldconsistencybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldconsistencybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_fieldconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fieldconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldconsistencybinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilefieldformatbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER fieldformat 
        Name of the form field to which a field format will be assigned. 
    .PARAMETER formactionurl_ff 
        Action URL of the form field to which a field format will be assigned. 
    .PARAMETER fieldtype 
        The field type you are assigning to this form field. 
    .PARAMETER fieldformatminlength 
        The minimum allowed length for data in this form field. 
    .PARAMETER fieldformatmaxlength 
        The maximum allowed length for data in this form field. 
    .PARAMETER isregex_ff 
        Is the form field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fieldformat_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilefieldformatbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefieldformatbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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

        [string]$fieldformat ,

        [string]$formactionurl_ff ,

        [string]$fieldtype ,

        [double]$fieldformatminlength ,

        [double]$fieldformatmaxlength ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_ff ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldformatbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('fieldformat')) { $Payload.Add('fieldformat', $fieldformat) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ff')) { $Payload.Add('formactionurl_ff', $formactionurl_ff) }
            if ($PSBoundParameters.ContainsKey('fieldtype')) { $Payload.Add('fieldtype', $fieldtype) }
            if ($PSBoundParameters.ContainsKey('fieldformatminlength')) { $Payload.Add('fieldformatminlength', $fieldformatminlength) }
            if ($PSBoundParameters.ContainsKey('fieldformatmaxlength')) { $Payload.Add('fieldformatmaxlength', $fieldformatmaxlength) }
            if ($PSBoundParameters.ContainsKey('isregex_ff')) { $Payload.Add('isregex_ff', $isregex_ff) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_fieldformat_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fieldformat_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilefieldformatbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldformatbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilefieldformatbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER fieldformat 
       Name of the form field to which a field format will be assigned.    .PARAMETER formactionurl_ff 
       Action URL of the form field to which a field format will be assigned.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilefieldformatbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefieldformatbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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

        [string]$fieldformat ,

        [string]$formactionurl_ff 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldformatbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('fieldformat')) { $Arguments.Add('fieldformat', $fieldformat) }
            if ($PSBoundParameters.ContainsKey('formactionurl_ff')) { $Arguments.Add('formactionurl_ff', $formactionurl_ff) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldformatbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilefieldformatbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_fieldformat_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_fieldformat_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldformatbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefieldformatbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefieldformatbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldformatbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefieldformatbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefieldformatbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldformatbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_fieldformat_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fieldformat_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldformatbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilefileuploadtypebinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER fileuploadtype 
        FileUploadTypes to allow/deny. 
    .PARAMETER as_fileuploadtypes_url 
        FileUploadTypes action URL. 
    .PARAMETER isregex_fileuploadtypes_url 
        Is a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER filetype 
        FileUploadTypes file types.  
        Possible values = pdf, msdoc, text, image, any 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fileuploadtype_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilefileuploadtypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefileuploadtypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$fileuploadtype ,

        [string]$as_fileuploadtypes_url ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_fileuploadtypes_url ,

        [ValidateSet('pdf', 'msdoc', 'text', 'image', 'any')]
        [string[]]$filetype ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefileuploadtypebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('fileuploadtype')) { $Payload.Add('fileuploadtype', $fileuploadtype) }
            if ($PSBoundParameters.ContainsKey('as_fileuploadtypes_url')) { $Payload.Add('as_fileuploadtypes_url', $as_fileuploadtypes_url) }
            if ($PSBoundParameters.ContainsKey('isregex_fileuploadtypes_url')) { $Payload.Add('isregex_fileuploadtypes_url', $isregex_fileuploadtypes_url) }
            if ($PSBoundParameters.ContainsKey('filetype')) { $Payload.Add('filetype', $filetype) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_fileuploadtype_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fileuploadtype_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilefileuploadtypebinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilefileuploadtypebinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilefileuploadtypebinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER fileuploadtype 
       FileUploadTypes to allow/deny.    .PARAMETER as_fileuploadtypes_url 
       FileUploadTypes action URL.    .PARAMETER filetype 
       FileUploadTypes file types.  
       Possible values = pdf, msdoc, text, image, any
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilefileuploadtypebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefileuploadtypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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

        [string]$fileuploadtype ,

        [string]$as_fileuploadtypes_url ,

        [string[]]$filetype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefileuploadtypebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('fileuploadtype')) { $Arguments.Add('fileuploadtype', $fileuploadtype) }
            if ($PSBoundParameters.ContainsKey('as_fileuploadtypes_url')) { $Arguments.Add('as_fileuploadtypes_url', $as_fileuploadtypes_url) }
            if ($PSBoundParameters.ContainsKey('filetype')) { $Arguments.Add('filetype', $filetype) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefileuploadtypebinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilefileuploadtypebinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_fileuploadtype_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_fileuploadtype_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefileuploadtypebinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefileuploadtypebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilefileuploadtypebinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefileuploadtypebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilefileuploadtypebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefileuploadtypebinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefileuploadtypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_fileuploadtype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fileuploadtype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilefileuploadtypebinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilejsondosurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER jsondosurl 
        The URL on which we need to enforce the specified JSON denial-of-service (JSONDoS) attack protections. An JSON DoS configuration consists of the following items: * URL. PCRE-format regular expression for the URL. * Maximum-document-length-check toggle. ON to enable this check, OFF to disable it. * Maximum document length. Positive integer representing the maximum length of the JSON document. * Maximum-container-depth-check toggle. ON to enable, OFF to disable. * Maximum container depth. Positive integer representing the maximum container depth of the JSON document. * Maximum-object-key-count-check toggle. ON to enable, OFF to disable. * Maximum object key count. Positive integer representing the maximum allowed number of keys in any of the JSON object. * Maximum-object-key-length-check toggle. ON to enable, OFF to disable. * Maximum object key length. Positive integer representing the maximum allowed length of key in any of the JSON object. * Maximum-array-value-count-check toggle. ON to enable, OFF to disable. * Maximum array value count. Positive integer representing the maximum allowed number of values in any of the JSON array. * Maximum-string-length-check toggle. ON to enable, OFF to disable. * Maximum string length. Positive integer representing the maximum length of string in JSON.  
        Minimum length = 1  
        Maximum length = 2047 
    .PARAMETER jsonmaxcontainerdepthcheck 
        State if JSON Max depth check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxcontainerdepth 
        Maximum allowed nesting depth of JSON document. JSON allows one to nest the containers (object and array) in any order to any depth. This check protects against documents that have excessive depth of hierarchy.  
        Default value: 5  
        Minimum value = 0  
        Maximum value = 127 
    .PARAMETER jsonmaxdocumentlengthcheck 
        State if JSON Max document length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxdocumentlength 
        Maximum document length of JSON document, in bytes.  
        Default value: 20000000  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER jsonmaxobjectkeycountcheck 
        State if JSON Max object key count check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxobjectkeycount 
        Maximum key count in the any of JSON object. This check protects against objects that have large number of keys.  
        Default value: 10000  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER jsonmaxobjectkeylengthcheck 
        State if JSON Max object key length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxobjectkeylength 
        Maximum key length in the any of JSON object. This check protects against objects that have large keys.  
        Default value: 128  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER jsonmaxarraylengthcheck 
        State if JSON Max array value count check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxarraylength 
        Maximum array length in the any of JSON object. This check protects against arrays having large lengths.  
        Default value: 10000  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER jsonmaxstringlengthcheck 
        State if JSON Max string value count check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER jsonmaxstringlength 
        Maximum string length in the JSON. This check protects against strings that have large length.  
        Default value: 1000000  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsondosurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilejsondosurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsondosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateLength(1, 2047)]
        [string]$jsondosurl ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxcontainerdepthcheck ,

        [ValidateRange(0, 127)]
        [double]$jsonmaxcontainerdepth = '5' ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxdocumentlengthcheck ,

        [ValidateRange(0, 2147483647)]
        [double]$jsonmaxdocumentlength = '20000000' ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxobjectkeycountcheck ,

        [ValidateRange(0, 2147483647)]
        [double]$jsonmaxobjectkeycount = '10000' ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxobjectkeylengthcheck ,

        [ValidateRange(0, 2147483647)]
        [double]$jsonmaxobjectkeylength = '128' ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxarraylengthcheck ,

        [ValidateRange(0, 2147483647)]
        [double]$jsonmaxarraylength = '10000' ,

        [ValidateSet('ON', 'OFF')]
        [string]$jsonmaxstringlengthcheck ,

        [ValidateRange(0, 2147483647)]
        [double]$jsonmaxstringlength = '1000000' ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsondosurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('jsondosurl')) { $Payload.Add('jsondosurl', $jsondosurl) }
            if ($PSBoundParameters.ContainsKey('jsonmaxcontainerdepthcheck')) { $Payload.Add('jsonmaxcontainerdepthcheck', $jsonmaxcontainerdepthcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxcontainerdepth')) { $Payload.Add('jsonmaxcontainerdepth', $jsonmaxcontainerdepth) }
            if ($PSBoundParameters.ContainsKey('jsonmaxdocumentlengthcheck')) { $Payload.Add('jsonmaxdocumentlengthcheck', $jsonmaxdocumentlengthcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxdocumentlength')) { $Payload.Add('jsonmaxdocumentlength', $jsonmaxdocumentlength) }
            if ($PSBoundParameters.ContainsKey('jsonmaxobjectkeycountcheck')) { $Payload.Add('jsonmaxobjectkeycountcheck', $jsonmaxobjectkeycountcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxobjectkeycount')) { $Payload.Add('jsonmaxobjectkeycount', $jsonmaxobjectkeycount) }
            if ($PSBoundParameters.ContainsKey('jsonmaxobjectkeylengthcheck')) { $Payload.Add('jsonmaxobjectkeylengthcheck', $jsonmaxobjectkeylengthcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxobjectkeylength')) { $Payload.Add('jsonmaxobjectkeylength', $jsonmaxobjectkeylength) }
            if ($PSBoundParameters.ContainsKey('jsonmaxarraylengthcheck')) { $Payload.Add('jsonmaxarraylengthcheck', $jsonmaxarraylengthcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxarraylength')) { $Payload.Add('jsonmaxarraylength', $jsonmaxarraylength) }
            if ($PSBoundParameters.ContainsKey('jsonmaxstringlengthcheck')) { $Payload.Add('jsonmaxstringlengthcheck', $jsonmaxstringlengthcheck) }
            if ($PSBoundParameters.ContainsKey('jsonmaxstringlength')) { $Payload.Add('jsonmaxstringlength', $jsonmaxstringlength) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_jsondosurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsondosurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsondosurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilejsondosurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilejsondosurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER jsondosurl 
       The URL on which we need to enforce the specified JSON denial-of-service (JSONDoS) attack protections. An JSON DoS configuration consists of the following items: * URL. PCRE-format regular expression for the URL. * Maximum-document-length-check toggle. ON to enable this check, OFF to disable it. * Maximum document length. Positive integer representing the maximum length of the JSON document. * Maximum-container-depth-check toggle. ON to enable, OFF to disable. * Maximum container depth. Positive integer representing the maximum container depth of the JSON document. * Maximum-object-key-count-check toggle. ON to enable, OFF to disable. * Maximum object key count. Positive integer representing the maximum allowed number of keys in any of the JSON object. * Maximum-object-key-length-check toggle. ON to enable, OFF to disable. * Maximum object key length. Positive integer representing the maximum allowed length of key in any of the JSON object. * Maximum-array-value-count-check toggle. ON to enable, OFF to disable. * Maximum array value count. Positive integer representing the maximum allowed number of values in any of the JSON array. * Maximum-string-length-check toggle. ON to enable, OFF to disable. * Maximum string length. Positive integer representing the maximum length of string in JSON.  
       Minimum length = 1  
       Maximum length = 2047
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilejsondosurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsondosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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

        [string]$jsondosurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsondosurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('jsondosurl')) { $Arguments.Add('jsondosurl', $jsondosurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsondosurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilejsondosurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_jsondosurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsondosurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsondosurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsondosurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsondosurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsondosurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsondosurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsondosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsondosurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_jsondosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsondosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilejsondosurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilejsonsqlurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER jsonsqlurl 
        A regular expression that designates a URL on the Json SQL URL list for which SQL violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters.  
        Minimum length = 1  
        Maximum length = 2047 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsonsqlurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilejsonsqlurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsonsqlurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateLength(1, 2047)]
        [string]$jsonsqlurl ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonsqlurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('jsonsqlurl')) { $Payload.Add('jsonsqlurl', $jsonsqlurl) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_jsonsqlurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsonsqlurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonsqlurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER jsonsqlurl 
       A regular expression that designates a URL on the Json SQL URL list for which SQL violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters.  
       Minimum length = 1  
       Maximum length = 2047
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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

        [string]$jsonsqlurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('jsonsqlurl')) { $Arguments.Add('jsonsqlurl', $jsonsqlurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilejsonsqlurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_jsonsqlurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsonsqlurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonsqlurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsonsqlurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonsqlurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsonsqlurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonsqlurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_jsonsqlurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsonsqlurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonsqlurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilejsonxssurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER jsonxssurl 
        A regular expression that designates a URL on the Json XSS URL list for which XSS violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters.  
        Minimum length = 1  
        Maximum length = 2047 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsonxssurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilejsonxssurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsonxssurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateLength(1, 2047)]
        [string]$jsonxssurl ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonxssurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('jsonxssurl')) { $Payload.Add('jsonxssurl', $jsonxssurl) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_jsonxssurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsonxssurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsonxssurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonxssurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilejsonxssurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER jsonxssurl 
       A regular expression that designates a URL on the Json XSS URL list for which XSS violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters.  
       Minimum length = 1  
       Maximum length = 2047
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilejsonxssurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsonxssurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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

        [string]$jsonxssurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonxssurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('jsonxssurl')) { $Arguments.Add('jsonxssurl', $jsonxssurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonxssurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilejsonxssurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_jsonxssurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsonxssurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonxssurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsonxssurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilejsonxssurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonxssurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilejsonxssurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsonxssurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonxssurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_jsonxssurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsonxssurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonxssurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilelogexpressionbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logexpression 
        Name of LogExpression object. 
    .PARAMETER as_logexpression 
        LogExpression to log when violation happened on appfw profile.  
        Maximum length = 1500 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_logexpression_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilelogexpressionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilelogexpressionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$logexpression ,

        [string]$as_logexpression ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilelogexpressionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('logexpression')) { $Payload.Add('logexpression', $logexpression) }
            if ($PSBoundParameters.ContainsKey('as_logexpression')) { $Payload.Add('as_logexpression', $as_logexpression) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_logexpression_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_logexpression_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilelogexpressionbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilelogexpressionbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilelogexpressionbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER logexpression 
       Name of LogExpression object.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilelogexpressionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilelogexpressionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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

        [string]$logexpression 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilelogexpressionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('logexpression')) { $Arguments.Add('logexpression', $logexpression) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilelogexpressionbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilelogexpressionbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_logexpression_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_logexpression_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilelogexpressionbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilelogexpressionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilelogexpressionbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilelogexpressionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilelogexpressionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilelogexpressionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilelogexpressionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_logexpression_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_logexpression_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilelogexpressionbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilesafeobjectbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER safeobject 
        Name of the Safe Object. 
    .PARAMETER as_expression 
        A regular expression that defines the Safe Object. 
    .PARAMETER maxmatchlength 
        Maximum match length for a Safe Object expression. 
    .PARAMETER action 
        Safe Object action types. (BLOCK | LOG | STATS | NONE).  
        Possible values = none, block, log, remove, stats, xout 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_safeobject_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilesafeobjectbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilesafeobjectbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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

        [string]$safeobject ,

        [string]$as_expression ,

        [double]$maxmatchlength ,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats', 'xout')]
        [string[]]$action ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilesafeobjectbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('safeobject')) { $Payload.Add('safeobject', $safeobject) }
            if ($PSBoundParameters.ContainsKey('as_expression')) { $Payload.Add('as_expression', $as_expression) }
            if ($PSBoundParameters.ContainsKey('maxmatchlength')) { $Payload.Add('maxmatchlength', $maxmatchlength) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_safeobject_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_safeobject_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilesafeobjectbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilesafeobjectbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilesafeobjectbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER safeobject 
       Name of the Safe Object.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilesafeobjectbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilesafeobjectbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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

        [string]$safeobject 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesafeobjectbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('safeobject')) { $Arguments.Add('safeobject', $safeobject) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesafeobjectbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilesafeobjectbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_safeobject_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_safeobject_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesafeobjectbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilesafeobjectbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilesafeobjectbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesafeobjectbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesafeobjectbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilesafeobjectbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilesafeobjectbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_safeobject_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_safeobject_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilesafeobjectbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilesqlinjectionbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER sqlinjection 
        The web form field name. 
    .PARAMETER formactionurl_sql 
        The web form action URL. 
    .PARAMETER isregex_sql 
        Is the web form field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER as_scan_location_sql 
        Location of SQL injection exception - form field, header or cookie.  
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER as_value_type_sql 
        The web form value type.  
        Possible values = Keyword, SpecialString, Wildchar 
    .PARAMETER as_value_expr_sql 
        The web form value expression. 
    .PARAMETER isvalueregex_sql 
        Is the web form field value a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_sqlinjection_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilesqlinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilesqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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

        [string]$sqlinjection ,

        [string]$formactionurl_sql ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_sql ,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE')]
        [string]$as_scan_location_sql ,

        [ValidateSet('Keyword', 'SpecialString', 'Wildchar')]
        [string]$as_value_type_sql ,

        [string]$as_value_expr_sql ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isvalueregex_sql ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilesqlinjectionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sqlinjection')) { $Payload.Add('sqlinjection', $sqlinjection) }
            if ($PSBoundParameters.ContainsKey('formactionurl_sql')) { $Payload.Add('formactionurl_sql', $formactionurl_sql) }
            if ($PSBoundParameters.ContainsKey('isregex_sql')) { $Payload.Add('isregex_sql', $isregex_sql) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_sql')) { $Payload.Add('as_scan_location_sql', $as_scan_location_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_type_sql')) { $Payload.Add('as_value_type_sql', $as_value_type_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_sql')) { $Payload.Add('as_value_expr_sql', $as_value_expr_sql) }
            if ($PSBoundParameters.ContainsKey('isvalueregex_sql')) { $Payload.Add('isvalueregex_sql', $isvalueregex_sql) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_sqlinjection_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_sqlinjection_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilesqlinjectionbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilesqlinjectionbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilesqlinjectionbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER sqlinjection 
       The web form field name.    .PARAMETER formactionurl_sql 
       The web form action URL.    .PARAMETER as_scan_location_sql 
       Location of SQL injection exception - form field, header or cookie.  
       Possible values = FORMFIELD, HEADER, COOKIE    .PARAMETER as_value_type_sql 
       The web form value type.  
       Possible values = Keyword, SpecialString, Wildchar    .PARAMETER as_value_expr_sql 
       The web form value expression.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilesqlinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilesqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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

        [string]$sqlinjection ,

        [string]$formactionurl_sql ,

        [string]$as_scan_location_sql ,

        [string]$as_value_type_sql ,

        [string]$as_value_expr_sql 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesqlinjectionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('sqlinjection')) { $Arguments.Add('sqlinjection', $sqlinjection) }
            if ($PSBoundParameters.ContainsKey('formactionurl_sql')) { $Arguments.Add('formactionurl_sql', $formactionurl_sql) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_sql')) { $Arguments.Add('as_scan_location_sql', $as_scan_location_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_type_sql')) { $Arguments.Add('as_value_type_sql', $as_value_type_sql) }
            if ($PSBoundParameters.ContainsKey('as_value_expr_sql')) { $Arguments.Add('as_value_expr_sql', $as_value_expr_sql) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesqlinjectionbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilesqlinjectionbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_sqlinjection_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_sqlinjection_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesqlinjectionbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilesqlinjectionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilesqlinjectionbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesqlinjectionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilesqlinjectionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilesqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilesqlinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_sqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_sqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilesqlinjectionbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilestarturlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER starturl 
        A regular expression that designates a URL on the Start URL list. 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_starturl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilestarturlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilestarturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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

        [string]$starturl ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilestarturlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('starturl')) { $Payload.Add('starturl', $starturl) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_starturl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_starturl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilestarturlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilestarturlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilestarturlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER starturl 
       A regular expression that designates a URL on the Start URL list.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilestarturlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilestarturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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

        [string]$starturl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilestarturlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('starturl')) { $Arguments.Add('starturl', $starturl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilestarturlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilestarturlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_starturl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_starturl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilestarturlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilestarturlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilestarturlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilestarturlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilestarturlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilestarturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilestarturlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_starturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_starturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_starturl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_starturl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_starturl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilestarturlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER trustedlearningclients 
        Specify trusted host/network IP. 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_trustedlearningclients_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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

        [string]$trustedlearningclients ,

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('trustedlearningclients')) { $Payload.Add('trustedlearningclients', $trustedlearningclients) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_trustedlearningclients_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_trustedlearningclients_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER trustedlearningclients 
       Specify trusted host/network IP.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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

        [string]$trustedlearningclients 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('trustedlearningclients')) { $Arguments.Add('trustedlearningclients', $trustedlearningclients) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_trustedlearningclients_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_trustedlearningclients_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_trustedlearningclients_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_trustedlearningclients_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmlattachmenturlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmlattachmenturl 
        XML attachment URL regular expression length. 
    .PARAMETER xmlmaxattachmentsizecheck 
        State if XML Max attachment size Check is ON or OFF. Protects against XML requests with large attachment data.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxattachmentsize 
        Specify maximum attachment size.  
        Minimum value = 0  
        Maximum value = 1000000000 
    .PARAMETER xmlattachmentcontenttypecheck 
        State if XML attachment content-type check is ON or OFF. Protects against XML requests with illegal attachments.  
        Possible values = ON, OFF 
    .PARAMETER xmlattachmentcontenttype 
        Specify content-type regular expression. 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlattachmenturl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmlattachmenturlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlattachmenturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmlattachmenturl ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxattachmentsizecheck ,

        [ValidateRange(0, 1000000000)]
        [double]$xmlmaxattachmentsize ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlattachmentcontenttypecheck ,

        [string]$xmlattachmentcontenttype ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlattachmenturlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmlattachmenturl')) { $Payload.Add('xmlattachmenturl', $xmlattachmenturl) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattachmentsizecheck')) { $Payload.Add('xmlmaxattachmentsizecheck', $xmlmaxattachmentsizecheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattachmentsize')) { $Payload.Add('xmlmaxattachmentsize', $xmlmaxattachmentsize) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentcontenttypecheck')) { $Payload.Add('xmlattachmentcontenttypecheck', $xmlattachmentcontenttypecheck) }
            if ($PSBoundParameters.ContainsKey('xmlattachmentcontenttype')) { $Payload.Add('xmlattachmentcontenttype', $xmlattachmentcontenttype) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmlattachmenturl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlattachmenturl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlattachmenturlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmlattachmenturl 
       XML attachment URL regular expression length.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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

        [string]$xmlattachmenturl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmlattachmenturl')) { $Arguments.Add('xmlattachmenturl', $xmlattachmenturl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmlattachmenturlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmlattachmenturl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlattachmenturl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlattachmenturlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlattachmenturlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlattachmenturlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmlattachmenturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlattachmenturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlattachmenturlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmldosurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmldosurl 
        XML DoS URL regular expression length. 
    .PARAMETER xmlmaxelementdepthcheck 
        State if XML Max element depth check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxelementdepth 
        Maximum nesting (depth) of XML elements. This check protects against documents that have excessive hierarchy depths. 
    .PARAMETER xmlmaxelementnamelengthcheck 
        State if XML Max element name length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxelementnamelength 
        Specify the longest name of any element (including the expanded namespace) to protect against overflow attacks. 
    .PARAMETER xmlmaxelementscheck 
        State if XML Max elements check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxelements 
        Specify the maximum number of XML elements allowed. Protects against overflow attacks. 
    .PARAMETER xmlmaxelementchildrencheck 
        State if XML Max element children check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxelementchildren 
        Specify the maximum number of children allowed per XML element. Protects against overflow attacks. 
    .PARAMETER xmlmaxnodescheck 
        State if XML Max nodes check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxnodes 
        Specify the maximum number of XML nodes. Protects against overflow attacks. 
    .PARAMETER xmlmaxattributescheck 
        State if XML Max attributes check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxattributes 
        Specify maximum number of attributes per XML element. Protects against overflow attacks. 
    .PARAMETER xmlmaxattributenamelengthcheck 
        State if XML Max attribute name length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxattributenamelength 
        Specify the longest name of any XML attribute. Protects against overflow attacks. 
    .PARAMETER xmlmaxattributevaluelengthcheck 
        State if XML Max atribute value length is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxattributevaluelength 
        Specify the longest value of any XML attribute. Protects against overflow attacks. 
    .PARAMETER xmlmaxchardatalengthcheck 
        State if XML Max CDATA length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxchardatalength 
        Specify the maximum size of CDATA. Protects against overflow attacks and large quantities of unparsed data within XML messages.  
        Minimum value = 0  
        Maximum value = 1000000000 
    .PARAMETER xmlmaxfilesizecheck 
        State if XML Max file size check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxfilesize 
        Specify the maximum size of XML messages. Protects against overflow attacks.  
        Minimum value = 0  
        Maximum value = 1000000000 
    .PARAMETER xmlminfilesizecheck 
        State if XML Min file size check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlminfilesize 
        Enforces minimum message size.  
        Minimum value = 0  
        Maximum value = 1000000000 
    .PARAMETER xmlblockpi 
        State if XML Block PI is ON or OFF. Protects resources from denial of service attacks as SOAP messages cannot have processing instructions (PI) in messages.  
        Possible values = ON, OFF 
    .PARAMETER xmlblockdtd 
        State if XML DTD is ON or OFF. Protects against recursive Document Type Declaration (DTD) entity expansion attacks. Also, SOAP messages cannot have DTDs in messages. .  
        Possible values = ON, OFF 
    .PARAMETER xmlblockexternalentities 
        State if XML Block External Entities Check is ON or OFF. Protects against XML External Entity (XXE) attacks that force applications to parse untrusted external entities (sources) in XML documents.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxentityexpansionscheck 
        State if XML Max Entity Expansions Check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxentityexpansions 
        Specify maximum allowed number of entity expansions. Protects aganist Entity Expansion Attack. 
    .PARAMETER xmlmaxentityexpansiondepthcheck 
        State if XML Max Entity Expansions Depth Check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxentityexpansiondepth 
        Specify maximum entity expansion depth. Protects aganist Entity Expansion Attack. 
    .PARAMETER xmlmaxnamespacescheck 
        State if XML Max namespaces check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxnamespaces 
        Specify maximum number of active namespaces. Protects against overflow attacks. 
    .PARAMETER xmlmaxnamespaceurilengthcheck 
        State if XML Max namespace URI length check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxnamespaceurilength 
        Specify the longest URI of any XML namespace. Protects against overflow attacks. 
    .PARAMETER xmlsoaparraycheck 
        State if XML SOAP Array check is ON or OFF.  
        Possible values = ON, OFF 
    .PARAMETER xmlmaxsoaparraysize 
        XML Max Total SOAP Array Size. Protects against SOAP Array Abuse attack.  
        Minimum value = 0  
        Maximum value = 1000000000 
    .PARAMETER xmlmaxsoaparrayrank 
        XML Max Individual SOAP Array Rank. This is the dimension of the SOAP array. 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmldosurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmldosurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmldosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmldosurl ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxelementdepthcheck ,

        [double]$xmlmaxelementdepth ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxelementnamelengthcheck ,

        [double]$xmlmaxelementnamelength ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxelementscheck ,

        [double]$xmlmaxelements ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxelementchildrencheck ,

        [double]$xmlmaxelementchildren ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxnodescheck ,

        [double]$xmlmaxnodes ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxattributescheck ,

        [double]$xmlmaxattributes ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxattributenamelengthcheck ,

        [double]$xmlmaxattributenamelength ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxattributevaluelengthcheck ,

        [double]$xmlmaxattributevaluelength ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxchardatalengthcheck ,

        [ValidateRange(0, 1000000000)]
        [double]$xmlmaxchardatalength ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxfilesizecheck ,

        [ValidateRange(0, 1000000000)]
        [double]$xmlmaxfilesize ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlminfilesizecheck ,

        [ValidateRange(0, 1000000000)]
        [double]$xmlminfilesize ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlblockpi ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlblockdtd ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlblockexternalentities ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxentityexpansionscheck ,

        [double]$xmlmaxentityexpansions ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxentityexpansiondepthcheck ,

        [double]$xmlmaxentityexpansiondepth ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxnamespacescheck ,

        [double]$xmlmaxnamespaces ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlmaxnamespaceurilengthcheck ,

        [double]$xmlmaxnamespaceurilength ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlsoaparraycheck ,

        [ValidateRange(0, 1000000000)]
        [double]$xmlmaxsoaparraysize ,

        [double]$xmlmaxsoaparrayrank ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmldosurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmldosurl')) { $Payload.Add('xmldosurl', $xmldosurl) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementdepthcheck')) { $Payload.Add('xmlmaxelementdepthcheck', $xmlmaxelementdepthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementdepth')) { $Payload.Add('xmlmaxelementdepth', $xmlmaxelementdepth) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementnamelengthcheck')) { $Payload.Add('xmlmaxelementnamelengthcheck', $xmlmaxelementnamelengthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementnamelength')) { $Payload.Add('xmlmaxelementnamelength', $xmlmaxelementnamelength) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementscheck')) { $Payload.Add('xmlmaxelementscheck', $xmlmaxelementscheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelements')) { $Payload.Add('xmlmaxelements', $xmlmaxelements) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementchildrencheck')) { $Payload.Add('xmlmaxelementchildrencheck', $xmlmaxelementchildrencheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxelementchildren')) { $Payload.Add('xmlmaxelementchildren', $xmlmaxelementchildren) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnodescheck')) { $Payload.Add('xmlmaxnodescheck', $xmlmaxnodescheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnodes')) { $Payload.Add('xmlmaxnodes', $xmlmaxnodes) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributescheck')) { $Payload.Add('xmlmaxattributescheck', $xmlmaxattributescheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributes')) { $Payload.Add('xmlmaxattributes', $xmlmaxattributes) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributenamelengthcheck')) { $Payload.Add('xmlmaxattributenamelengthcheck', $xmlmaxattributenamelengthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributenamelength')) { $Payload.Add('xmlmaxattributenamelength', $xmlmaxattributenamelength) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributevaluelengthcheck')) { $Payload.Add('xmlmaxattributevaluelengthcheck', $xmlmaxattributevaluelengthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxattributevaluelength')) { $Payload.Add('xmlmaxattributevaluelength', $xmlmaxattributevaluelength) }
            if ($PSBoundParameters.ContainsKey('xmlmaxchardatalengthcheck')) { $Payload.Add('xmlmaxchardatalengthcheck', $xmlmaxchardatalengthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxchardatalength')) { $Payload.Add('xmlmaxchardatalength', $xmlmaxchardatalength) }
            if ($PSBoundParameters.ContainsKey('xmlmaxfilesizecheck')) { $Payload.Add('xmlmaxfilesizecheck', $xmlmaxfilesizecheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxfilesize')) { $Payload.Add('xmlmaxfilesize', $xmlmaxfilesize) }
            if ($PSBoundParameters.ContainsKey('xmlminfilesizecheck')) { $Payload.Add('xmlminfilesizecheck', $xmlminfilesizecheck) }
            if ($PSBoundParameters.ContainsKey('xmlminfilesize')) { $Payload.Add('xmlminfilesize', $xmlminfilesize) }
            if ($PSBoundParameters.ContainsKey('xmlblockpi')) { $Payload.Add('xmlblockpi', $xmlblockpi) }
            if ($PSBoundParameters.ContainsKey('xmlblockdtd')) { $Payload.Add('xmlblockdtd', $xmlblockdtd) }
            if ($PSBoundParameters.ContainsKey('xmlblockexternalentities')) { $Payload.Add('xmlblockexternalentities', $xmlblockexternalentities) }
            if ($PSBoundParameters.ContainsKey('xmlmaxentityexpansionscheck')) { $Payload.Add('xmlmaxentityexpansionscheck', $xmlmaxentityexpansionscheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxentityexpansions')) { $Payload.Add('xmlmaxentityexpansions', $xmlmaxentityexpansions) }
            if ($PSBoundParameters.ContainsKey('xmlmaxentityexpansiondepthcheck')) { $Payload.Add('xmlmaxentityexpansiondepthcheck', $xmlmaxentityexpansiondepthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxentityexpansiondepth')) { $Payload.Add('xmlmaxentityexpansiondepth', $xmlmaxentityexpansiondepth) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnamespacescheck')) { $Payload.Add('xmlmaxnamespacescheck', $xmlmaxnamespacescheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnamespaces')) { $Payload.Add('xmlmaxnamespaces', $xmlmaxnamespaces) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnamespaceurilengthcheck')) { $Payload.Add('xmlmaxnamespaceurilengthcheck', $xmlmaxnamespaceurilengthcheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxnamespaceurilength')) { $Payload.Add('xmlmaxnamespaceurilength', $xmlmaxnamespaceurilength) }
            if ($PSBoundParameters.ContainsKey('xmlsoaparraycheck')) { $Payload.Add('xmlsoaparraycheck', $xmlsoaparraycheck) }
            if ($PSBoundParameters.ContainsKey('xmlmaxsoaparraysize')) { $Payload.Add('xmlmaxsoaparraysize', $xmlmaxsoaparraysize) }
            if ($PSBoundParameters.ContainsKey('xmlmaxsoaparrayrank')) { $Payload.Add('xmlmaxsoaparrayrank', $xmlmaxsoaparrayrank) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmldosurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmldosurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmldosurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmldosurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmldosurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmldosurl 
       XML DoS URL regular expression length.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmldosurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmldosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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

        [string]$xmldosurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmldosurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmldosurl')) { $Arguments.Add('xmldosurl', $xmldosurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmldosurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmldosurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmldosurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmldosurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmldosurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmldosurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmldosurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmldosurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmldosurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmldosurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmldosurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmldosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmldosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmldosurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmlsqlinjection 
        Exempt the specified URL from the XML SQL injection check. An XML SQL injection exemption (relaxation) consists of the following items: * Name. Name to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the injection is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER isregex_xmlsql 
        Is the XML SQL Injection exempted field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER as_scan_location_xmlsql 
        Location of SQL injection exception - XML Element or Attribute.  
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlsqlinjection_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmlsqlinjection ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_xmlsql ,

        [ValidateSet('ELEMENT', 'ATTRIBUTE')]
        [string]$as_scan_location_xmlsql ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjection')) { $Payload.Add('xmlsqlinjection', $xmlsqlinjection) }
            if ($PSBoundParameters.ContainsKey('isregex_xmlsql')) { $Payload.Add('isregex_xmlsql', $isregex_xmlsql) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xmlsql')) { $Payload.Add('as_scan_location_xmlsql', $as_scan_location_xmlsql) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmlsqlinjection_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlsqlinjection_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmlsqlinjection 
       Exempt the specified URL from the XML SQL injection check. An XML SQL injection exemption (relaxation) consists of the following items: * Name. Name to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the injection is located in an XML element, ATTRIBUTE if located in an XML attribute.    .PARAMETER as_scan_location_xmlsql 
       Location of SQL injection exception - XML Element or Attribute.  
       Possible values = ELEMENT, ATTRIBUTE
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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

        [string]$xmlsqlinjection ,

        [string]$as_scan_location_xmlsql 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmlsqlinjection')) { $Arguments.Add('xmlsqlinjection', $xmlsqlinjection) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xmlsql')) { $Arguments.Add('as_scan_location_xmlsql', $as_scan_location_xmlsql) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmlsqlinjection_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlsqlinjection_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmlsqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlsqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmlvalidationurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmlvalidationurl 
        XML Validation URL regular expression. 
    .PARAMETER xmlrequestschema 
        XML Schema object for request validation . 
    .PARAMETER xmlresponseschema 
        XML Schema object for response validation. 
    .PARAMETER xmlwsdl 
        WSDL object for soap request validation. 
    .PARAMETER xmladditionalsoapheaders 
        Allow addtional soap headers.  
        Possible values = ON, OFF 
    .PARAMETER xmlendpointcheck 
        Modifies the behaviour of the Request URL validation w.r.t. the Service URL. If set to ABSOLUTE, the entire request URL is validated with the entire URL mentioned in Service of the associated WSDL. eg: Service URL: http://example.org/ExampleService, Request URL: http//example.com/ExampleService would FAIL the validation. If set to RELAIVE, only the non-hostname part of the request URL is validated against the non-hostname part of the Service URL. eg: Service URL: http://example.org/ExampleService, Request URL: http//example.com/ExampleService would PASS the validation.  
        Possible values = ABSOLUTE, RELATIVE 
    .PARAMETER xmlvalidatesoapenvelope 
        Validate SOAP Evelope only.  
        Possible values = ON, OFF 
    .PARAMETER xmlvalidateresponse 
        Validate response message.  
        Possible values = ON, OFF 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlvalidationurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmlvalidationurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlvalidationurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmlvalidationurl ,

        [string]$xmlrequestschema ,

        [string]$xmlresponseschema ,

        [string]$xmlwsdl ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmladditionalsoapheaders ,

        [ValidateSet('ABSOLUTE', 'RELATIVE')]
        [string]$xmlendpointcheck ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlvalidatesoapenvelope ,

        [ValidateSet('ON', 'OFF')]
        [string]$xmlvalidateresponse ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlvalidationurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmlvalidationurl')) { $Payload.Add('xmlvalidationurl', $xmlvalidationurl) }
            if ($PSBoundParameters.ContainsKey('xmlrequestschema')) { $Payload.Add('xmlrequestschema', $xmlrequestschema) }
            if ($PSBoundParameters.ContainsKey('xmlresponseschema')) { $Payload.Add('xmlresponseschema', $xmlresponseschema) }
            if ($PSBoundParameters.ContainsKey('xmlwsdl')) { $Payload.Add('xmlwsdl', $xmlwsdl) }
            if ($PSBoundParameters.ContainsKey('xmladditionalsoapheaders')) { $Payload.Add('xmladditionalsoapheaders', $xmladditionalsoapheaders) }
            if ($PSBoundParameters.ContainsKey('xmlendpointcheck')) { $Payload.Add('xmlendpointcheck', $xmlendpointcheck) }
            if ($PSBoundParameters.ContainsKey('xmlvalidatesoapenvelope')) { $Payload.Add('xmlvalidatesoapenvelope', $xmlvalidatesoapenvelope) }
            if ($PSBoundParameters.ContainsKey('xmlvalidateresponse')) { $Payload.Add('xmlvalidateresponse', $xmlvalidateresponse) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmlvalidationurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlvalidationurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlvalidationurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmlvalidationurl 
       XML Validation URL regular expression.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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

        [string]$xmlvalidationurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmlvalidationurl')) { $Arguments.Add('xmlvalidationurl', $xmlvalidationurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmlvalidationurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmlvalidationurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlvalidationurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlvalidationurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlvalidationurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlvalidationurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmlvalidationurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlvalidationurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlvalidationurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmlwsiurlbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmlwsiurl 
        XML WS-I URL regular expression length. 
    .PARAMETER xmlwsichecks 
        Specify a comma separated list of relevant WS-I rule IDs. (R1140, R1141). 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlwsiurl_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmlwsiurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlwsiurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmlwsiurl ,

        [string]$xmlwsichecks ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlwsiurlbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmlwsiurl')) { $Payload.Add('xmlwsiurl', $xmlwsiurl) }
            if ($PSBoundParameters.ContainsKey('xmlwsichecks')) { $Payload.Add('xmlwsichecks', $xmlwsichecks) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmlwsiurl_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlwsiurl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlwsiurlbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmlwsiurl 
       XML WS-I URL regular expression length.
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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

        [string]$xmlwsiurl 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmlwsiurl')) { $Arguments.Add('xmlwsiurl', $xmlwsiurl) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmlwsiurlbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmlwsiurl_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlwsiurl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlwsiurlbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlwsiurlbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlwsiurlbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlwsiurlbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlwsiurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmlwsiurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlwsiurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlwsiurlbinding: Ended"
    }
}

function Invoke-ADCAddAppfwprofilexmlxssbinding {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER name 
        Name of the profile to which to bind an exemption or rule.  
        Minimum length = 1 
    .PARAMETER comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER state 
        Enabled.  
        Possible values = ENABLED, DISABLED 
    .PARAMETER xmlxss 
        Exempt the specified URL from the XML cross-site scripting (XSS) check. An XML cross-site scripting exemption (relaxation) consists of the following items: * URL. URL to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the attachment is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER isregex_xmlxss 
        Is the XML XSS exempted field name a regular expression?.  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER as_scan_location_xmlxss 
        Location of XSS injection exception - XML Element or Attribute.  
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER isautodeployed 
        Is the rule auto deployed by dynamic profile ?.  
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlxss_binding item.
    .EXAMPLE
        Invoke-ADCAddAppfwprofilexmlxssbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlxssbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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

        [string]$comment ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state ,

        [string]$xmlxss ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex_xmlxss ,

        [ValidateSet('ELEMENT', 'ATTRIBUTE')]
        [string]$as_scan_location_xmlxss ,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$isautodeployed ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlxssbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('xmlxss')) { $Payload.Add('xmlxss', $xmlxss) }
            if ($PSBoundParameters.ContainsKey('isregex_xmlxss')) { $Payload.Add('isregex_xmlxss', $isregex_xmlxss) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xmlxss')) { $Payload.Add('as_scan_location_xmlxss', $as_scan_location_xmlxss) }
            if ($PSBoundParameters.ContainsKey('isautodeployed')) { $Payload.Add('isautodeployed', $isautodeployed) }
 
            if ($PSCmdlet.ShouldProcess("appfwprofile_xmlxss_binding", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlxss_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlxssbinding -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlxssbinding: Finished"
    }
}

function Invoke-ADCDeleteAppfwprofilexmlxssbinding {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule.  
       Minimum length = 1    .PARAMETER xmlxss 
       Exempt the specified URL from the XML cross-site scripting (XSS) check. An XML cross-site scripting exemption (relaxation) consists of the following items: * URL. URL to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the attachment is located in an XML element, ATTRIBUTE if located in an XML attribute.    .PARAMETER as_scan_location_xmlxss 
       Location of XSS injection exception - XML Element or Attribute.  
       Possible values = ELEMENT, ATTRIBUTE
    .EXAMPLE
        Invoke-ADCDeleteAppfwprofilexmlxssbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlxssbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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

        [string]$xmlxss ,

        [string]$as_scan_location_xmlxss 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlxssbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('xmlxss')) { $Arguments.Add('xmlxss', $xmlxss) }
            if ($PSBoundParameters.ContainsKey('as_scan_location_xmlxss')) { $Arguments.Add('as_scan_location_xmlxss', $as_scan_location_xmlxss) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlxssbinding: Finished"
    }
}

function Invoke-ADCGetAppfwprofilexmlxssbinding {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retreive all appfwprofile_xmlxss_binding object(s)
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlxss_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlxssbinding
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlxssbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwprofilexmlxssbinding -Count
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlxssbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwprofilexmlxssbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlxssbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlxssbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all appfwprofile_xmlxss_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlxss_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlxssbinding: Ended"
    }
}

function Invoke-ADCUpdateAppfwsettings {
<#
    .SYNOPSIS
        Update Application Firewall configuration Object
    .DESCRIPTION
        Update Application Firewall configuration Object 
    .PARAMETER defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is APPFW_BYPASS, which sends unmatched connections back to the Citrix ADC without attempting to filter them further.  
        Default value: APPFW_BYPASS  
        Minimum length = 1 
    .PARAMETER undefaction 
        Profile to use when an application firewall policy evaluates to undefined (UNDEF).  
        An UNDEF event indicates an internal error condition. The APPFW_BLOCK built-in profile is the default setting. You can specify a different built-in or user-created profile as the UNDEF profile.  
        Default value: APPFW_BLOCK  
        Minimum length = 1 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL.  
        Default value: 900  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER learnratelimit 
        Maximum number of connections per second that the application firewall learning engine examines to generate new relaxations for learning-enabled security checks. The application firewall drops any connections above this limit from the list of connections used by the learning engine.  
        Default value: 400  
        Minimum value = 1  
        Maximum value = 1000 
    .PARAMETER sessionlifetime 
        Maximum amount of time (in seconds) that the application firewall allows a user session to remain active, regardless of user activity. After this time, the user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 2147483647 
    .PARAMETER sessioncookiename 
        Name of the session cookie that the application firewall uses to track user sessions.  
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER clientiploggingheader 
        Name of an HTTP header that contains the IP address that the client used to connect to the protected web site or service. 
    .PARAMETER importsizelimit 
        Cumulative total maximum number of bytes in web forms imported to a protected web site. If a user attempts to upload files with a total byte count higher than the specified limit, the application firewall blocks the request.  
        Default value: 134217728  
        Minimum value = 1  
        Maximum value = 268435456 
    .PARAMETER signatureautoupdate 
        Flag used to enable/disable auto update signatures.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER signatureurl 
        URL to download the mapping file from server.  
        Default value: https://s3.amazonaws.com/NSAppFwSignatures/SignaturesMapping.xml 
    .PARAMETER cookiepostencryptprefix 
        String that is prepended to all encrypted cookie values.  
        Minimum length = 1 
    .PARAMETER logmalformedreq 
        Log requests that are so malformed that application firewall parsing doesn't occur.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER geolocationlogging 
        Enable Geo-Location Logging in CEF format logs.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER ceflogging 
        Enable CEF format logs.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER entitydecoding 
        Transform multibyte (double- or half-width) characters to single width characters.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER useconfigurablesecretkey 
        Use configurable secret key in AppFw operations.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER sessionlimit 
        Maximum number of sessions that the application firewall allows to be active, regardless of user activity. After the max_limit reaches, No more user session will be created .  
        Default value: 100000  
        Minimum value = 0  
        Maximum value = 500000 
    .PARAMETER malformedreqaction 
        flag to define action on malformed requests that application firewall cannot parse.  
        Possible values = none, block, log, stats 
    .PARAMETER centralizedlearning 
        Flag used to enable/disable ADM centralized learning.  
        Default value: OFF  
        Possible values = ON, OFF
    .EXAMPLE
        Invoke-ADCUpdateAppfwsettings 
    .NOTES
        File Name : Invoke-ADCUpdateAppfwsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings/
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
        [string]$defaultprofile ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$undefaction ,

        [ValidateRange(1, 65535)]
        [double]$sessiontimeout ,

        [ValidateRange(1, 1000)]
        [double]$learnratelimit ,

        [ValidateRange(0, 2147483647)]
        [double]$sessionlifetime ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sessioncookiename ,

        [string]$clientiploggingheader ,

        [ValidateRange(1, 268435456)]
        [double]$importsizelimit ,

        [ValidateSet('ON', 'OFF')]
        [string]$signatureautoupdate ,

        [string]$signatureurl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookiepostencryptprefix ,

        [ValidateSet('ON', 'OFF')]
        [string]$logmalformedreq ,

        [ValidateSet('ON', 'OFF')]
        [string]$geolocationlogging ,

        [ValidateSet('ON', 'OFF')]
        [string]$ceflogging ,

        [ValidateSet('ON', 'OFF')]
        [string]$entitydecoding ,

        [ValidateSet('ON', 'OFF')]
        [string]$useconfigurablesecretkey ,

        [ValidateRange(0, 500000)]
        [double]$sessionlimit ,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$malformedreqaction ,

        [ValidateSet('ON', 'OFF')]
        [string]$centralizedlearning 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('learnratelimit')) { $Payload.Add('learnratelimit', $learnratelimit) }
            if ($PSBoundParameters.ContainsKey('sessionlifetime')) { $Payload.Add('sessionlifetime', $sessionlifetime) }
            if ($PSBoundParameters.ContainsKey('sessioncookiename')) { $Payload.Add('sessioncookiename', $sessioncookiename) }
            if ($PSBoundParameters.ContainsKey('clientiploggingheader')) { $Payload.Add('clientiploggingheader', $clientiploggingheader) }
            if ($PSBoundParameters.ContainsKey('importsizelimit')) { $Payload.Add('importsizelimit', $importsizelimit) }
            if ($PSBoundParameters.ContainsKey('signatureautoupdate')) { $Payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ($PSBoundParameters.ContainsKey('signatureurl')) { $Payload.Add('signatureurl', $signatureurl) }
            if ($PSBoundParameters.ContainsKey('cookiepostencryptprefix')) { $Payload.Add('cookiepostencryptprefix', $cookiepostencryptprefix) }
            if ($PSBoundParameters.ContainsKey('logmalformedreq')) { $Payload.Add('logmalformedreq', $logmalformedreq) }
            if ($PSBoundParameters.ContainsKey('geolocationlogging')) { $Payload.Add('geolocationlogging', $geolocationlogging) }
            if ($PSBoundParameters.ContainsKey('ceflogging')) { $Payload.Add('ceflogging', $ceflogging) }
            if ($PSBoundParameters.ContainsKey('entitydecoding')) { $Payload.Add('entitydecoding', $entitydecoding) }
            if ($PSBoundParameters.ContainsKey('useconfigurablesecretkey')) { $Payload.Add('useconfigurablesecretkey', $useconfigurablesecretkey) }
            if ($PSBoundParameters.ContainsKey('sessionlimit')) { $Payload.Add('sessionlimit', $sessionlimit) }
            if ($PSBoundParameters.ContainsKey('malformedreqaction')) { $Payload.Add('malformedreqaction', $malformedreqaction) }
            if ($PSBoundParameters.ContainsKey('centralizedlearning')) { $Payload.Add('centralizedlearning', $centralizedlearning) }
 
            if ($PSCmdlet.ShouldProcess("appfwsettings", "Update Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwsettings -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAppfwsettings: Finished"
    }
}

function Invoke-ADCUnsetAppfwsettings {
<#
    .SYNOPSIS
        Unset Application Firewall configuration Object
    .DESCRIPTION
        Unset Application Firewall configuration Object 
   .PARAMETER defaultprofile 
       Profile to use when a connection does not match any policy. Default setting is APPFW_BYPASS, which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
   .PARAMETER undefaction 
       Profile to use when an application firewall policy evaluates to undefined (UNDEF).  
       An UNDEF event indicates an internal error condition. The APPFW_BLOCK built-in profile is the default setting. You can specify a different built-in or user-created profile as the UNDEF profile. 
   .PARAMETER sessiontimeout 
       Timeout, in seconds, after which a user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
   .PARAMETER learnratelimit 
       Maximum number of connections per second that the application firewall learning engine examines to generate new relaxations for learning-enabled security checks. The application firewall drops any connections above this limit from the list of connections used by the learning engine. 
   .PARAMETER sessionlifetime 
       Maximum amount of time (in seconds) that the application firewall allows a user session to remain active, regardless of user activity. After this time, the user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
   .PARAMETER sessioncookiename 
       Name of the session cookie that the application firewall uses to track user sessions.  
       Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
   .PARAMETER clientiploggingheader 
       Name of an HTTP header that contains the IP address that the client used to connect to the protected web site or service. 
   .PARAMETER importsizelimit 
       Cumulative total maximum number of bytes in web forms imported to a protected web site. If a user attempts to upload files with a total byte count higher than the specified limit, the application firewall blocks the request. 
   .PARAMETER signatureautoupdate 
       Flag used to enable/disable auto update signatures.  
       Possible values = ON, OFF 
   .PARAMETER signatureurl 
       URL to download the mapping file from server. 
   .PARAMETER cookiepostencryptprefix 
       String that is prepended to all encrypted cookie values. 
   .PARAMETER logmalformedreq 
       Log requests that are so malformed that application firewall parsing doesn't occur.  
       Possible values = ON, OFF 
   .PARAMETER geolocationlogging 
       Enable Geo-Location Logging in CEF format logs.  
       Possible values = ON, OFF 
   .PARAMETER ceflogging 
       Enable CEF format logs.  
       Possible values = ON, OFF 
   .PARAMETER entitydecoding 
       Transform multibyte (double- or half-width) characters to single width characters.  
       Possible values = ON, OFF 
   .PARAMETER useconfigurablesecretkey 
       Use configurable secret key in AppFw operations.  
       Possible values = ON, OFF 
   .PARAMETER sessionlimit 
       Maximum number of sessions that the application firewall allows to be active, regardless of user activity. After the max_limit reaches, No more user session will be created . 
   .PARAMETER malformedreqaction 
       flag to define action on malformed requests that application firewall cannot parse.  
       Possible values = none, block, log, stats 
   .PARAMETER centralizedlearning 
       Flag used to enable/disable ADM centralized learning.  
       Possible values = ON, OFF
    .EXAMPLE
        Invoke-ADCUnsetAppfwsettings 
    .NOTES
        File Name : Invoke-ADCUnsetAppfwsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings
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

        [Boolean]$defaultprofile ,

        [Boolean]$undefaction ,

        [Boolean]$sessiontimeout ,

        [Boolean]$learnratelimit ,

        [Boolean]$sessionlifetime ,

        [Boolean]$sessioncookiename ,

        [Boolean]$clientiploggingheader ,

        [Boolean]$importsizelimit ,

        [Boolean]$signatureautoupdate ,

        [Boolean]$signatureurl ,

        [Boolean]$cookiepostencryptprefix ,

        [Boolean]$logmalformedreq ,

        [Boolean]$geolocationlogging ,

        [Boolean]$ceflogging ,

        [Boolean]$entitydecoding ,

        [Boolean]$useconfigurablesecretkey ,

        [Boolean]$sessionlimit ,

        [Boolean]$malformedreqaction ,

        [Boolean]$centralizedlearning 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('defaultprofile')) { $Payload.Add('defaultprofile', $defaultprofile) }
            if ($PSBoundParameters.ContainsKey('undefaction')) { $Payload.Add('undefaction', $undefaction) }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('learnratelimit')) { $Payload.Add('learnratelimit', $learnratelimit) }
            if ($PSBoundParameters.ContainsKey('sessionlifetime')) { $Payload.Add('sessionlifetime', $sessionlifetime) }
            if ($PSBoundParameters.ContainsKey('sessioncookiename')) { $Payload.Add('sessioncookiename', $sessioncookiename) }
            if ($PSBoundParameters.ContainsKey('clientiploggingheader')) { $Payload.Add('clientiploggingheader', $clientiploggingheader) }
            if ($PSBoundParameters.ContainsKey('importsizelimit')) { $Payload.Add('importsizelimit', $importsizelimit) }
            if ($PSBoundParameters.ContainsKey('signatureautoupdate')) { $Payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ($PSBoundParameters.ContainsKey('signatureurl')) { $Payload.Add('signatureurl', $signatureurl) }
            if ($PSBoundParameters.ContainsKey('cookiepostencryptprefix')) { $Payload.Add('cookiepostencryptprefix', $cookiepostencryptprefix) }
            if ($PSBoundParameters.ContainsKey('logmalformedreq')) { $Payload.Add('logmalformedreq', $logmalformedreq) }
            if ($PSBoundParameters.ContainsKey('geolocationlogging')) { $Payload.Add('geolocationlogging', $geolocationlogging) }
            if ($PSBoundParameters.ContainsKey('ceflogging')) { $Payload.Add('ceflogging', $ceflogging) }
            if ($PSBoundParameters.ContainsKey('entitydecoding')) { $Payload.Add('entitydecoding', $entitydecoding) }
            if ($PSBoundParameters.ContainsKey('useconfigurablesecretkey')) { $Payload.Add('useconfigurablesecretkey', $useconfigurablesecretkey) }
            if ($PSBoundParameters.ContainsKey('sessionlimit')) { $Payload.Add('sessionlimit', $sessionlimit) }
            if ($PSBoundParameters.ContainsKey('malformedreqaction')) { $Payload.Add('malformedreqaction', $malformedreqaction) }
            if ($PSBoundParameters.ContainsKey('centralizedlearning')) { $Payload.Add('centralizedlearning', $centralizedlearning) }
            if ($PSCmdlet.ShouldProcess("appfwsettings", "Unset Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwsettings -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAppfwsettings: Finished"
    }
}

function Invoke-ADCGetAppfwsettings {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER GetAll 
        Retreive all appfwsettings object(s)
    .PARAMETER Count
        If specified, the count of the appfwsettings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwsettings
    .EXAMPLE 
        Invoke-ADCGetAppfwsettings -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwsettings -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwsettings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings/
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
        Write-Verbose "Invoke-ADCGetAppfwsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwsettings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwsettings: Ended"
    }
}

function Invoke-ADCDeleteAppfwsignatures {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the signature object.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwsignatures -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwsignatures
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        Write-Verbose "Invoke-ADCDeleteAppfwsignatures: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwsignatures -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwsignatures: Finished"
    }
}

function Invoke-ADCImportAppfwsignatures {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and file name) for the location at which to store the imported signatures object.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Name of the signature object. 
    .PARAMETER xslt 
        XSLT file source. 
    .PARAMETER comment 
        Any comments to preserve information about the signatures object. 
    .PARAMETER overwrite 
        Overwrite any existing signatures object of the same name. 
    .PARAMETER merge 
        Merges the existing Signature with new signature rules. 
    .PARAMETER preservedefactions 
        preserves def actions of signature rules. 
    .PARAMETER sha1 
        File path for sha1 file to validate signature file. 
    .PARAMETER vendortype 
        Third party vendor type for which WAF signatures has to be generated.  
        Possible values = Snort
    .EXAMPLE
        Invoke-ADCImportAppfwsignatures -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwsignatures
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$xslt ,

        [string]$comment ,

        [boolean]$overwrite ,

        [boolean]$merge ,

        [boolean]$preservedefactions ,

        [ValidateLength(1, 2047)]
        [string]$sha1 ,

        [ValidateSet('Snort')]
        [string]$vendortype 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwsignatures: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('xslt')) { $Payload.Add('xslt', $xslt) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSBoundParameters.ContainsKey('merge')) { $Payload.Add('merge', $merge) }
            if ($PSBoundParameters.ContainsKey('preservedefactions')) { $Payload.Add('preservedefactions', $preservedefactions) }
            if ($PSBoundParameters.ContainsKey('sha1')) { $Payload.Add('sha1', $sha1) }
            if ($PSBoundParameters.ContainsKey('vendortype')) { $Payload.Add('vendortype', $vendortype) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwsignatures -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwsignatures: Finished"
    }
}

function Invoke-ADCChangeAppfwsignatures {
<#
    .SYNOPSIS
        Change Application Firewall configuration Object
    .DESCRIPTION
        Change Application Firewall configuration Object 
    .PARAMETER name 
        Name of the signature object.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER mergedefault 
        Merges signature file with default signature file. 
    .PARAMETER PassThru 
        Return details about the created appfwsignatures item.
    .EXAMPLE
        Invoke-ADCChangeAppfwsignatures -name <string>
    .NOTES
        File Name : Invoke-ADCChangeAppfwsignatures
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        [string]$name ,

        [boolean]$mergedefault ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwsignatures: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('mergedefault')) { $Payload.Add('mergedefault', $mergedefault) }
 
            if ($PSCmdlet.ShouldProcess("appfwsignatures", "Change Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwsignatures -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwsignatures -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeAppfwsignatures: Finished"
    }
}

function Invoke-ADCGetAppfwsignatures {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the signature object. 
    .PARAMETER GetAll 
        Retreive all appfwsignatures object(s)
    .PARAMETER Count
        If specified, the count of the appfwsignatures object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwsignatures
    .EXAMPLE 
        Invoke-ADCGetAppfwsignatures -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwsignatures -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwsignatures -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwsignatures
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwsignatures: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwsignatures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwsignatures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwsignatures objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwsignatures configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwsignatures configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwsignatures: Ended"
    }
}

function Invoke-ADCGetAppfwtransactionrecords {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all appfwtransactionrecords object(s)
    .PARAMETER Count
        If specified, the count of the appfwtransactionrecords object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwtransactionrecords
    .EXAMPLE 
        Invoke-ADCGetAppfwtransactionrecords -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwtransactionrecords -Count
    .EXAMPLE
        Invoke-ADCGetAppfwtransactionrecords -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwtransactionrecords -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwtransactionrecords
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwtransactionrecords/
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
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwtransactionrecords: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwtransactionrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwtransactionrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwtransactionrecords objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwtransactionrecords configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwtransactionrecords configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwtransactionrecords: Ended"
    }
}

function Invoke-ADCAddAppfwurlencodedformcontenttype {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER urlencodedformcontenttypevalue 
        Content type to be classified as urlencoded form.  
        Minimum length = 1 
    .PARAMETER isregex 
        Is urlencoded form content type a regular expression?.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwurlencodedformcontenttype item.
    .EXAMPLE
        Invoke-ADCAddAppfwurlencodedformcontenttype -urlencodedformcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwurlencodedformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$urlencodedformcontenttypevalue ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex = 'NOTREGEX' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwurlencodedformcontenttype: Starting"
    }
    process {
        try {
            $Payload = @{
                urlencodedformcontenttypevalue = $urlencodedformcontenttypevalue
            }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
 
            if ($PSCmdlet.ShouldProcess("appfwurlencodedformcontenttype", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwurlencodedformcontenttype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwurlencodedformcontenttype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwurlencodedformcontenttype: Finished"
    }
}

function Invoke-ADCDeleteAppfwurlencodedformcontenttype {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER urlencodedformcontenttypevalue 
       Content type to be classified as urlencoded form.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAppfwurlencodedformcontenttype -urlencodedformcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwurlencodedformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$urlencodedformcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwurlencodedformcontenttype: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$urlencodedformcontenttypevalue", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Resource $urlencodedformcontenttypevalue -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwurlencodedformcontenttype: Finished"
    }
}

function Invoke-ADCGetAppfwurlencodedformcontenttype {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER urlencodedformcontenttypevalue 
       Content type to be classified as urlencoded form. 
    .PARAMETER GetAll 
        Retreive all appfwurlencodedformcontenttype object(s)
    .PARAMETER Count
        If specified, the count of the appfwurlencodedformcontenttype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwurlencodedformcontenttype
    .EXAMPLE 
        Invoke-ADCGetAppfwurlencodedformcontenttype -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwurlencodedformcontenttype -Count
    .EXAMPLE
        Invoke-ADCGetAppfwurlencodedformcontenttype -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwurlencodedformcontenttype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwurlencodedformcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$urlencodedformcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwurlencodedformcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwurlencodedformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwurlencodedformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype configuration for property 'urlencodedformcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Resource $urlencodedformcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwurlencodedformcontenttype: Ended"
    }
}

function Invoke-ADCDeleteAppfwwsdl {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the WSDL file to remove.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwwsdl -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwwsdl
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        Write-Verbose "Invoke-ADCDeleteAppfwwsdl: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwwsdl -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwwsdl: Finished"
    }
}

function Invoke-ADCImportAppfwwsdl {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and name) of the WSDL file to be imported is stored.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Name of the WSDL file to remove. 
    .PARAMETER comment 
        Any comments to preserve information about the WSDL. 
    .PARAMETER overwrite 
        Overwrite any existing WSDL of the same name.
    .EXAMPLE
        Invoke-ADCImportAppfwwsdl -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwwsdl
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwwsdl: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwwsdl -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwwsdl: Finished"
    }
}

function Invoke-ADCGetAppfwwsdl {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the WSDL file to remove. 
    .PARAMETER GetAll 
        Retreive all appfwwsdl object(s)
    .PARAMETER Count
        If specified, the count of the appfwwsdl object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwwsdl
    .EXAMPLE 
        Invoke-ADCGetAppfwwsdl -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwwsdl -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwwsdl -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwwsdl
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwwsdl: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwwsdl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwwsdl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwwsdl objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwwsdl configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwwsdl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwwsdl: Ended"
    }
}

function Invoke-ADCAddAppfwxmlcontenttype {
<#
    .SYNOPSIS
        Add Application Firewall configuration Object
    .DESCRIPTION
        Add Application Firewall configuration Object 
    .PARAMETER xmlcontenttypevalue 
        Content type to be classified as XML.  
        Minimum length = 1 
    .PARAMETER isregex 
        Is field name a regular expression?.  
        Default value: NOTREGEX  
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwxmlcontenttype item.
    .EXAMPLE
        Invoke-ADCAddAppfwxmlcontenttype -xmlcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCAddAppfwxmlcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$xmlcontenttypevalue ,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$isregex = 'NOTREGEX' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwxmlcontenttype: Starting"
    }
    process {
        try {
            $Payload = @{
                xmlcontenttypevalue = $xmlcontenttypevalue
            }
            if ($PSBoundParameters.ContainsKey('isregex')) { $Payload.Add('isregex', $isregex) }
 
            if ($PSCmdlet.ShouldProcess("appfwxmlcontenttype", "Add Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlcontenttype -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwxmlcontenttype -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddAppfwxmlcontenttype: Finished"
    }
}

function Invoke-ADCDeleteAppfwxmlcontenttype {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER xmlcontenttypevalue 
       Content type to be classified as XML.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAppfwxmlcontenttype -xmlcontenttypevalue <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$xmlcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwxmlcontenttype: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$xmlcontenttypevalue", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Resource $xmlcontenttypevalue -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlcontenttype: Finished"
    }
}

function Invoke-ADCGetAppfwxmlcontenttype {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER xmlcontenttypevalue 
       Content type to be classified as XML. 
    .PARAMETER GetAll 
        Retreive all appfwxmlcontenttype object(s)
    .PARAMETER Count
        If specified, the count of the appfwxmlcontenttype object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwxmlcontenttype
    .EXAMPLE 
        Invoke-ADCGetAppfwxmlcontenttype -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAppfwxmlcontenttype -Count
    .EXAMPLE
        Invoke-ADCGetAppfwxmlcontenttype -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwxmlcontenttype -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlcontenttype
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$xmlcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwxmlcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwxmlcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlcontenttype objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlcontenttype configuration for property 'xmlcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Resource $xmlcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwxmlcontenttype: Ended"
    }
}

function Invoke-ADCDeleteAppfwxmlerrorpage {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Indicates name of the imported xml error page to be removed.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwxmlerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlerrorpage: Finished"
    }
}

function Invoke-ADCImportAppfwxmlerrorpage {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and name) for the location at which to store the imported XML error object.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Indicates name of the imported xml error page to be removed. 
    .PARAMETER comment 
        Any comments to preserve information about the XML error object. 
    .PARAMETER overwrite 
        Overwrite any existing XML error object of the same name.
    .EXAMPLE
        Invoke-ADCImportAppfwxmlerrorpage -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwxmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlerrorpage -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwxmlerrorpage: Finished"
    }
}

function Invoke-ADCChangeAppfwxmlerrorpage {
<#
    .SYNOPSIS
        Change Application Firewall configuration Object
    .DESCRIPTION
        Change Application Firewall configuration Object 
    .PARAMETER name 
        Indicates name of the imported xml error page to be removed.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER PassThru 
        Return details about the created appfwxmlerrorpage item.
    .EXAMPLE
        Invoke-ADCChangeAppfwxmlerrorpage -name <string>
    .NOTES
        File Name : Invoke-ADCChangeAppfwxmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        [string]$name ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

 
            if ($PSCmdlet.ShouldProcess("appfwxmlerrorpage", "Change Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlerrorpage -Action update -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAppfwxmlerrorpage -Filter $Payload)
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
        Write-Verbose "Invoke-ADCChangeAppfwxmlerrorpage: Finished"
    }
}

function Invoke-ADCGetAppfwxmlerrorpage {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Indicates name of the imported xml error page to be removed. 
    .PARAMETER GetAll 
        Retreive all appfwxmlerrorpage object(s)
    .PARAMETER Count
        If specified, the count of the appfwxmlerrorpage object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwxmlerrorpage
    .EXAMPLE 
        Invoke-ADCGetAppfwxmlerrorpage -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwxmlerrorpage -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwxmlerrorpage -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlerrorpage
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwxmlerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwxmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlerrorpage objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwxmlerrorpage: Ended"
    }
}

function Invoke-ADCDeleteAppfwxmlschema {
<#
    .SYNOPSIS
        Delete Application Firewall configuration Object
    .DESCRIPTION
        Delete Application Firewall configuration Object
    .PARAMETER name 
       Name of the XML Schema object to remove.  
       Minimum length = 1  
       Maximum length = 31 
    .EXAMPLE
        Invoke-ADCDeleteAppfwxmlschema -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlschema
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlschema: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlschema -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlschema: Finished"
    }
}

function Invoke-ADCImportAppfwxmlschema {
<#
    .SYNOPSIS
        Import Application Firewall configuration Object
    .DESCRIPTION
        Import Application Firewall configuration Object 
    .PARAMETER src 
        URL (protocol, host, path, and file name) for the location at which to store the imported XML Schema.  
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER name 
        Name of the XML Schema object to remove. 
    .PARAMETER comment 
        Any comments to preserve information about the XML Schema object. 
    .PARAMETER overwrite 
        Overwrite any existing XML Schema object of the same name.
    .EXAMPLE
        Invoke-ADCImportAppfwxmlschema -src <string> -name <string>
    .NOTES
        File Name : Invoke-ADCImportAppfwxmlschema
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        [ValidateLength(1, 2047)]
        [string]$src ,

        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 31)]
        [string]$name ,

        [string]$comment ,

        [boolean]$overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwxmlschema: Starting"
    }
    process {
        try {
            $Payload = @{
                src = $src
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('overwrite')) { $Payload.Add('overwrite', $overwrite) }
            if ($PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlschema -Action import -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCImportAppfwxmlschema: Finished"
    }
}

function Invoke-ADCGetAppfwxmlschema {
<#
    .SYNOPSIS
        Get Application Firewall configuration object(s)
    .DESCRIPTION
        Get Application Firewall configuration object(s)
    .PARAMETER name 
       Name of the XML Schema object to remove. 
    .PARAMETER GetAll 
        Retreive all appfwxmlschema object(s)
    .PARAMETER Count
        If specified, the count of the appfwxmlschema object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAppfwxmlschema
    .EXAMPLE 
        Invoke-ADCGetAppfwxmlschema -GetAll
    .EXAMPLE
        Invoke-ADCGetAppfwxmlschema -name <string>
    .EXAMPLE
        Invoke-ADCGetAppfwxmlschema -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlschema
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        [ValidateLength(1, 31)]
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwxmlschema: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all appfwxmlschema objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlschema objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlschema objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlschema configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlschema configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAppfwxmlschema: Ended"
    }
}


