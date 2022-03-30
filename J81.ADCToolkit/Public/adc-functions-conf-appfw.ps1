function Invoke-ADCDeleteAppfwarchive {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for archive resource.
    .PARAMETER Name 
        Name of tar archive.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwarchive -Name <string>
        An example how to delete appfwarchive configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwarchive
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        Write-Verbose "Invoke-ADCDeleteAppfwarchive: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwarchive -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCExportAppfwarchive {
    <#
    .SYNOPSIS
        Export Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for archive resource.
    .PARAMETER Name 
        Name of tar archive. 
    .PARAMETER Target 
        Path to the file to be exported.
    .EXAMPLE
        PS C:\>Invoke-ADCExportAppfwarchive -name <string> -target <string>
        An example how to export appfwarchive configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportAppfwarchive
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        [ValidateLength(1, 2047)]
        [string]$Target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwarchive: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                target         = $target
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwarchive -Action export -Payload $payload -GetWarning
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
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for archive resource.
    .PARAMETER Src 
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
    .PARAMETER Name 
        Name of tar archive. 
    .PARAMETER Comment 
        Comments associated with this archive.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwarchive -src <string> -name <string>
        An example how to import appfwarchive configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwarchive
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwarchive: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwarchive -Action import -Payload $payload -GetWarning
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

function Invoke-ADCGetAppfwarchive {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for archive resource.
    .PARAMETER GetAll 
        Retrieve all appfwarchive object(s).
    .PARAMETER Count
        If specified, the count of the appfwarchive object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwarchive
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwarchive -GetAll 
        Get all appfwarchive data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwarchive -name <string>
        Get appfwarchive object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwarchive -Filter @{ 'name'='<value>' }
        Get appfwarchive data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwarchive
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwarchive/
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
        Write-Verbose "Invoke-ADCGetAppfwarchive: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwarchive objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwarchive objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwarchive objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwarchive configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwarchive configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwarchive -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAppfwconfidfield {
    <#
    .SYNOPSIS
        Unset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for configured confidential form fields resource.
    .PARAMETER Fieldname 
        Name of the form field to designate as confidential. 
    .PARAMETER Url 
        URL of the web page that contains the web form. 
    .PARAMETER Comment 
        Any comments to preserve information about the form field designation. 
    .PARAMETER Isregex 
        Method of specifying the form field name. Available settings function as follows: 
        * REGEX. Form field is a regular expression. 
        * NOTREGEX. Form field is a literal string. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER State 
        Enable or disable the confidential field designation. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppfwconfidfield -fieldname <string> -url <string>
        An example how to unset appfwconfidfield configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppfwconfidfield
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield
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
        [string]$Fieldname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [Boolean]$comment,

        [Boolean]$isregex,

        [Boolean]$state 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwconfidfield: Starting"
    }
    process {
        try {
            $payload = @{ fieldname = $fieldname
                url                 = $url
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSCmdlet.ShouldProcess("$fieldname url", "Unset Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwconfidfield -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwconfidfield {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for configured confidential form fields resource.
    .PARAMETER Fieldname 
        Name of the form field to designate as confidential. 
    .PARAMETER Url 
        URL of the web page that contains the web form.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwconfidfield -Fieldname <string>
        An example how to delete appfwconfidfield configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwconfidfield
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$Fieldname,

        [string]$Url 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwconfidfield: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Url') ) { $arguments.Add('url', $Url) }
            if ( $PSCmdlet.ShouldProcess("$fieldname", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwconfidfield -NitroPath nitro/v1/config -Resource $fieldname -Arguments $arguments
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
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for configured confidential form fields resource.
    .PARAMETER Fieldname 
        Name of the form field to designate as confidential. 
    .PARAMETER Url 
        URL of the web page that contains the web form. 
    .PARAMETER Comment 
        Any comments to preserve information about the form field designation. 
    .PARAMETER Isregex 
        Method of specifying the form field name. Available settings function as follows: 
        * REGEX. Form field is a regular expression. 
        * NOTREGEX. Form field is a literal string. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER State 
        Enable or disable the confidential field designation. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwconfidfield -fieldname <string> -url <string>
        An example how to update appfwconfidfield configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwconfidfield
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$Fieldname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [string]$Comment,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwconfidfield: Starting"
    }
    process {
        try {
            $payload = @{ fieldname = $fieldname
                url                 = $url
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSCmdlet.ShouldProcess("appfwconfidfield", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwconfidfield -Payload $payload -GetWarning
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

function Invoke-ADCAddAppfwconfidfield {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for configured confidential form fields resource.
    .PARAMETER Fieldname 
        Name of the form field to designate as confidential. 
    .PARAMETER Url 
        URL of the web page that contains the web form. 
    .PARAMETER Isregex 
        Method of specifying the form field name. Available settings function as follows: 
        * REGEX. Form field is a regular expression. 
        * NOTREGEX. Form field is a literal string. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments to preserve information about the form field designation. 
    .PARAMETER State 
        Enable or disable the confidential field designation. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwconfidfield -fieldname <string> -url <string>
        An example how to add appfwconfidfield configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwconfidfield
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        [string]$Fieldname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex = 'NOTREGEX',

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED' 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwconfidfield: Starting"
    }
    process {
        try {
            $payload = @{ fieldname = $fieldname
                url                 = $url
            }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSCmdlet.ShouldProcess("appfwconfidfield", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwconfidfield -Payload $payload -GetWarning
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

function Invoke-ADCGetAppfwconfidfield {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for configured confidential form fields resource.
    .PARAMETER GetAll 
        Retrieve all appfwconfidfield object(s).
    .PARAMETER Count
        If specified, the count of the appfwconfidfield object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwconfidfield
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwconfidfield -GetAll 
        Get all appfwconfidfield data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwconfidfield -Count 
        Get the number of appfwconfidfield objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwconfidfield -name <string>
        Get appfwconfidfield object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwconfidfield -Filter @{ 'name'='<value>' }
        Get appfwconfidfield data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwconfidfield
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwconfidfield/
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
        Write-Verbose "Invoke-ADCGetAppfwconfidfield: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwconfidfield objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwconfidfield objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwconfidfield objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwconfidfield configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwconfidfield configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwconfidfield -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Export Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall custom settings XML configuration resource.
    .PARAMETER Name 
        . 
    .PARAMETER Target 
        .
    .EXAMPLE
        PS C:\>Invoke-ADCExportAppfwcustomsettings -name <string> -target <string>
        An example how to export appfwcustomsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportAppfwcustomsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwcustomsettings/
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
        [ValidateLength(1, 2047)]
        [string]$Target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwcustomsettings: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                target         = $target
            }

            if ( $PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwcustomsettings -Action export -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAppfwfieldtype {
    <#
    .SYNOPSIS
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall form field type resource.
    .PARAMETER Name 
        Name for the field type. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER Regex 
        PCRE - format regular expression defining the characters and length allowed for this field type. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the field type. A lower number specifies a higher priority. Field types are checked in the order of their priority numbers. 
    .PARAMETER Comment 
        Comment describing the type of field that this field type is intended to match. 
    .PARAMETER PassThru 
        Return details about the created appfwfieldtype item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwfieldtype -name <string> -regex <string> -priority <double>
        An example how to update appfwfieldtype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwfieldtype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        [string]$Regex,

        [Parameter(Mandatory)]
        [ValidateRange(0, 64000)]
        [double]$Priority,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwfieldtype: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                regex          = $regex
                priority       = $priority
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appfwfieldtype", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwfieldtype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwfieldtype -Filter $payload)
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

function Invoke-ADCAddAppfwfieldtype {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall form field type resource.
    .PARAMETER Name 
        Name for the field type. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER Regex 
        PCRE - format regular expression defining the characters and length allowed for this field type. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the field type. A lower number specifies a higher priority. Field types are checked in the order of their priority numbers. 
    .PARAMETER Comment 
        Comment describing the type of field that this field type is intended to match. 
    .PARAMETER PassThru 
        Return details about the created appfwfieldtype item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwfieldtype -name <string> -regex <string> -priority <double>
        An example how to add appfwfieldtype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwfieldtype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        [string]$Regex,

        [Parameter(Mandatory)]
        [ValidateRange(0, 64000)]
        [double]$Priority,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwfieldtype: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                regex          = $regex
                priority       = $priority
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("appfwfieldtype", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwfieldtype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwfieldtype -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall form field type resource.
    .PARAMETER Name 
        Name for the field type. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwfieldtype -Name <string>
        An example how to delete appfwfieldtype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwfieldtype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        Write-Verbose "Invoke-ADCDeleteAppfwfieldtype: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwfieldtype -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwfieldtype {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for application firewall form field type resource.
    .PARAMETER Name 
        Name for the field type. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the field type is added. 
    .PARAMETER GetAll 
        Retrieve all appfwfieldtype object(s).
    .PARAMETER Count
        If specified, the count of the appfwfieldtype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwfieldtype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwfieldtype -GetAll 
        Get all appfwfieldtype data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwfieldtype -Count 
        Get the number of appfwfieldtype objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwfieldtype -name <string>
        Get appfwfieldtype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwfieldtype -Filter @{ 'name'='<value>' }
        Get appfwfieldtype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwfieldtype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwfieldtype/
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
        Write-Verbose "Invoke-ADCGetAppfwfieldtype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwfieldtype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwfieldtype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwfieldtype objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwfieldtype configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwfieldtype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwfieldtype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER State 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = reqvserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwglobalappfwpolicybinding -policyname <string> -priority <double>
        An example how to add appfwglobal_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'NONE')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalappfwpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_appfwpolicy_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwglobalappfwpolicybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Priority 
        The priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwglobalappfwpolicybinding 
        An example how to delete appfwglobal_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalappfwpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_appfwpolicy_binding", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwglobal.
    .PARAMETER GetAll 
        Retrieve all appfwglobal_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwglobal_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalappfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalappfwpolicybinding -GetAll 
        Get all appfwglobal_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalappfwpolicybinding -Count 
        Get the number of appfwglobal_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalappfwpolicybinding -name <string>
        Get appfwglobal_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalappfwpolicybinding -Filter @{ 'name'='<value>' }
        Get appfwglobal_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwglobal_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER State 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is smaller than the current policy's priority number. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label. 
        Possible values = reqvserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwglobalauditnslogpolicybinding -policyname <string> -priority <double>
        An example how to add appfwglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'NONE')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_auditnslogpolicy_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Priority 
        The priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding 
        An example how to delete appfwglobal_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_auditnslogpolicy_binding", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to appfwglobal.
    .PARAMETER GetAll 
        Retrieve all appfwglobal_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwglobal_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalauditnslogpolicybinding -GetAll 
        Get all appfwglobal_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Count 
        Get the number of appfwglobal_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditnslogpolicybinding -name <string>
        Get appfwglobal_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get appfwglobal_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Priority 
        The priority of the policy. 
    .PARAMETER State 
        Enable or disable the binding to activate or deactivate the policy. This is applicable to classic policies only. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to evaluate if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a number that is larger than the largest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is smaller than the current policy's priority number. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label. 
        Possible values = reqvserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwglobal_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwglobalauditsyslogpolicybinding -policyname <string> -priority <double>
        An example how to add appfwglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwglobalauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'HTTPQUIC_REQ_OVERRIDE', 'HTTPQUIC_REQ_DEFAULT', 'NONE')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_auditsyslogpolicy_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwglobal_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to appfwglobal.
    .PARAMETER Policyname 
        Name of the policy. 
    .PARAMETER Type 
        Bind point to which to policy is bound. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, HTTPQUIC_REQ_OVERRIDE, HTTPQUIC_REQ_DEFAULT, NONE 
    .PARAMETER Priority 
        The priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding 
        An example how to delete appfwglobal_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwglobalauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("appfwglobal_auditsyslogpolicy_binding", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to appfwglobal.
    .PARAMETER GetAll 
        Retrieve all appfwglobal_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwglobal_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -GetAll 
        Get all appfwglobal_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Count 
        Get the number of appfwglobal_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -name <string>
        Get appfwglobal_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get appfwglobal_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appfwglobal.
    .PARAMETER GetAll 
        Retrieve all appfwglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwglobalbinding -GetAll 
        Get all appfwglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalbinding -name <string>
        Get appfwglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwglobalbinding -Filter @{ 'name'='<value>' }
        Get appfwglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCImportAppfwhtmlerrorpage {
    <#
    .SYNOPSIS
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for HTML error page resource.
    .PARAMETER Src 
        URL (protocol, host, path, and name) for the location at which to store the imported HTML error object. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name of the XML error object to remove. 
    .PARAMETER Comment 
        Any comments to preserve information about the HTML error object. 
    .PARAMETER Overwrite 
        Overwrite any existing HTML error object of the same name.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwhtmlerrorpage -src <string> -name <string>
        An example how to import appfwhtmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwhtmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwhtmlerrorpage -Action import -Payload $payload -GetWarning
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
        Change Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for HTML error page resource.
    .PARAMETER Name 
        Name of the XML error object to remove. 
    .PARAMETER PassThru 
        Return details about the created appfwhtmlerrorpage item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeAppfwhtmlerrorpage -name <string>
        An example how to change appfwhtmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeAppfwhtmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("appfwhtmlerrorpage", "Change Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwhtmlerrorpage -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwhtmlerrorpage -Filter $payload)
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

function Invoke-ADCDeleteAppfwhtmlerrorpage {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for HTML error page resource.
    .PARAMETER Name 
        Name of the XML error object to remove.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwhtmlerrorpage -Name <string>
        An example how to delete appfwhtmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwhtmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwhtmlerrorpage: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwhtmlerrorpage {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for HTML error page resource.
    .PARAMETER Name 
        Name of the XML error object to remove. 
    .PARAMETER GetAll 
        Retrieve all appfwhtmlerrorpage object(s).
    .PARAMETER Count
        If specified, the count of the appfwhtmlerrorpage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwhtmlerrorpage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwhtmlerrorpage -GetAll 
        Get all appfwhtmlerrorpage data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwhtmlerrorpage -name <string>
        Get appfwhtmlerrorpage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwhtmlerrorpage -Filter @{ 'name'='<value>' }
        Get appfwhtmlerrorpage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwhtmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwhtmlerrorpage/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwhtmlerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwhtmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwhtmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwhtmlerrorpage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwhtmlerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwhtmlerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwhtmlerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCDeleteAppfwjsoncontenttype {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for JSON content type resource.
    .PARAMETER Jsoncontenttypevalue 
        Content type to be classified as JSON.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwjsoncontenttype -Jsoncontenttypevalue <string>
        An example how to delete appfwjsoncontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwjsoncontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$Jsoncontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwjsoncontenttype: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$jsoncontenttypevalue", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Resource $jsoncontenttypevalue -Arguments $arguments
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

function Invoke-ADCAddAppfwjsoncontenttype {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for JSON content type resource.
    .PARAMETER Jsoncontenttypevalue 
        Content type to be classified as JSON. 
    .PARAMETER Isregex 
        Is json content type a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwjsoncontenttype item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwjsoncontenttype -jsoncontenttypevalue <string>
        An example how to add appfwjsoncontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwjsoncontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$Jsoncontenttypevalue,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex = 'NOTREGEX',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwjsoncontenttype: Starting"
    }
    process {
        try {
            $payload = @{ jsoncontenttypevalue = $jsoncontenttypevalue }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSCmdlet.ShouldProcess("appfwjsoncontenttype", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsoncontenttype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwjsoncontenttype -Filter $payload)
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

function Invoke-ADCGetAppfwjsoncontenttype {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for JSON content type resource.
    .PARAMETER Jsoncontenttypevalue 
        Content type to be classified as JSON. 
    .PARAMETER GetAll 
        Retrieve all appfwjsoncontenttype object(s).
    .PARAMETER Count
        If specified, the count of the appfwjsoncontenttype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsoncontenttype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwjsoncontenttype -GetAll 
        Get all appfwjsoncontenttype data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwjsoncontenttype -Count 
        Get the number of appfwjsoncontenttype objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsoncontenttype -name <string>
        Get appfwjsoncontenttype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsoncontenttype -Filter @{ 'name'='<value>' }
        Get appfwjsoncontenttype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwjsoncontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsoncontenttype/
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
        [string]$Jsoncontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwjsoncontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwjsoncontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwjsoncontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwjsoncontenttype objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwjsoncontenttype configuration for property 'jsoncontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Resource $jsoncontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwjsoncontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsoncontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCImportAppfwjsonerrorpage {
    <#
    .SYNOPSIS
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for JSON error page resource.
    .PARAMETER Src 
        URL (protocol, host, path, and name) for the location at which to store the imported JSON error object. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Indicates name of the imported json error page to be removed. 
    .PARAMETER Comment 
        Any comments to preserve information about the JSON error object. 
    .PARAMETER Overwrite 
        Overwrite any existing JSON error object of the same name.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwjsonerrorpage -src <string> -name <string>
        An example how to import appfwjsonerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwjsonerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsonerrorpage -Action import -Payload $payload -GetWarning
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
        Change Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for JSON error page resource.
    .PARAMETER Name 
        Indicates name of the imported json error page to be removed. 
    .PARAMETER PassThru 
        Return details about the created appfwjsonerrorpage item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeAppfwjsonerrorpage -name <string>
        An example how to change appfwjsonerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeAppfwjsonerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("appfwjsonerrorpage", "Change Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwjsonerrorpage -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwjsonerrorpage -Filter $payload)
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

function Invoke-ADCDeleteAppfwjsonerrorpage {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for JSON error page resource.
    .PARAMETER Name 
        Indicates name of the imported json error page to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwjsonerrorpage -Name <string>
        An example how to delete appfwjsonerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwjsonerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwjsonerrorpage: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwjsonerrorpage {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for JSON error page resource.
    .PARAMETER Name 
        Indicates name of the imported json error page to be removed. 
    .PARAMETER GetAll 
        Retrieve all appfwjsonerrorpage object(s).
    .PARAMETER Count
        If specified, the count of the appfwjsonerrorpage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsonerrorpage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwjsonerrorpage -GetAll 
        Get all appfwjsonerrorpage data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsonerrorpage -name <string>
        Get appfwjsonerrorpage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwjsonerrorpage -Filter @{ 'name'='<value>' }
        Get appfwjsonerrorpage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwjsonerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwjsonerrorpage/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwjsonerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwjsonerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwjsonerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwjsonerrorpage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwjsonerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwjsonerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwjsonerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCResetAppfwlearningdata {
    <#
    .SYNOPSIS
        Reset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for learning data resource.
    .EXAMPLE
        PS C:\>Invoke-ADCResetAppfwlearningdata 
        An example how to reset appfwlearningdata configuration Object(s).
    .NOTES
        File Name : Invoke-ADCResetAppfwlearningdata
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [Object]$ADCSession = (Get-ADCSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCResetAppfwlearningdata: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Reset Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwlearningdata -Action reset -Payload $payload -GetWarning
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
        Export Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for learning data resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER Securitycheck 
        Name of the security check. 
        Possible values = startURL, cookieConsistency, fieldConsistency, crossSiteScripting, SQLInjection, fieldFormat, CSRFtag, XMLDoSCheck, XMLWSICheck, XMLAttachmentCheck, TotalXMLRequests, creditCardNumber, ContentType 
    .PARAMETER Target 
        Target filename for data to be exported.
    .EXAMPLE
        PS C:\>Invoke-ADCExportAppfwlearningdata -profilename <string> -securitycheck <string>
        An example how to export appfwlearningdata configuration Object(s).
    .NOTES
        File Name : Invoke-ADCExportAppfwlearningdata
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [string]$Profilename,

        [Parameter(Mandatory)]
        [ValidateSet('startURL', 'cookieConsistency', 'fieldConsistency', 'crossSiteScripting', 'SQLInjection', 'fieldFormat', 'CSRFtag', 'XMLDoSCheck', 'XMLWSICheck', 'XMLAttachmentCheck', 'TotalXMLRequests', 'creditCardNumber', 'ContentType')]
        [string]$Securitycheck,

        [ValidateLength(1, 127)]
        [string]$Target 

    )
    begin {
        Write-Verbose "Invoke-ADCExportAppfwlearningdata: Starting"
    }
    process {
        try {
            $payload = @{ profilename = $profilename
                securitycheck         = $securitycheck
            }
            if ( $PSBoundParameters.ContainsKey('target') ) { $payload.Add('target', $target) }
            if ( $PSCmdlet.ShouldProcess($Name, "Export Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwlearningdata -Action export -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwlearningdata {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for learning data resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER Starturl 
        Start URL configuration. 
    .PARAMETER Cookieconsistency 
        Cookie Name. 
    .PARAMETER Fieldconsistency 
        Form field name. 
    .PARAMETER Formactionurl_ffc 
        Form action URL. 
    .PARAMETER Contenttype 
        Content Type Name. 
    .PARAMETER Crosssitescripting 
        Cross-site scripting. 
    .PARAMETER Formactionurl_xss 
        Form action URL. 
    .PARAMETER As_scan_location_xss 
        Location of cross-site scripting exception - form field, header, cookie or url. 
        Possible values = FORMFIELD, HEADER, COOKIE, URL 
    .PARAMETER As_value_type_xss 
        XSS value type. (Tag | Attribute | Pattern). 
        Possible values = Tag, Attribute, Pattern 
    .PARAMETER As_value_expr_xss 
        XSS value expressions consistituting expressions for Tag, Attribute or Pattern. 
    .PARAMETER Sqlinjection 
        Form field name. 
    .PARAMETER Formactionurl_sql 
        Form action URL. 
    .PARAMETER As_scan_location_sql 
        Location of sql injection exception - form field, header or cookie. 
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER As_value_type_sql 
        SQL value type. Keyword, SpecialString or Wildchar. 
        Possible values = Keyword, SpecialString, Wildchar 
    .PARAMETER As_value_expr_sql 
        SQL value expressions consistituting expressions for Keyword, SpecialString or Wildchar. 
    .PARAMETER Fieldformat 
        Field format name. 
    .PARAMETER Formactionurl_ff 
        Form action URL. 
    .PARAMETER Csrftag 
        CSRF Form Action URL. 
    .PARAMETER Csrfformoriginurl 
        CSRF Form Origin URL. 
    .PARAMETER Creditcardnumber 
        The object expression that is to be excluded from safe commerce check. 
    .PARAMETER Creditcardnumberurl 
        The url for which the list of credit card numbers are needed to be bypassed from inspection. 
    .PARAMETER Xmldoscheck 
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
    .PARAMETER Xmlwsicheck 
        Web Services Interoperability Rule ID. 
    .PARAMETER Xmlattachmentcheck 
        XML Attachment Content-Type. 
    .PARAMETER Totalxmlrequests 
        Total XML requests.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwlearningdata 
        An example how to delete appfwlearningdata configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwlearningdata
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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

        [string]$Profilename,

        [string]$Starturl,

        [string]$Cookieconsistency,

        [string]$Fieldconsistency,

        [string]$Formactionurl_ffc,

        [string]$Contenttype,

        [string]$Crosssitescripting,

        [string]$Formactionurl_xss,

        [string]$As_scan_location_xss,

        [string]$As_value_type_xss,

        [string]$As_value_expr_xss,

        [string]$Sqlinjection,

        [string]$Formactionurl_sql,

        [string]$As_scan_location_sql,

        [string]$As_value_type_sql,

        [string]$As_value_expr_sql,

        [string]$Fieldformat,

        [string]$Formactionurl_ff,

        [string]$Csrftag,

        [string]$Csrfformoriginurl,

        [string]$Creditcardnumber,

        [string]$Creditcardnumberurl,

        [string]$Xmldoscheck,

        [string]$Xmlwsicheck,

        [string]$Xmlattachmentcheck,

        [boolean]$Totalxmlrequests 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwlearningdata: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Profilename') ) { $arguments.Add('profilename', $Profilename) }
            if ( $PSBoundParameters.ContainsKey('Starturl') ) { $arguments.Add('starturl', $Starturl) }
            if ( $PSBoundParameters.ContainsKey('Cookieconsistency') ) { $arguments.Add('cookieconsistency', $Cookieconsistency) }
            if ( $PSBoundParameters.ContainsKey('Fieldconsistency') ) { $arguments.Add('fieldconsistency', $Fieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_ffc') ) { $arguments.Add('formactionurl_ffc', $Formactionurl_ffc) }
            if ( $PSBoundParameters.ContainsKey('Contenttype') ) { $arguments.Add('contenttype', $Contenttype) }
            if ( $PSBoundParameters.ContainsKey('Crosssitescripting') ) { $arguments.Add('crosssitescripting', $Crosssitescripting) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_xss') ) { $arguments.Add('formactionurl_xss', $Formactionurl_xss) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_xss') ) { $arguments.Add('as_scan_location_xss', $As_scan_location_xss) }
            if ( $PSBoundParameters.ContainsKey('As_value_type_xss') ) { $arguments.Add('as_value_type_xss', $As_value_type_xss) }
            if ( $PSBoundParameters.ContainsKey('As_value_expr_xss') ) { $arguments.Add('as_value_expr_xss', $As_value_expr_xss) }
            if ( $PSBoundParameters.ContainsKey('Sqlinjection') ) { $arguments.Add('sqlinjection', $Sqlinjection) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_sql') ) { $arguments.Add('formactionurl_sql', $Formactionurl_sql) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_sql') ) { $arguments.Add('as_scan_location_sql', $As_scan_location_sql) }
            if ( $PSBoundParameters.ContainsKey('As_value_type_sql') ) { $arguments.Add('as_value_type_sql', $As_value_type_sql) }
            if ( $PSBoundParameters.ContainsKey('As_value_expr_sql') ) { $arguments.Add('as_value_expr_sql', $As_value_expr_sql) }
            if ( $PSBoundParameters.ContainsKey('Fieldformat') ) { $arguments.Add('fieldformat', $Fieldformat) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_ff') ) { $arguments.Add('formactionurl_ff', $Formactionurl_ff) }
            if ( $PSBoundParameters.ContainsKey('Csrftag') ) { $arguments.Add('csrftag', $Csrftag) }
            if ( $PSBoundParameters.ContainsKey('Csrfformoriginurl') ) { $arguments.Add('csrfformoriginurl', $Csrfformoriginurl) }
            if ( $PSBoundParameters.ContainsKey('Creditcardnumber') ) { $arguments.Add('creditcardnumber', $Creditcardnumber) }
            if ( $PSBoundParameters.ContainsKey('Creditcardnumberurl') ) { $arguments.Add('creditcardnumberurl', $Creditcardnumberurl) }
            if ( $PSBoundParameters.ContainsKey('Xmldoscheck') ) { $arguments.Add('xmldoscheck', $Xmldoscheck) }
            if ( $PSBoundParameters.ContainsKey('Xmlwsicheck') ) { $arguments.Add('xmlwsicheck', $Xmlwsicheck) }
            if ( $PSBoundParameters.ContainsKey('Xmlattachmentcheck') ) { $arguments.Add('xmlattachmentcheck', $Xmlattachmentcheck) }
            if ( $PSBoundParameters.ContainsKey('Totalxmlrequests') ) { $arguments.Add('totalxmlrequests', $Totalxmlrequests) }
            if ( $PSCmdlet.ShouldProcess("appfwlearningdata", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwlearningdata -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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

function Invoke-ADCGetAppfwlearningdata {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for learning data resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER Securitycheck 
        Name of the security check. 
        Possible values = startURL, cookieConsistency, fieldConsistency, crossSiteScripting, SQLInjection, fieldFormat, CSRFtag, XMLDoSCheck, XMLWSICheck, XMLAttachmentCheck, TotalXMLRequests, creditCardNumber, ContentType 
    .PARAMETER GetAll 
        Retrieve all appfwlearningdata object(s).
    .PARAMETER Count
        If specified, the count of the appfwlearningdata object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningdata
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwlearningdata -GetAll 
        Get all appfwlearningdata data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwlearningdata -Count 
        Get the number of appfwlearningdata objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningdata -name <string>
        Get appfwlearningdata object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningdata -Filter @{ 'name'='<value>' }
        Get appfwlearningdata data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwlearningdata
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningdata/
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
        [string]$Profilename,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('startURL', 'cookieConsistency', 'fieldConsistency', 'crossSiteScripting', 'SQLInjection', 'fieldFormat', 'CSRFtag', 'XMLDoSCheck', 'XMLWSICheck', 'XMLAttachmentCheck', 'TotalXMLRequests', 'creditCardNumber', 'ContentType')]
        [string]$Securitycheck,
			
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwlearningdata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwlearningdata objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwlearningdata objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('profilename') ) { $arguments.Add('profilename', $profilename) } 
                if ( $PSBoundParameters.ContainsKey('securitycheck') ) { $arguments.Add('securitycheck', $securitycheck) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwlearningdata configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwlearningdata configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningdata -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAppfwlearningsettings {
    <#
    .SYNOPSIS
        Unset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for learning settings resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER Starturlminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn start URLs. 
    .PARAMETER Starturlpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular start URL pattern for the learning engine to learn that start URL. 
    .PARAMETER Cookieconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cookies. 
    .PARAMETER Cookieconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cookie pattern for the learning engine to learn that cookie. 
    .PARAMETER Csrftagminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cross-site request forgery (CSRF) tags. 
    .PARAMETER Csrftagpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular CSRF tag for the learning engine to learn that CSRF tag. 
    .PARAMETER Fieldconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field consistency information. 
    .PARAMETER Fieldconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular field consistency pattern for the learning engine to learn that field consistency pattern. 
    .PARAMETER Crosssitescriptingminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML cross-site scripting patterns. 
    .PARAMETER Crosssitescriptingpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cross-site scripting pattern for the learning engine to learn that cross-site scripting pattern. 
    .PARAMETER Sqlinjectionminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML SQL injection patterns. 
    .PARAMETER Sqlinjectionpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular HTML SQL injection pattern for the learning engine to learn that HTML SQL injection pattern. 
    .PARAMETER Fieldformatminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field formats. 
    .PARAMETER Fieldformatpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular web form field pattern for the learning engine to recommend a field format for that form field. 
    .PARAMETER Creditcardnumberminthreshold 
        Minimum threshold to learn Credit Card information. 
    .PARAMETER Creditcardnumberpercentthreshold 
        Minimum threshold in percent to learn Credit Card information. 
    .PARAMETER Contenttypeminthreshold 
        Minimum threshold to learn Content Type information. 
    .PARAMETER Contenttypepercentthreshold 
        Minimum threshold in percent to learn Content Type information. 
    .PARAMETER Xmlwsiminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn web services interoperability (WSI) information. 
    .PARAMETER Xmlwsipercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular pattern for the learning engine to learn a web services interoperability (WSI) pattern. 
    .PARAMETER Xmlattachmentminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn XML attachment patterns. 
    .PARAMETER Xmlattachmentpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular XML attachment pattern for the learning engine to learn that XML attachment pattern. 
    .PARAMETER Fieldformatautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Sqlinjectionautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Crosssitescriptingautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Starturlautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Cookieconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Csrftagautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Fieldconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Contenttypeautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppfwlearningsettings -profilename <string>
        An example how to unset appfwlearningsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppfwlearningsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings
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
        [string]$Profilename,

        [Boolean]$starturlminthreshold,

        [Boolean]$starturlpercentthreshold,

        [Boolean]$cookieconsistencyminthreshold,

        [Boolean]$cookieconsistencypercentthreshold,

        [Boolean]$csrftagminthreshold,

        [Boolean]$csrftagpercentthreshold,

        [Boolean]$fieldconsistencyminthreshold,

        [Boolean]$fieldconsistencypercentthreshold,

        [Boolean]$crosssitescriptingminthreshold,

        [Boolean]$crosssitescriptingpercentthreshold,

        [Boolean]$sqlinjectionminthreshold,

        [Boolean]$sqlinjectionpercentthreshold,

        [Boolean]$fieldformatminthreshold,

        [Boolean]$fieldformatpercentthreshold,

        [Boolean]$creditcardnumberminthreshold,

        [Boolean]$creditcardnumberpercentthreshold,

        [Boolean]$contenttypeminthreshold,

        [Boolean]$contenttypepercentthreshold,

        [Boolean]$xmlwsiminthreshold,

        [Boolean]$xmlwsipercentthreshold,

        [Boolean]$xmlattachmentminthreshold,

        [Boolean]$xmlattachmentpercentthreshold,

        [Boolean]$fieldformatautodeploygraceperiod,

        [Boolean]$sqlinjectionautodeploygraceperiod,

        [Boolean]$crosssitescriptingautodeploygraceperiod,

        [Boolean]$starturlautodeploygraceperiod,

        [Boolean]$cookieconsistencyautodeploygraceperiod,

        [Boolean]$csrftagautodeploygraceperiod,

        [Boolean]$fieldconsistencyautodeploygraceperiod,

        [Boolean]$contenttypeautodeploygraceperiod 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwlearningsettings: Starting"
    }
    process {
        try {
            $payload = @{ profilename = $profilename }
            if ( $PSBoundParameters.ContainsKey('starturlminthreshold') ) { $payload.Add('starturlminthreshold', $starturlminthreshold) }
            if ( $PSBoundParameters.ContainsKey('starturlpercentthreshold') ) { $payload.Add('starturlpercentthreshold', $starturlpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyminthreshold') ) { $payload.Add('cookieconsistencyminthreshold', $cookieconsistencyminthreshold) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencypercentthreshold') ) { $payload.Add('cookieconsistencypercentthreshold', $cookieconsistencypercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('csrftagminthreshold') ) { $payload.Add('csrftagminthreshold', $csrftagminthreshold) }
            if ( $PSBoundParameters.ContainsKey('csrftagpercentthreshold') ) { $payload.Add('csrftagpercentthreshold', $csrftagpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyminthreshold') ) { $payload.Add('fieldconsistencyminthreshold', $fieldconsistencyminthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencypercentthreshold') ) { $payload.Add('fieldconsistencypercentthreshold', $fieldconsistencypercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingminthreshold') ) { $payload.Add('crosssitescriptingminthreshold', $crosssitescriptingminthreshold) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingpercentthreshold') ) { $payload.Add('crosssitescriptingpercentthreshold', $crosssitescriptingpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionminthreshold') ) { $payload.Add('sqlinjectionminthreshold', $sqlinjectionminthreshold) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionpercentthreshold') ) { $payload.Add('sqlinjectionpercentthreshold', $sqlinjectionpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatminthreshold') ) { $payload.Add('fieldformatminthreshold', $fieldformatminthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatpercentthreshold') ) { $payload.Add('fieldformatpercentthreshold', $fieldformatpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumberminthreshold') ) { $payload.Add('creditcardnumberminthreshold', $creditcardnumberminthreshold) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumberpercentthreshold') ) { $payload.Add('creditcardnumberpercentthreshold', $creditcardnumberpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('contenttypeminthreshold') ) { $payload.Add('contenttypeminthreshold', $contenttypeminthreshold) }
            if ( $PSBoundParameters.ContainsKey('contenttypepercentthreshold') ) { $payload.Add('contenttypepercentthreshold', $contenttypepercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiminthreshold') ) { $payload.Add('xmlwsiminthreshold', $xmlwsiminthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlwsipercentthreshold') ) { $payload.Add('xmlwsipercentthreshold', $xmlwsipercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentminthreshold') ) { $payload.Add('xmlattachmentminthreshold', $xmlattachmentminthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentpercentthreshold') ) { $payload.Add('xmlattachmentpercentthreshold', $xmlattachmentpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatautodeploygraceperiod') ) { $payload.Add('fieldformatautodeploygraceperiod', $fieldformatautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionautodeploygraceperiod') ) { $payload.Add('sqlinjectionautodeploygraceperiod', $sqlinjectionautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingautodeploygraceperiod') ) { $payload.Add('crosssitescriptingautodeploygraceperiod', $crosssitescriptingautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('starturlautodeploygraceperiod') ) { $payload.Add('starturlautodeploygraceperiod', $starturlautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyautodeploygraceperiod') ) { $payload.Add('cookieconsistencyautodeploygraceperiod', $cookieconsistencyautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('csrftagautodeploygraceperiod') ) { $payload.Add('csrftagautodeploygraceperiod', $csrftagautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyautodeploygraceperiod') ) { $payload.Add('fieldconsistencyautodeploygraceperiod', $fieldconsistencyautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('contenttypeautodeploygraceperiod') ) { $payload.Add('contenttypeautodeploygraceperiod', $contenttypeautodeploygraceperiod) }
            if ( $PSCmdlet.ShouldProcess("$profilename", "Unset Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwlearningsettings -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAppfwlearningsettings {
    <#
    .SYNOPSIS
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for learning settings resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER Starturlminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn start URLs. 
    .PARAMETER Starturlpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular start URL pattern for the learning engine to learn that start URL. 
    .PARAMETER Cookieconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cookies. 
    .PARAMETER Cookieconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cookie pattern for the learning engine to learn that cookie. 
    .PARAMETER Csrftagminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn cross-site request forgery (CSRF) tags. 
    .PARAMETER Csrftagpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular CSRF tag for the learning engine to learn that CSRF tag. 
    .PARAMETER Fieldconsistencyminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field consistency information. 
    .PARAMETER Fieldconsistencypercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular field consistency pattern for the learning engine to learn that field consistency pattern. 
    .PARAMETER Crosssitescriptingminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML cross-site scripting patterns. 
    .PARAMETER Crosssitescriptingpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular cross-site scripting pattern for the learning engine to learn that cross-site scripting pattern. 
    .PARAMETER Sqlinjectionminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn HTML SQL injection patterns. 
    .PARAMETER Sqlinjectionpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular HTML SQL injection pattern for the learning engine to learn that HTML SQL injection pattern. 
    .PARAMETER Fieldformatminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn field formats. 
    .PARAMETER Fieldformatpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular web form field pattern for the learning engine to recommend a field format for that form field. 
    .PARAMETER Creditcardnumberminthreshold 
        Minimum threshold to learn Credit Card information. 
    .PARAMETER Creditcardnumberpercentthreshold 
        Minimum threshold in percent to learn Credit Card information. 
    .PARAMETER Contenttypeminthreshold 
        Minimum threshold to learn Content Type information. 
    .PARAMETER Contenttypepercentthreshold 
        Minimum threshold in percent to learn Content Type information. 
    .PARAMETER Xmlwsiminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn web services interoperability (WSI) information. 
    .PARAMETER Xmlwsipercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular pattern for the learning engine to learn a web services interoperability (WSI) pattern. 
    .PARAMETER Xmlattachmentminthreshold 
        Minimum number of application firewall sessions that the learning engine must observe to learn XML attachment patterns. 
    .PARAMETER Xmlattachmentpercentthreshold 
        Minimum percentage of application firewall sessions that must contain a particular XML attachment pattern for the learning engine to learn that XML attachment pattern. 
    .PARAMETER Fieldformatautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Sqlinjectionautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Crosssitescriptingautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Starturlautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Cookieconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Csrftagautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Fieldconsistencyautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER Contenttypeautodeploygraceperiod 
        The number of minutes after the threshold hit alert the learned rule will be deployed. 
    .PARAMETER PassThru 
        Return details about the created appfwlearningsettings item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwlearningsettings -profilename <string>
        An example how to update appfwlearningsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwlearningsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings/
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
        [string]$Profilename,

        [double]$Starturlminthreshold,

        [ValidateRange(0, 100)]
        [double]$Starturlpercentthreshold,

        [double]$Cookieconsistencyminthreshold,

        [ValidateRange(0, 100)]
        [double]$Cookieconsistencypercentthreshold,

        [double]$Csrftagminthreshold,

        [ValidateRange(0, 100)]
        [double]$Csrftagpercentthreshold,

        [double]$Fieldconsistencyminthreshold,

        [ValidateRange(0, 100)]
        [double]$Fieldconsistencypercentthreshold,

        [double]$Crosssitescriptingminthreshold,

        [ValidateRange(0, 100)]
        [double]$Crosssitescriptingpercentthreshold,

        [double]$Sqlinjectionminthreshold,

        [ValidateRange(0, 100)]
        [double]$Sqlinjectionpercentthreshold,

        [double]$Fieldformatminthreshold,

        [ValidateRange(0, 100)]
        [double]$Fieldformatpercentthreshold,

        [double]$Creditcardnumberminthreshold,

        [ValidateRange(0, 100)]
        [double]$Creditcardnumberpercentthreshold,

        [double]$Contenttypeminthreshold,

        [ValidateRange(0, 100)]
        [double]$Contenttypepercentthreshold,

        [double]$Xmlwsiminthreshold,

        [ValidateRange(0, 100)]
        [double]$Xmlwsipercentthreshold,

        [double]$Xmlattachmentminthreshold,

        [ValidateRange(0, 100)]
        [double]$Xmlattachmentpercentthreshold,

        [ValidateRange(5, 43200)]
        [double]$Fieldformatautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Sqlinjectionautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Crosssitescriptingautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Starturlautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Cookieconsistencyautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Csrftagautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Fieldconsistencyautodeploygraceperiod,

        [ValidateRange(5, 43200)]
        [double]$Contenttypeautodeploygraceperiod,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwlearningsettings: Starting"
    }
    process {
        try {
            $payload = @{ profilename = $profilename }
            if ( $PSBoundParameters.ContainsKey('starturlminthreshold') ) { $payload.Add('starturlminthreshold', $starturlminthreshold) }
            if ( $PSBoundParameters.ContainsKey('starturlpercentthreshold') ) { $payload.Add('starturlpercentthreshold', $starturlpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyminthreshold') ) { $payload.Add('cookieconsistencyminthreshold', $cookieconsistencyminthreshold) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencypercentthreshold') ) { $payload.Add('cookieconsistencypercentthreshold', $cookieconsistencypercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('csrftagminthreshold') ) { $payload.Add('csrftagminthreshold', $csrftagminthreshold) }
            if ( $PSBoundParameters.ContainsKey('csrftagpercentthreshold') ) { $payload.Add('csrftagpercentthreshold', $csrftagpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyminthreshold') ) { $payload.Add('fieldconsistencyminthreshold', $fieldconsistencyminthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencypercentthreshold') ) { $payload.Add('fieldconsistencypercentthreshold', $fieldconsistencypercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingminthreshold') ) { $payload.Add('crosssitescriptingminthreshold', $crosssitescriptingminthreshold) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingpercentthreshold') ) { $payload.Add('crosssitescriptingpercentthreshold', $crosssitescriptingpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionminthreshold') ) { $payload.Add('sqlinjectionminthreshold', $sqlinjectionminthreshold) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionpercentthreshold') ) { $payload.Add('sqlinjectionpercentthreshold', $sqlinjectionpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatminthreshold') ) { $payload.Add('fieldformatminthreshold', $fieldformatminthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatpercentthreshold') ) { $payload.Add('fieldformatpercentthreshold', $fieldformatpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumberminthreshold') ) { $payload.Add('creditcardnumberminthreshold', $creditcardnumberminthreshold) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumberpercentthreshold') ) { $payload.Add('creditcardnumberpercentthreshold', $creditcardnumberpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('contenttypeminthreshold') ) { $payload.Add('contenttypeminthreshold', $contenttypeminthreshold) }
            if ( $PSBoundParameters.ContainsKey('contenttypepercentthreshold') ) { $payload.Add('contenttypepercentthreshold', $contenttypepercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiminthreshold') ) { $payload.Add('xmlwsiminthreshold', $xmlwsiminthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlwsipercentthreshold') ) { $payload.Add('xmlwsipercentthreshold', $xmlwsipercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentminthreshold') ) { $payload.Add('xmlattachmentminthreshold', $xmlattachmentminthreshold) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentpercentthreshold') ) { $payload.Add('xmlattachmentpercentthreshold', $xmlattachmentpercentthreshold) }
            if ( $PSBoundParameters.ContainsKey('fieldformatautodeploygraceperiod') ) { $payload.Add('fieldformatautodeploygraceperiod', $fieldformatautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionautodeploygraceperiod') ) { $payload.Add('sqlinjectionautodeploygraceperiod', $sqlinjectionautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingautodeploygraceperiod') ) { $payload.Add('crosssitescriptingautodeploygraceperiod', $crosssitescriptingautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('starturlautodeploygraceperiod') ) { $payload.Add('starturlautodeploygraceperiod', $starturlautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyautodeploygraceperiod') ) { $payload.Add('cookieconsistencyautodeploygraceperiod', $cookieconsistencyautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('csrftagautodeploygraceperiod') ) { $payload.Add('csrftagautodeploygraceperiod', $csrftagautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyautodeploygraceperiod') ) { $payload.Add('fieldconsistencyautodeploygraceperiod', $fieldconsistencyautodeploygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('contenttypeautodeploygraceperiod') ) { $payload.Add('contenttypeautodeploygraceperiod', $contenttypeautodeploygraceperiod) }
            if ( $PSCmdlet.ShouldProcess("appfwlearningsettings", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwlearningsettings -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwlearningsettings -Filter $payload)
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

function Invoke-ADCGetAppfwlearningsettings {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for learning settings resource.
    .PARAMETER Profilename 
        Name of the profile. 
    .PARAMETER GetAll 
        Retrieve all appfwlearningsettings object(s).
    .PARAMETER Count
        If specified, the count of the appfwlearningsettings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningsettings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwlearningsettings -GetAll 
        Get all appfwlearningsettings data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwlearningsettings -Count 
        Get the number of appfwlearningsettings objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningsettings -name <string>
        Get appfwlearningsettings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwlearningsettings -Filter @{ 'name'='<value>' }
        Get appfwlearningsettings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwlearningsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwlearningsettings/
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
        [string]$Profilename,

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
        Write-Verbose "Invoke-ADCGetAppfwlearningsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwlearningsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwlearningsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwlearningsettings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwlearningsettings configuration for property 'profilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Resource $profilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwlearningsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwlearningsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCDeleteAppfwmultipartformcontenttype {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for Multipart form content type resource.
    .PARAMETER Multipartformcontenttypevalue 
        Content type to be classified as multipart form.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwmultipartformcontenttype -Multipartformcontenttypevalue <string>
        An example how to delete appfwmultipartformcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwmultipartformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$Multipartformcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwmultipartformcontenttype: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$multipartformcontenttypevalue", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Resource $multipartformcontenttypevalue -Arguments $arguments
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

function Invoke-ADCAddAppfwmultipartformcontenttype {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for Multipart form content type resource.
    .PARAMETER Multipartformcontenttypevalue 
        Content type to be classified as multipart form. 
    .PARAMETER Isregex 
        Is multipart_form content type a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwmultipartformcontenttype item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwmultipartformcontenttype -multipartformcontenttypevalue <string>
        An example how to add appfwmultipartformcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwmultipartformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$Multipartformcontenttypevalue,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex = 'NOTREGEX',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwmultipartformcontenttype: Starting"
    }
    process {
        try {
            $payload = @{ multipartformcontenttypevalue = $multipartformcontenttypevalue }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSCmdlet.ShouldProcess("appfwmultipartformcontenttype", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwmultipartformcontenttype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwmultipartformcontenttype -Filter $payload)
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

function Invoke-ADCGetAppfwmultipartformcontenttype {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for Multipart form content type resource.
    .PARAMETER Multipartformcontenttypevalue 
        Content type to be classified as multipart form. 
    .PARAMETER GetAll 
        Retrieve all appfwmultipartformcontenttype object(s).
    .PARAMETER Count
        If specified, the count of the appfwmultipartformcontenttype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwmultipartformcontenttype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwmultipartformcontenttype -GetAll 
        Get all appfwmultipartformcontenttype data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwmultipartformcontenttype -Count 
        Get the number of appfwmultipartformcontenttype objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwmultipartformcontenttype -name <string>
        Get appfwmultipartformcontenttype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwmultipartformcontenttype -Filter @{ 'name'='<value>' }
        Get appfwmultipartformcontenttype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwmultipartformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwmultipartformcontenttype/
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
        [string]$Multipartformcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwmultipartformcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwmultipartformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwmultipartformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwmultipartformcontenttype objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwmultipartformcontenttype configuration for property 'multipartformcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Resource $multipartformcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwmultipartformcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwmultipartformcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRenameAppfwpolicy {
    <#
    .SYNOPSIS
        Rename Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER Newname 
        New name for the policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppfwpolicy -name <string> -newname <string>
        An example how to rename appfwpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAppfwpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appfwpolicy", "Rename Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $payload)
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

function Invoke-ADCUnsetAppfwpolicy {
    <#
    .SYNOPSIS
        Unset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER Comment 
        Any comments to preserve information about the policy for later reference. 
    .PARAMETER Logaction 
        Where to log information for connections that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppfwpolicy -name <string>
        An example how to unset appfwpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy
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

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwpolicy {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwpolicy -Name <string>
        An example how to delete appfwpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or a Citrix ADC expression, that the policy uses to determine whether to filter the connection through the application firewall with the designated profile. 
    .PARAMETER Profilename 
        Name of the application firewall profile to use if the policy matches. 
    .PARAMETER Comment 
        Any comments to preserve information about the policy for later reference. 
    .PARAMETER Logaction 
        Where to log information for connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwpolicy -name <string>
        An example how to update appfwpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$Profilename,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("appfwpolicy", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $payload)
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

function Invoke-ADCAddAppfwpolicy {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER Rule 
        Name of the Citrix ADC named rule, or a Citrix ADC expression, that the policy uses to determine whether to filter the connection through the application firewall with the designated profile. 
    .PARAMETER Profilename 
        Name of the application firewall profile to use if the policy matches. 
    .PARAMETER Comment 
        Any comments to preserve information about the policy for later reference. 
    .PARAMETER Logaction 
        Where to log information for connections that match this policy. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwpolicy -name <string> -rule <string> -profilename <string>
        An example how to add appfwpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        [string]$Profilename,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                profilename    = $profilename
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("appfwpolicy", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicy -Filter $payload)
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

function Invoke-ADCGetAppfwpolicy {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for application firewall policy resource.
    .PARAMETER Name 
        Name for the policy. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Can be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicy -GetAll 
        Get all appfwpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicy -Count 
        Get the number of appfwpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicy -name <string>
        Get appfwpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicy -Filter @{ 'name'='<value>' }
        Get appfwpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRenameAppfwpolicylabel {
    <#
    .SYNOPSIS
        Rename Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER Newname 
        The new name of the application firewall policylabel. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAppfwpolicylabel -labelname <string> -newname <string>
        An example how to rename appfwpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAppfwpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCRenameAppfwpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("appfwpolicylabel", "Rename Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabel -Filter $payload)
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

function Invoke-ADCDeleteAppfwpolicylabel {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwpolicylabel -Labelname <string>
        An example how to delete appfwpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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

function Invoke-ADCAddAppfwpolicylabel {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER Policylabeltype 
        Type of transformations allowed by the policies bound to the label. Always http_req for application firewall policy labels. 
        Possible values = http_req, httpquic_req 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwpolicylabel -labelname <string> -policylabeltype <string>
        An example how to add appfwpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        [ValidateSet('http_req', 'httpquic_req')]
        [string]$Policylabeltype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policylabeltype     = $policylabeltype
            }

            if ( $PSCmdlet.ShouldProcess("appfwpolicylabel", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabel -Filter $payload)
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

function Invoke-ADCGetAppfwpolicylabel {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for application firewall policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Can be changed after the policy label is created. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabel -GetAll 
        Get all appfwpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabel -Count 
        Get the number of appfwpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabel -name <string>
        Get appfwpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabel -Filter @{ 'name'='<value>' }
        Get appfwpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwpolicylabel.
    .PARAMETER Labelname 
        Name of the application firewall policy label. 
    .PARAMETER Policyname 
        Name of the application firewall policy to bind to the policy label. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the policy. A lower number specifies a higher priority. Must be unique within a group of policies that are bound to the same bind point or label. Policies are evaluated in the order of their priority numbers. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke if the current policy evaluates to TRUE and the invoke parameter is set. Available settings function as follows: * reqvserver. Invoke the unnamed policy label associated with the specified request virtual server. * policylabel. Invoke the specified user-defined policy label. 
        Possible values = reqvserver, policylabel 
    .PARAMETER Invoke_labelname 
        Name of the policy label to invoke if the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is set to Policy Label. 
    .PARAMETER PassThru 
        Return details about the created appfwpolicylabel_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwpolicylabelappfwpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add appfwpolicylabel_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwpolicylabelappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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

        [ValidateSet('reqvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwpolicylabelappfwpolicybinding: Starting"
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
            if ( $PSCmdlet.ShouldProcess("appfwpolicylabel_appfwpolicy_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwpolicylabel_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwpolicylabel.
    .PARAMETER Labelname 
        Name of the application firewall policy label. 
    .PARAMETER Policyname 
        Name of the application firewall policy to bind to the policy label. 
    .PARAMETER Priority 
        Positive integer specifying the priority of the policy. A lower number specifies a higher priority. Must be unique within a group of policies that are bound to the same bind point or label. Policies are evaluated in the order of their priority numbers.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding -Labelname <string>
        An example how to delete appfwpolicylabel_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteAppfwpolicylabelappfwpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to appfwpolicylabel.
    .PARAMETER Labelname 
        Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicylabel_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelappfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -GetAll 
        Get all appfwpolicylabel_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Count 
        Get the number of appfwpolicylabel_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -name <string>
        Get appfwpolicylabel_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelappfwpolicybinding -Filter @{ 'name'='<value>' }
        Get appfwpolicylabel_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicylabel_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appfwpolicylabel.
    .PARAMETER Labelname 
        Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabelbinding -GetAll 
        Get all appfwpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelbinding -name <string>
        Get appfwpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to appfwpolicylabel.
    .PARAMETER Labelname 
        Name of the application firewall policy label. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -GetAll 
        Get all appfwpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -Count 
        Get the number of appfwpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -name <string>
        Get appfwpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylabelpolicybindingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwglobal that can be bound to appfwpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy_appfwglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy_appfwglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicyappfwglobalbinding -GetAll 
        Get all appfwpolicy_appfwglobal_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicyappfwglobalbinding -Count 
        Get the number of appfwpolicy_appfwglobal_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwglobalbinding -name <string>
        Get appfwpolicy_appfwglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwglobalbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicy_appfwglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicyappfwglobalbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_appfwglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_appfwglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_appfwglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicylabel that can be bound to appfwpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy_appfwpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy_appfwpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -GetAll 
        Get all appfwpolicy_appfwpolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -Count 
        Get the number of appfwpolicy_appfwpolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -name <string>
        Get appfwpolicy_appfwpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicy_appfwpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_appfwpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicyappfwpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicy_appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_appfwpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_appfwpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_appfwpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appfwpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicybinding -GetAll 
        Get all appfwpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicybinding -name <string>
        Get appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicybinding -Filter @{ 'name'='<value>' }
        Get appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to appfwpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicycsvserverbinding -GetAll 
        Get all appfwpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicycsvserverbinding -Count 
        Get the number of appfwpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicycsvserverbinding -name <string>
        Get appfwpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicycsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to appfwpolicy.
    .PARAMETER Name 
        Name of the policy. 
    .PARAMETER GetAll 
        Retrieve all appfwpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylbvserverbinding -GetAll 
        Get all appfwpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwpolicylbvserverbinding -Count 
        Get the number of appfwpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylbvserverbinding -name <string>
        Get appfwpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get appfwpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwpolicylbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCRestoreAppfwprofile {
    <#
    .SYNOPSIS
        Restore Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Archivename 
        Source for tar archive. 
    .PARAMETER Relaxationrules 
        Import all appfw relaxation rules. 
    .PARAMETER Importprofilename 
        Name of the profile which will be created/updated to associate the relaxation rules. 
    .PARAMETER Matchurlstring 
        Match this action url in archived Relaxation Rules to replace. 
    .PARAMETER Replaceurlstring 
        Replace matched url string with this action url string while restoring Relaxation Rules. 
    .PARAMETER Overwrite 
        Purge existing Relaxation Rules and replace during import. 
    .PARAMETER Augment 
        Augment Relaxation Rules during import.
    .EXAMPLE
        PS C:\>Invoke-ADCRestoreAppfwprofile -archivename <string>
        An example how to restore appfwprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRestoreAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        [string]$Archivename,

        [boolean]$Relaxationrules,

        [string]$Importprofilename,

        [string]$Matchurlstring,

        [string]$Replaceurlstring,

        [boolean]$Overwrite,

        [boolean]$Augment 

    )
    begin {
        Write-Verbose "Invoke-ADCRestoreAppfwprofile: Starting"
    }
    process {
        try {
            $payload = @{ archivename = $archivename }
            if ( $PSBoundParameters.ContainsKey('relaxationrules') ) { $payload.Add('relaxationrules', $relaxationrules) }
            if ( $PSBoundParameters.ContainsKey('importprofilename') ) { $payload.Add('importprofilename', $importprofilename) }
            if ( $PSBoundParameters.ContainsKey('matchurlstring') ) { $payload.Add('matchurlstring', $matchurlstring) }
            if ( $PSBoundParameters.ContainsKey('replaceurlstring') ) { $payload.Add('replaceurlstring', $replaceurlstring) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSBoundParameters.ContainsKey('augment') ) { $payload.Add('augment', $augment) }
            if ( $PSCmdlet.ShouldProcess($Name, "Restore Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwprofile -Action restore -Payload $payload -GetWarning
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

function Invoke-ADCUnsetAppfwprofile {
    <#
    .SYNOPSIS
        Unset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Starturlaction 
        One or more Start URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Infercontenttypexmlpayloadaction 
        One or more infer content type payload actions. Available settings function as follows: 
        * Block - Block connections that have mismatch in content-type header and payload. 
        * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request. 
        * Stats - Generate statistics when there is mismatch in content-type header and payload. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type. 
        Possible values = block, log, stats, none 
    .PARAMETER Contenttypeaction 
        One or more Content-type actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Inspectcontenttypes 
        One or more InspectContentType lists. 
        * application/x-www-form-urlencoded 
        * multipart/form-data 
        * text/x-gwt-rpc 
        CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected. 
        Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
    .PARAMETER Starturlclosure 
        Toggle the state of Start URL Closure. 
        Possible values = ON, OFF 
    .PARAMETER Denyurlaction 
        One or more Deny URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check. 
        CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Refererheadercheck 
        Enable validation of Referer headers. 
        Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker. 
        Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks. 
        Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
    .PARAMETER Cookieconsistencyaction 
        One or more Cookie Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cookiehijackingaction 
        One or more actions to prevent cookie hijacking. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: Cookie Hijacking feature is not supported for TLSv1.3 
        CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cookietransforms 
        Perform the specified type of cookie transformation. 
        Available settings function as follows: 
        * Encryption - Encrypt cookies. 
        * Proxying - Mask contents of server cookies by sending proxy cookie to users. 
        * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Cookieencryption 
        Type of cookie encryption. Available settings function as follows: 
        * None - Do not encrypt cookies. 
        * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies. 
        * Encrypt Session Only - Encrypt session cookies, but not permanent cookies. 
        * Encrypt All - Encrypt all cookies. 
        Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
    .PARAMETER Cookieproxying 
        Cookie proxy setting. Available settings function as follows: 
        * None - Do not proxy cookies. 
        * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies. 
        Possible values = none, sessionOnly 
    .PARAMETER Addcookieflags 
        Add the specified flags to cookies. Available settings function as follows: 
        * None - Do not add flags to cookies. 
        * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies. 
        * Secure - Add Secure flag to cookies. 
        * All - Add both HTTPOnly and Secure flags to cookies. 
        Possible values = none, httpOnly, secure, all 
    .PARAMETER Fieldconsistencyaction 
        One or more Form Field Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Csrftagaction 
        One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingaction 
        One or more Cross-Site Scripting (XSS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingtransformunsafehtml 
        Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Crosssitescriptingcheckcompleteurls 
        Check complete URLs for cross-site scripts, instead of just the query portions of URLs. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionaction 
        One or more HTML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cmdinjectionaction 
        Command injection action. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Sqlinjectiontransformspecialchars 
        Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special strings (characters) for injected SQL code. 
        Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Sqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiongrammar 
        Check for SQL injection using SQL grammar. 
        Possible values = ON, OFF 
    .PARAMETER Fieldformataction 
        One or more Field Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Defaultfieldformattype 
        Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them. 
    .PARAMETER Defaultfieldformatminlength 
        Minimum length, in characters, for data entered into a field that is assigned the default field type. 
        To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0). 
    .PARAMETER Defaultfieldformatmaxlength 
        Maximum length, in characters, for data entered into a field that is assigned the default field type. 
    .PARAMETER Bufferoverflowaction 
        One or more Buffer Overflow actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Bufferoverflowmaxurllength 
        Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked. 
    .PARAMETER Bufferoverflowmaxheaderlength 
        Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked. 
    .PARAMETER Bufferoverflowmaxcookielength 
        Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked. 
    .PARAMETER Bufferoverflowmaxquerylength 
        Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked. 
    .PARAMETER Bufferoverflowmaxtotalheaderlength 
        Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked. 
    .PARAMETER Creditcardaction 
        One or more Credit Card actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Creditcard 
        Credit card types that the application firewall should protect. 
        Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
    .PARAMETER Creditcardmaxallowed 
        This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked. 
    .PARAMETER Creditcardxout 
        Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.". 
        Possible values = ON, OFF 
    .PARAMETER Dosecurecreditcardlogging 
        Setting this option logs credit card numbers in the response when the match is found. 
        Possible values = ON, OFF 
    .PARAMETER Streaming 
        Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : Signatures, SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging, JSON SQL, JSON XSS, JSON DOS is enabled. Please make sure that the backend server accepts chunked requests before enabling this option. Citrix recommends enabling this option for large request sizes(>20MB). 
        Possible values = ON, OFF 
    .PARAMETER Trace 
        Toggle the state of trace. 
        Possible values = ON, OFF 
    .PARAMETER Requestcontenttype 
        Default Content-Type header for requests. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Responsecontenttype 
        Default Content-Type header for responses. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Jsonerrorobject 
        Name to the imported JSON Error Object to be set on application firewall profile. 
    .PARAMETER Jsonerrorstatuscode 
        Response status code associated with JSON error page. 
    .PARAMETER Jsonerrorstatusmessage 
        Response status message associated with JSON error page. 
    .PARAMETER Jsondosaction 
        One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectionaction 
        One or more JSON SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found, 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Jsonsqlinjectiongrammar 
        Check for SQL injection using SQL grammar in JSON. 
        Possible values = ON, OFF 
    .PARAMETER Jsoncmdinjectionaction 
        One or more JSON CMD Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONCMDInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONCMDInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsoncmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Jsonxssaction 
        One or more JSON Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmldosaction 
        One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlformataction 
        One or more XML Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectionaction 
        One or more XML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL. 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Xmlsqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectionparsecomments 
        Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Xmlxssaction 
        One or more XML Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlwsiaction 
        One or more Web Services Interoperability (WSI) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlattachmentaction 
        One or more XML Attachment actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlvalidationaction 
        One or more XML Validation actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlerrorobject 
        Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
    .PARAMETER Xmlerrorstatuscode 
        Response status code associated with XML error page. 
    .PARAMETER Xmlerrorstatusmessage 
        Response status message associated with XML error page. 
    .PARAMETER Customsettings 
        Object name for custom settings. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Signatures 
        Object name for signatures. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Xmlsoapfaultaction 
        One or more XML SOAP Fault Filtering actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        * Remove - Remove all violations for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none". 
        Possible values = none, block, log, remove, stats 
    .PARAMETER Usehtmlerrorobject 
        Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL. 
        Possible values = ON, OFF 
    .PARAMETER Errorurl 
        URL that application firewall uses as the Error URL. 
    .PARAMETER Htmlerrorobject 
        Name to assign to the HTML Error Object. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
    .PARAMETER Htmlerrorstatuscode 
        Response status code associated with HTML error page. 
    .PARAMETER Htmlerrorstatusmessage 
        Response status message associated with HTML error page. 
    .PARAMETER Logeverypolicyhit 
        Log every profile match, regardless of security checks results. 
        Possible values = ON, OFF 
    .PARAMETER Stripcomments 
        Strip HTML comments. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Striphtmlcomments 
        Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all, exclude_script_tag 
    .PARAMETER Stripxmlcomments 
        Strip XML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Dynamiclearning 
        One or more security checks. Available options are as follows: 
        * SQLInjection - Enable dynamic learning for SQLInjection security check. 
        * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check. 
        * fieldFormat - Enable dynamic learning for fieldFormat security check. 
        * None - Disable security checks for all security checks. 
        CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none". 
        Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
    .PARAMETER Exemptclosureurlsfromsecuritychecks 
        Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers. 
        Possible values = ON, OFF 
    .PARAMETER Defaultcharset 
        Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are: 
        * iso-8859-1 (English US) 
        * big5 (Chinese Traditional) 
        * gb2312 (Chinese Simplified) 
        * sjis (Japanese Shift-JIS) 
        * euc-jp (Japanese EUC-JP) 
        * iso-8859-9 (Turkish) 
        * utf-8 (Unicode) 
        * euc-kr (Korean). 
    .PARAMETER Postbodylimit 
        Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB. Citrix recommends enabling streaming option for large values of post body limit (>20MB). 
    .PARAMETER Postbodylimitaction 
        One or more Post Body Limit actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. Must always be set. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled. 
        Possible values = block, log, stats 
    .PARAMETER Postbodylimitsignature 
        Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile. 
    .PARAMETER Fileuploadmaxnum 
        Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads. 
    .PARAMETER Canonicalizehtmlresponse 
        Perform HTML entity encoding for any special characters in responses sent by your protected web sites. 
        Possible values = ON, OFF 
    .PARAMETER Enableformtagging 
        Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks. 
        Possible values = ON, OFF 
    .PARAMETER Sessionlessfieldconsistency 
        Perform sessionless Field Consistency Checks. 
        Possible values = OFF, ON, postOnly 
    .PARAMETER Sessionlessurlclosure 
        Enable session less URL Closure Checks. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Semicolonfieldseparator 
        Allow ';' as a form field separator in URL queries and POST form bodies. . 
        Possible values = ON, OFF 
    .PARAMETER Excludefileuploadfromchecks 
        Exclude uploaded files from Form checks. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionparsecomments 
        Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Invalidpercenthandling 
        Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows: 
        * apache_mode - Apache format. 
        * asp_mode - Microsoft ASP format. 
        * secure_mode - Secure format. 
        Possible values = apache_mode, asp_mode, secure_mode 
    .PARAMETER Type 
        Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows: 
        * HTML - HTML-based web sites. 
        * XML - XML-based web sites and services. 
        * JSON - JSON-based web sites and services. 
        * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds. 
        * HTML JSON - Sites that contain both HTML and JSON content. 
        * XML JSON - Sites that contain both XML and JSON content. 
        * HTML XML JSON - Sites that contain HTML, XML and JSON content. 
        Possible values = HTML, XML, JSON 
    .PARAMETER Checkrequestheaders 
        Check request headers as well as web forms for injected SQL and cross-site scripts. 
        Possible values = ON, OFF 
    .PARAMETER Inspectquerycontenttypes 
        Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types. 
        Possible values = HTML, XML, JSON, OTHER 
    .PARAMETER Optimizepartialreqs 
        Optimize handle of HTTP partial requests i.e. those with range headers. 
        Available settings are as follows: 
        * ON - Partial requests by the client result in partial requests to the backend server in most cases. 
        * OFF - Partial requests by the client are changed to full requests to the backend server. 
        Possible values = ON, OFF 
    .PARAMETER Urldecoderequestcookies 
        URL Decode request cookies before subjecting them to SQL and cross-site scripting checks. 
        Possible values = ON, OFF 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Percentdecoderecursively 
        Configure whether the application firewall should use percentage recursive decoding. 
        Possible values = ON, OFF 
    .PARAMETER Multipleheaderaction 
        One or more multiple header actions. Available settings function as follows: 
        * Block - Block connections that have multiple headers. 
        * Log - Log connections that have multiple headers. 
        * KeepLast - Keep only last header when multiple headers are present. 
        CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled. 
        Possible values = block, keepLast, log, none 
    .PARAMETER Rfcprofile 
        Object name of the rfc profile. 
    .PARAMETER Fileuploadtypesaction 
        One or more file upload types actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Verboseloglevel 
        Detailed Logging Verbose Log Level. 
        Possible values = pattern, patternPayload, patternPayloadHeader 
    .PARAMETER Insertcookiesamesiteattribute 
        Configure whether application firewall should add samesite attribute for set-cookies. 
        Possible values = ON, OFF 
    .PARAMETER Cookiesamesiteattribute 
        Cookie Samesite attribute added to support adding cookie SameSite attribute for all set-cookies including appfw session cookies. Default value will be "SameSite=Lax". 
        Possible values = None, LAX, STRICT 
    .PARAMETER Sqlinjectionruletype 
        Specifies SQL Injection rule type: ALLOW/DENY. If ALLOW rule type is configured then allow list rules are used, if DENY rule type is configured then deny rules are used. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppfwprofile -name <string>
        An example how to unset appfwprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile
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

        [Boolean]$starturlaction,

        [Boolean]$infercontenttypexmlpayloadaction,

        [Boolean]$contenttypeaction,

        [Boolean]$inspectcontenttypes,

        [Boolean]$starturlclosure,

        [Boolean]$denyurlaction,

        [Boolean]$refererheadercheck,

        [Boolean]$cookieconsistencyaction,

        [Boolean]$cookiehijackingaction,

        [Boolean]$cookietransforms,

        [Boolean]$cookieencryption,

        [Boolean]$cookieproxying,

        [Boolean]$addcookieflags,

        [Boolean]$fieldconsistencyaction,

        [Boolean]$csrftagaction,

        [Boolean]$crosssitescriptingaction,

        [Boolean]$crosssitescriptingtransformunsafehtml,

        [Boolean]$crosssitescriptingcheckcompleteurls,

        [Boolean]$sqlinjectionaction,

        [Boolean]$cmdinjectionaction,

        [Boolean]$cmdinjectiontype,

        [Boolean]$sqlinjectiontransformspecialchars,

        [Boolean]$sqlinjectiononlycheckfieldswithsqlchars,

        [Boolean]$sqlinjectiontype,

        [Boolean]$sqlinjectionchecksqlwildchars,

        [Boolean]$sqlinjectiongrammar,

        [Boolean]$fieldformataction,

        [Boolean]$defaultfieldformattype,

        [Boolean]$defaultfieldformatminlength,

        [Boolean]$defaultfieldformatmaxlength,

        [Boolean]$bufferoverflowaction,

        [Boolean]$bufferoverflowmaxurllength,

        [Boolean]$bufferoverflowmaxheaderlength,

        [Boolean]$bufferoverflowmaxcookielength,

        [Boolean]$bufferoverflowmaxquerylength,

        [Boolean]$bufferoverflowmaxtotalheaderlength,

        [Boolean]$creditcardaction,

        [Boolean]$creditcard,

        [Boolean]$creditcardmaxallowed,

        [Boolean]$creditcardxout,

        [Boolean]$dosecurecreditcardlogging,

        [Boolean]$streaming,

        [Boolean]$trace,

        [Boolean]$requestcontenttype,

        [Boolean]$responsecontenttype,

        [Boolean]$jsonerrorobject,

        [Boolean]$jsonerrorstatuscode,

        [Boolean]$jsonerrorstatusmessage,

        [Boolean]$jsondosaction,

        [Boolean]$jsonsqlinjectionaction,

        [Boolean]$jsonsqlinjectiontype,

        [Boolean]$jsonsqlinjectiongrammar,

        [Boolean]$jsoncmdinjectionaction,

        [Boolean]$jsoncmdinjectiontype,

        [Boolean]$jsonxssaction,

        [Boolean]$xmldosaction,

        [Boolean]$xmlformataction,

        [Boolean]$xmlsqlinjectionaction,

        [Boolean]$xmlsqlinjectiononlycheckfieldswithsqlchars,

        [Boolean]$xmlsqlinjectiontype,

        [Boolean]$xmlsqlinjectionchecksqlwildchars,

        [Boolean]$xmlsqlinjectionparsecomments,

        [Boolean]$xmlxssaction,

        [Boolean]$xmlwsiaction,

        [Boolean]$xmlattachmentaction,

        [Boolean]$xmlvalidationaction,

        [Boolean]$xmlerrorobject,

        [Boolean]$xmlerrorstatuscode,

        [Boolean]$xmlerrorstatusmessage,

        [Boolean]$customsettings,

        [Boolean]$signatures,

        [Boolean]$xmlsoapfaultaction,

        [Boolean]$usehtmlerrorobject,

        [Boolean]$errorurl,

        [Boolean]$htmlerrorobject,

        [Boolean]$htmlerrorstatuscode,

        [Boolean]$htmlerrorstatusmessage,

        [Boolean]$logeverypolicyhit,

        [Boolean]$stripcomments,

        [Boolean]$striphtmlcomments,

        [Boolean]$stripxmlcomments,

        [Boolean]$clientipexpression,

        [Boolean]$dynamiclearning,

        [Boolean]$exemptclosureurlsfromsecuritychecks,

        [Boolean]$defaultcharset,

        [Boolean]$postbodylimit,

        [Boolean]$postbodylimitaction,

        [Boolean]$postbodylimitsignature,

        [Boolean]$fileuploadmaxnum,

        [Boolean]$canonicalizehtmlresponse,

        [Boolean]$enableformtagging,

        [Boolean]$sessionlessfieldconsistency,

        [Boolean]$sessionlessurlclosure,

        [Boolean]$semicolonfieldseparator,

        [Boolean]$excludefileuploadfromchecks,

        [Boolean]$sqlinjectionparsecomments,

        [Boolean]$invalidpercenthandling,

        [Boolean]$type,

        [Boolean]$checkrequestheaders,

        [Boolean]$inspectquerycontenttypes,

        [Boolean]$optimizepartialreqs,

        [Boolean]$urldecoderequestcookies,

        [Boolean]$comment,

        [Boolean]$percentdecoderecursively,

        [Boolean]$multipleheaderaction,

        [Boolean]$rfcprofile,

        [Boolean]$fileuploadtypesaction,

        [Boolean]$verboseloglevel,

        [Boolean]$insertcookiesamesiteattribute,

        [Boolean]$cookiesamesiteattribute,

        [Boolean]$sqlinjectionruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('starturlaction') ) { $payload.Add('starturlaction', $starturlaction) }
            if ( $PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction') ) { $payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ( $PSBoundParameters.ContainsKey('contenttypeaction') ) { $payload.Add('contenttypeaction', $contenttypeaction) }
            if ( $PSBoundParameters.ContainsKey('inspectcontenttypes') ) { $payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ( $PSBoundParameters.ContainsKey('starturlclosure') ) { $payload.Add('starturlclosure', $starturlclosure) }
            if ( $PSBoundParameters.ContainsKey('denyurlaction') ) { $payload.Add('denyurlaction', $denyurlaction) }
            if ( $PSBoundParameters.ContainsKey('refererheadercheck') ) { $payload.Add('refererheadercheck', $refererheadercheck) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyaction') ) { $payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('cookiehijackingaction') ) { $payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ( $PSBoundParameters.ContainsKey('cookietransforms') ) { $payload.Add('cookietransforms', $cookietransforms) }
            if ( $PSBoundParameters.ContainsKey('cookieencryption') ) { $payload.Add('cookieencryption', $cookieencryption) }
            if ( $PSBoundParameters.ContainsKey('cookieproxying') ) { $payload.Add('cookieproxying', $cookieproxying) }
            if ( $PSBoundParameters.ContainsKey('addcookieflags') ) { $payload.Add('addcookieflags', $addcookieflags) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyaction') ) { $payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('csrftagaction') ) { $payload.Add('csrftagaction', $csrftagaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingaction') ) { $payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml') ) { $payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls') ) { $payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionaction') ) { $payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectionaction') ) { $payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectiontype') ) { $payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars') ) { $payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontype') ) { $payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars') ) { $payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiongrammar') ) { $payload.Add('sqlinjectiongrammar', $sqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('fieldformataction') ) { $payload.Add('fieldformataction', $fieldformataction) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformattype') ) { $payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatminlength') ) { $payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatmaxlength') ) { $payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowaction') ) { $payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxurllength') ) { $payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength') ) { $payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength') ) { $payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength') ) { $payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength') ) { $payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ( $PSBoundParameters.ContainsKey('creditcardaction') ) { $payload.Add('creditcardaction', $creditcardaction) }
            if ( $PSBoundParameters.ContainsKey('creditcard') ) { $payload.Add('creditcard', $creditcard) }
            if ( $PSBoundParameters.ContainsKey('creditcardmaxallowed') ) { $payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ( $PSBoundParameters.ContainsKey('creditcardxout') ) { $payload.Add('creditcardxout', $creditcardxout) }
            if ( $PSBoundParameters.ContainsKey('dosecurecreditcardlogging') ) { $payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ( $PSBoundParameters.ContainsKey('streaming') ) { $payload.Add('streaming', $streaming) }
            if ( $PSBoundParameters.ContainsKey('trace') ) { $payload.Add('trace', $trace) }
            if ( $PSBoundParameters.ContainsKey('requestcontenttype') ) { $payload.Add('requestcontenttype', $requestcontenttype) }
            if ( $PSBoundParameters.ContainsKey('responsecontenttype') ) { $payload.Add('responsecontenttype', $responsecontenttype) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorobject') ) { $payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatuscode') ) { $payload.Add('jsonerrorstatuscode', $jsonerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatusmessage') ) { $payload.Add('jsonerrorstatusmessage', $jsonerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('jsondosaction') ) { $payload.Add('jsondosaction', $jsondosaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectionaction') ) { $payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiontype') ) { $payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiongrammar') ) { $payload.Add('jsonsqlinjectiongrammar', $jsonsqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectionaction') ) { $payload.Add('jsoncmdinjectionaction', $jsoncmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectiontype') ) { $payload.Add('jsoncmdinjectiontype', $jsoncmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonxssaction') ) { $payload.Add('jsonxssaction', $jsonxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmldosaction') ) { $payload.Add('xmldosaction', $xmldosaction) }
            if ( $PSBoundParameters.ContainsKey('xmlformataction') ) { $payload.Add('xmlformataction', $xmlformataction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionaction') ) { $payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiontype') ) { $payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars') ) { $payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments') ) { $payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('xmlxssaction') ) { $payload.Add('xmlxssaction', $xmlxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiaction') ) { $payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentaction') ) { $payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidationaction') ) { $payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorobject') ) { $payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatuscode') ) { $payload.Add('xmlerrorstatuscode', $xmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatusmessage') ) { $payload.Add('xmlerrorstatusmessage', $xmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('customsettings') ) { $payload.Add('customsettings', $customsettings) }
            if ( $PSBoundParameters.ContainsKey('signatures') ) { $payload.Add('signatures', $signatures) }
            if ( $PSBoundParameters.ContainsKey('xmlsoapfaultaction') ) { $payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ( $PSBoundParameters.ContainsKey('usehtmlerrorobject') ) { $payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorobject') ) { $payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatuscode') ) { $payload.Add('htmlerrorstatuscode', $htmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatusmessage') ) { $payload.Add('htmlerrorstatusmessage', $htmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('logeverypolicyhit') ) { $payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ( $PSBoundParameters.ContainsKey('stripcomments') ) { $payload.Add('stripcomments', $stripcomments) }
            if ( $PSBoundParameters.ContainsKey('striphtmlcomments') ) { $payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ( $PSBoundParameters.ContainsKey('stripxmlcomments') ) { $payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('dynamiclearning') ) { $payload.Add('dynamiclearning', $dynamiclearning) }
            if ( $PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks') ) { $payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ( $PSBoundParameters.ContainsKey('defaultcharset') ) { $payload.Add('defaultcharset', $defaultcharset) }
            if ( $PSBoundParameters.ContainsKey('postbodylimit') ) { $payload.Add('postbodylimit', $postbodylimit) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitaction') ) { $payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitsignature') ) { $payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ( $PSBoundParameters.ContainsKey('fileuploadmaxnum') ) { $payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ( $PSBoundParameters.ContainsKey('canonicalizehtmlresponse') ) { $payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ( $PSBoundParameters.ContainsKey('enableformtagging') ) { $payload.Add('enableformtagging', $enableformtagging) }
            if ( $PSBoundParameters.ContainsKey('sessionlessfieldconsistency') ) { $payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('sessionlessurlclosure') ) { $payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ( $PSBoundParameters.ContainsKey('semicolonfieldseparator') ) { $payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ( $PSBoundParameters.ContainsKey('excludefileuploadfromchecks') ) { $payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionparsecomments') ) { $payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('invalidpercenthandling') ) { $payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('checkrequestheaders') ) { $payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ( $PSBoundParameters.ContainsKey('inspectquerycontenttypes') ) { $payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ( $PSBoundParameters.ContainsKey('optimizepartialreqs') ) { $payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ( $PSBoundParameters.ContainsKey('urldecoderequestcookies') ) { $payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('percentdecoderecursively') ) { $payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ( $PSBoundParameters.ContainsKey('multipleheaderaction') ) { $payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ( $PSBoundParameters.ContainsKey('rfcprofile') ) { $payload.Add('rfcprofile', $rfcprofile) }
            if ( $PSBoundParameters.ContainsKey('fileuploadtypesaction') ) { $payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('insertcookiesamesiteattribute') ) { $payload.Add('insertcookiesamesiteattribute', $insertcookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('cookiesamesiteattribute') ) { $payload.Add('cookiesamesiteattribute', $cookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionruletype') ) { $payload.Add('sqlinjectionruletype', $sqlinjectionruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwprofile {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofile -Name <string>
        An example how to delete appfwprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        Write-Verbose "Invoke-ADCDeleteAppfwprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Starturlaction 
        One or more Start URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Infercontenttypexmlpayloadaction 
        One or more infer content type payload actions. Available settings function as follows: 
        * Block - Block connections that have mismatch in content-type header and payload. 
        * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request. 
        * Stats - Generate statistics when there is mismatch in content-type header and payload. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type. 
        Possible values = block, log, stats, none 
    .PARAMETER Contenttypeaction 
        One or more Content-type actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Inspectcontenttypes 
        One or more InspectContentType lists. 
        * application/x-www-form-urlencoded 
        * multipart/form-data 
        * text/x-gwt-rpc 
        CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected. 
        Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
    .PARAMETER Starturlclosure 
        Toggle the state of Start URL Closure. 
        Possible values = ON, OFF 
    .PARAMETER Denyurlaction 
        One or more Deny URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check. 
        CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Refererheadercheck 
        Enable validation of Referer headers. 
        Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker. 
        Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks. 
        Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
    .PARAMETER Cookieconsistencyaction 
        One or more Cookie Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cookiehijackingaction 
        One or more actions to prevent cookie hijacking. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: Cookie Hijacking feature is not supported for TLSv1.3 
        CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cookietransforms 
        Perform the specified type of cookie transformation. 
        Available settings function as follows: 
        * Encryption - Encrypt cookies. 
        * Proxying - Mask contents of server cookies by sending proxy cookie to users. 
        * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Cookieencryption 
        Type of cookie encryption. Available settings function as follows: 
        * None - Do not encrypt cookies. 
        * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies. 
        * Encrypt Session Only - Encrypt session cookies, but not permanent cookies. 
        * Encrypt All - Encrypt all cookies. 
        Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
    .PARAMETER Cookieproxying 
        Cookie proxy setting. Available settings function as follows: 
        * None - Do not proxy cookies. 
        * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies. 
        Possible values = none, sessionOnly 
    .PARAMETER Addcookieflags 
        Add the specified flags to cookies. Available settings function as follows: 
        * None - Do not add flags to cookies. 
        * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies. 
        * Secure - Add Secure flag to cookies. 
        * All - Add both HTTPOnly and Secure flags to cookies. 
        Possible values = none, httpOnly, secure, all 
    .PARAMETER Fieldconsistencyaction 
        One or more Form Field Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Csrftagaction 
        One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingaction 
        One or more Cross-Site Scripting (XSS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingtransformunsafehtml 
        Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Crosssitescriptingcheckcompleteurls 
        Check complete URLs for cross-site scripts, instead of just the query portions of URLs. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionaction 
        One or more HTML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cmdinjectionaction 
        Command injection action. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Sqlinjectiontransformspecialchars 
        Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special strings (characters) for injected SQL code. 
        Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Sqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiongrammar 
        Check for SQL injection using SQL grammar. 
        Possible values = ON, OFF 
    .PARAMETER Fieldformataction 
        One or more Field Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Defaultfieldformattype 
        Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them. 
    .PARAMETER Defaultfieldformatminlength 
        Minimum length, in characters, for data entered into a field that is assigned the default field type. 
        To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0). 
    .PARAMETER Defaultfieldformatmaxlength 
        Maximum length, in characters, for data entered into a field that is assigned the default field type. 
    .PARAMETER Bufferoverflowaction 
        One or more Buffer Overflow actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Bufferoverflowmaxurllength 
        Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked. 
    .PARAMETER Bufferoverflowmaxheaderlength 
        Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked. 
    .PARAMETER Bufferoverflowmaxcookielength 
        Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked. 
    .PARAMETER Bufferoverflowmaxquerylength 
        Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked. 
    .PARAMETER Bufferoverflowmaxtotalheaderlength 
        Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked. 
    .PARAMETER Creditcardaction 
        One or more Credit Card actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Creditcard 
        Credit card types that the application firewall should protect. 
        Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
    .PARAMETER Creditcardmaxallowed 
        This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked. 
    .PARAMETER Creditcardxout 
        Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.". 
        Possible values = ON, OFF 
    .PARAMETER Dosecurecreditcardlogging 
        Setting this option logs credit card numbers in the response when the match is found. 
        Possible values = ON, OFF 
    .PARAMETER Streaming 
        Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : Signatures, SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging, JSON SQL, JSON XSS, JSON DOS is enabled. Please make sure that the backend server accepts chunked requests before enabling this option. Citrix recommends enabling this option for large request sizes(>20MB). 
        Possible values = ON, OFF 
    .PARAMETER Trace 
        Toggle the state of trace. 
        Possible values = ON, OFF 
    .PARAMETER Requestcontenttype 
        Default Content-Type header for requests. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Responsecontenttype 
        Default Content-Type header for responses. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Jsonerrorobject 
        Name to the imported JSON Error Object to be set on application firewall profile. 
    .PARAMETER Jsonerrorstatuscode 
        Response status code associated with JSON error page. 
    .PARAMETER Jsonerrorstatusmessage 
        Response status message associated with JSON error page. 
    .PARAMETER Jsondosaction 
        One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectionaction 
        One or more JSON SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found, 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Jsonsqlinjectiongrammar 
        Check for SQL injection using SQL grammar in JSON. 
        Possible values = ON, OFF 
    .PARAMETER Jsoncmdinjectionaction 
        One or more JSON CMD Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONCMDInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONCMDInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsoncmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Jsonxssaction 
        One or more JSON Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmldosaction 
        One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlformataction 
        One or more XML Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectionaction 
        One or more XML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL. 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Xmlsqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectionparsecomments 
        Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Xmlxssaction 
        One or more XML Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlwsiaction 
        One or more Web Services Interoperability (WSI) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlattachmentaction 
        One or more XML Attachment actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlvalidationaction 
        One or more XML Validation actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlerrorobject 
        Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
    .PARAMETER Xmlerrorstatuscode 
        Response status code associated with XML error page. 
    .PARAMETER Xmlerrorstatusmessage 
        Response status message associated with XML error page. 
    .PARAMETER Customsettings 
        Object name for custom settings. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Signatures 
        Object name for signatures. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Xmlsoapfaultaction 
        One or more XML SOAP Fault Filtering actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        * Remove - Remove all violations for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none". 
        Possible values = none, block, log, remove, stats 
    .PARAMETER Usehtmlerrorobject 
        Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL. 
        Possible values = ON, OFF 
    .PARAMETER Errorurl 
        URL that application firewall uses as the Error URL. 
    .PARAMETER Htmlerrorobject 
        Name to assign to the HTML Error Object. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
    .PARAMETER Htmlerrorstatuscode 
        Response status code associated with HTML error page. 
    .PARAMETER Htmlerrorstatusmessage 
        Response status message associated with HTML error page. 
    .PARAMETER Logeverypolicyhit 
        Log every profile match, regardless of security checks results. 
        Possible values = ON, OFF 
    .PARAMETER Stripcomments 
        Strip HTML comments. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Striphtmlcomments 
        Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all, exclude_script_tag 
    .PARAMETER Stripxmlcomments 
        Strip XML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Dynamiclearning 
        One or more security checks. Available options are as follows: 
        * SQLInjection - Enable dynamic learning for SQLInjection security check. 
        * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check. 
        * fieldFormat - Enable dynamic learning for fieldFormat security check. 
        * None - Disable security checks for all security checks. 
        CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none". 
        Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
    .PARAMETER Exemptclosureurlsfromsecuritychecks 
        Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers. 
        Possible values = ON, OFF 
    .PARAMETER Defaultcharset 
        Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are: 
        * iso-8859-1 (English US) 
        * big5 (Chinese Traditional) 
        * gb2312 (Chinese Simplified) 
        * sjis (Japanese Shift-JIS) 
        * euc-jp (Japanese EUC-JP) 
        * iso-8859-9 (Turkish) 
        * utf-8 (Unicode) 
        * euc-kr (Korean). 
    .PARAMETER Postbodylimit 
        Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB. Citrix recommends enabling streaming option for large values of post body limit (>20MB). 
    .PARAMETER Postbodylimitaction 
        One or more Post Body Limit actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. Must always be set. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled. 
        Possible values = block, log, stats 
    .PARAMETER Postbodylimitsignature 
        Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile. 
    .PARAMETER Fileuploadmaxnum 
        Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads. 
    .PARAMETER Canonicalizehtmlresponse 
        Perform HTML entity encoding for any special characters in responses sent by your protected web sites. 
        Possible values = ON, OFF 
    .PARAMETER Enableformtagging 
        Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks. 
        Possible values = ON, OFF 
    .PARAMETER Sessionlessfieldconsistency 
        Perform sessionless Field Consistency Checks. 
        Possible values = OFF, ON, postOnly 
    .PARAMETER Sessionlessurlclosure 
        Enable session less URL Closure Checks. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Semicolonfieldseparator 
        Allow ';' as a form field separator in URL queries and POST form bodies. . 
        Possible values = ON, OFF 
    .PARAMETER Excludefileuploadfromchecks 
        Exclude uploaded files from Form checks. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionparsecomments 
        Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Invalidpercenthandling 
        Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows: 
        * apache_mode - Apache format. 
        * asp_mode - Microsoft ASP format. 
        * secure_mode - Secure format. 
        Possible values = apache_mode, asp_mode, secure_mode 
    .PARAMETER Type 
        Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows: 
        * HTML - HTML-based web sites. 
        * XML - XML-based web sites and services. 
        * JSON - JSON-based web sites and services. 
        * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds. 
        * HTML JSON - Sites that contain both HTML and JSON content. 
        * XML JSON - Sites that contain both XML and JSON content. 
        * HTML XML JSON - Sites that contain HTML, XML and JSON content. 
        Possible values = HTML, XML, JSON 
    .PARAMETER Checkrequestheaders 
        Check request headers as well as web forms for injected SQL and cross-site scripts. 
        Possible values = ON, OFF 
    .PARAMETER Inspectquerycontenttypes 
        Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types. 
        Possible values = HTML, XML, JSON, OTHER 
    .PARAMETER Optimizepartialreqs 
        Optimize handle of HTTP partial requests i.e. those with range headers. 
        Available settings are as follows: 
        * ON - Partial requests by the client result in partial requests to the backend server in most cases. 
        * OFF - Partial requests by the client are changed to full requests to the backend server. 
        Possible values = ON, OFF 
    .PARAMETER Urldecoderequestcookies 
        URL Decode request cookies before subjecting them to SQL and cross-site scripting checks. 
        Possible values = ON, OFF 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Percentdecoderecursively 
        Configure whether the application firewall should use percentage recursive decoding. 
        Possible values = ON, OFF 
    .PARAMETER Multipleheaderaction 
        One or more multiple header actions. Available settings function as follows: 
        * Block - Block connections that have multiple headers. 
        * Log - Log connections that have multiple headers. 
        * KeepLast - Keep only last header when multiple headers are present. 
        CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled. 
        Possible values = block, keepLast, log, none 
    .PARAMETER Rfcprofile 
        Object name of the rfc profile. 
    .PARAMETER Fileuploadtypesaction 
        One or more file upload types actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Verboseloglevel 
        Detailed Logging Verbose Log Level. 
        Possible values = pattern, patternPayload, patternPayloadHeader 
    .PARAMETER Insertcookiesamesiteattribute 
        Configure whether application firewall should add samesite attribute for set-cookies. 
        Possible values = ON, OFF 
    .PARAMETER Cookiesamesiteattribute 
        Cookie Samesite attribute added to support adding cookie SameSite attribute for all set-cookies including appfw session cookies. Default value will be "SameSite=Lax". 
        Possible values = None, LAX, STRICT 
    .PARAMETER Sqlinjectionruletype 
        Specifies SQL Injection rule type: ALLOW/DENY. If ALLOW rule type is configured then allow list rules are used, if DENY rule type is configured then deny rules are used. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwprofile -name <string>
        An example how to update appfwprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Starturlaction,

        [ValidateSet('block', 'log', 'stats', 'none')]
        [string[]]$Infercontenttypexmlpayloadaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Contenttypeaction,

        [ValidateSet('none', 'application/x-www-form-urlencoded', 'multipart/form-data', 'text/x-gwt-rpc')]
        [string[]]$Inspectcontenttypes,

        [ValidateSet('ON', 'OFF')]
        [string]$Starturlclosure,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Denyurlaction,

        [ValidateSet('OFF', 'if_present', 'AlwaysExceptStartURLs', 'AlwaysExceptFirstRequest')]
        [string]$Refererheadercheck,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Cookieconsistencyaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Cookiehijackingaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Cookietransforms,

        [ValidateSet('none', 'decryptOnly', 'encryptSessionOnly', 'encryptAll')]
        [string]$Cookieencryption,

        [ValidateSet('none', 'sessionOnly')]
        [string]$Cookieproxying,

        [ValidateSet('none', 'httpOnly', 'secure', 'all')]
        [string]$Addcookieflags,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Fieldconsistencyaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Csrftagaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Crosssitescriptingaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Crosssitescriptingtransformunsafehtml,

        [ValidateSet('ON', 'OFF')]
        [string]$Crosssitescriptingcheckcompleteurls,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Sqlinjectionaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Cmdinjectionaction,

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$Cmdinjectiontype,

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiontransformspecialchars,

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiononlycheckfieldswithsqlchars,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Sqlinjectiontype,

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectionchecksqlwildchars,

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiongrammar,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Fieldformataction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Defaultfieldformattype,

        [ValidateRange(0, 2147483647)]
        [double]$Defaultfieldformatminlength,

        [ValidateRange(1, 2147483647)]
        [double]$Defaultfieldformatmaxlength,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Bufferoverflowaction,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxurllength,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxheaderlength,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxcookielength,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxquerylength,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxtotalheaderlength,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Creditcardaction,

        [ValidateSet('none', 'visa', 'mastercard', 'discover', 'amex', 'jcb', 'dinersclub')]
        [string[]]$Creditcard,

        [ValidateRange(0, 255)]
        [double]$Creditcardmaxallowed,

        [ValidateSet('ON', 'OFF')]
        [string]$Creditcardxout,

        [ValidateSet('ON', 'OFF')]
        [string]$Dosecurecreditcardlogging,

        [ValidateSet('ON', 'OFF')]
        [string]$Streaming,

        [ValidateSet('ON', 'OFF')]
        [string]$Trace,

        [ValidateLength(1, 255)]
        [string]$Requestcontenttype,

        [ValidateLength(1, 255)]
        [string]$Responsecontenttype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Jsonerrorobject,

        [ValidateRange(1, 999)]
        [double]$Jsonerrorstatuscode,

        [string]$Jsonerrorstatusmessage,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsondosaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsonsqlinjectionaction,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Jsonsqlinjectiontype,

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonsqlinjectiongrammar,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsoncmdinjectionaction,

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$Jsoncmdinjectiontype,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsonxssaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmldosaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlformataction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlsqlinjectionaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlsqlinjectiononlycheckfieldswithsqlchars,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Xmlsqlinjectiontype,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlsqlinjectionchecksqlwildchars,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$Xmlsqlinjectionparsecomments,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlxssaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlwsiaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlattachmentaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlvalidationaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Xmlerrorobject,

        [ValidateRange(1, 999)]
        [double]$Xmlerrorstatuscode,

        [string]$Xmlerrorstatusmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customsettings,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signatures,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats')]
        [string[]]$Xmlsoapfaultaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Usehtmlerrorobject,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Htmlerrorobject,

        [ValidateRange(1, 999)]
        [double]$Htmlerrorstatuscode,

        [string]$Htmlerrorstatusmessage,

        [ValidateSet('ON', 'OFF')]
        [string]$Logeverypolicyhit,

        [ValidateSet('ON', 'OFF')]
        [string]$Stripcomments,

        [ValidateSet('none', 'all', 'exclude_script_tag')]
        [string]$Striphtmlcomments,

        [ValidateSet('none', 'all')]
        [string]$Stripxmlcomments,

        [string]$Clientipexpression,

        [ValidateSet('none', 'SQLInjection', 'CrossSiteScripting', 'fieldFormat', 'startURL', 'cookieConsistency', 'fieldConsistency', 'CSRFtag', 'ContentType')]
        [string[]]$Dynamiclearning,

        [ValidateSet('ON', 'OFF')]
        [string]$Exemptclosureurlsfromsecuritychecks,

        [ValidateLength(1, 31)]
        [string]$Defaultcharset,

        [double]$Postbodylimit,

        [ValidateSet('block', 'log', 'stats')]
        [string[]]$Postbodylimitaction,

        [double]$Postbodylimitsignature,

        [ValidateRange(0, 65535)]
        [double]$Fileuploadmaxnum,

        [ValidateSet('ON', 'OFF')]
        [string]$Canonicalizehtmlresponse,

        [ValidateSet('ON', 'OFF')]
        [string]$Enableformtagging,

        [ValidateSet('OFF', 'ON', 'postOnly')]
        [string]$Sessionlessfieldconsistency,

        [ValidateSet('ON', 'OFF')]
        [string]$Sessionlessurlclosure,

        [ValidateSet('ON', 'OFF')]
        [string]$Semicolonfieldseparator,

        [ValidateSet('ON', 'OFF')]
        [string]$Excludefileuploadfromchecks,

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$Sqlinjectionparsecomments,

        [ValidateSet('apache_mode', 'asp_mode', 'secure_mode')]
        [string]$Invalidpercenthandling,

        [ValidateSet('HTML', 'XML', 'JSON')]
        [string[]]$Type,

        [ValidateSet('ON', 'OFF')]
        [string]$Checkrequestheaders,

        [ValidateSet('HTML', 'XML', 'JSON', 'OTHER')]
        [string[]]$Inspectquerycontenttypes,

        [ValidateSet('ON', 'OFF')]
        [string]$Optimizepartialreqs,

        [ValidateSet('ON', 'OFF')]
        [string]$Urldecoderequestcookies,

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Percentdecoderecursively,

        [ValidateSet('block', 'keepLast', 'log', 'none')]
        [string[]]$Multipleheaderaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rfcprofile,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Fileuploadtypesaction,

        [ValidateSet('pattern', 'patternPayload', 'patternPayloadHeader')]
        [string]$Verboseloglevel,

        [ValidateSet('ON', 'OFF')]
        [string]$Insertcookiesamesiteattribute,

        [ValidateSet('None', 'LAX', 'STRICT')]
        [string]$Cookiesamesiteattribute,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Sqlinjectionruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('starturlaction') ) { $payload.Add('starturlaction', $starturlaction) }
            if ( $PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction') ) { $payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ( $PSBoundParameters.ContainsKey('contenttypeaction') ) { $payload.Add('contenttypeaction', $contenttypeaction) }
            if ( $PSBoundParameters.ContainsKey('inspectcontenttypes') ) { $payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ( $PSBoundParameters.ContainsKey('starturlclosure') ) { $payload.Add('starturlclosure', $starturlclosure) }
            if ( $PSBoundParameters.ContainsKey('denyurlaction') ) { $payload.Add('denyurlaction', $denyurlaction) }
            if ( $PSBoundParameters.ContainsKey('refererheadercheck') ) { $payload.Add('refererheadercheck', $refererheadercheck) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyaction') ) { $payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('cookiehijackingaction') ) { $payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ( $PSBoundParameters.ContainsKey('cookietransforms') ) { $payload.Add('cookietransforms', $cookietransforms) }
            if ( $PSBoundParameters.ContainsKey('cookieencryption') ) { $payload.Add('cookieencryption', $cookieencryption) }
            if ( $PSBoundParameters.ContainsKey('cookieproxying') ) { $payload.Add('cookieproxying', $cookieproxying) }
            if ( $PSBoundParameters.ContainsKey('addcookieflags') ) { $payload.Add('addcookieflags', $addcookieflags) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyaction') ) { $payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('csrftagaction') ) { $payload.Add('csrftagaction', $csrftagaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingaction') ) { $payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml') ) { $payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls') ) { $payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionaction') ) { $payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectionaction') ) { $payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectiontype') ) { $payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars') ) { $payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontype') ) { $payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars') ) { $payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiongrammar') ) { $payload.Add('sqlinjectiongrammar', $sqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('fieldformataction') ) { $payload.Add('fieldformataction', $fieldformataction) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformattype') ) { $payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatminlength') ) { $payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatmaxlength') ) { $payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowaction') ) { $payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxurllength') ) { $payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength') ) { $payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength') ) { $payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength') ) { $payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength') ) { $payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ( $PSBoundParameters.ContainsKey('creditcardaction') ) { $payload.Add('creditcardaction', $creditcardaction) }
            if ( $PSBoundParameters.ContainsKey('creditcard') ) { $payload.Add('creditcard', $creditcard) }
            if ( $PSBoundParameters.ContainsKey('creditcardmaxallowed') ) { $payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ( $PSBoundParameters.ContainsKey('creditcardxout') ) { $payload.Add('creditcardxout', $creditcardxout) }
            if ( $PSBoundParameters.ContainsKey('dosecurecreditcardlogging') ) { $payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ( $PSBoundParameters.ContainsKey('streaming') ) { $payload.Add('streaming', $streaming) }
            if ( $PSBoundParameters.ContainsKey('trace') ) { $payload.Add('trace', $trace) }
            if ( $PSBoundParameters.ContainsKey('requestcontenttype') ) { $payload.Add('requestcontenttype', $requestcontenttype) }
            if ( $PSBoundParameters.ContainsKey('responsecontenttype') ) { $payload.Add('responsecontenttype', $responsecontenttype) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorobject') ) { $payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatuscode') ) { $payload.Add('jsonerrorstatuscode', $jsonerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatusmessage') ) { $payload.Add('jsonerrorstatusmessage', $jsonerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('jsondosaction') ) { $payload.Add('jsondosaction', $jsondosaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectionaction') ) { $payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiontype') ) { $payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiongrammar') ) { $payload.Add('jsonsqlinjectiongrammar', $jsonsqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectionaction') ) { $payload.Add('jsoncmdinjectionaction', $jsoncmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectiontype') ) { $payload.Add('jsoncmdinjectiontype', $jsoncmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonxssaction') ) { $payload.Add('jsonxssaction', $jsonxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmldosaction') ) { $payload.Add('xmldosaction', $xmldosaction) }
            if ( $PSBoundParameters.ContainsKey('xmlformataction') ) { $payload.Add('xmlformataction', $xmlformataction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionaction') ) { $payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiontype') ) { $payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars') ) { $payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments') ) { $payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('xmlxssaction') ) { $payload.Add('xmlxssaction', $xmlxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiaction') ) { $payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentaction') ) { $payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidationaction') ) { $payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorobject') ) { $payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatuscode') ) { $payload.Add('xmlerrorstatuscode', $xmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatusmessage') ) { $payload.Add('xmlerrorstatusmessage', $xmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('customsettings') ) { $payload.Add('customsettings', $customsettings) }
            if ( $PSBoundParameters.ContainsKey('signatures') ) { $payload.Add('signatures', $signatures) }
            if ( $PSBoundParameters.ContainsKey('xmlsoapfaultaction') ) { $payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ( $PSBoundParameters.ContainsKey('usehtmlerrorobject') ) { $payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorobject') ) { $payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatuscode') ) { $payload.Add('htmlerrorstatuscode', $htmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatusmessage') ) { $payload.Add('htmlerrorstatusmessage', $htmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('logeverypolicyhit') ) { $payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ( $PSBoundParameters.ContainsKey('stripcomments') ) { $payload.Add('stripcomments', $stripcomments) }
            if ( $PSBoundParameters.ContainsKey('striphtmlcomments') ) { $payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ( $PSBoundParameters.ContainsKey('stripxmlcomments') ) { $payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('dynamiclearning') ) { $payload.Add('dynamiclearning', $dynamiclearning) }
            if ( $PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks') ) { $payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ( $PSBoundParameters.ContainsKey('defaultcharset') ) { $payload.Add('defaultcharset', $defaultcharset) }
            if ( $PSBoundParameters.ContainsKey('postbodylimit') ) { $payload.Add('postbodylimit', $postbodylimit) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitaction') ) { $payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitsignature') ) { $payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ( $PSBoundParameters.ContainsKey('fileuploadmaxnum') ) { $payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ( $PSBoundParameters.ContainsKey('canonicalizehtmlresponse') ) { $payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ( $PSBoundParameters.ContainsKey('enableformtagging') ) { $payload.Add('enableformtagging', $enableformtagging) }
            if ( $PSBoundParameters.ContainsKey('sessionlessfieldconsistency') ) { $payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('sessionlessurlclosure') ) { $payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ( $PSBoundParameters.ContainsKey('semicolonfieldseparator') ) { $payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ( $PSBoundParameters.ContainsKey('excludefileuploadfromchecks') ) { $payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionparsecomments') ) { $payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('invalidpercenthandling') ) { $payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('checkrequestheaders') ) { $payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ( $PSBoundParameters.ContainsKey('inspectquerycontenttypes') ) { $payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ( $PSBoundParameters.ContainsKey('optimizepartialreqs') ) { $payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ( $PSBoundParameters.ContainsKey('urldecoderequestcookies') ) { $payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('percentdecoderecursively') ) { $payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ( $PSBoundParameters.ContainsKey('multipleheaderaction') ) { $payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ( $PSBoundParameters.ContainsKey('rfcprofile') ) { $payload.Add('rfcprofile', $rfcprofile) }
            if ( $PSBoundParameters.ContainsKey('fileuploadtypesaction') ) { $payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('insertcookiesamesiteattribute') ) { $payload.Add('insertcookiesamesiteattribute', $insertcookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('cookiesamesiteattribute') ) { $payload.Add('cookiesamesiteattribute', $cookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionruletype') ) { $payload.Add('sqlinjectionruletype', $sqlinjectionruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofile -Filter $payload)
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

function Invoke-ADCAddAppfwprofile {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER Defaults 
        Default configuration to apply to the profile. Basic defaults are intended for standard content that requires little further configuration, such as static web site content. Advanced defaults are intended for specialized content that requires significant specialized configuration, such as heavily scripted or dynamic content. 
        CLI users: When adding an application firewall profile, you can set either the defaults or the type, but not both. To set both options, create the profile by using the add appfw profile command, and then use the set appfw profile command to configure the other option. 
        Possible values = basic, advanced 
    .PARAMETER Starturlaction 
        One or more Start URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -startURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -startURLaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Infercontenttypexmlpayloadaction 
        One or more infer content type payload actions. Available settings function as follows: 
        * Block - Block connections that have mismatch in content-type header and payload. 
        * Log - Log connections that have mismatch in content-type header and payload. The mismatched content-type in HTTP request header will be logged for the request. 
        * Stats - Generate statistics when there is mismatch in content-type header and payload. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -inferContentTypeXMLPayloadAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -inferContentTypeXMLPayloadAction none". Please note "none" action cannot be used with any other action type. 
        Possible values = block, log, stats, none 
    .PARAMETER Contenttypeaction 
        One or more Content-type actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -contentTypeaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -contentTypeaction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Inspectcontenttypes 
        One or more InspectContentType lists. 
        * application/x-www-form-urlencoded 
        * multipart/form-data 
        * text/x-gwt-rpc 
        CLI users: To enable, type "set appfw profile -InspectContentTypes" followed by the content types to be inspected. 
        Possible values = none, application/x-www-form-urlencoded, multipart/form-data, text/x-gwt-rpc 
    .PARAMETER Starturlclosure 
        Toggle the state of Start URL Closure. 
        Possible values = ON, OFF 
    .PARAMETER Denyurlaction 
        One or more Deny URL actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: The Deny URL check takes precedence over the Start URL check. If you enable blocking for the Deny URL check, the application firewall blocks any URL that is explicitly blocked by a Deny URL, even if the same URL would otherwise be allowed by the Start URL check. 
        CLI users: To enable one or more actions, type "set appfw profile -denyURLaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -denyURLaction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Refererheadercheck 
        Enable validation of Referer headers. 
        Referer validation ensures that a web form that a user sends to your web site originally came from your web site, not an outside attacker. 
        Although this parameter is part of the Start URL check, referer validation protects against cross-site request forgery (CSRF) attacks, not Start URL attacks. 
        Possible values = OFF, if_present, AlwaysExceptStartURLs, AlwaysExceptFirstRequest 
    .PARAMETER Cookieconsistencyaction 
        One or more Cookie Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cookieConsistencyAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cookiehijackingaction 
        One or more actions to prevent cookie hijacking. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        NOTE: Cookie Hijacking feature is not supported for TLSv1.3 
        CLI users: To enable one or more actions, type "set appfw profile -cookieHijackingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cookieHijackingAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cookietransforms 
        Perform the specified type of cookie transformation. 
        Available settings function as follows: 
        * Encryption - Encrypt cookies. 
        * Proxying - Mask contents of server cookies by sending proxy cookie to users. 
        * Cookie flags - Flag cookies as HTTP only to prevent scripts on user's browser from accessing and possibly modifying them. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cookie transformations. If it is set to OFF, no cookie transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Cookieencryption 
        Type of cookie encryption. Available settings function as follows: 
        * None - Do not encrypt cookies. 
        * Decrypt Only - Decrypt encrypted cookies, but do not encrypt cookies. 
        * Encrypt Session Only - Encrypt session cookies, but not permanent cookies. 
        * Encrypt All - Encrypt all cookies. 
        Possible values = none, decryptOnly, encryptSessionOnly, encryptAll 
    .PARAMETER Cookieproxying 
        Cookie proxy setting. Available settings function as follows: 
        * None - Do not proxy cookies. 
        * Session Only - Proxy session cookies by using the Citrix ADC session ID, but do not proxy permanent cookies. 
        Possible values = none, sessionOnly 
    .PARAMETER Addcookieflags 
        Add the specified flags to cookies. Available settings function as follows: 
        * None - Do not add flags to cookies. 
        * HTTP Only - Add the HTTP Only flag to cookies, which prevents scripts from accessing cookies. 
        * Secure - Add Secure flag to cookies. 
        * All - Add both HTTPOnly and Secure flags to cookies. 
        Possible values = none, httpOnly, secure, all 
    .PARAMETER Fieldconsistencyaction 
        One or more Form Field Consistency actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldConsistencyaction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldConsistencyAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Csrftagaction 
        One or more Cross-Site Request Forgery (CSRF) Tagging actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -CSRFTagAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -CSRFTagAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingaction 
        One or more Cross-Site Scripting (XSS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -crossSiteScriptingAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -crossSiteScriptingAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Crosssitescriptingtransformunsafehtml 
        Transform cross-site scripts. This setting configures the application firewall to disable dangerous HTML instead of blocking the request. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any cross-site scripting transformations. If it is set to OFF, no cross-site scripting transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Crosssitescriptingcheckcompleteurls 
        Check complete URLs for cross-site scripts, instead of just the query portions of URLs. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionaction 
        One or more HTML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -SQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -SQLInjectionAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Cmdinjectionaction 
        Command injection action. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -cmdInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -cmdInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Cmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Sqlinjectiongrammar 
        Check for SQL injection using SQL grammar. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiontransformspecialchars 
        Transform injected SQL code. This setting configures the application firewall to disable SQL special strings instead of blocking the request. Since most SQL servers require a special string to activate an SQL keyword, in most cases a request that contains injected SQL code is safe if special strings are disabled. 
        CAUTION: Make sure that this parameter is set to ON if you are configuring any SQL injection transformations. If it is set to OFF, no SQL injection transformations are performed regardless of any other settings. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special strings (characters) for injected SQL code. 
        Most SQL servers require a special string to activate an SQL request, so SQL code without a special string is harmless to most SQL servers. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Sqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Fieldformataction 
        One or more Field Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of suggested web form fields and field format assignments. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fieldFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fieldFormatAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Defaultfieldformattype 
        Designate a default field type to be applied to web form fields that do not have a field type explicitly assigned to them. 
    .PARAMETER Defaultfieldformatminlength 
        Minimum length, in characters, for data entered into a field that is assigned the default field type. 
        To disable the minimum and maximum length settings and allow data of any length to be entered into the field, set this parameter to zero (0). 
    .PARAMETER Defaultfieldformatmaxlength 
        Maximum length, in characters, for data entered into a field that is assigned the default field type. 
    .PARAMETER Bufferoverflowaction 
        One or more Buffer Overflow actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -bufferOverflowAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -bufferOverflowAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Bufferoverflowmaxurllength 
        Maximum length, in characters, for URLs on your protected web sites. Requests with longer URLs are blocked. 
    .PARAMETER Bufferoverflowmaxheaderlength 
        Maximum length, in characters, for HTTP headers in requests sent to your protected web sites. Requests with longer headers are blocked. 
    .PARAMETER Bufferoverflowmaxcookielength 
        Maximum length, in characters, for cookies sent to your protected web sites. Requests with longer cookies are blocked. 
    .PARAMETER Bufferoverflowmaxquerylength 
        Maximum length, in bytes, for query string sent to your protected web sites. Requests with longer query strings are blocked. 
    .PARAMETER Bufferoverflowmaxtotalheaderlength 
        Maximum length, in bytes, for the total HTTP header length in requests sent to your protected web sites. The minimum value of this and maxHeaderLen in httpProfile will be used. Requests with longer length are blocked. 
    .PARAMETER Creditcardaction 
        One or more Credit Card actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -creditCardAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -creditCardAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Creditcard 
        Credit card types that the application firewall should protect. 
        Possible values = none, visa, mastercard, discover, amex, jcb, dinersclub 
    .PARAMETER Creditcardmaxallowed 
        This parameter value is used by the block action. It represents the maximum number of credit card numbers that can appear on a web page served by your protected web sites. Pages that contain more credit card numbers are blocked. 
    .PARAMETER Creditcardxout 
        Mask any credit card number detected in a response by replacing each digit, except the digits in the final group, with the letter "X.". 
        Possible values = ON, OFF 
    .PARAMETER Dosecurecreditcardlogging 
        Setting this option logs credit card numbers in the response when the match is found. 
        Possible values = ON, OFF 
    .PARAMETER Streaming 
        Setting this option converts content-length form submission requests (requests with content-type "application/x-www-form-urlencoded" or "multipart/form-data") to chunked requests when atleast one of the following protections : Signatures, SQL injection protection, XSS protection, form field consistency protection, starturl closure, CSRF tagging, JSON SQL, JSON XSS, JSON DOS is enabled. Please make sure that the backend server accepts chunked requests before enabling this option. Citrix recommends enabling this option for large request sizes(>20MB). 
        Possible values = ON, OFF 
    .PARAMETER Trace 
        Toggle the state of trace. 
        Possible values = ON, OFF 
    .PARAMETER Requestcontenttype 
        Default Content-Type header for requests. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Responsecontenttype 
        Default Content-Type header for responses. 
        A Content-Type header can contain 0-255 letters, numbers, and the hyphen (-) and underscore (_) characters. 
    .PARAMETER Jsonerrorobject 
        Name to the imported JSON Error Object to be set on application firewall profile. 
    .PARAMETER Jsonerrorstatuscode 
        Response status code associated with JSON error page. 
    .PARAMETER Jsonerrorstatusmessage 
        Response status message associated with JSON error page. 
    .PARAMETER Jsondosaction 
        One or more JSON Denial-of-Service (JsonDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONDoSAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectionaction 
        One or more JSON SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsonsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found, 
        -None : Disables checking using both SQL Special Char and Keyword. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Jsonsqlinjectiongrammar 
        Check for SQL injection using SQL grammar in JSON. 
        Possible values = ON, OFF 
    .PARAMETER Jsoncmdinjectionaction 
        One or more JSON CMD Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONCMDInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONCMDInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Jsoncmdinjectiontype 
        Available CMD injection types. 
        -CMDSplChar : Checks for CMD Special Chars 
        -CMDKeyword : Checks for CMD Keywords 
        -CMDSplCharANDKeyword : Checks for both and blocks if both are found 
        -CMDSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = CMDSplChar, CMDKeyword, CMDSplCharORKeyword, CMDSplCharANDKeyword 
    .PARAMETER Jsonxssaction 
        One or more JSON Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -JSONXssAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -JSONXssAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmldosaction 
        One or more XML Denial-of-Service (XDoS) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLDoSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLDoSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlformataction 
        One or more XML Format actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLFormatAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLFormatAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectionaction 
        One or more XML SQL Injection actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSQLInjectionAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSQLInjectionAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlsqlinjectiononlycheckfieldswithsqlchars 
        Check only form fields that contain SQL special characters, which most SQL servers require before accepting an SQL command, for injected SQL. 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectiontype 
        Available SQL injection types. 
        -SQLSplChar : Checks for SQL Special Chars 
        -SQLKeyword : Checks for SQL Keywords 
        -SQLSplCharANDKeyword : Checks for both and blocks if both are found 
        -SQLSplCharORKeyword : Checks for both and blocks if anyone is found. 
        Possible values = SQLSplChar, SQLKeyword, SQLSplCharORKeyword, SQLSplCharANDKeyword, None 
    .PARAMETER Xmlsqlinjectionchecksqlwildchars 
        Check for form fields that contain SQL wild chars . 
        Possible values = ON, OFF 
    .PARAMETER Xmlsqlinjectionparsecomments 
        Parse comments in XML Data and exempt those sections of the request that are from the XML SQL Injection check. You must configure the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Xmlxssaction 
        One or more XML Cross-Site Scripting actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLXSSAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLXSSAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlwsiaction 
        One or more Web Services Interoperability (WSI) actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLWSIAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLWSIAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlattachmentaction 
        One or more XML Attachment actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Learn - Use the learning engine to generate a list of exceptions to this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLAttachmentAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLAttachmentAction none". 
        Possible values = none, block, learn, log, stats 
    .PARAMETER Xmlvalidationaction 
        One or more XML Validation actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLValidationAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLValidationAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Xmlerrorobject 
        Name to assign to the XML Error Object, which the application firewall displays when a user request is blocked. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the XML error object is added. 
    .PARAMETER Xmlerrorstatuscode 
        Response status code associated with XML error page. 
    .PARAMETER Xmlerrorstatusmessage 
        Response status message associated with XML error page. 
    .PARAMETER Customsettings 
        Object name for custom settings. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Signatures 
        Object name for signatures. 
        This check is applicable to Profile Type: HTML, XML. . 
    .PARAMETER Xmlsoapfaultaction 
        One or more XML SOAP Fault Filtering actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        * Remove - Remove all violations for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -XMLSOAPFaultAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -XMLSOAPFaultAction none". 
        Possible values = none, block, log, remove, stats 
    .PARAMETER Usehtmlerrorobject 
        Send an imported HTML Error object to a user when a request is blocked, instead of redirecting the user to the designated Error URL. 
        Possible values = ON, OFF 
    .PARAMETER Errorurl 
        URL that application firewall uses as the Error URL. 
    .PARAMETER Htmlerrorobject 
        Name to assign to the HTML Error Object. 
        Must begin with a letter, number, or the underscore character \(_\), and must contain only letters, numbers, and the hyphen \(-\), period \(.\) pound \(\#\), space \( \), at (@), equals \(=\), colon \(:\), and underscore characters. Cannot be changed after the HTML error object is added. 
    .PARAMETER Htmlerrorstatuscode 
        Response status code associated with HTML error page. 
    .PARAMETER Htmlerrorstatusmessage 
        Response status message associated with HTML error page. 
    .PARAMETER Logeverypolicyhit 
        Log every profile match, regardless of security checks results. 
        Possible values = ON, OFF 
    .PARAMETER Stripcomments 
        Strip HTML comments. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Striphtmlcomments 
        Strip HTML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all, exclude_script_tag 
    .PARAMETER Stripxmlcomments 
        Strip XML comments before forwarding a web page sent by a protected web site in response to a user request. 
        Possible values = none, all 
    .PARAMETER Exemptclosureurlsfromsecuritychecks 
        Exempt URLs that pass the Start URL closure check from SQL injection, cross-site script, field format and field consistency security checks at locations other than headers. 
        Possible values = ON, OFF 
    .PARAMETER Defaultcharset 
        Default character set for protected web pages. Web pages sent by your protected web sites in response to user requests are assigned this character set if the page does not already specify a character set. The character sets supported by the application firewall are: 
        * iso-8859-1 (English US) 
        * big5 (Chinese Traditional) 
        * gb2312 (Chinese Simplified) 
        * sjis (Japanese Shift-JIS) 
        * euc-jp (Japanese EUC-JP) 
        * iso-8859-9 (Turkish) 
        * utf-8 (Unicode) 
        * euc-kr (Korean). 
    .PARAMETER Clientipexpression 
        Expression to get the client IP. 
    .PARAMETER Dynamiclearning 
        One or more security checks. Available options are as follows: 
        * SQLInjection - Enable dynamic learning for SQLInjection security check. 
        * CrossSiteScripting - Enable dynamic learning for CrossSiteScripting security check. 
        * fieldFormat - Enable dynamic learning for fieldFormat security check. 
        * None - Disable security checks for all security checks. 
        CLI users: To enable dynamic learning on one or more security checks, type "set appfw profile -dynamicLearning" followed by the security checks to be enabled. To turn off dynamic learning on all security checks, type "set appfw profile -dynamicLearning none". 
        Possible values = none, SQLInjection, CrossSiteScripting, fieldFormat, startURL, cookieConsistency, fieldConsistency, CSRFtag, ContentType 
    .PARAMETER Postbodylimit 
        Maximum allowed HTTP post body size, in bytes. Maximum supported value is 10GB. Citrix recommends enabling streaming option for large values of post body limit (>20MB). 
    .PARAMETER Postbodylimitaction 
        One or more Post Body Limit actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. Must always be set. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -PostBodyLimitAction block" followed by the other actions to be enabled. 
        Possible values = block, log, stats 
    .PARAMETER Postbodylimitsignature 
        Maximum allowed HTTP post body size for signature inspection for location HTTP_POST_BODY in the signatures, in bytes. Note that the changes in value could impact CPU and latency profile. 
    .PARAMETER Fileuploadmaxnum 
        Maximum allowed number of file uploads per form-submission request. The maximum setting (65535) allows an unlimited number of uploads. 
    .PARAMETER Canonicalizehtmlresponse 
        Perform HTML entity encoding for any special characters in responses sent by your protected web sites. 
        Possible values = ON, OFF 
    .PARAMETER Enableformtagging 
        Enable tagging of web form fields for use by the Form Field Consistency and CSRF Form Tagging checks. 
        Possible values = ON, OFF 
    .PARAMETER Sessionlessfieldconsistency 
        Perform sessionless Field Consistency Checks. 
        Possible values = OFF, ON, postOnly 
    .PARAMETER Sessionlessurlclosure 
        Enable session less URL Closure Checks. 
        This check is applicable to Profile Type: HTML. . 
        Possible values = ON, OFF 
    .PARAMETER Semicolonfieldseparator 
        Allow ';' as a form field separator in URL queries and POST form bodies. . 
        Possible values = ON, OFF 
    .PARAMETER Excludefileuploadfromchecks 
        Exclude uploaded files from Form checks. 
        Possible values = ON, OFF 
    .PARAMETER Sqlinjectionparsecomments 
        Parse HTML comments and exempt them from the HTML SQL Injection check. You must specify the type of comments that the application firewall is to detect and exempt from this security check. Available settings function as follows: 
        * Check all - Check all content. 
        * ANSI - Exempt content that is part of an ANSI (Mozilla-style) comment. 
        * Nested - Exempt content that is part of a nested (Microsoft-style) comment. 
        * ANSI Nested - Exempt content that is part of any type of comment. 
        Possible values = checkall, ansi, nested, ansinested 
    .PARAMETER Invalidpercenthandling 
        Configure the method that the application firewall uses to handle percent-encoded names and values. Available settings function as follows: 
        * apache_mode - Apache format. 
        * asp_mode - Microsoft ASP format. 
        * secure_mode - Secure format. 
        Possible values = apache_mode, asp_mode, secure_mode 
    .PARAMETER Type 
        Application firewall profile type, which controls which security checks and settings are applied to content that is filtered with the profile. Available settings function as follows: 
        * HTML - HTML-based web sites. 
        * XML - XML-based web sites and services. 
        * JSON - JSON-based web sites and services. 
        * HTML XML (Web 2.0) - Sites that contain both HTML and XML content, such as ATOM feeds, blogs, and RSS feeds. 
        * HTML JSON - Sites that contain both HTML and JSON content. 
        * XML JSON - Sites that contain both XML and JSON content. 
        * HTML XML JSON - Sites that contain HTML, XML and JSON content. 
        Possible values = HTML, XML, JSON 
    .PARAMETER Checkrequestheaders 
        Check request headers as well as web forms for injected SQL and cross-site scripts. 
        Possible values = ON, OFF 
    .PARAMETER Inspectquerycontenttypes 
        Inspect request query as well as web forms for injected SQL and cross-site scripts for following content types. 
        Possible values = HTML, XML, JSON, OTHER 
    .PARAMETER Optimizepartialreqs 
        Optimize handle of HTTP partial requests i.e. those with range headers. 
        Available settings are as follows: 
        * ON - Partial requests by the client result in partial requests to the backend server in most cases. 
        * OFF - Partial requests by the client are changed to full requests to the backend server. 
        Possible values = ON, OFF 
    .PARAMETER Urldecoderequestcookies 
        URL Decode request cookies before subjecting them to SQL and cross-site scripting checks. 
        Possible values = ON, OFF 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER Percentdecoderecursively 
        Configure whether the application firewall should use percentage recursive decoding. 
        Possible values = ON, OFF 
    .PARAMETER Multipleheaderaction 
        One or more multiple header actions. Available settings function as follows: 
        * Block - Block connections that have multiple headers. 
        * Log - Log connections that have multiple headers. 
        * KeepLast - Keep only last header when multiple headers are present. 
        CLI users: To enable one or more actions, type "set appfw profile -multipleHeaderAction" followed by the actions to be enabled. 
        Possible values = block, keepLast, log, none 
    .PARAMETER Rfcprofile 
        Object name of the rfc profile. 
    .PARAMETER Fileuploadtypesaction 
        One or more file upload types actions. Available settings function as follows: 
        * Block - Block connections that violate this security check. 
        * Log - Log violations of this security check. 
        * Stats - Generate statistics for this security check. 
        * None - Disable all actions for this security check. 
        CLI users: To enable one or more actions, type "set appfw profile -fileUploadTypeAction" followed by the actions to be enabled. To turn off all actions, type "set appfw profile -fileUploadTypeAction none". 
        Possible values = none, block, log, stats 
    .PARAMETER Verboseloglevel 
        Detailed Logging Verbose Log Level. 
        Possible values = pattern, patternPayload, patternPayloadHeader 
    .PARAMETER Insertcookiesamesiteattribute 
        Configure whether application firewall should add samesite attribute for set-cookies. 
        Possible values = ON, OFF 
    .PARAMETER Cookiesamesiteattribute 
        Cookie Samesite attribute added to support adding cookie SameSite attribute for all set-cookies including appfw session cookies. Default value will be "SameSite=Lax". 
        Possible values = None, LAX, STRICT 
    .PARAMETER Sqlinjectionruletype 
        Specifies SQL Injection rule type: ALLOW/DENY. If ALLOW rule type is configured then allow list rules are used, if DENY rule type is configured then deny rules are used. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofile -name <string>
        An example how to add appfwprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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

        [ValidateSet('basic', 'advanced')]
        [string]$Defaults,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Starturlaction,

        [ValidateSet('block', 'log', 'stats', 'none')]
        [string[]]$Infercontenttypexmlpayloadaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Contenttypeaction,

        [ValidateSet('none', 'application/x-www-form-urlencoded', 'multipart/form-data', 'text/x-gwt-rpc')]
        [string[]]$Inspectcontenttypes,

        [ValidateSet('ON', 'OFF')]
        [string]$Starturlclosure = 'OFF',

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Denyurlaction,

        [ValidateSet('OFF', 'if_present', 'AlwaysExceptStartURLs', 'AlwaysExceptFirstRequest')]
        [string]$Refererheadercheck = 'OFF',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Cookieconsistencyaction = 'none',

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Cookiehijackingaction = 'none',

        [ValidateSet('ON', 'OFF')]
        [string]$Cookietransforms = 'OFF',

        [ValidateSet('none', 'decryptOnly', 'encryptSessionOnly', 'encryptAll')]
        [string]$Cookieencryption = 'none',

        [ValidateSet('none', 'sessionOnly')]
        [string]$Cookieproxying = 'none',

        [ValidateSet('none', 'httpOnly', 'secure', 'all')]
        [string]$Addcookieflags = 'none',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Fieldconsistencyaction = 'none',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Csrftagaction = 'none',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Crosssitescriptingaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Crosssitescriptingtransformunsafehtml = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Crosssitescriptingcheckcompleteurls = 'OFF',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Sqlinjectionaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Cmdinjectionaction = 'none',

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$Cmdinjectiontype = 'CMDSplCharANDKeyword',

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiongrammar = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiontransformspecialchars = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectiononlycheckfieldswithsqlchars = 'ON',

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Sqlinjectiontype = 'SQLSplCharANDKeyword',

        [ValidateSet('ON', 'OFF')]
        [string]$Sqlinjectionchecksqlwildchars = 'OFF',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Fieldformataction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Defaultfieldformattype,

        [ValidateRange(0, 2147483647)]
        [double]$Defaultfieldformatminlength = '0',

        [ValidateRange(1, 2147483647)]
        [double]$Defaultfieldformatmaxlength = '65535',

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Bufferoverflowaction,

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxurllength = '1024',

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxheaderlength = '4096',

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxcookielength = '4096',

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxquerylength = '65535',

        [ValidateRange(0, 65535)]
        [double]$Bufferoverflowmaxtotalheaderlength = '65535',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Creditcardaction = 'none',

        [ValidateSet('none', 'visa', 'mastercard', 'discover', 'amex', 'jcb', 'dinersclub')]
        [string[]]$Creditcard = 'none',

        [ValidateRange(0, 255)]
        [double]$Creditcardmaxallowed,

        [ValidateSet('ON', 'OFF')]
        [string]$Creditcardxout = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Dosecurecreditcardlogging = 'ON',

        [ValidateSet('ON', 'OFF')]
        [string]$Streaming = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Trace = 'OFF',

        [ValidateLength(1, 255)]
        [string]$Requestcontenttype,

        [ValidateLength(1, 255)]
        [string]$Responsecontenttype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Jsonerrorobject,

        [ValidateRange(1, 999)]
        [double]$Jsonerrorstatuscode = '200',

        [string]$Jsonerrorstatusmessage,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsondosaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsonsqlinjectionaction,

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Jsonsqlinjectiontype = 'SQLSplCharANDKeyword',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonsqlinjectiongrammar = 'OFF',

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsoncmdinjectionaction,

        [ValidateSet('CMDSplChar', 'CMDKeyword', 'CMDSplCharORKeyword', 'CMDSplCharANDKeyword')]
        [string]$Jsoncmdinjectiontype = 'CMDSplCharANDKeyword',

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Jsonxssaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmldosaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlformataction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlsqlinjectionaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlsqlinjectiononlycheckfieldswithsqlchars = 'ON',

        [ValidateSet('SQLSplChar', 'SQLKeyword', 'SQLSplCharORKeyword', 'SQLSplCharANDKeyword', 'None')]
        [string]$Xmlsqlinjectiontype = 'SQLSplCharANDKeyword',

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlsqlinjectionchecksqlwildchars = 'OFF',

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$Xmlsqlinjectionparsecomments = 'checkall',

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlxssaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlwsiaction,

        [ValidateSet('none', 'block', 'learn', 'log', 'stats')]
        [string[]]$Xmlattachmentaction,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Xmlvalidationaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Xmlerrorobject,

        [ValidateRange(1, 999)]
        [double]$Xmlerrorstatuscode = '200',

        [string]$Xmlerrorstatusmessage,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Customsettings,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Signatures,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats')]
        [string[]]$Xmlsoapfaultaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Usehtmlerrorobject = 'OFF',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Errorurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Htmlerrorobject,

        [ValidateRange(1, 999)]
        [double]$Htmlerrorstatuscode = '200',

        [string]$Htmlerrorstatusmessage,

        [ValidateSet('ON', 'OFF')]
        [string]$Logeverypolicyhit = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Stripcomments = 'OFF',

        [ValidateSet('none', 'all', 'exclude_script_tag')]
        [string]$Striphtmlcomments = 'none',

        [ValidateSet('none', 'all')]
        [string]$Stripxmlcomments = 'none',

        [ValidateSet('ON', 'OFF')]
        [string]$Exemptclosureurlsfromsecuritychecks = 'ON',

        [ValidateLength(1, 31)]
        [string]$Defaultcharset,

        [string]$Clientipexpression,

        [ValidateSet('none', 'SQLInjection', 'CrossSiteScripting', 'fieldFormat', 'startURL', 'cookieConsistency', 'fieldConsistency', 'CSRFtag', 'ContentType')]
        [string[]]$Dynamiclearning,

        [double]$Postbodylimit = '20000000',

        [ValidateSet('block', 'log', 'stats')]
        [string[]]$Postbodylimitaction,

        [double]$Postbodylimitsignature = '2048',

        [ValidateRange(0, 65535)]
        [double]$Fileuploadmaxnum = '65535',

        [ValidateSet('ON', 'OFF')]
        [string]$Canonicalizehtmlresponse = 'ON',

        [ValidateSet('ON', 'OFF')]
        [string]$Enableformtagging = 'ON',

        [ValidateSet('OFF', 'ON', 'postOnly')]
        [string]$Sessionlessfieldconsistency = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Sessionlessurlclosure = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Semicolonfieldseparator = 'OFF',

        [ValidateSet('ON', 'OFF')]
        [string]$Excludefileuploadfromchecks = 'OFF',

        [ValidateSet('checkall', 'ansi', 'nested', 'ansinested')]
        [string]$Sqlinjectionparsecomments,

        [ValidateSet('apache_mode', 'asp_mode', 'secure_mode')]
        [string]$Invalidpercenthandling = 'secure_mode',

        [ValidateSet('HTML', 'XML', 'JSON')]
        [string[]]$Type = 'HTML',

        [ValidateSet('ON', 'OFF')]
        [string]$Checkrequestheaders = 'OFF',

        [ValidateSet('HTML', 'XML', 'JSON', 'OTHER')]
        [string[]]$Inspectquerycontenttypes,

        [ValidateSet('ON', 'OFF')]
        [string]$Optimizepartialreqs = 'ON',

        [ValidateSet('ON', 'OFF')]
        [string]$Urldecoderequestcookies = 'OFF',

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$Percentdecoderecursively = 'ON',

        [ValidateSet('block', 'keepLast', 'log', 'none')]
        [string[]]$Multipleheaderaction,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Rfcprofile,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Fileuploadtypesaction,

        [ValidateSet('pattern', 'patternPayload', 'patternPayloadHeader')]
        [string]$Verboseloglevel = 'pattern',

        [ValidateSet('ON', 'OFF')]
        [string]$Insertcookiesamesiteattribute = 'OFF',

        [ValidateSet('None', 'LAX', 'STRICT')]
        [string]$Cookiesamesiteattribute = 'LAX',

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Sqlinjectionruletype = 'ALLOW',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('defaults') ) { $payload.Add('defaults', $defaults) }
            if ( $PSBoundParameters.ContainsKey('starturlaction') ) { $payload.Add('starturlaction', $starturlaction) }
            if ( $PSBoundParameters.ContainsKey('infercontenttypexmlpayloadaction') ) { $payload.Add('infercontenttypexmlpayloadaction', $infercontenttypexmlpayloadaction) }
            if ( $PSBoundParameters.ContainsKey('contenttypeaction') ) { $payload.Add('contenttypeaction', $contenttypeaction) }
            if ( $PSBoundParameters.ContainsKey('inspectcontenttypes') ) { $payload.Add('inspectcontenttypes', $inspectcontenttypes) }
            if ( $PSBoundParameters.ContainsKey('starturlclosure') ) { $payload.Add('starturlclosure', $starturlclosure) }
            if ( $PSBoundParameters.ContainsKey('denyurlaction') ) { $payload.Add('denyurlaction', $denyurlaction) }
            if ( $PSBoundParameters.ContainsKey('refererheadercheck') ) { $payload.Add('refererheadercheck', $refererheadercheck) }
            if ( $PSBoundParameters.ContainsKey('cookieconsistencyaction') ) { $payload.Add('cookieconsistencyaction', $cookieconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('cookiehijackingaction') ) { $payload.Add('cookiehijackingaction', $cookiehijackingaction) }
            if ( $PSBoundParameters.ContainsKey('cookietransforms') ) { $payload.Add('cookietransforms', $cookietransforms) }
            if ( $PSBoundParameters.ContainsKey('cookieencryption') ) { $payload.Add('cookieencryption', $cookieencryption) }
            if ( $PSBoundParameters.ContainsKey('cookieproxying') ) { $payload.Add('cookieproxying', $cookieproxying) }
            if ( $PSBoundParameters.ContainsKey('addcookieflags') ) { $payload.Add('addcookieflags', $addcookieflags) }
            if ( $PSBoundParameters.ContainsKey('fieldconsistencyaction') ) { $payload.Add('fieldconsistencyaction', $fieldconsistencyaction) }
            if ( $PSBoundParameters.ContainsKey('csrftagaction') ) { $payload.Add('csrftagaction', $csrftagaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingaction') ) { $payload.Add('crosssitescriptingaction', $crosssitescriptingaction) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingtransformunsafehtml') ) { $payload.Add('crosssitescriptingtransformunsafehtml', $crosssitescriptingtransformunsafehtml) }
            if ( $PSBoundParameters.ContainsKey('crosssitescriptingcheckcompleteurls') ) { $payload.Add('crosssitescriptingcheckcompleteurls', $crosssitescriptingcheckcompleteurls) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionaction') ) { $payload.Add('sqlinjectionaction', $sqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectionaction') ) { $payload.Add('cmdinjectionaction', $cmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('cmdinjectiontype') ) { $payload.Add('cmdinjectiontype', $cmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiongrammar') ) { $payload.Add('sqlinjectiongrammar', $sqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontransformspecialchars') ) { $payload.Add('sqlinjectiontransformspecialchars', $sqlinjectiontransformspecialchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('sqlinjectiononlycheckfieldswithsqlchars', $sqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectiontype') ) { $payload.Add('sqlinjectiontype', $sqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionchecksqlwildchars') ) { $payload.Add('sqlinjectionchecksqlwildchars', $sqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('fieldformataction') ) { $payload.Add('fieldformataction', $fieldformataction) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformattype') ) { $payload.Add('defaultfieldformattype', $defaultfieldformattype) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatminlength') ) { $payload.Add('defaultfieldformatminlength', $defaultfieldformatminlength) }
            if ( $PSBoundParameters.ContainsKey('defaultfieldformatmaxlength') ) { $payload.Add('defaultfieldformatmaxlength', $defaultfieldformatmaxlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowaction') ) { $payload.Add('bufferoverflowaction', $bufferoverflowaction) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxurllength') ) { $payload.Add('bufferoverflowmaxurllength', $bufferoverflowmaxurllength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxheaderlength') ) { $payload.Add('bufferoverflowmaxheaderlength', $bufferoverflowmaxheaderlength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxcookielength') ) { $payload.Add('bufferoverflowmaxcookielength', $bufferoverflowmaxcookielength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxquerylength') ) { $payload.Add('bufferoverflowmaxquerylength', $bufferoverflowmaxquerylength) }
            if ( $PSBoundParameters.ContainsKey('bufferoverflowmaxtotalheaderlength') ) { $payload.Add('bufferoverflowmaxtotalheaderlength', $bufferoverflowmaxtotalheaderlength) }
            if ( $PSBoundParameters.ContainsKey('creditcardaction') ) { $payload.Add('creditcardaction', $creditcardaction) }
            if ( $PSBoundParameters.ContainsKey('creditcard') ) { $payload.Add('creditcard', $creditcard) }
            if ( $PSBoundParameters.ContainsKey('creditcardmaxallowed') ) { $payload.Add('creditcardmaxallowed', $creditcardmaxallowed) }
            if ( $PSBoundParameters.ContainsKey('creditcardxout') ) { $payload.Add('creditcardxout', $creditcardxout) }
            if ( $PSBoundParameters.ContainsKey('dosecurecreditcardlogging') ) { $payload.Add('dosecurecreditcardlogging', $dosecurecreditcardlogging) }
            if ( $PSBoundParameters.ContainsKey('streaming') ) { $payload.Add('streaming', $streaming) }
            if ( $PSBoundParameters.ContainsKey('trace') ) { $payload.Add('trace', $trace) }
            if ( $PSBoundParameters.ContainsKey('requestcontenttype') ) { $payload.Add('requestcontenttype', $requestcontenttype) }
            if ( $PSBoundParameters.ContainsKey('responsecontenttype') ) { $payload.Add('responsecontenttype', $responsecontenttype) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorobject') ) { $payload.Add('jsonerrorobject', $jsonerrorobject) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatuscode') ) { $payload.Add('jsonerrorstatuscode', $jsonerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('jsonerrorstatusmessage') ) { $payload.Add('jsonerrorstatusmessage', $jsonerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('jsondosaction') ) { $payload.Add('jsondosaction', $jsondosaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectionaction') ) { $payload.Add('jsonsqlinjectionaction', $jsonsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiontype') ) { $payload.Add('jsonsqlinjectiontype', $jsonsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlinjectiongrammar') ) { $payload.Add('jsonsqlinjectiongrammar', $jsonsqlinjectiongrammar) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectionaction') ) { $payload.Add('jsoncmdinjectionaction', $jsoncmdinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('jsoncmdinjectiontype') ) { $payload.Add('jsoncmdinjectiontype', $jsoncmdinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('jsonxssaction') ) { $payload.Add('jsonxssaction', $jsonxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmldosaction') ) { $payload.Add('xmldosaction', $xmldosaction) }
            if ( $PSBoundParameters.ContainsKey('xmlformataction') ) { $payload.Add('xmlformataction', $xmlformataction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionaction') ) { $payload.Add('xmlsqlinjectionaction', $xmlsqlinjectionaction) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiononlycheckfieldswithsqlchars') ) { $payload.Add('xmlsqlinjectiononlycheckfieldswithsqlchars', $xmlsqlinjectiononlycheckfieldswithsqlchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectiontype') ) { $payload.Add('xmlsqlinjectiontype', $xmlsqlinjectiontype) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionchecksqlwildchars') ) { $payload.Add('xmlsqlinjectionchecksqlwildchars', $xmlsqlinjectionchecksqlwildchars) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjectionparsecomments') ) { $payload.Add('xmlsqlinjectionparsecomments', $xmlsqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('xmlxssaction') ) { $payload.Add('xmlxssaction', $xmlxssaction) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiaction') ) { $payload.Add('xmlwsiaction', $xmlwsiaction) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentaction') ) { $payload.Add('xmlattachmentaction', $xmlattachmentaction) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidationaction') ) { $payload.Add('xmlvalidationaction', $xmlvalidationaction) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorobject') ) { $payload.Add('xmlerrorobject', $xmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatuscode') ) { $payload.Add('xmlerrorstatuscode', $xmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('xmlerrorstatusmessage') ) { $payload.Add('xmlerrorstatusmessage', $xmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('customsettings') ) { $payload.Add('customsettings', $customsettings) }
            if ( $PSBoundParameters.ContainsKey('signatures') ) { $payload.Add('signatures', $signatures) }
            if ( $PSBoundParameters.ContainsKey('xmlsoapfaultaction') ) { $payload.Add('xmlsoapfaultaction', $xmlsoapfaultaction) }
            if ( $PSBoundParameters.ContainsKey('usehtmlerrorobject') ) { $payload.Add('usehtmlerrorobject', $usehtmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('errorurl') ) { $payload.Add('errorurl', $errorurl) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorobject') ) { $payload.Add('htmlerrorobject', $htmlerrorobject) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatuscode') ) { $payload.Add('htmlerrorstatuscode', $htmlerrorstatuscode) }
            if ( $PSBoundParameters.ContainsKey('htmlerrorstatusmessage') ) { $payload.Add('htmlerrorstatusmessage', $htmlerrorstatusmessage) }
            if ( $PSBoundParameters.ContainsKey('logeverypolicyhit') ) { $payload.Add('logeverypolicyhit', $logeverypolicyhit) }
            if ( $PSBoundParameters.ContainsKey('stripcomments') ) { $payload.Add('stripcomments', $stripcomments) }
            if ( $PSBoundParameters.ContainsKey('striphtmlcomments') ) { $payload.Add('striphtmlcomments', $striphtmlcomments) }
            if ( $PSBoundParameters.ContainsKey('stripxmlcomments') ) { $payload.Add('stripxmlcomments', $stripxmlcomments) }
            if ( $PSBoundParameters.ContainsKey('exemptclosureurlsfromsecuritychecks') ) { $payload.Add('exemptclosureurlsfromsecuritychecks', $exemptclosureurlsfromsecuritychecks) }
            if ( $PSBoundParameters.ContainsKey('defaultcharset') ) { $payload.Add('defaultcharset', $defaultcharset) }
            if ( $PSBoundParameters.ContainsKey('clientipexpression') ) { $payload.Add('clientipexpression', $clientipexpression) }
            if ( $PSBoundParameters.ContainsKey('dynamiclearning') ) { $payload.Add('dynamiclearning', $dynamiclearning) }
            if ( $PSBoundParameters.ContainsKey('postbodylimit') ) { $payload.Add('postbodylimit', $postbodylimit) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitaction') ) { $payload.Add('postbodylimitaction', $postbodylimitaction) }
            if ( $PSBoundParameters.ContainsKey('postbodylimitsignature') ) { $payload.Add('postbodylimitsignature', $postbodylimitsignature) }
            if ( $PSBoundParameters.ContainsKey('fileuploadmaxnum') ) { $payload.Add('fileuploadmaxnum', $fileuploadmaxnum) }
            if ( $PSBoundParameters.ContainsKey('canonicalizehtmlresponse') ) { $payload.Add('canonicalizehtmlresponse', $canonicalizehtmlresponse) }
            if ( $PSBoundParameters.ContainsKey('enableformtagging') ) { $payload.Add('enableformtagging', $enableformtagging) }
            if ( $PSBoundParameters.ContainsKey('sessionlessfieldconsistency') ) { $payload.Add('sessionlessfieldconsistency', $sessionlessfieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('sessionlessurlclosure') ) { $payload.Add('sessionlessurlclosure', $sessionlessurlclosure) }
            if ( $PSBoundParameters.ContainsKey('semicolonfieldseparator') ) { $payload.Add('semicolonfieldseparator', $semicolonfieldseparator) }
            if ( $PSBoundParameters.ContainsKey('excludefileuploadfromchecks') ) { $payload.Add('excludefileuploadfromchecks', $excludefileuploadfromchecks) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionparsecomments') ) { $payload.Add('sqlinjectionparsecomments', $sqlinjectionparsecomments) }
            if ( $PSBoundParameters.ContainsKey('invalidpercenthandling') ) { $payload.Add('invalidpercenthandling', $invalidpercenthandling) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('checkrequestheaders') ) { $payload.Add('checkrequestheaders', $checkrequestheaders) }
            if ( $PSBoundParameters.ContainsKey('inspectquerycontenttypes') ) { $payload.Add('inspectquerycontenttypes', $inspectquerycontenttypes) }
            if ( $PSBoundParameters.ContainsKey('optimizepartialreqs') ) { $payload.Add('optimizepartialreqs', $optimizepartialreqs) }
            if ( $PSBoundParameters.ContainsKey('urldecoderequestcookies') ) { $payload.Add('urldecoderequestcookies', $urldecoderequestcookies) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('percentdecoderecursively') ) { $payload.Add('percentdecoderecursively', $percentdecoderecursively) }
            if ( $PSBoundParameters.ContainsKey('multipleheaderaction') ) { $payload.Add('multipleheaderaction', $multipleheaderaction) }
            if ( $PSBoundParameters.ContainsKey('rfcprofile') ) { $payload.Add('rfcprofile', $rfcprofile) }
            if ( $PSBoundParameters.ContainsKey('fileuploadtypesaction') ) { $payload.Add('fileuploadtypesaction', $fileuploadtypesaction) }
            if ( $PSBoundParameters.ContainsKey('verboseloglevel') ) { $payload.Add('verboseloglevel', $verboseloglevel) }
            if ( $PSBoundParameters.ContainsKey('insertcookiesamesiteattribute') ) { $payload.Add('insertcookiesamesiteattribute', $insertcookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('cookiesamesiteattribute') ) { $payload.Add('cookiesamesiteattribute', $cookiesamesiteattribute) }
            if ( $PSBoundParameters.ContainsKey('sqlinjectionruletype') ) { $payload.Add('sqlinjectionruletype', $sqlinjectionruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofile -Filter $payload)
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

function Invoke-ADCGetAppfwprofile {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for application firewall profile resource.
    .PARAMETER Name 
        Name for the profile. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.), pound (#), space ( ), at (@), equals (=), colon (:), and underscore (_) characters. Cannot be changed after the profile is added. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofile -GetAll 
        Get all appfwprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofile -Count 
        Get the number of appfwprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofile -name <string>
        Get appfwprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofile -Filter @{ 'name'='<value>' }
        Get appfwprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile/
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
        Write-Verbose "Invoke-ADCGetAppfwprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to appfwprofile.
    .PARAMETER Name 
        Name of the application firewall profile. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilebinding -GetAll 
        Get all appfwprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilebinding -name <string>
        Get appfwprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilebinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the cmdinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Cmdinjection 
        Name of the relaxed web form field/header/cookie. 
    .PARAMETER Formactionurl_cmd 
        The web form action URL. 
    .PARAMETER Isregex_cmd 
        Is the relaxed web form field name/header/cookie a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER As_scan_location_cmd 
        Location of command injection exception - form field, header or cookie. 
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER As_value_type_cmd 
        Type of the relaxed web form value. 
        Possible values = Keyword, SpecialString 
    .PARAMETER As_value_expr_cmd 
        The web form/header/cookie value expression. 
    .PARAMETER Isvalueregex_cmd 
        Is the web form field/header/cookie value a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_cmdinjection_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecmdinjectionbinding -name <string>
        An example how to add appfwprofile_cmdinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecmdinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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

        [string]$Cmdinjection,

        [string]$Formactionurl_cmd,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_cmd,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE')]
        [string]$As_scan_location_cmd,

        [ValidateSet('Keyword', 'SpecialString')]
        [string]$As_value_type_cmd,

        [string]$As_value_expr_cmd,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isvalueregex_cmd,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecmdinjectionbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('cmdinjection') ) { $payload.Add('cmdinjection', $cmdinjection) }
            if ( $PSBoundParameters.ContainsKey('formactionurl_cmd') ) { $payload.Add('formactionurl_cmd', $formactionurl_cmd) }
            if ( $PSBoundParameters.ContainsKey('isregex_cmd') ) { $payload.Add('isregex_cmd', $isregex_cmd) }
            if ( $PSBoundParameters.ContainsKey('as_scan_location_cmd') ) { $payload.Add('as_scan_location_cmd', $as_scan_location_cmd) }
            if ( $PSBoundParameters.ContainsKey('as_value_type_cmd') ) { $payload.Add('as_value_type_cmd', $as_value_type_cmd) }
            if ( $PSBoundParameters.ContainsKey('as_value_expr_cmd') ) { $payload.Add('as_value_expr_cmd', $as_value_expr_cmd) }
            if ( $PSBoundParameters.ContainsKey('isvalueregex_cmd') ) { $payload.Add('isvalueregex_cmd', $isvalueregex_cmd) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_cmdinjection_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_cmdinjection_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecmdinjectionbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the cmdinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Cmdinjection 
        Name of the relaxed web form field/header/cookie. 
    .PARAMETER Formactionurl_cmd 
        The web form action URL. 
    .PARAMETER As_scan_location_cmd 
        Location of command injection exception - form field, header or cookie. 
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER As_value_type_cmd 
        Type of the relaxed web form value. 
        Possible values = Keyword, SpecialString 
    .PARAMETER As_value_expr_cmd 
        The web form/header/cookie value expression. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecmdinjectionbinding -Name <string>
        An example how to delete appfwprofile_cmdinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecmdinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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

        [string]$Cmdinjection,

        [string]$Formactionurl_cmd,

        [string]$As_scan_location_cmd,

        [string]$As_value_type_cmd,

        [string]$As_value_expr_cmd,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecmdinjectionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Cmdinjection') ) { $arguments.Add('cmdinjection', $Cmdinjection) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_cmd') ) { $arguments.Add('formactionurl_cmd', $Formactionurl_cmd) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_cmd') ) { $arguments.Add('as_scan_location_cmd', $As_scan_location_cmd) }
            if ( $PSBoundParameters.ContainsKey('As_value_type_cmd') ) { $arguments.Add('as_value_type_cmd', $As_value_type_cmd) }
            if ( $PSBoundParameters.ContainsKey('As_value_expr_cmd') ) { $arguments.Add('as_value_expr_cmd', $As_value_expr_cmd) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the cmdinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_cmdinjection_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_cmdinjection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecmdinjectionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecmdinjectionbinding -GetAll 
        Get all appfwprofile_cmdinjection_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecmdinjectionbinding -Count 
        Get the number of appfwprofile_cmdinjection_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecmdinjectionbinding -name <string>
        Get appfwprofile_cmdinjection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecmdinjectionbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_cmdinjection_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecmdinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cmdinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecmdinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_cmdinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_cmdinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_cmdinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cmdinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the contenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Contenttype 
        A regular expression that designates a content-type on the content-types list. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_contenttype_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecontenttypebinding -name <string>
        An example how to add appfwprofile_contenttype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Contenttype,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecontenttypebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('contenttype') ) { $payload.Add('contenttype', $contenttype) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_contenttype_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_contenttype_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecontenttypebinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the contenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Contenttype 
        A regular expression that designates a content-type on the content-types list. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecontenttypebinding -Name <string>
        An example how to delete appfwprofile_contenttype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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

        [string]$Contenttype,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecontenttypebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Contenttype') ) { $arguments.Add('contenttype', $Contenttype) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the contenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_contenttype_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_contenttype_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecontenttypebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecontenttypebinding -GetAll 
        Get all appfwprofile_contenttype_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecontenttypebinding -Count 
        Get the number of appfwprofile_contenttype_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecontenttypebinding -name <string>
        Get appfwprofile_contenttype_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecontenttypebinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_contenttype_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_contenttype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecontenttypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_contenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_contenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_contenttype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_contenttype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the cookieconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Cookieconsistency 
        The name of the cookie to be checked. 
    .PARAMETER Isregex 
        Is the cookie name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_cookieconsistency_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecookieconsistencybinding -name <string>
        An example how to add appfwprofile_cookieconsistency_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecookieconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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

        [string]$Cookieconsistency,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecookieconsistencybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('cookieconsistency') ) { $payload.Add('cookieconsistency', $cookieconsistency) }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_cookieconsistency_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_cookieconsistency_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecookieconsistencybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the cookieconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Cookieconsistency 
        The name of the cookie to be checked. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecookieconsistencybinding -Name <string>
        An example how to delete appfwprofile_cookieconsistency_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecookieconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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

        [string]$Cookieconsistency,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecookieconsistencybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Cookieconsistency') ) { $arguments.Add('cookieconsistency', $Cookieconsistency) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the cookieconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_cookieconsistency_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_cookieconsistency_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecookieconsistencybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecookieconsistencybinding -GetAll 
        Get all appfwprofile_cookieconsistency_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecookieconsistencybinding -Count 
        Get the number of appfwprofile_cookieconsistency_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecookieconsistencybinding -name <string>
        Get appfwprofile_cookieconsistency_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecookieconsistencybinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_cookieconsistency_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecookieconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_cookieconsistency_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecookieconsistencybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_cookieconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_cookieconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_cookieconsistency_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_cookieconsistency_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the creditcardnumber that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Creditcardnumber 
        The object expression that is to be excluded from safe commerce check. 
    .PARAMETER Creditcardnumberurl 
        The url for which the list of credit card numbers are needed to be bypassed from inspection. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_creditcardnumber_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecreditcardnumberbinding -name <string>
        An example how to add appfwprofile_creditcardnumber_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecreditcardnumberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Creditcardnumber,

        [string]$Creditcardnumberurl,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecreditcardnumberbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumber') ) { $payload.Add('creditcardnumber', $creditcardnumber) }
            if ( $PSBoundParameters.ContainsKey('creditcardnumberurl') ) { $payload.Add('creditcardnumberurl', $creditcardnumberurl) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_creditcardnumber_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_creditcardnumber_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the creditcardnumber that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Creditcardnumber 
        The object expression that is to be excluded from safe commerce check. 
    .PARAMETER Creditcardnumberurl 
        The url for which the list of credit card numbers are needed to be bypassed from inspection. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding -Name <string>
        An example how to delete appfwprofile_creditcardnumber_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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

        [string]$Creditcardnumber,

        [string]$Creditcardnumberurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecreditcardnumberbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Creditcardnumber') ) { $arguments.Add('creditcardnumber', $Creditcardnumber) }
            if ( $PSBoundParameters.ContainsKey('Creditcardnumberurl') ) { $arguments.Add('creditcardnumberurl', $Creditcardnumberurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the creditcardnumber that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_creditcardnumber_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_creditcardnumber_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecreditcardnumberbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecreditcardnumberbinding -GetAll 
        Get all appfwprofile_creditcardnumber_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Count 
        Get the number of appfwprofile_creditcardnumber_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecreditcardnumberbinding -name <string>
        Get appfwprofile_creditcardnumber_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecreditcardnumberbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_creditcardnumber_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecreditcardnumberbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_creditcardnumber_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecreditcardnumberbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_creditcardnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_creditcardnumber_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_creditcardnumber_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_creditcardnumber_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the crosssitescripting that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Crosssitescripting 
        The web form field name. 
    .PARAMETER Formactionurl_xss 
        The web form action URL. 
    .PARAMETER Isregex_xss 
        Is the web form field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER As_scan_location_xss 
        Location of cross-site scripting exception - form field, header, cookie or URL. 
        Possible values = FORMFIELD, HEADER, COOKIE, URL 
    .PARAMETER As_value_type_xss 
        The web form value type. 
        Possible values = Tag, Attribute, Pattern 
    .PARAMETER As_value_expr_xss 
        The web form value expression. 
    .PARAMETER Isvalueregex_xss 
        Is the web form field value a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_crosssitescripting_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecrosssitescriptingbinding -name <string>
        An example how to add appfwprofile_crosssitescripting_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecrosssitescriptingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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

        [string]$Crosssitescripting,

        [string]$Formactionurl_xss,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_xss,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE', 'URL')]
        [string]$As_scan_location_xss,

        [ValidateSet('Tag', 'Attribute', 'Pattern')]
        [string]$As_value_type_xss,

        [string]$As_value_expr_xss,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isvalueregex_xss,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecrosssitescriptingbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('crosssitescripting') ) { $payload.Add('crosssitescripting', $crosssitescripting) }
            if ( $PSBoundParameters.ContainsKey('formactionurl_xss') ) { $payload.Add('formactionurl_xss', $formactionurl_xss) }
            if ( $PSBoundParameters.ContainsKey('isregex_xss') ) { $payload.Add('isregex_xss', $isregex_xss) }
            if ( $PSBoundParameters.ContainsKey('as_scan_location_xss') ) { $payload.Add('as_scan_location_xss', $as_scan_location_xss) }
            if ( $PSBoundParameters.ContainsKey('as_value_type_xss') ) { $payload.Add('as_value_type_xss', $as_value_type_xss) }
            if ( $PSBoundParameters.ContainsKey('as_value_expr_xss') ) { $payload.Add('as_value_expr_xss', $as_value_expr_xss) }
            if ( $PSBoundParameters.ContainsKey('isvalueregex_xss') ) { $payload.Add('isvalueregex_xss', $isvalueregex_xss) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_crosssitescripting_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_crosssitescripting_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the crosssitescripting that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Crosssitescripting 
        The web form field name. 
    .PARAMETER Formactionurl_xss 
        The web form action URL. 
    .PARAMETER As_scan_location_xss 
        Location of cross-site scripting exception - form field, header, cookie or URL. 
        Possible values = FORMFIELD, HEADER, COOKIE, URL 
    .PARAMETER As_value_type_xss 
        The web form value type. 
        Possible values = Tag, Attribute, Pattern 
    .PARAMETER As_value_expr_xss 
        The web form value expression. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding -Name <string>
        An example how to delete appfwprofile_crosssitescripting_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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

        [string]$Crosssitescripting,

        [string]$Formactionurl_xss,

        [string]$As_scan_location_xss,

        [string]$As_value_type_xss,

        [string]$As_value_expr_xss,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecrosssitescriptingbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Crosssitescripting') ) { $arguments.Add('crosssitescripting', $Crosssitescripting) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_xss') ) { $arguments.Add('formactionurl_xss', $Formactionurl_xss) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_xss') ) { $arguments.Add('as_scan_location_xss', $As_scan_location_xss) }
            if ( $PSBoundParameters.ContainsKey('As_value_type_xss') ) { $arguments.Add('as_value_type_xss', $As_value_type_xss) }
            if ( $PSBoundParameters.ContainsKey('As_value_expr_xss') ) { $arguments.Add('as_value_expr_xss', $As_value_expr_xss) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the crosssitescripting that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_crosssitescripting_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_crosssitescripting_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecrosssitescriptingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -GetAll 
        Get all appfwprofile_crosssitescripting_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Count 
        Get the number of appfwprofile_crosssitescripting_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -name <string>
        Get appfwprofile_crosssitescripting_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecrosssitescriptingbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_crosssitescripting_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecrosssitescriptingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_crosssitescripting_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecrosssitescriptingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_crosssitescripting_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_crosssitescripting_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_crosssitescripting_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_crosssitescripting_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the csrftag that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Csrftag 
        The web form originating URL. 
    .PARAMETER Csrfformactionurl 
        The web form action URL. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_csrftag_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilecsrftagbinding -name <string>
        An example how to add appfwprofile_csrftag_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilecsrftagbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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

        [string]$Csrftag,

        [string]$Csrfformactionurl,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilecsrftagbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('csrftag') ) { $payload.Add('csrftag', $csrftag) }
            if ( $PSBoundParameters.ContainsKey('csrfformactionurl') ) { $payload.Add('csrfformactionurl', $csrfformactionurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_csrftag_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_csrftag_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilecsrftagbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the csrftag that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Csrftag 
        The web form originating URL. 
    .PARAMETER Csrfformactionurl 
        The web form action URL. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilecsrftagbinding -Name <string>
        An example how to delete appfwprofile_csrftag_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilecsrftagbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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

        [string]$Csrftag,

        [string]$Csrfformactionurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilecsrftagbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Csrftag') ) { $arguments.Add('csrftag', $Csrftag) }
            if ( $PSBoundParameters.ContainsKey('Csrfformactionurl') ) { $arguments.Add('csrfformactionurl', $Csrfformactionurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the csrftag that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_csrftag_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_csrftag_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecsrftagbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecsrftagbinding -GetAll 
        Get all appfwprofile_csrftag_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilecsrftagbinding -Count 
        Get the number of appfwprofile_csrftag_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecsrftagbinding -name <string>
        Get appfwprofile_csrftag_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilecsrftagbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_csrftag_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilecsrftagbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_csrftag_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilecsrftagbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_csrftag_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_csrftag_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_csrftag_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_csrftag_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the denyurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Denyurl 
        A regular expression that designates a URL on the Deny URL list. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_denyurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofiledenyurlbinding -name <string>
        An example how to add appfwprofile_denyurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofiledenyurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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

        [string]$Denyurl,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofiledenyurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('denyurl') ) { $payload.Add('denyurl', $denyurl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_denyurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_denyurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofiledenyurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the denyurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Denyurl 
        A regular expression that designates a URL on the Deny URL list. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofiledenyurlbinding -Name <string>
        An example how to delete appfwprofile_denyurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofiledenyurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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

        [string]$Denyurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofiledenyurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Denyurl') ) { $arguments.Add('denyurl', $Denyurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the denyurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_denyurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_denyurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiledenyurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofiledenyurlbinding -GetAll 
        Get all appfwprofile_denyurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofiledenyurlbinding -Count 
        Get the number of appfwprofile_denyurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiledenyurlbinding -name <string>
        Get appfwprofile_denyurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiledenyurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_denyurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofiledenyurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_denyurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofiledenyurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_denyurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_denyurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_denyurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_denyurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the excluderescontenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Excluderescontenttype 
        A regular expression that represents the content type of the response that are to be excluded from inspection. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_excluderescontenttype_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofileexcluderescontenttypebinding -name <string>
        An example how to add appfwprofile_excluderescontenttype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofileexcluderescontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Excluderescontenttype,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofileexcluderescontenttypebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('excluderescontenttype') ) { $payload.Add('excluderescontenttype', $excluderescontenttype) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_excluderescontenttype_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_excluderescontenttype_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the excluderescontenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Excluderescontenttype 
        A regular expression that represents the content type of the response that are to be excluded from inspection. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding -Name <string>
        An example how to delete appfwprofile_excluderescontenttype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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

        [string]$Excluderescontenttype,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofileexcluderescontenttypebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Excluderescontenttype') ) { $arguments.Add('excluderescontenttype', $Excluderescontenttype) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the excluderescontenttype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_excluderescontenttype_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_excluderescontenttype_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofileexcluderescontenttypebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -GetAll 
        Get all appfwprofile_excluderescontenttype_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Count 
        Get the number of appfwprofile_excluderescontenttype_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -name <string>
        Get appfwprofile_excluderescontenttype_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofileexcluderescontenttypebinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_excluderescontenttype_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofileexcluderescontenttypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_excluderescontenttype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofileexcluderescontenttypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_excluderescontenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_excluderescontenttype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_excluderescontenttype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_excluderescontenttype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fieldconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Fieldconsistency 
        The web form field name. 
    .PARAMETER Formactionurl_ffc 
        The web form action URL. 
    .PARAMETER Isregex_ffc 
        Is the web form field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fieldconsistency_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilefieldconsistencybinding -name <string>
        An example how to add appfwprofile_fieldconsistency_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefieldconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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

        [string]$Fieldconsistency,

        [string]$Formactionurl_ffc,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_ffc,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldconsistencybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('fieldconsistency') ) { $payload.Add('fieldconsistency', $fieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('formactionurl_ffc') ) { $payload.Add('formactionurl_ffc', $formactionurl_ffc) }
            if ( $PSBoundParameters.ContainsKey('isregex_ffc') ) { $payload.Add('isregex_ffc', $isregex_ffc) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_fieldconsistency_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fieldconsistency_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilefieldconsistencybinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fieldconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Fieldconsistency 
        The web form field name. 
    .PARAMETER Formactionurl_ffc 
        The web form action URL. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilefieldconsistencybinding -Name <string>
        An example how to delete appfwprofile_fieldconsistency_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefieldconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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

        [string]$Fieldconsistency,

        [string]$Formactionurl_ffc,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldconsistencybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Fieldconsistency') ) { $arguments.Add('fieldconsistency', $Fieldconsistency) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_ffc') ) { $arguments.Add('formactionurl_ffc', $Formactionurl_ffc) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the fieldconsistency that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_fieldconsistency_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_fieldconsistency_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldconsistencybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefieldconsistencybinding -GetAll 
        Get all appfwprofile_fieldconsistency_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefieldconsistencybinding -Count 
        Get the number of appfwprofile_fieldconsistency_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldconsistencybinding -name <string>
        Get appfwprofile_fieldconsistency_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldconsistencybinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_fieldconsistency_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefieldconsistencybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldconsistency_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldconsistencybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_fieldconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fieldconsistency_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fieldconsistency_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldconsistency_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fieldformat that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Fieldformat 
        Name of the form field to which a field format will be assigned. 
    .PARAMETER Formactionurl_ff 
        Action URL of the form field to which a field format will be assigned. 
    .PARAMETER Fieldtype 
        The field type you are assigning to this form field. 
    .PARAMETER Fieldformatminlength 
        The minimum allowed length for data in this form field. 
    .PARAMETER Fieldformatmaxlength 
        The maximum allowed length for data in this form field. 
    .PARAMETER Isregex_ff 
        Is the form field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fieldformat_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilefieldformatbinding -name <string>
        An example how to add appfwprofile_fieldformat_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefieldformatbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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

        [string]$Fieldformat,

        [string]$Formactionurl_ff,

        [string]$Fieldtype,

        [double]$Fieldformatminlength,

        [double]$Fieldformatmaxlength,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_ff,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefieldformatbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('fieldformat') ) { $payload.Add('fieldformat', $fieldformat) }
            if ( $PSBoundParameters.ContainsKey('formactionurl_ff') ) { $payload.Add('formactionurl_ff', $formactionurl_ff) }
            if ( $PSBoundParameters.ContainsKey('fieldtype') ) { $payload.Add('fieldtype', $fieldtype) }
            if ( $PSBoundParameters.ContainsKey('fieldformatminlength') ) { $payload.Add('fieldformatminlength', $fieldformatminlength) }
            if ( $PSBoundParameters.ContainsKey('fieldformatmaxlength') ) { $payload.Add('fieldformatmaxlength', $fieldformatmaxlength) }
            if ( $PSBoundParameters.ContainsKey('isregex_ff') ) { $payload.Add('isregex_ff', $isregex_ff) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_fieldformat_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fieldformat_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilefieldformatbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fieldformat that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Fieldformat 
        Name of the form field to which a field format will be assigned. 
    .PARAMETER Formactionurl_ff 
        Action URL of the form field to which a field format will be assigned. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilefieldformatbinding -Name <string>
        An example how to delete appfwprofile_fieldformat_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefieldformatbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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

        [string]$Fieldformat,

        [string]$Formactionurl_ff,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefieldformatbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Fieldformat') ) { $arguments.Add('fieldformat', $Fieldformat) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_ff') ) { $arguments.Add('formactionurl_ff', $Formactionurl_ff) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the fieldformat that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_fieldformat_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_fieldformat_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldformatbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefieldformatbinding -GetAll 
        Get all appfwprofile_fieldformat_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefieldformatbinding -Count 
        Get the number of appfwprofile_fieldformat_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldformatbinding -name <string>
        Get appfwprofile_fieldformat_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefieldformatbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_fieldformat_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefieldformatbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fieldformat_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefieldformatbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_fieldformat_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fieldformat_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fieldformat_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fieldformat_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fileuploadtype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Fileuploadtype 
        FileUploadTypes to allow/deny. 
    .PARAMETER As_fileuploadtypes_url 
        FileUploadTypes action URL. 
    .PARAMETER Isregex_fileuploadtypes_url 
        Is a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Filetype 
        FileUploadTypes file types. 
        Possible values = pdf, msdoc, text, image, any 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_fileuploadtype_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilefileuploadtypebinding -name <string>
        An example how to add appfwprofile_fileuploadtype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilefileuploadtypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Fileuploadtype,

        [string]$As_fileuploadtypes_url,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_fileuploadtypes_url,

        [ValidateSet('pdf', 'msdoc', 'text', 'image', 'any')]
        [string[]]$Filetype,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilefileuploadtypebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('fileuploadtype') ) { $payload.Add('fileuploadtype', $fileuploadtype) }
            if ( $PSBoundParameters.ContainsKey('as_fileuploadtypes_url') ) { $payload.Add('as_fileuploadtypes_url', $as_fileuploadtypes_url) }
            if ( $PSBoundParameters.ContainsKey('isregex_fileuploadtypes_url') ) { $payload.Add('isregex_fileuploadtypes_url', $isregex_fileuploadtypes_url) }
            if ( $PSBoundParameters.ContainsKey('filetype') ) { $payload.Add('filetype', $filetype) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_fileuploadtype_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_fileuploadtype_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilefileuploadtypebinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the fileuploadtype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Fileuploadtype 
        FileUploadTypes to allow/deny. 
    .PARAMETER As_fileuploadtypes_url 
        FileUploadTypes action URL. 
    .PARAMETER Filetype 
        FileUploadTypes file types. 
        Possible values = pdf, msdoc, text, image, any 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilefileuploadtypebinding -Name <string>
        An example how to delete appfwprofile_fileuploadtype_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilefileuploadtypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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

        [string]$Fileuploadtype,

        [string]$As_fileuploadtypes_url,

        [string[]]$Filetype,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilefileuploadtypebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Fileuploadtype') ) { $arguments.Add('fileuploadtype', $Fileuploadtype) }
            if ( $PSBoundParameters.ContainsKey('As_fileuploadtypes_url') ) { $arguments.Add('as_fileuploadtypes_url', $As_fileuploadtypes_url) }
            if ( $PSBoundParameters.ContainsKey('Filetype') ) { $arguments.Add('filetype', $Filetype) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the fileuploadtype that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_fileuploadtype_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_fileuploadtype_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefileuploadtypebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefileuploadtypebinding -GetAll 
        Get all appfwprofile_fileuploadtype_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilefileuploadtypebinding -Count 
        Get the number of appfwprofile_fileuploadtype_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefileuploadtypebinding -name <string>
        Get appfwprofile_fileuploadtype_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilefileuploadtypebinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_fileuploadtype_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilefileuploadtypebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_fileuploadtype_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilefileuploadtypebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_fileuploadtype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_fileuploadtype_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_fileuploadtype_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_fileuploadtype_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsondosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Jsondosurl 
        The URL on which we need to enforce the specified JSON denial-of-service (JSONDoS) attack protections. An JSON DoS configuration consists of the following items: * URL. PCRE-format regular expression for the URL. * Maximum-document-length-check toggle. ON to enable this check, OFF to disable it. * Maximum document length. Positive integer representing the maximum length of the JSON document. * Maximum-container-depth-check toggle. ON to enable, OFF to disable. * Maximum container depth. Positive integer representing the maximum container depth of the JSON document. * Maximum-object-key-count-check toggle. ON to enable, OFF to disable. * Maximum object key count. Positive integer representing the maximum allowed number of keys in any of the JSON object. * Maximum-object-key-length-check toggle. ON to enable, OFF to disable. * Maximum object key length. Positive integer representing the maximum allowed length of key in any of the JSON object. * Maximum-array-value-count-check toggle. ON to enable, OFF to disable. * Maximum array value count. Positive integer representing the maximum allowed number of values in any of the JSON array. * Maximum-string-length-check toggle. ON to enable, OFF to disable. * Maximum string length. Positive integer representing the maximum length of string in JSON. 
    .PARAMETER Jsonmaxcontainerdepthcheck 
        State if JSON Max depth check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxcontainerdepth 
        Maximum allowed nesting depth of JSON document. JSON allows one to nest the containers (object and array) in any order to any depth. This check protects against documents that have excessive depth of hierarchy. 
    .PARAMETER Jsonmaxdocumentlengthcheck 
        State if JSON Max document length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxdocumentlength 
        Maximum document length of JSON document, in bytes. 
    .PARAMETER Jsonmaxobjectkeycountcheck 
        State if JSON Max object key count check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxobjectkeycount 
        Maximum key count in the any of JSON object. This check protects against objects that have large number of keys. 
    .PARAMETER Jsonmaxobjectkeylengthcheck 
        State if JSON Max object key length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxobjectkeylength 
        Maximum key length in the any of JSON object. This check protects against objects that have large keys. 
    .PARAMETER Jsonmaxarraylengthcheck 
        State if JSON Max array value count check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxarraylength 
        Maximum array length in the any of JSON object. This check protects against arrays having large lengths. 
    .PARAMETER Jsonmaxstringlengthcheck 
        State if JSON Max string value count check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Jsonmaxstringlength 
        Maximum string length in the JSON. This check protects against strings that have large length. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsondosurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilejsondosurlbinding -name <string>
        An example how to add appfwprofile_jsondosurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsondosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateLength(1, 2047)]
        [string]$Jsondosurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxcontainerdepthcheck,

        [ValidateRange(0, 127)]
        [double]$Jsonmaxcontainerdepth = '5',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxdocumentlengthcheck,

        [ValidateRange(0, 2147483647)]
        [double]$Jsonmaxdocumentlength = '20000000',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxobjectkeycountcheck,

        [ValidateRange(0, 2147483647)]
        [double]$Jsonmaxobjectkeycount = '10000',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxobjectkeylengthcheck,

        [ValidateRange(0, 2147483647)]
        [double]$Jsonmaxobjectkeylength = '128',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxarraylengthcheck,

        [ValidateRange(0, 2147483647)]
        [double]$Jsonmaxarraylength = '10000',

        [ValidateSet('ON', 'OFF')]
        [string]$Jsonmaxstringlengthcheck,

        [ValidateRange(0, 2147483647)]
        [double]$Jsonmaxstringlength = '1000000',

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsondosurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('jsondosurl') ) { $payload.Add('jsondosurl', $jsondosurl) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxcontainerdepthcheck') ) { $payload.Add('jsonmaxcontainerdepthcheck', $jsonmaxcontainerdepthcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxcontainerdepth') ) { $payload.Add('jsonmaxcontainerdepth', $jsonmaxcontainerdepth) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxdocumentlengthcheck') ) { $payload.Add('jsonmaxdocumentlengthcheck', $jsonmaxdocumentlengthcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxdocumentlength') ) { $payload.Add('jsonmaxdocumentlength', $jsonmaxdocumentlength) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxobjectkeycountcheck') ) { $payload.Add('jsonmaxobjectkeycountcheck', $jsonmaxobjectkeycountcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxobjectkeycount') ) { $payload.Add('jsonmaxobjectkeycount', $jsonmaxobjectkeycount) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxobjectkeylengthcheck') ) { $payload.Add('jsonmaxobjectkeylengthcheck', $jsonmaxobjectkeylengthcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxobjectkeylength') ) { $payload.Add('jsonmaxobjectkeylength', $jsonmaxobjectkeylength) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxarraylengthcheck') ) { $payload.Add('jsonmaxarraylengthcheck', $jsonmaxarraylengthcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxarraylength') ) { $payload.Add('jsonmaxarraylength', $jsonmaxarraylength) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxstringlengthcheck') ) { $payload.Add('jsonmaxstringlengthcheck', $jsonmaxstringlengthcheck) }
            if ( $PSBoundParameters.ContainsKey('jsonmaxstringlength') ) { $payload.Add('jsonmaxstringlength', $jsonmaxstringlength) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_jsondosurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsondosurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsondosurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsondosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Jsondosurl 
        The URL on which we need to enforce the specified JSON denial-of-service (JSONDoS) attack protections. An JSON DoS configuration consists of the following items: * URL. PCRE-format regular expression for the URL. * Maximum-document-length-check toggle. ON to enable this check, OFF to disable it. * Maximum document length. Positive integer representing the maximum length of the JSON document. * Maximum-container-depth-check toggle. ON to enable, OFF to disable. * Maximum container depth. Positive integer representing the maximum container depth of the JSON document. * Maximum-object-key-count-check toggle. ON to enable, OFF to disable. * Maximum object key count. Positive integer representing the maximum allowed number of keys in any of the JSON object. * Maximum-object-key-length-check toggle. ON to enable, OFF to disable. * Maximum object key length. Positive integer representing the maximum allowed length of key in any of the JSON object. * Maximum-array-value-count-check toggle. ON to enable, OFF to disable. * Maximum array value count. Positive integer representing the maximum allowed number of values in any of the JSON array. * Maximum-string-length-check toggle. ON to enable, OFF to disable. * Maximum string length. Positive integer representing the maximum length of string in JSON. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilejsondosurlbinding -Name <string>
        An example how to delete appfwprofile_jsondosurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsondosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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

        [string]$Jsondosurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsondosurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Jsondosurl') ) { $arguments.Add('jsondosurl', $Jsondosurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the jsondosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_jsondosurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsondosurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsondosurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsondosurlbinding -GetAll 
        Get all appfwprofile_jsondosurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsondosurlbinding -Count 
        Get the number of appfwprofile_jsondosurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsondosurlbinding -name <string>
        Get appfwprofile_jsondosurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsondosurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_jsondosurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsondosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsondosurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsondosurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_jsondosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsondosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsondosurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsondosurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsonsqlurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Jsonsqlurl 
        A regular expression that designates a URL on the Json SQL URL list for which SQL violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsonsqlurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilejsonsqlurlbinding -name <string>
        An example how to add appfwprofile_jsonsqlurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsonsqlurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateLength(1, 2047)]
        [string]$Jsonsqlurl,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonsqlurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('jsonsqlurl') ) { $payload.Add('jsonsqlurl', $jsonsqlurl) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_jsonsqlurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsonsqlurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsonsqlurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Jsonsqlurl 
        A regular expression that designates a URL on the Json SQL URL list for which SQL violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding -Name <string>
        An example how to delete appfwprofile_jsonsqlurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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

        [string]$Jsonsqlurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonsqlurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Jsonsqlurl') ) { $arguments.Add('jsonsqlurl', $Jsonsqlurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the jsonsqlurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_jsonsqlurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsonsqlurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonsqlurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsonsqlurlbinding -GetAll 
        Get all appfwprofile_jsonsqlurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Count 
        Get the number of appfwprofile_jsonsqlurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonsqlurlbinding -name <string>
        Get appfwprofile_jsonsqlurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonsqlurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_jsonsqlurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsonsqlurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonsqlurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonsqlurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_jsonsqlurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsonsqlurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsonsqlurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonsqlurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsonxssurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Jsonxssurl 
        A regular expression that designates a URL on the Json XSS URL list for which XSS violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_jsonxssurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilejsonxssurlbinding -name <string>
        An example how to add appfwprofile_jsonxssurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilejsonxssurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateLength(1, 2047)]
        [string]$Jsonxssurl,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilejsonxssurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('jsonxssurl') ) { $payload.Add('jsonxssurl', $jsonxssurl) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_jsonxssurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_jsonxssurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilejsonxssurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the jsonxssurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Jsonxssurl 
        A regular expression that designates a URL on the Json XSS URL list for which XSS violations are relaxed. Enclose URLs in double quotes to ensure preservation of any embedded spaces or non-alphanumeric characters. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilejsonxssurlbinding -Name <string>
        An example how to delete appfwprofile_jsonxssurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilejsonxssurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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

        [string]$Jsonxssurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilejsonxssurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Jsonxssurl') ) { $arguments.Add('jsonxssurl', $Jsonxssurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the jsonxssurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_jsonxssurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_jsonxssurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonxssurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsonxssurlbinding -GetAll 
        Get all appfwprofile_jsonxssurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilejsonxssurlbinding -Count 
        Get the number of appfwprofile_jsonxssurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonxssurlbinding -name <string>
        Get appfwprofile_jsonxssurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilejsonxssurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_jsonxssurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilejsonxssurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_jsonxssurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilejsonxssurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_jsonxssurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_jsonxssurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_jsonxssurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_jsonxssurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logexpression 
        Name of LogExpression object. 
    .PARAMETER As_logexpression 
        LogExpression to log when violation happened on appfw profile. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_logexpression_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilelogexpressionbinding -name <string>
        An example how to add appfwprofile_logexpression_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilelogexpressionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Logexpression,

        [string]$As_logexpression,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilelogexpressionbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('logexpression') ) { $payload.Add('logexpression', $logexpression) }
            if ( $PSBoundParameters.ContainsKey('as_logexpression') ) { $payload.Add('as_logexpression', $as_logexpression) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_logexpression_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_logexpression_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilelogexpressionbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Logexpression 
        Name of LogExpression object. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilelogexpressionbinding -Name <string>
        An example how to delete appfwprofile_logexpression_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilelogexpressionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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

        [string]$Logexpression,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilelogexpressionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Logexpression') ) { $arguments.Add('logexpression', $Logexpression) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the logexpression that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_logexpression_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_logexpression_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilelogexpressionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilelogexpressionbinding -GetAll 
        Get all appfwprofile_logexpression_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilelogexpressionbinding -Count 
        Get the number of appfwprofile_logexpression_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilelogexpressionbinding -name <string>
        Get appfwprofile_logexpression_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilelogexpressionbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_logexpression_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilelogexpressionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_logexpression_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilelogexpressionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_logexpression_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_logexpression_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_logexpression_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_logexpression_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the safeobject that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Safeobject 
        Name of the Safe Object. 
    .PARAMETER As_expression 
        A regular expression that defines the Safe Object. 
    .PARAMETER Maxmatchlength 
        Maximum match length for a Safe Object expression. 
    .PARAMETER Action 
        Safe Object action types. (BLOCK | LOG | STATS | NONE). 
        Possible values = none, block, log, remove, stats, xout 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_safeobject_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilesafeobjectbinding -name <string>
        An example how to add appfwprofile_safeobject_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilesafeobjectbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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

        [string]$Safeobject,

        [string]$As_expression,

        [double]$Maxmatchlength,

        [ValidateSet('none', 'block', 'log', 'remove', 'stats', 'xout')]
        [string[]]$Action,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilesafeobjectbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('safeobject') ) { $payload.Add('safeobject', $safeobject) }
            if ( $PSBoundParameters.ContainsKey('as_expression') ) { $payload.Add('as_expression', $as_expression) }
            if ( $PSBoundParameters.ContainsKey('maxmatchlength') ) { $payload.Add('maxmatchlength', $maxmatchlength) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_safeobject_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_safeobject_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilesafeobjectbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the safeobject that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Safeobject 
        Name of the Safe Object. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilesafeobjectbinding -Name <string>
        An example how to delete appfwprofile_safeobject_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilesafeobjectbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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

        [string]$Safeobject,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesafeobjectbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Safeobject') ) { $arguments.Add('safeobject', $Safeobject) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the safeobject that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_safeobject_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_safeobject_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesafeobjectbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilesafeobjectbinding -GetAll 
        Get all appfwprofile_safeobject_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilesafeobjectbinding -Count 
        Get the number of appfwprofile_safeobject_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesafeobjectbinding -name <string>
        Get appfwprofile_safeobject_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesafeobjectbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_safeobject_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilesafeobjectbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_safeobject_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilesafeobjectbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_safeobject_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_safeobject_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_safeobject_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_safeobject_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the sqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Sqlinjection 
        The web form field name. 
    .PARAMETER Formactionurl_sql 
        The web form action URL. 
    .PARAMETER Isregex_sql 
        Is the web form field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER As_scan_location_sql 
        Location of SQL injection exception - form field, header or cookie. 
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER As_value_type_sql 
        The web form value type. 
        Possible values = Keyword, SpecialString, Wildchar 
    .PARAMETER As_value_expr_sql 
        The web form value expression. 
    .PARAMETER Isvalueregex_sql 
        Is the web form field value a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_sqlinjection_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilesqlinjectionbinding -name <string>
        An example how to add appfwprofile_sqlinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilesqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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

        [string]$Sqlinjection,

        [string]$Formactionurl_sql,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_sql,

        [ValidateSet('FORMFIELD', 'HEADER', 'COOKIE')]
        [string]$As_scan_location_sql,

        [ValidateSet('Keyword', 'SpecialString', 'Wildchar')]
        [string]$As_value_type_sql,

        [string]$As_value_expr_sql,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isvalueregex_sql,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilesqlinjectionbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sqlinjection') ) { $payload.Add('sqlinjection', $sqlinjection) }
            if ( $PSBoundParameters.ContainsKey('formactionurl_sql') ) { $payload.Add('formactionurl_sql', $formactionurl_sql) }
            if ( $PSBoundParameters.ContainsKey('isregex_sql') ) { $payload.Add('isregex_sql', $isregex_sql) }
            if ( $PSBoundParameters.ContainsKey('as_scan_location_sql') ) { $payload.Add('as_scan_location_sql', $as_scan_location_sql) }
            if ( $PSBoundParameters.ContainsKey('as_value_type_sql') ) { $payload.Add('as_value_type_sql', $as_value_type_sql) }
            if ( $PSBoundParameters.ContainsKey('as_value_expr_sql') ) { $payload.Add('as_value_expr_sql', $as_value_expr_sql) }
            if ( $PSBoundParameters.ContainsKey('isvalueregex_sql') ) { $payload.Add('isvalueregex_sql', $isvalueregex_sql) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_sqlinjection_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_sqlinjection_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilesqlinjectionbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the sqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Sqlinjection 
        The web form field name. 
    .PARAMETER Formactionurl_sql 
        The web form action URL. 
    .PARAMETER As_scan_location_sql 
        Location of SQL injection exception - form field, header or cookie. 
        Possible values = FORMFIELD, HEADER, COOKIE 
    .PARAMETER As_value_type_sql 
        The web form value type. 
        Possible values = Keyword, SpecialString, Wildchar 
    .PARAMETER As_value_expr_sql 
        The web form value expression. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilesqlinjectionbinding -Name <string>
        An example how to delete appfwprofile_sqlinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilesqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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

        [string]$Sqlinjection,

        [string]$Formactionurl_sql,

        [string]$As_scan_location_sql,

        [string]$As_value_type_sql,

        [string]$As_value_expr_sql,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilesqlinjectionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Sqlinjection') ) { $arguments.Add('sqlinjection', $Sqlinjection) }
            if ( $PSBoundParameters.ContainsKey('Formactionurl_sql') ) { $arguments.Add('formactionurl_sql', $Formactionurl_sql) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_sql') ) { $arguments.Add('as_scan_location_sql', $As_scan_location_sql) }
            if ( $PSBoundParameters.ContainsKey('As_value_type_sql') ) { $arguments.Add('as_value_type_sql', $As_value_type_sql) }
            if ( $PSBoundParameters.ContainsKey('As_value_expr_sql') ) { $arguments.Add('as_value_expr_sql', $As_value_expr_sql) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the sqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_sqlinjection_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_sqlinjection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesqlinjectionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilesqlinjectionbinding -GetAll 
        Get all appfwprofile_sqlinjection_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilesqlinjectionbinding -Count 
        Get the number of appfwprofile_sqlinjection_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesqlinjectionbinding -name <string>
        Get appfwprofile_sqlinjection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilesqlinjectionbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_sqlinjection_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilesqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_sqlinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilesqlinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_sqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_sqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_sqlinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_sqlinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the starturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Starturl 
        A regular expression that designates a URL on the Start URL list. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_starturl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilestarturlbinding -name <string>
        An example how to add appfwprofile_starturl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilestarturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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

        [string]$Starturl,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilestarturlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('starturl') ) { $payload.Add('starturl', $starturl) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_starturl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_starturl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilestarturlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the starturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Starturl 
        A regular expression that designates a URL on the Start URL list. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilestarturlbinding -Name <string>
        An example how to delete appfwprofile_starturl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilestarturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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

        [string]$Starturl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilestarturlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Starturl') ) { $arguments.Add('starturl', $Starturl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the starturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_starturl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_starturl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilestarturlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilestarturlbinding -GetAll 
        Get all appfwprofile_starturl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilestarturlbinding -Count 
        Get the number of appfwprofile_starturl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilestarturlbinding -name <string>
        Get appfwprofile_starturl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilestarturlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_starturl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilestarturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_starturl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilestarturlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_starturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_starturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_starturl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_starturl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_starturl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_starturl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the trustedlearningclients that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Trustedlearningclients 
        Specify trusted host/network IP. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_trustedlearningclients_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding -name <string>
        An example how to add appfwprofile_trustedlearningclients_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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

        [string]$Trustedlearningclients,

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofiletrustedlearningclientsbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('trustedlearningclients') ) { $payload.Add('trustedlearningclients', $trustedlearningclients) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_trustedlearningclients_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_trustedlearningclients_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the trustedlearningclients that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Trustedlearningclients 
        Specify trusted host/network IP. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding -Name <string>
        An example how to delete appfwprofile_trustedlearningclients_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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

        [string]$Trustedlearningclients,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofiletrustedlearningclientsbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Trustedlearningclients') ) { $arguments.Add('trustedlearningclients', $Trustedlearningclients) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the trustedlearningclients that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_trustedlearningclients_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_trustedlearningclients_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -GetAll 
        Get all appfwprofile_trustedlearningclients_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Count 
        Get the number of appfwprofile_trustedlearningclients_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -name <string>
        Get appfwprofile_trustedlearningclients_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_trustedlearningclients_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_trustedlearningclients_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofiletrustedlearningclientsbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_trustedlearningclients_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_trustedlearningclients_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_trustedlearningclients_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_trustedlearningclients_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlattachmenturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmlattachmenturl 
        XML attachment URL regular expression length. 
    .PARAMETER Xmlmaxattachmentsizecheck 
        State if XML Max attachment size Check is ON or OFF. Protects against XML requests with large attachment data. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxattachmentsize 
        Specify maximum attachment size. 
    .PARAMETER Xmlattachmentcontenttypecheck 
        State if XML attachment content-type check is ON or OFF. Protects against XML requests with illegal attachments. 
        Possible values = ON, OFF 
    .PARAMETER Xmlattachmentcontenttype 
        Specify content-type regular expression. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlattachmenturl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmlattachmenturlbinding -name <string>
        An example how to add appfwprofile_xmlattachmenturl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlattachmenturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmlattachmenturl,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxattachmentsizecheck,

        [ValidateRange(0, 1000000000)]
        [double]$Xmlmaxattachmentsize,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlattachmentcontenttypecheck,

        [string]$Xmlattachmentcontenttype,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlattachmenturlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmenturl') ) { $payload.Add('xmlattachmenturl', $xmlattachmenturl) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattachmentsizecheck') ) { $payload.Add('xmlmaxattachmentsizecheck', $xmlmaxattachmentsizecheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattachmentsize') ) { $payload.Add('xmlmaxattachmentsize', $xmlmaxattachmentsize) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentcontenttypecheck') ) { $payload.Add('xmlattachmentcontenttypecheck', $xmlattachmentcontenttypecheck) }
            if ( $PSBoundParameters.ContainsKey('xmlattachmentcontenttype') ) { $payload.Add('xmlattachmentcontenttype', $xmlattachmentcontenttype) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmlattachmenturl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlattachmenturl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlattachmenturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmlattachmenturl 
        XML attachment URL regular expression length. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding -Name <string>
        An example how to delete appfwprofile_xmlattachmenturl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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

        [string]$Xmlattachmenturl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlattachmenturlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmlattachmenturl') ) { $arguments.Add('xmlattachmenturl', $Xmlattachmenturl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmlattachmenturl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmlattachmenturl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlattachmenturl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlattachmenturlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -GetAll 
        Get all appfwprofile_xmlattachmenturl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Count 
        Get the number of appfwprofile_xmlattachmenturl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -name <string>
        Get appfwprofile_xmlattachmenturl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlattachmenturlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmlattachmenturl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlattachmenturlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlattachmenturl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlattachmenturlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmlattachmenturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlattachmenturl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlattachmenturl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlattachmenturl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmldosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmldosurl 
        XML DoS URL regular expression length. 
    .PARAMETER Xmlmaxelementdepthcheck 
        State if XML Max element depth check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxelementdepth 
        Maximum nesting (depth) of XML elements. This check protects against documents that have excessive hierarchy depths. 
    .PARAMETER Xmlmaxelementnamelengthcheck 
        State if XML Max element name length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxelementnamelength 
        Specify the longest name of any element (including the expanded namespace) to protect against overflow attacks. 
    .PARAMETER Xmlmaxelementscheck 
        State if XML Max elements check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxelements 
        Specify the maximum number of XML elements allowed. Protects against overflow attacks. 
    .PARAMETER Xmlmaxelementchildrencheck 
        State if XML Max element children check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxelementchildren 
        Specify the maximum number of children allowed per XML element. Protects against overflow attacks. 
    .PARAMETER Xmlmaxnodescheck 
        State if XML Max nodes check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxnodes 
        Specify the maximum number of XML nodes. Protects against overflow attacks. 
    .PARAMETER Xmlmaxattributescheck 
        State if XML Max attributes check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxattributes 
        Specify maximum number of attributes per XML element. Protects against overflow attacks. 
    .PARAMETER Xmlmaxattributenamelengthcheck 
        State if XML Max attribute name length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxattributenamelength 
        Specify the longest name of any XML attribute. Protects against overflow attacks. 
    .PARAMETER Xmlmaxattributevaluelengthcheck 
        State if XML Max atribute value length is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxattributevaluelength 
        Specify the longest value of any XML attribute. Protects against overflow attacks. 
    .PARAMETER Xmlmaxchardatalengthcheck 
        State if XML Max CDATA length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxchardatalength 
        Specify the maximum size of CDATA. Protects against overflow attacks and large quantities of unparsed data within XML messages. 
    .PARAMETER Xmlmaxfilesizecheck 
        State if XML Max file size check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxfilesize 
        Specify the maximum size of XML messages. Protects against overflow attacks. 
    .PARAMETER Xmlminfilesizecheck 
        State if XML Min file size check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlminfilesize 
        Enforces minimum message size. 
    .PARAMETER Xmlblockpi 
        State if XML Block PI is ON or OFF. Protects resources from denial of service attacks as SOAP messages cannot have processing instructions (PI) in messages. 
        Possible values = ON, OFF 
    .PARAMETER Xmlblockdtd 
        State if XML DTD is ON or OFF. Protects against recursive Document Type Declaration (DTD) entity expansion attacks. Also, SOAP messages cannot have DTDs in messages. . 
        Possible values = ON, OFF 
    .PARAMETER Xmlblockexternalentities 
        State if XML Block External Entities Check is ON or OFF. Protects against XML External Entity (XXE) attacks that force applications to parse untrusted external entities (sources) in XML documents. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxentityexpansionscheck 
        State if XML Max Entity Expansions Check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxentityexpansions 
        Specify maximum allowed number of entity expansions. Protects aganist Entity Expansion Attack. 
    .PARAMETER Xmlmaxentityexpansiondepthcheck 
        State if XML Max Entity Expansions Depth Check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxentityexpansiondepth 
        Specify maximum entity expansion depth. Protects aganist Entity Expansion Attack. 
    .PARAMETER Xmlmaxnamespacescheck 
        State if XML Max namespaces check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxnamespaces 
        Specify maximum number of active namespaces. Protects against overflow attacks. 
    .PARAMETER Xmlmaxnamespaceurilengthcheck 
        State if XML Max namespace URI length check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxnamespaceurilength 
        Specify the longest URI of any XML namespace. Protects against overflow attacks. 
    .PARAMETER Xmlsoaparraycheck 
        State if XML SOAP Array check is ON or OFF. 
        Possible values = ON, OFF 
    .PARAMETER Xmlmaxsoaparraysize 
        XML Max Total SOAP Array Size. Protects against SOAP Array Abuse attack. 
    .PARAMETER Xmlmaxsoaparrayrank 
        XML Max Individual SOAP Array Rank. This is the dimension of the SOAP array. 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmldosurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmldosurlbinding -name <string>
        An example how to add appfwprofile_xmldosurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmldosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmldosurl,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxelementdepthcheck,

        [double]$Xmlmaxelementdepth,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxelementnamelengthcheck,

        [double]$Xmlmaxelementnamelength,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxelementscheck,

        [double]$Xmlmaxelements,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxelementchildrencheck,

        [double]$Xmlmaxelementchildren,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxnodescheck,

        [double]$Xmlmaxnodes,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxattributescheck,

        [double]$Xmlmaxattributes,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxattributenamelengthcheck,

        [double]$Xmlmaxattributenamelength,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxattributevaluelengthcheck,

        [double]$Xmlmaxattributevaluelength,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxchardatalengthcheck,

        [ValidateRange(0, 1000000000)]
        [double]$Xmlmaxchardatalength,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxfilesizecheck,

        [ValidateRange(0, 1000000000)]
        [double]$Xmlmaxfilesize,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlminfilesizecheck,

        [ValidateRange(0, 1000000000)]
        [double]$Xmlminfilesize,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlblockpi,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlblockdtd,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlblockexternalentities,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxentityexpansionscheck,

        [double]$Xmlmaxentityexpansions,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxentityexpansiondepthcheck,

        [double]$Xmlmaxentityexpansiondepth,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxnamespacescheck,

        [double]$Xmlmaxnamespaces,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlmaxnamespaceurilengthcheck,

        [double]$Xmlmaxnamespaceurilength,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlsoaparraycheck,

        [ValidateRange(0, 1000000000)]
        [double]$Xmlmaxsoaparraysize,

        [double]$Xmlmaxsoaparrayrank,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmldosurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmldosurl') ) { $payload.Add('xmldosurl', $xmldosurl) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementdepthcheck') ) { $payload.Add('xmlmaxelementdepthcheck', $xmlmaxelementdepthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementdepth') ) { $payload.Add('xmlmaxelementdepth', $xmlmaxelementdepth) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementnamelengthcheck') ) { $payload.Add('xmlmaxelementnamelengthcheck', $xmlmaxelementnamelengthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementnamelength') ) { $payload.Add('xmlmaxelementnamelength', $xmlmaxelementnamelength) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementscheck') ) { $payload.Add('xmlmaxelementscheck', $xmlmaxelementscheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelements') ) { $payload.Add('xmlmaxelements', $xmlmaxelements) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementchildrencheck') ) { $payload.Add('xmlmaxelementchildrencheck', $xmlmaxelementchildrencheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxelementchildren') ) { $payload.Add('xmlmaxelementchildren', $xmlmaxelementchildren) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnodescheck') ) { $payload.Add('xmlmaxnodescheck', $xmlmaxnodescheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnodes') ) { $payload.Add('xmlmaxnodes', $xmlmaxnodes) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributescheck') ) { $payload.Add('xmlmaxattributescheck', $xmlmaxattributescheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributes') ) { $payload.Add('xmlmaxattributes', $xmlmaxattributes) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributenamelengthcheck') ) { $payload.Add('xmlmaxattributenamelengthcheck', $xmlmaxattributenamelengthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributenamelength') ) { $payload.Add('xmlmaxattributenamelength', $xmlmaxattributenamelength) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributevaluelengthcheck') ) { $payload.Add('xmlmaxattributevaluelengthcheck', $xmlmaxattributevaluelengthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxattributevaluelength') ) { $payload.Add('xmlmaxattributevaluelength', $xmlmaxattributevaluelength) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxchardatalengthcheck') ) { $payload.Add('xmlmaxchardatalengthcheck', $xmlmaxchardatalengthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxchardatalength') ) { $payload.Add('xmlmaxchardatalength', $xmlmaxchardatalength) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxfilesizecheck') ) { $payload.Add('xmlmaxfilesizecheck', $xmlmaxfilesizecheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxfilesize') ) { $payload.Add('xmlmaxfilesize', $xmlmaxfilesize) }
            if ( $PSBoundParameters.ContainsKey('xmlminfilesizecheck') ) { $payload.Add('xmlminfilesizecheck', $xmlminfilesizecheck) }
            if ( $PSBoundParameters.ContainsKey('xmlminfilesize') ) { $payload.Add('xmlminfilesize', $xmlminfilesize) }
            if ( $PSBoundParameters.ContainsKey('xmlblockpi') ) { $payload.Add('xmlblockpi', $xmlblockpi) }
            if ( $PSBoundParameters.ContainsKey('xmlblockdtd') ) { $payload.Add('xmlblockdtd', $xmlblockdtd) }
            if ( $PSBoundParameters.ContainsKey('xmlblockexternalentities') ) { $payload.Add('xmlblockexternalentities', $xmlblockexternalentities) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxentityexpansionscheck') ) { $payload.Add('xmlmaxentityexpansionscheck', $xmlmaxentityexpansionscheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxentityexpansions') ) { $payload.Add('xmlmaxentityexpansions', $xmlmaxentityexpansions) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxentityexpansiondepthcheck') ) { $payload.Add('xmlmaxentityexpansiondepthcheck', $xmlmaxentityexpansiondepthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxentityexpansiondepth') ) { $payload.Add('xmlmaxentityexpansiondepth', $xmlmaxentityexpansiondepth) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnamespacescheck') ) { $payload.Add('xmlmaxnamespacescheck', $xmlmaxnamespacescheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnamespaces') ) { $payload.Add('xmlmaxnamespaces', $xmlmaxnamespaces) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnamespaceurilengthcheck') ) { $payload.Add('xmlmaxnamespaceurilengthcheck', $xmlmaxnamespaceurilengthcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxnamespaceurilength') ) { $payload.Add('xmlmaxnamespaceurilength', $xmlmaxnamespaceurilength) }
            if ( $PSBoundParameters.ContainsKey('xmlsoaparraycheck') ) { $payload.Add('xmlsoaparraycheck', $xmlsoaparraycheck) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxsoaparraysize') ) { $payload.Add('xmlmaxsoaparraysize', $xmlmaxsoaparraysize) }
            if ( $PSBoundParameters.ContainsKey('xmlmaxsoaparrayrank') ) { $payload.Add('xmlmaxsoaparrayrank', $xmlmaxsoaparrayrank) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmldosurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmldosurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmldosurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmldosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmldosurl 
        XML DoS URL regular expression length. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmldosurlbinding -Name <string>
        An example how to delete appfwprofile_xmldosurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmldosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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

        [string]$Xmldosurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmldosurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmldosurl') ) { $arguments.Add('xmldosurl', $Xmldosurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmldosurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmldosurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmldosurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmldosurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmldosurlbinding -GetAll 
        Get all appfwprofile_xmldosurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmldosurlbinding -Count 
        Get the number of appfwprofile_xmldosurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmldosurlbinding -name <string>
        Get appfwprofile_xmldosurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmldosurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmldosurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmldosurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmldosurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmldosurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmldosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmldosurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmldosurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmldosurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlsqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmlsqlinjection 
        Exempt the specified URL from the XML SQL injection check. An XML SQL injection exemption (relaxation) consists of the following items: * Name. Name to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the injection is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER Isregex_xmlsql 
        Is the XML SQL Injection exempted field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER As_scan_location_xmlsql 
        Location of SQL injection exception - XML Element or Attribute. 
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlsqlinjection_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding -name <string>
        An example how to add appfwprofile_xmlsqlinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmlsqlinjection,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_xmlsql,

        [ValidateSet('ELEMENT', 'ATTRIBUTE')]
        [string]$As_scan_location_xmlsql,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlsqlinjectionbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmlsqlinjection') ) { $payload.Add('xmlsqlinjection', $xmlsqlinjection) }
            if ( $PSBoundParameters.ContainsKey('isregex_xmlsql') ) { $payload.Add('isregex_xmlsql', $isregex_xmlsql) }
            if ( $PSBoundParameters.ContainsKey('as_scan_location_xmlsql') ) { $payload.Add('as_scan_location_xmlsql', $as_scan_location_xmlsql) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmlsqlinjection_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlsqlinjection_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlsqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmlsqlinjection 
        Exempt the specified URL from the XML SQL injection check. An XML SQL injection exemption (relaxation) consists of the following items: * Name. Name to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the injection is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER As_scan_location_xmlsql 
        Location of SQL injection exception - XML Element or Attribute. 
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding -Name <string>
        An example how to delete appfwprofile_xmlsqlinjection_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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

        [string]$Xmlsqlinjection,

        [string]$As_scan_location_xmlsql,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlsqlinjectionbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmlsqlinjection') ) { $arguments.Add('xmlsqlinjection', $Xmlsqlinjection) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_xmlsql') ) { $arguments.Add('as_scan_location_xmlsql', $As_scan_location_xmlsql) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmlsqlinjection that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmlsqlinjection_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlsqlinjection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -GetAll 
        Get all appfwprofile_xmlsqlinjection_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Count 
        Get the number of appfwprofile_xmlsqlinjection_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -name <string>
        Get appfwprofile_xmlsqlinjection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmlsqlinjection_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlsqlinjection_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlsqlinjectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmlsqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlsqlinjection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlsqlinjection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlsqlinjection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlvalidationurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmlvalidationurl 
        XML Validation URL regular expression. 
    .PARAMETER Xmlrequestschema 
        XML Schema object for request validation . 
    .PARAMETER Xmlresponseschema 
        XML Schema object for response validation. 
    .PARAMETER Xmlwsdl 
        WSDL object for soap request validation. 
    .PARAMETER Xmladditionalsoapheaders 
        Allow addtional soap headers. 
        Possible values = ON, OFF 
    .PARAMETER Xmlendpointcheck 
        Modifies the behaviour of the Request URL validation w.r.t. the Service URL. If set to ABSOLUTE, the entire request URL is validated with the entire URL mentioned in Service of the associated WSDL. eg: Service URL: http://example.org/ExampleService, Request URL: http//example.com/ExampleService would FAIL the validation. If set to RELAIVE, only the non-hostname part of the request URL is validated against the non-hostname part of the Service URL. eg: Service URL: http://example.org/ExampleService, Request URL: http//example.com/ExampleService would PASS the validation. 
        Possible values = ABSOLUTE, RELATIVE 
    .PARAMETER Xmlvalidatesoapenvelope 
        Validate SOAP Evelope only. 
        Possible values = ON, OFF 
    .PARAMETER Xmlvalidateresponse 
        Validate response message. 
        Possible values = ON, OFF 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlvalidationurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmlvalidationurlbinding -name <string>
        An example how to add appfwprofile_xmlvalidationurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlvalidationurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmlvalidationurl,

        [string]$Xmlrequestschema,

        [string]$Xmlresponseschema,

        [string]$Xmlwsdl,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmladditionalsoapheaders,

        [ValidateSet('ABSOLUTE', 'RELATIVE')]
        [string]$Xmlendpointcheck,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlvalidatesoapenvelope,

        [ValidateSet('ON', 'OFF')]
        [string]$Xmlvalidateresponse,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlvalidationurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidationurl') ) { $payload.Add('xmlvalidationurl', $xmlvalidationurl) }
            if ( $PSBoundParameters.ContainsKey('xmlrequestschema') ) { $payload.Add('xmlrequestschema', $xmlrequestschema) }
            if ( $PSBoundParameters.ContainsKey('xmlresponseschema') ) { $payload.Add('xmlresponseschema', $xmlresponseschema) }
            if ( $PSBoundParameters.ContainsKey('xmlwsdl') ) { $payload.Add('xmlwsdl', $xmlwsdl) }
            if ( $PSBoundParameters.ContainsKey('xmladditionalsoapheaders') ) { $payload.Add('xmladditionalsoapheaders', $xmladditionalsoapheaders) }
            if ( $PSBoundParameters.ContainsKey('xmlendpointcheck') ) { $payload.Add('xmlendpointcheck', $xmlendpointcheck) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidatesoapenvelope') ) { $payload.Add('xmlvalidatesoapenvelope', $xmlvalidatesoapenvelope) }
            if ( $PSBoundParameters.ContainsKey('xmlvalidateresponse') ) { $payload.Add('xmlvalidateresponse', $xmlvalidateresponse) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmlvalidationurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlvalidationurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlvalidationurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmlvalidationurl 
        XML Validation URL regular expression. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding -Name <string>
        An example how to delete appfwprofile_xmlvalidationurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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

        [string]$Xmlvalidationurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlvalidationurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmlvalidationurl') ) { $arguments.Add('xmlvalidationurl', $Xmlvalidationurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmlvalidationurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmlvalidationurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlvalidationurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlvalidationurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -GetAll 
        Get all appfwprofile_xmlvalidationurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Count 
        Get the number of appfwprofile_xmlvalidationurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -name <string>
        Get appfwprofile_xmlvalidationurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlvalidationurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmlvalidationurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlvalidationurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlvalidationurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlvalidationurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmlvalidationurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlvalidationurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlvalidationurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlvalidationurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlwsiurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmlwsiurl 
        XML WS-I URL regular expression length. 
    .PARAMETER Xmlwsichecks 
        Specify a comma separated list of relevant WS-I rule IDs. (R1140, R1141). 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlwsiurl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmlwsiurlbinding -name <string>
        An example how to add appfwprofile_xmlwsiurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlwsiurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmlwsiurl,

        [string]$Xmlwsichecks,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlwsiurlbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmlwsiurl') ) { $payload.Add('xmlwsiurl', $xmlwsiurl) }
            if ( $PSBoundParameters.ContainsKey('xmlwsichecks') ) { $payload.Add('xmlwsichecks', $xmlwsichecks) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmlwsiurl_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlwsiurl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlwsiurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmlwsiurl 
        XML WS-I URL regular expression length. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding -Name <string>
        An example how to delete appfwprofile_xmlwsiurl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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

        [string]$Xmlwsiurl,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlwsiurlbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmlwsiurl') ) { $arguments.Add('xmlwsiurl', $Xmlwsiurl) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmlwsiurl that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmlwsiurl_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlwsiurl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlwsiurlbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlwsiurlbinding -GetAll 
        Get all appfwprofile_xmlwsiurl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Count 
        Get the number of appfwprofile_xmlwsiurl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlwsiurlbinding -name <string>
        Get appfwprofile_xmlwsiurl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlwsiurlbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmlwsiurl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlwsiurlbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlwsiurl_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlwsiurlbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmlwsiurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlwsiurl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlwsiurl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlwsiurl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlxss that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Comment 
        Any comments about the purpose of profile, or other useful information about the profile. 
    .PARAMETER State 
        Enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Xmlxss 
        Exempt the specified URL from the XML cross-site scripting (XSS) check. An XML cross-site scripting exemption (relaxation) consists of the following items: * URL. URL to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the attachment is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER Isregex_xmlxss 
        Is the XML XSS exempted field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER As_scan_location_xmlxss 
        Location of XSS injection exception - XML Element or Attribute. 
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER Isautodeployed 
        Is the rule auto deployed by dynamic profile ?. 
        Possible values = AUTODEPLOYED, NOTAUTODEPLOYED 
    .PARAMETER Resourceid 
        A "id" that identifies the rule. 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY 
    .PARAMETER PassThru 
        Return details about the created appfwprofile_xmlxss_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwprofilexmlxssbinding -name <string>
        An example how to add appfwprofile_xmlxss_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwprofilexmlxssbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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

        [string]$Comment,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State,

        [string]$Xmlxss,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex_xmlxss,

        [ValidateSet('ELEMENT', 'ATTRIBUTE')]
        [string]$As_scan_location_xmlxss,

        [ValidateSet('AUTODEPLOYED', 'NOTAUTODEPLOYED')]
        [string]$Isautodeployed,

        [string]$Resourceid,

        [ValidateSet('ALLOW', 'DENY')]
        [string]$Ruletype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwprofilexmlxssbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('xmlxss') ) { $payload.Add('xmlxss', $xmlxss) }
            if ( $PSBoundParameters.ContainsKey('isregex_xmlxss') ) { $payload.Add('isregex_xmlxss', $isregex_xmlxss) }
            if ( $PSBoundParameters.ContainsKey('as_scan_location_xmlxss') ) { $payload.Add('as_scan_location_xmlxss', $as_scan_location_xmlxss) }
            if ( $PSBoundParameters.ContainsKey('isautodeployed') ) { $payload.Add('isautodeployed', $isautodeployed) }
            if ( $PSBoundParameters.ContainsKey('resourceid') ) { $payload.Add('resourceid', $resourceid) }
            if ( $PSBoundParameters.ContainsKey('ruletype') ) { $payload.Add('ruletype', $ruletype) }
            if ( $PSCmdlet.ShouldProcess("appfwprofile_xmlxss_binding", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwprofile_xmlxss_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwprofilexmlxssbinding -Filter $payload)
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Binding object showing the xmlxss that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER Xmlxss 
        Exempt the specified URL from the XML cross-site scripting (XSS) check. An XML cross-site scripting exemption (relaxation) consists of the following items: * URL. URL to exempt, as a string or a PCRE-format regular expression. * ISREGEX flag. REGEX if URL is a regular expression, NOTREGEX if URL is a fixed string. * Location. ELEMENT if the attachment is located in an XML element, ATTRIBUTE if located in an XML attribute. 
    .PARAMETER As_scan_location_xmlxss 
        Location of XSS injection exception - XML Element or Attribute. 
        Possible values = ELEMENT, ATTRIBUTE 
    .PARAMETER Ruletype 
        Specifies rule type of binding. 
        Possible values = ALLOW, DENY
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwprofilexmlxssbinding -Name <string>
        An example how to delete appfwprofile_xmlxss_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwprofilexmlxssbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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

        [string]$Xmlxss,

        [string]$As_scan_location_xmlxss,

        [string]$Ruletype 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwprofilexmlxssbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Xmlxss') ) { $arguments.Add('xmlxss', $Xmlxss) }
            if ( $PSBoundParameters.ContainsKey('As_scan_location_xmlxss') ) { $arguments.Add('as_scan_location_xmlxss', $As_scan_location_xmlxss) }
            if ( $PSBoundParameters.ContainsKey('Ruletype') ) { $arguments.Add('ruletype', $Ruletype) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Binding object showing the xmlxss that can be bound to appfwprofile.
    .PARAMETER Name 
        Name of the profile to which to bind an exemption or rule. 
    .PARAMETER GetAll 
        Retrieve all appfwprofile_xmlxss_binding object(s).
    .PARAMETER Count
        If specified, the count of the appfwprofile_xmlxss_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlxssbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlxssbinding -GetAll 
        Get all appfwprofile_xmlxss_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwprofilexmlxssbinding -Count 
        Get the number of appfwprofile_xmlxss_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlxssbinding -name <string>
        Get appfwprofile_xmlxss_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwprofilexmlxssbinding -Filter @{ 'name'='<value>' }
        Get appfwprofile_xmlxss_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwprofilexmlxssbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwprofile_xmlxss_binding/
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
        Write-Verbose "Invoke-ADCGetAppfwprofilexmlxssbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all appfwprofile_xmlxss_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwprofile_xmlxss_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwprofile_xmlxss_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwprofile_xmlxss_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCUnsetAppfwsettings {
    <#
    .SYNOPSIS
        Unset Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for AS settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is APPFW_BYPASS, which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Undefaction 
        Profile to use when an application firewall policy evaluates to undefined (UNDEF). 
        An UNDEF event indicates an internal error condition. The APPFW_BLOCK built-in profile is the default setting. You can specify a different built-in or user-created profile as the UNDEF profile. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
    .PARAMETER Learnratelimit 
        Maximum number of connections per second that the application firewall learning engine examines to generate new relaxations for learning-enabled security checks. The application firewall drops any connections above this limit from the list of connections used by the learning engine. 
    .PARAMETER Sessionlifetime 
        Maximum amount of time (in seconds) that the application firewall allows a user session to remain active, regardless of user activity. After this time, the user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
    .PARAMETER Sessioncookiename 
        Name of the session cookie that the application firewall uses to track user sessions. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Clientiploggingheader 
        Name of an HTTP header that contains the IP address that the client used to connect to the protected web site or service. 
    .PARAMETER Importsizelimit 
        Cumulative total maximum number of bytes in web forms imported to a protected web site. If a user attempts to upload files with a total byte count higher than the specified limit, the application firewall blocks the request. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable auto update signatures. 
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the mapping file from server. 
    .PARAMETER Cookiepostencryptprefix 
        String that is prepended to all encrypted cookie values. 
    .PARAMETER Logmalformedreq 
        Log requests that are so malformed that application firewall parsing doesn't occur. 
        Possible values = ON, OFF 
    .PARAMETER Geolocationlogging 
        Enable Geo-Location Logging in CEF format logs. 
        Possible values = ON, OFF 
    .PARAMETER Ceflogging 
        Enable CEF format logs. 
        Possible values = ON, OFF 
    .PARAMETER Entitydecoding 
        Transform multibyte (double- or half-width) characters to single width characters. 
        Possible values = ON, OFF 
    .PARAMETER Useconfigurablesecretkey 
        Use configurable secret key in AppFw operations. 
        Possible values = ON, OFF 
    .PARAMETER Sessionlimit 
        Maximum number of sessions that the application firewall allows to be active, regardless of user activity. After the max_limit reaches, No more user session will be created . 
    .PARAMETER Malformedreqaction 
        flag to define action on malformed requests that application firewall cannot parse. 
        Possible values = none, block, log, stats 
    .PARAMETER Centralizedlearning 
        Flag used to enable/disable ADM centralized learning. 
        Possible values = ON, OFF 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAppfwsettings 
        An example how to unset appfwsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAppfwsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings
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

        [Boolean]$defaultprofile,

        [Boolean]$undefaction,

        [Boolean]$sessiontimeout,

        [Boolean]$learnratelimit,

        [Boolean]$sessionlifetime,

        [Boolean]$sessioncookiename,

        [Boolean]$clientiploggingheader,

        [Boolean]$importsizelimit,

        [Boolean]$signatureautoupdate,

        [Boolean]$signatureurl,

        [Boolean]$cookiepostencryptprefix,

        [Boolean]$logmalformedreq,

        [Boolean]$geolocationlogging,

        [Boolean]$ceflogging,

        [Boolean]$entitydecoding,

        [Boolean]$useconfigurablesecretkey,

        [Boolean]$sessionlimit,

        [Boolean]$malformedreqaction,

        [Boolean]$centralizedlearning,

        [Boolean]$proxyserver,

        [Boolean]$proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAppfwsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('learnratelimit') ) { $payload.Add('learnratelimit', $learnratelimit) }
            if ( $PSBoundParameters.ContainsKey('sessionlifetime') ) { $payload.Add('sessionlifetime', $sessionlifetime) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('clientiploggingheader') ) { $payload.Add('clientiploggingheader', $clientiploggingheader) }
            if ( $PSBoundParameters.ContainsKey('importsizelimit') ) { $payload.Add('importsizelimit', $importsizelimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('cookiepostencryptprefix') ) { $payload.Add('cookiepostencryptprefix', $cookiepostencryptprefix) }
            if ( $PSBoundParameters.ContainsKey('logmalformedreq') ) { $payload.Add('logmalformedreq', $logmalformedreq) }
            if ( $PSBoundParameters.ContainsKey('geolocationlogging') ) { $payload.Add('geolocationlogging', $geolocationlogging) }
            if ( $PSBoundParameters.ContainsKey('ceflogging') ) { $payload.Add('ceflogging', $ceflogging) }
            if ( $PSBoundParameters.ContainsKey('entitydecoding') ) { $payload.Add('entitydecoding', $entitydecoding) }
            if ( $PSBoundParameters.ContainsKey('useconfigurablesecretkey') ) { $payload.Add('useconfigurablesecretkey', $useconfigurablesecretkey) }
            if ( $PSBoundParameters.ContainsKey('sessionlimit') ) { $payload.Add('sessionlimit', $sessionlimit) }
            if ( $PSBoundParameters.ContainsKey('malformedreqaction') ) { $payload.Add('malformedreqaction', $malformedreqaction) }
            if ( $PSBoundParameters.ContainsKey('centralizedlearning') ) { $payload.Add('centralizedlearning', $centralizedlearning) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSCmdlet.ShouldProcess("appfwsettings", "Unset Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type appfwsettings -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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

function Invoke-ADCUpdateAppfwsettings {
    <#
    .SYNOPSIS
        Update Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for AS settings resource.
    .PARAMETER Defaultprofile 
        Profile to use when a connection does not match any policy. Default setting is APPFW_BYPASS, which sends unmatched connections back to the Citrix ADC without attempting to filter them further. 
    .PARAMETER Undefaction 
        Profile to use when an application firewall policy evaluates to undefined (UNDEF). 
        An UNDEF event indicates an internal error condition. The APPFW_BLOCK built-in profile is the default setting. You can specify a different built-in or user-created profile as the UNDEF profile. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, after which a user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
    .PARAMETER Learnratelimit 
        Maximum number of connections per second that the application firewall learning engine examines to generate new relaxations for learning-enabled security checks. The application firewall drops any connections above this limit from the list of connections used by the learning engine. 
    .PARAMETER Sessionlifetime 
        Maximum amount of time (in seconds) that the application firewall allows a user session to remain active, regardless of user activity. After this time, the user session is terminated. Before continuing to use the protected web site, the user must establish a new session by opening a designated start URL. 
    .PARAMETER Sessioncookiename 
        Name of the session cookie that the application firewall uses to track user sessions. 
        Must begin with a letter or number, and can consist of from 1 to 31 letters, numbers, and the hyphen (-) and underscore (_) symbols. 
    .PARAMETER Clientiploggingheader 
        Name of an HTTP header that contains the IP address that the client used to connect to the protected web site or service. 
    .PARAMETER Importsizelimit 
        Cumulative total maximum number of bytes in web forms imported to a protected web site. If a user attempts to upload files with a total byte count higher than the specified limit, the application firewall blocks the request. 
    .PARAMETER Signatureautoupdate 
        Flag used to enable/disable auto update signatures. 
        Possible values = ON, OFF 
    .PARAMETER Signatureurl 
        URL to download the mapping file from server. 
    .PARAMETER Cookiepostencryptprefix 
        String that is prepended to all encrypted cookie values. 
    .PARAMETER Logmalformedreq 
        Log requests that are so malformed that application firewall parsing doesn't occur. 
        Possible values = ON, OFF 
    .PARAMETER Geolocationlogging 
        Enable Geo-Location Logging in CEF format logs. 
        Possible values = ON, OFF 
    .PARAMETER Ceflogging 
        Enable CEF format logs. 
        Possible values = ON, OFF 
    .PARAMETER Entitydecoding 
        Transform multibyte (double- or half-width) characters to single width characters. 
        Possible values = ON, OFF 
    .PARAMETER Useconfigurablesecretkey 
        Use configurable secret key in AppFw operations. 
        Possible values = ON, OFF 
    .PARAMETER Sessionlimit 
        Maximum number of sessions that the application firewall allows to be active, regardless of user activity. After the max_limit reaches, No more user session will be created . 
    .PARAMETER Malformedreqaction 
        flag to define action on malformed requests that application firewall cannot parse. 
        Possible values = none, block, log, stats 
    .PARAMETER Centralizedlearning 
        Flag used to enable/disable ADM centralized learning. 
        Possible values = ON, OFF 
    .PARAMETER Proxyserver 
        Proxy Server IP to get updated signatures from AWS. 
    .PARAMETER Proxyport 
        Proxy Server Port to get updated signatures from AWS. 
        * in CLI is represented as 65535 in NITRO API
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAppfwsettings 
        An example how to update appfwsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAppfwsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings/
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
        [string]$Defaultprofile,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Undefaction,

        [ValidateRange(1, 65535)]
        [double]$Sessiontimeout,

        [ValidateRange(1, 1000)]
        [double]$Learnratelimit,

        [ValidateRange(0, 2147483647)]
        [double]$Sessionlifetime,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sessioncookiename,

        [string]$Clientiploggingheader,

        [ValidateRange(1, 268435456)]
        [double]$Importsizelimit,

        [ValidateSet('ON', 'OFF')]
        [string]$Signatureautoupdate,

        [string]$Signatureurl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiepostencryptprefix,

        [ValidateSet('ON', 'OFF')]
        [string]$Logmalformedreq,

        [ValidateSet('ON', 'OFF')]
        [string]$Geolocationlogging,

        [ValidateSet('ON', 'OFF')]
        [string]$Ceflogging,

        [ValidateSet('ON', 'OFF')]
        [string]$Entitydecoding,

        [ValidateSet('ON', 'OFF')]
        [string]$Useconfigurablesecretkey,

        [ValidateRange(0, 500000)]
        [double]$Sessionlimit,

        [ValidateSet('none', 'block', 'log', 'stats')]
        [string[]]$Malformedreqaction,

        [ValidateSet('ON', 'OFF')]
        [string]$Centralizedlearning,

        [string]$Proxyserver,

        [ValidateRange(1, 65535)]
        [int]$Proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAppfwsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('defaultprofile') ) { $payload.Add('defaultprofile', $defaultprofile) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('learnratelimit') ) { $payload.Add('learnratelimit', $learnratelimit) }
            if ( $PSBoundParameters.ContainsKey('sessionlifetime') ) { $payload.Add('sessionlifetime', $sessionlifetime) }
            if ( $PSBoundParameters.ContainsKey('sessioncookiename') ) { $payload.Add('sessioncookiename', $sessioncookiename) }
            if ( $PSBoundParameters.ContainsKey('clientiploggingheader') ) { $payload.Add('clientiploggingheader', $clientiploggingheader) }
            if ( $PSBoundParameters.ContainsKey('importsizelimit') ) { $payload.Add('importsizelimit', $importsizelimit) }
            if ( $PSBoundParameters.ContainsKey('signatureautoupdate') ) { $payload.Add('signatureautoupdate', $signatureautoupdate) }
            if ( $PSBoundParameters.ContainsKey('signatureurl') ) { $payload.Add('signatureurl', $signatureurl) }
            if ( $PSBoundParameters.ContainsKey('cookiepostencryptprefix') ) { $payload.Add('cookiepostencryptprefix', $cookiepostencryptprefix) }
            if ( $PSBoundParameters.ContainsKey('logmalformedreq') ) { $payload.Add('logmalformedreq', $logmalformedreq) }
            if ( $PSBoundParameters.ContainsKey('geolocationlogging') ) { $payload.Add('geolocationlogging', $geolocationlogging) }
            if ( $PSBoundParameters.ContainsKey('ceflogging') ) { $payload.Add('ceflogging', $ceflogging) }
            if ( $PSBoundParameters.ContainsKey('entitydecoding') ) { $payload.Add('entitydecoding', $entitydecoding) }
            if ( $PSBoundParameters.ContainsKey('useconfigurablesecretkey') ) { $payload.Add('useconfigurablesecretkey', $useconfigurablesecretkey) }
            if ( $PSBoundParameters.ContainsKey('sessionlimit') ) { $payload.Add('sessionlimit', $sessionlimit) }
            if ( $PSBoundParameters.ContainsKey('malformedreqaction') ) { $payload.Add('malformedreqaction', $malformedreqaction) }
            if ( $PSBoundParameters.ContainsKey('centralizedlearning') ) { $payload.Add('centralizedlearning', $centralizedlearning) }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSCmdlet.ShouldProcess("appfwsettings", "Update Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type appfwsettings -Payload $payload -GetWarning
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

function Invoke-ADCGetAppfwsettings {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for AS settings resource.
    .PARAMETER GetAll 
        Retrieve all appfwsettings object(s).
    .PARAMETER Count
        If specified, the count of the appfwsettings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsettings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwsettings -GetAll 
        Get all appfwsettings data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsettings -name <string>
        Get appfwsettings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsettings -Filter @{ 'name'='<value>' }
        Get appfwsettings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwsettings
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsettings/
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
        Write-Verbose "Invoke-ADCGetAppfwsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwsettings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCChangeAppfwsignatures {
    <#
    .SYNOPSIS
        Change Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall signatures XML configuration resource.
    .PARAMETER Name 
        Name of the signature object. 
    .PARAMETER Mergedefault 
        Merges signature file with default signature file. 
    .PARAMETER PassThru 
        Return details about the created appfwsignatures item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeAppfwsignatures -name <string>
        An example how to change appfwsignatures configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeAppfwsignatures
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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

        [boolean]$Mergedefault,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwsignatures: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('mergedefault') ) { $payload.Add('mergedefault', $mergedefault) }
            if ( $PSCmdlet.ShouldProcess("appfwsignatures", "Change Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwsignatures -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwsignatures -Filter $payload)
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

function Invoke-ADCImportAppfwsignatures {
    <#
    .SYNOPSIS
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall signatures XML configuration resource.
    .PARAMETER Src 
        URL (protocol, host, path, and file name) for the location at which to store the imported signatures object. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name of the signature object. 
    .PARAMETER Xslt 
        XSLT file source. 
    .PARAMETER Comment 
        Any comments to preserve information about the signatures object. 
    .PARAMETER Overwrite 
        Overwrite any existing signatures object of the same name. 
    .PARAMETER Merge 
        Merges the existing Signature with new signature rules. 
    .PARAMETER Preservedefactions 
        preserves def actions of signature rules. 
    .PARAMETER Sha1 
        File path for sha1 file to validate signature file. 
    .PARAMETER Vendortype 
        Third party vendor type for which WAF signatures has to be generated. 
        Possible values = Snort
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwsignatures -src <string> -name <string>
        An example how to import appfwsignatures configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwsignatures
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Xslt,

        [string]$Comment,

        [boolean]$Overwrite,

        [boolean]$Merge,

        [boolean]$Preservedefactions,

        [ValidateLength(1, 2047)]
        [string]$Sha1,

        [ValidateSet('Snort')]
        [string]$Vendortype 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwsignatures: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('xslt') ) { $payload.Add('xslt', $xslt) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSBoundParameters.ContainsKey('merge') ) { $payload.Add('merge', $merge) }
            if ( $PSBoundParameters.ContainsKey('preservedefactions') ) { $payload.Add('preservedefactions', $preservedefactions) }
            if ( $PSBoundParameters.ContainsKey('sha1') ) { $payload.Add('sha1', $sha1) }
            if ( $PSBoundParameters.ContainsKey('vendortype') ) { $payload.Add('vendortype', $vendortype) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwsignatures -Action import -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwsignatures {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for application firewall signatures XML configuration resource.
    .PARAMETER Name 
        Name of the signature object.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwsignatures -Name <string>
        An example how to delete appfwsignatures configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwsignatures
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        Write-Verbose "Invoke-ADCDeleteAppfwsignatures: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwsignatures -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwsignatures {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for application firewall signatures XML configuration resource.
    .PARAMETER Name 
        Name of the signature object. 
    .PARAMETER GetAll 
        Retrieve all appfwsignatures object(s).
    .PARAMETER Count
        If specified, the count of the appfwsignatures object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsignatures
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwsignatures -GetAll 
        Get all appfwsignatures data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsignatures -name <string>
        Get appfwsignatures object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwsignatures -Filter @{ 'name'='<value>' }
        Get appfwsignatures data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwsignatures
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwsignatures/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwsignatures: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwsignatures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwsignatures objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwsignatures objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwsignatures configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwsignatures configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwsignatures -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for Application firewall transaction record resource.
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all appfwtransactionrecords object(s).
    .PARAMETER Count
        If specified, the count of the appfwtransactionrecords object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwtransactionrecords
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwtransactionrecords -GetAll 
        Get all appfwtransactionrecords data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwtransactionrecords -Count 
        Get the number of appfwtransactionrecords objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwtransactionrecords -name <string>
        Get appfwtransactionrecords object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwtransactionrecords -Filter @{ 'name'='<value>' }
        Get appfwtransactionrecords data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwtransactionrecords
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwtransactionrecords/
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
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwtransactionrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwtransactionrecords objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwtransactionrecords objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwtransactionrecords configuration for property ''"

            } else {
                Write-Verbose "Retrieving appfwtransactionrecords configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwtransactionrecords -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCDeleteAppfwurlencodedformcontenttype {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for Urlencoded form content type resource.
    .PARAMETER Urlencodedformcontenttypevalue 
        Content type to be classified as urlencoded form.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwurlencodedformcontenttype -Urlencodedformcontenttypevalue <string>
        An example how to delete appfwurlencodedformcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwurlencodedformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$Urlencodedformcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwurlencodedformcontenttype: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$urlencodedformcontenttypevalue", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Resource $urlencodedformcontenttypevalue -Arguments $arguments
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

function Invoke-ADCAddAppfwurlencodedformcontenttype {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for Urlencoded form content type resource.
    .PARAMETER Urlencodedformcontenttypevalue 
        Content type to be classified as urlencoded form. 
    .PARAMETER Isregex 
        Is urlencoded form content type a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwurlencodedformcontenttype item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwurlencodedformcontenttype -urlencodedformcontenttypevalue <string>
        An example how to add appfwurlencodedformcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwurlencodedformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$Urlencodedformcontenttypevalue,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex = 'NOTREGEX',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwurlencodedformcontenttype: Starting"
    }
    process {
        try {
            $payload = @{ urlencodedformcontenttypevalue = $urlencodedformcontenttypevalue }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSCmdlet.ShouldProcess("appfwurlencodedformcontenttype", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwurlencodedformcontenttype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwurlencodedformcontenttype -Filter $payload)
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

function Invoke-ADCGetAppfwurlencodedformcontenttype {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for Urlencoded form content type resource.
    .PARAMETER Urlencodedformcontenttypevalue 
        Content type to be classified as urlencoded form. 
    .PARAMETER GetAll 
        Retrieve all appfwurlencodedformcontenttype object(s).
    .PARAMETER Count
        If specified, the count of the appfwurlencodedformcontenttype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwurlencodedformcontenttype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwurlencodedformcontenttype -GetAll 
        Get all appfwurlencodedformcontenttype data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwurlencodedformcontenttype -Count 
        Get the number of appfwurlencodedformcontenttype objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwurlencodedformcontenttype -name <string>
        Get appfwurlencodedformcontenttype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwurlencodedformcontenttype -Filter @{ 'name'='<value>' }
        Get appfwurlencodedformcontenttype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwurlencodedformcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwurlencodedformcontenttype/
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
        [string]$Urlencodedformcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwurlencodedformcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwurlencodedformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwurlencodedformcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype configuration for property 'urlencodedformcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Resource $urlencodedformcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwurlencodedformcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwurlencodedformcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for WSDL file resource.
    .PARAMETER Name 
        Name of the WSDL file to remove.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwwsdl -Name <string>
        An example how to delete appfwwsdl configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwwsdl
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        Write-Verbose "Invoke-ADCDeleteAppfwwsdl: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwwsdl -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for WSDL file resource.
    .PARAMETER Src 
        URL (protocol, host, path, and name) of the WSDL file to be imported is stored. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name of the WSDL file to remove. 
    .PARAMETER Comment 
        Any comments to preserve information about the WSDL. 
    .PARAMETER Overwrite 
        Overwrite any existing WSDL of the same name.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwwsdl -src <string> -name <string>
        An example how to import appfwwsdl configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwwsdl
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwwsdl: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwwsdl -Action import -Payload $payload -GetWarning
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
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for WSDL file resource.
    .PARAMETER Name 
        Name of the WSDL file to remove. 
    .PARAMETER GetAll 
        Retrieve all appfwwsdl object(s).
    .PARAMETER Count
        If specified, the count of the appfwwsdl object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwwsdl
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwwsdl -GetAll 
        Get all appfwwsdl data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwwsdl -name <string>
        Get appfwwsdl object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwwsdl -Filter @{ 'name'='<value>' }
        Get appfwwsdl data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwwsdl
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwwsdl/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwwsdl: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwwsdl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwwsdl objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwwsdl objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwwsdl configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwwsdl configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwwsdl -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCDeleteAppfwxmlcontenttype {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for XML Content type resource.
    .PARAMETER Xmlcontenttypevalue 
        Content type to be classified as XML.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwxmlcontenttype -Xmlcontenttypevalue <string>
        An example how to delete appfwxmlcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$Xmlcontenttypevalue 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAppfwxmlcontenttype: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$xmlcontenttypevalue", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Resource $xmlcontenttypevalue -Arguments $arguments
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

function Invoke-ADCAddAppfwxmlcontenttype {
    <#
    .SYNOPSIS
        Add Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for XML Content type resource.
    .PARAMETER Xmlcontenttypevalue 
        Content type to be classified as XML. 
    .PARAMETER Isregex 
        Is field name a regular expression?. 
        Possible values = REGEX, NOTREGEX 
    .PARAMETER PassThru 
        Return details about the created appfwxmlcontenttype item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAppfwxmlcontenttype -xmlcontenttypevalue <string>
        An example how to add appfwxmlcontenttype configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAppfwxmlcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$Xmlcontenttypevalue,

        [ValidateSet('REGEX', 'NOTREGEX')]
        [string]$Isregex = 'NOTREGEX',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAppfwxmlcontenttype: Starting"
    }
    process {
        try {
            $payload = @{ xmlcontenttypevalue = $xmlcontenttypevalue }
            if ( $PSBoundParameters.ContainsKey('isregex') ) { $payload.Add('isregex', $isregex) }
            if ( $PSCmdlet.ShouldProcess("appfwxmlcontenttype", "Add Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlcontenttype -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwxmlcontenttype -Filter $payload)
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

function Invoke-ADCGetAppfwxmlcontenttype {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for XML Content type resource.
    .PARAMETER Xmlcontenttypevalue 
        Content type to be classified as XML. 
    .PARAMETER GetAll 
        Retrieve all appfwxmlcontenttype object(s).
    .PARAMETER Count
        If specified, the count of the appfwxmlcontenttype object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlcontenttype
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwxmlcontenttype -GetAll 
        Get all appfwxmlcontenttype data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwxmlcontenttype -Count 
        Get the number of appfwxmlcontenttype objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlcontenttype -name <string>
        Get appfwxmlcontenttype object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlcontenttype -Filter @{ 'name'='<value>' }
        Get appfwxmlcontenttype data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlcontenttype
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlcontenttype/
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
        [string]$Xmlcontenttypevalue,

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
        Write-Verbose "Invoke-ADCGetAppfwxmlcontenttype: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwxmlcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlcontenttype objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlcontenttype objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlcontenttype configuration for property 'xmlcontenttypevalue'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Resource $xmlcontenttypevalue -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlcontenttype configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlcontenttype -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCImportAppfwxmlerrorpage {
    <#
    .SYNOPSIS
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for xml error page resource.
    .PARAMETER Src 
        URL (protocol, host, path, and name) for the location at which to store the imported XML error object. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Indicates name of the imported xml error page to be removed. 
    .PARAMETER Comment 
        Any comments to preserve information about the XML error object. 
    .PARAMETER Overwrite 
        Overwrite any existing XML error object of the same name.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwxmlerrorpage -src <string> -name <string>
        An example how to import appfwxmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwxmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlerrorpage -Action import -Payload $payload -GetWarning
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
        Change Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for xml error page resource.
    .PARAMETER Name 
        Indicates name of the imported xml error page to be removed. 
    .PARAMETER PassThru 
        Return details about the created appfwxmlerrorpage item.
    .EXAMPLE
        PS C:\>Invoke-ADCChangeAppfwxmlerrorpage -name <string>
        An example how to change appfwxmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCChangeAppfwxmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCChangeAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess("appfwxmlerrorpage", "Change Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlerrorpage -Action update -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAppfwxmlerrorpage -Filter $payload)
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

function Invoke-ADCDeleteAppfwxmlerrorpage {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for xml error page resource.
    .PARAMETER Name 
        Indicates name of the imported xml error page to be removed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwxmlerrorpage -Name <string>
        An example how to delete appfwxmlerrorpage configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlerrorpage: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwxmlerrorpage {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for xml error page resource.
    .PARAMETER Name 
        Indicates name of the imported xml error page to be removed. 
    .PARAMETER GetAll 
        Retrieve all appfwxmlerrorpage object(s).
    .PARAMETER Count
        If specified, the count of the appfwxmlerrorpage object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlerrorpage
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwxmlerrorpage -GetAll 
        Get all appfwxmlerrorpage data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlerrorpage -name <string>
        Get appfwxmlerrorpage object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlerrorpage -Filter @{ 'name'='<value>' }
        Get appfwxmlerrorpage data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlerrorpage
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlerrorpage/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwxmlerrorpage: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwxmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlerrorpage objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlerrorpage objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlerrorpage configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlerrorpage configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlerrorpage -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

function Invoke-ADCImportAppfwxmlschema {
    <#
    .SYNOPSIS
        Import Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for XML schema resource.
    .PARAMETER Src 
        URL (protocol, host, path, and file name) for the location at which to store the imported XML Schema. 
        NOTE: The import fails if the object to be imported is on an HTTPS server that requires client certificate authentication for access. 
    .PARAMETER Name 
        Name of the XML Schema object to remove. 
    .PARAMETER Comment 
        Any comments to preserve information about the XML Schema object. 
    .PARAMETER Overwrite 
        Overwrite any existing XML Schema object of the same name.
    .EXAMPLE
        PS C:\>Invoke-ADCImportAppfwxmlschema -src <string> -name <string>
        An example how to import appfwxmlschema configuration Object(s).
    .NOTES
        File Name : Invoke-ADCImportAppfwxmlschema
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        [ValidateLength(1, 2047)]
        [string]$Src,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Name,

        [string]$Comment,

        [boolean]$Overwrite 

    )
    begin {
        Write-Verbose "Invoke-ADCImportAppfwxmlschema: Starting"
    }
    process {
        try {
            $payload = @{ src = $src
                name          = $name
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('overwrite') ) { $payload.Add('overwrite', $overwrite) }
            if ( $PSCmdlet.ShouldProcess($Name, "Import Application Firewall configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type appfwxmlschema -Action import -Payload $payload -GetWarning
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

function Invoke-ADCDeleteAppfwxmlschema {
    <#
    .SYNOPSIS
        Delete Application Firewall configuration Object.
    .DESCRIPTION
        Configuration for XML schema resource.
    .PARAMETER Name 
        Name of the XML Schema object to remove.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAppfwxmlschema -Name <string>
        An example how to delete appfwxmlschema configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAppfwxmlschema
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        Write-Verbose "Invoke-ADCDeleteAppfwxmlschema: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Application Firewall configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type appfwxmlschema -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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

function Invoke-ADCGetAppfwxmlschema {
    <#
    .SYNOPSIS
        Get Application Firewall configuration object(s).
    .DESCRIPTION
        Configuration for XML schema resource.
    .PARAMETER Name 
        Name of the XML Schema object to remove. 
    .PARAMETER GetAll 
        Retrieve all appfwxmlschema object(s).
    .PARAMETER Count
        If specified, the count of the appfwxmlschema object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlschema
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAppfwxmlschema -GetAll 
        Get all appfwxmlschema data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlschema -name <string>
        Get appfwxmlschema object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAppfwxmlschema -Filter @{ 'name'='<value>' }
        Get appfwxmlschema data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAppfwxmlschema
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/appfw/appfwxmlschema/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetAppfwxmlschema: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all appfwxmlschema objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for appfwxmlschema objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving appfwxmlschema objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving appfwxmlschema configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving appfwxmlschema configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type appfwxmlschema -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDvA40l8RsVz+3f
# iusF+jLIFdxr+3fRTKFTpWz9J68B1KCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgFz0of+6UO/aznzdjTE+v96ES0GYGeH4cF32fmsupLdwwDQYJKoZIhvcNAQEB
# BQAEggEAfKu1bc1WZEWmffZrLAP90gsbNgK22mcXoNt+D/CaXuztoBBIbxJ6nAm2
# kF/+pSztox+IWzVaKTt9Z46NOka+0wU9xAKpFWug4c0OFec5/+LovfDjqxb051t9
# gQ8YlC2oTj9nELbkrGvXvoMDKcIn89Yda25FX2MB/WVAyBSdiDSD+jm5JeWJy54u
# hPZYVE//VC/YM/rpvvsXvmRWQvHicmDf6jZoJmcFY7U50dE7UyjT9axbJz76K0nn
# bV+uZs+iYcJgyCGzSq7z/FJGu+92ow4w31zMd3YKiRKjkpJYJjqcWFenzwot4MlJ
# O3DJnxySJ/jkD5XnV6VHbBSK5O31BQ==
# SIG # End signature block
