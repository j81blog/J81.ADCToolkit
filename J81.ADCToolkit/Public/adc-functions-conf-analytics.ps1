function Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding {
    <#
    .SYNOPSIS
        Add Analytics configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to analyticsglobal.
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound. 
    .PARAMETER PassThru 
        Return details about the created analyticsglobal_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding -analyticsprofile <string>
        An example how to add analyticsglobal_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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
        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ analyticsprofile = $analyticsprofile }

            if ( $PSCmdlet.ShouldProcess("analyticsglobal_analyticsprofile_binding", "Add Analytics configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type analyticsglobal_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding {
    <#
    .SYNOPSIS
        Delete Analytics configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to analyticsglobal.
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding 
        An example how to delete analyticsglobal_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("analyticsglobal_analyticsprofile_binding", "Delete Analytics configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type analyticsglobal_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding {
    <#
    .SYNOPSIS
        Get Analytics configuration object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to analyticsglobal.
    .PARAMETER GetAll 
        Retrieve all analyticsglobal_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the analyticsglobal_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -GetAll 
        Get all analyticsglobal_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Count 
        Get the number of analyticsglobal_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -name <string>
        Get analyticsglobal_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Filter @{ 'name'='<value>' }
        Get analyticsglobal_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all analyticsglobal_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsglobal_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding: Ended"
    }
}

function Invoke-ADCGetAnalyticsglobalbinding {
    <#
    .SYNOPSIS
        Get Analytics configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to analyticsglobal.
    .PARAMETER GetAll 
        Retrieve all analyticsglobal_binding object(s).
    .PARAMETER Count
        If specified, the count of the analyticsglobal_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAnalyticsglobalbinding -GetAll 
        Get all analyticsglobal_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalbinding -name <string>
        Get analyticsglobal_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsglobalbinding -Filter @{ 'name'='<value>' }
        Get analyticsglobal_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAnalyticsglobalbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAnalyticsglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all analyticsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsglobal_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving analyticsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAnalyticsglobalbinding: Ended"
    }
}

function Invoke-ADCDeleteAnalyticsprofile {
    <#
    .SYNOPSIS
        Delete Analytics configuration Object.
    .DESCRIPTION
        Configuration for Analytics profile resource.
    .PARAMETER Name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAnalyticsprofile -Name <string>
        An example how to delete analyticsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAnalyticsprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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
        Write-Verbose "Invoke-ADCDeleteAnalyticsprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Analytics configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type analyticsprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAnalyticsprofile: Finished"
    }
}

function Invoke-ADCUnsetAnalyticsprofile {
    <#
    .SYNOPSIS
        Unset Analytics configuration Object.
    .DESCRIPTION
        Configuration for Analytics profile resource.
    .PARAMETER Name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced. 
    .PARAMETER Type 
        This option indicates what information needs to be collected and exported. 
        Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
    .PARAMETER Httpclientsidemeasurements 
        On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httppagetracking 
        On enabling this option, the Citrix ADC will link the embedded objects of a page together. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurl 
        On enabling this option, the Citrix ADC will log the URL in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        On enabling this option, the Citrix ADC will log the Host header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        On enabling this option, the Citrix ADC will log the method header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        On enabling this option, the Citrix ADC will log the referer header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        On enabling this option, the Citrix ADC will log User-Agent header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        On enabling this option, the Citrix ADC will log cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        On enabling this option, the Citrix ADC will log location header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        On enabling this option, the Citrix ADC will send the URL category record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Allhttpheaders 
        On enabling this option, the Citrix ADC will log all the request and response headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcontenttype 
        On enabling this option, the Citrix ADC will log content-length header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthentication 
        On enabling this option, the Citrix ADC will log Authentication header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        On enabling this option, the Citrix ADC will Via header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedforheader 
        On enabling this option, the Citrix ADC will log X-Forwarded-For header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        On enabling this option, the Citrix ADC will log set-cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        On enabling this option, the Citrix ADC will log set-cookie2 header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomainname 
        On enabling this option, the Citrix ADC will log domain name. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurlquery 
        On enabling this option, the Citrix ADC will log URL Query. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpburstreporting 
        On enabling this option, the Citrix ADC will log TCP burst parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        On enabling this option, the Citrix ADC will log TCP CQA parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Integratedcache 
        On enabling this option, the Citrix ADC will log the Integrated Caching appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Grpcstatus 
        On enabling this option, the Citrix ADC will log the gRPC status headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Outputmode 
        This option indicates the format of REST API POST body. It depends on the consumer of the analytics data. 
        Possible values = avro, prometheus, influx 
    .PARAMETER Metrics 
        This option indicates the whether metrics should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        This option indicates the whether events should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        This option indicates the whether auditlog should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAnalyticsprofile -name <string>
        An example how to unset analyticsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAnalyticsprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile
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

        [Boolean]$collectors,

        [Boolean]$type,

        [Boolean]$httpclientsidemeasurements,

        [Boolean]$httppagetracking,

        [Boolean]$httpurl,

        [Boolean]$httphost,

        [Boolean]$httpmethod,

        [Boolean]$httpreferer,

        [Boolean]$httpuseragent,

        [Boolean]$httpcookie,

        [Boolean]$httplocation,

        [Boolean]$urlcategory,

        [Boolean]$allhttpheaders,

        [Boolean]$httpcontenttype,

        [Boolean]$httpauthentication,

        [Boolean]$httpvia,

        [Boolean]$httpxforwardedforheader,

        [Boolean]$httpsetcookie,

        [Boolean]$httpsetcookie2,

        [Boolean]$httpdomainname,

        [Boolean]$httpurlquery,

        [Boolean]$tcpburstreporting,

        [Boolean]$cqareporting,

        [Boolean]$integratedcache,

        [Boolean]$grpcstatus,

        [Boolean]$outputmode,

        [Boolean]$metrics,

        [Boolean]$events,

        [Boolean]$auditlogs 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAnalyticsprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('collectors') ) { $payload.Add('collectors', $collectors) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('httpclientsidemeasurements') ) { $payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('httppagetracking') ) { $payload.Add('httppagetracking', $httppagetracking) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('allhttpheaders') ) { $payload.Add('allhttpheaders', $allhttpheaders) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthentication') ) { $payload.Add('httpauthentication', $httpauthentication) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedforheader') ) { $payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('httpdomainname') ) { $payload.Add('httpdomainname', $httpdomainname) }
            if ( $PSBoundParameters.ContainsKey('httpurlquery') ) { $payload.Add('httpurlquery', $httpurlquery) }
            if ( $PSBoundParameters.ContainsKey('tcpburstreporting') ) { $payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('integratedcache') ) { $payload.Add('integratedcache', $integratedcache) }
            if ( $PSBoundParameters.ContainsKey('grpcstatus') ) { $payload.Add('grpcstatus', $grpcstatus) }
            if ( $PSBoundParameters.ContainsKey('outputmode') ) { $payload.Add('outputmode', $outputmode) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Analytics configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type analyticsprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAnalyticsprofile: Finished"
    }
}

function Invoke-ADCUpdateAnalyticsprofile {
    <#
    .SYNOPSIS
        Update Analytics configuration Object.
    .DESCRIPTION
        Configuration for Analytics profile resource.
    .PARAMETER Name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced. 
    .PARAMETER Type 
        This option indicates what information needs to be collected and exported. 
        Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
    .PARAMETER Httpclientsidemeasurements 
        On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httppagetracking 
        On enabling this option, the Citrix ADC will link the embedded objects of a page together. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurl 
        On enabling this option, the Citrix ADC will log the URL in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        On enabling this option, the Citrix ADC will log the Host header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        On enabling this option, the Citrix ADC will log the method header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        On enabling this option, the Citrix ADC will log the referer header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        On enabling this option, the Citrix ADC will log User-Agent header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        On enabling this option, the Citrix ADC will log cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        On enabling this option, the Citrix ADC will log location header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        On enabling this option, the Citrix ADC will send the URL category record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Allhttpheaders 
        On enabling this option, the Citrix ADC will log all the request and response headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcontenttype 
        On enabling this option, the Citrix ADC will log content-length header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthentication 
        On enabling this option, the Citrix ADC will log Authentication header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        On enabling this option, the Citrix ADC will Via header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedforheader 
        On enabling this option, the Citrix ADC will log X-Forwarded-For header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        On enabling this option, the Citrix ADC will log set-cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        On enabling this option, the Citrix ADC will log set-cookie2 header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomainname 
        On enabling this option, the Citrix ADC will log domain name. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurlquery 
        On enabling this option, the Citrix ADC will log URL Query. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpburstreporting 
        On enabling this option, the Citrix ADC will log TCP burst parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        On enabling this option, the Citrix ADC will log TCP CQA parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Integratedcache 
        On enabling this option, the Citrix ADC will log the Integrated Caching appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Grpcstatus 
        On enabling this option, the Citrix ADC will log the gRPC status headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Outputmode 
        This option indicates the format of REST API POST body. It depends on the consumer of the analytics data. 
        Possible values = avro, prometheus, influx 
    .PARAMETER Metrics 
        This option indicates the whether metrics should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        This option indicates the whether events should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        This option indicates the whether auditlog should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created analyticsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAnalyticsprofile -name <string>
        An example how to update analyticsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAnalyticsprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Collectors,

        [ValidateSet('global', 'webinsight', 'tcpinsight', 'securityinsight', 'videoinsight', 'hdxinsight', 'gatewayinsight', 'timeseries', 'lsninsight', 'botinsight', 'CIinsight')]
        [string]$Type,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpclientsidemeasurements,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httppagetracking,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httphost,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpmethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpreferer,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpuseragent,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httplocation,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlcategory,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Allhttpheaders,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcontenttype,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpauthentication,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpvia,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpxforwardedforheader,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie2,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpdomainname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurlquery,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpburstreporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cqareporting,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Integratedcache,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Grpcstatus,

        [ValidateSet('avro', 'prometheus', 'influx')]
        [string]$Outputmode,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metrics,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Events,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Auditlogs,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAnalyticsprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('collectors') ) { $payload.Add('collectors', $collectors) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('httpclientsidemeasurements') ) { $payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('httppagetracking') ) { $payload.Add('httppagetracking', $httppagetracking) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('allhttpheaders') ) { $payload.Add('allhttpheaders', $allhttpheaders) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthentication') ) { $payload.Add('httpauthentication', $httpauthentication) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedforheader') ) { $payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('httpdomainname') ) { $payload.Add('httpdomainname', $httpdomainname) }
            if ( $PSBoundParameters.ContainsKey('httpurlquery') ) { $payload.Add('httpurlquery', $httpurlquery) }
            if ( $PSBoundParameters.ContainsKey('tcpburstreporting') ) { $payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('integratedcache') ) { $payload.Add('integratedcache', $integratedcache) }
            if ( $PSBoundParameters.ContainsKey('grpcstatus') ) { $payload.Add('grpcstatus', $grpcstatus) }
            if ( $PSBoundParameters.ContainsKey('outputmode') ) { $payload.Add('outputmode', $outputmode) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSCmdlet.ShouldProcess("analyticsprofile", "Update Analytics configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type analyticsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAnalyticsprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAnalyticsprofile: Finished"
    }
}

function Invoke-ADCAddAnalyticsprofile {
    <#
    .SYNOPSIS
        Add Analytics configuration Object.
    .DESCRIPTION
        Configuration for Analytics profile resource.
    .PARAMETER Name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER Collectors 
        The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced. 
    .PARAMETER Type 
        This option indicates what information needs to be collected and exported. 
        Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
    .PARAMETER Httpclientsidemeasurements 
        On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httppagetracking 
        On enabling this option, the Citrix ADC will link the embedded objects of a page together. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurl 
        On enabling this option, the Citrix ADC will log the URL in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httphost 
        On enabling this option, the Citrix ADC will log the Host header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpmethod 
        On enabling this option, the Citrix ADC will log the method header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpreferer 
        On enabling this option, the Citrix ADC will log the referer header in appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpuseragent 
        On enabling this option, the Citrix ADC will log User-Agent header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcookie 
        On enabling this option, the Citrix ADC will log cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httplocation 
        On enabling this option, the Citrix ADC will log location header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Urlcategory 
        On enabling this option, the Citrix ADC will send the URL category record. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Allhttpheaders 
        On enabling this option, the Citrix ADC will log all the request and response headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpcontenttype 
        On enabling this option, the Citrix ADC will log content-length header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpauthentication 
        On enabling this option, the Citrix ADC will log Authentication header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpvia 
        On enabling this option, the Citrix ADC will Via header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpxforwardedforheader 
        On enabling this option, the Citrix ADC will log X-Forwarded-For header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie 
        On enabling this option, the Citrix ADC will log set-cookie header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpsetcookie2 
        On enabling this option, the Citrix ADC will log set-cookie2 header. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpdomainname 
        On enabling this option, the Citrix ADC will log domain name. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Httpurlquery 
        On enabling this option, the Citrix ADC will log URL Query. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tcpburstreporting 
        On enabling this option, the Citrix ADC will log TCP burst parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Cqareporting 
        On enabling this option, the Citrix ADC will log TCP CQA parameters. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Integratedcache 
        On enabling this option, the Citrix ADC will log the Integrated Caching appflow records. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Grpcstatus 
        On enabling this option, the Citrix ADC will log the gRPC status headers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Outputmode 
        This option indicates the format of REST API POST body. It depends on the consumer of the analytics data. 
        Possible values = avro, prometheus, influx 
    .PARAMETER Metrics 
        This option indicates the whether metrics should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Events 
        This option indicates the whether events should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Auditlogs 
        This option indicates the whether auditlog should be sent to the REST collector. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created analyticsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAnalyticsprofile -name <string> -type <string>
        An example how to add analyticsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAnalyticsprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Collectors,

        [Parameter(Mandatory)]
        [ValidateSet('global', 'webinsight', 'tcpinsight', 'securityinsight', 'videoinsight', 'hdxinsight', 'gatewayinsight', 'timeseries', 'lsninsight', 'botinsight', 'CIinsight')]
        [string]$Type,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpclientsidemeasurements = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httppagetracking = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurl = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httphost = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpmethod = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpreferer = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpuseragent = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcookie = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httplocation = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Urlcategory = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Allhttpheaders = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpcontenttype = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpauthentication = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpvia = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpxforwardedforheader = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpsetcookie2 = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpdomainname = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Httpurlquery = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpburstreporting = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Cqareporting = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Integratedcache = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Grpcstatus = 'DISABLED',

        [ValidateSet('avro', 'prometheus', 'influx')]
        [string]$Outputmode = 'avro',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Metrics = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Events = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Auditlogs = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAnalyticsprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('collectors') ) { $payload.Add('collectors', $collectors) }
            if ( $PSBoundParameters.ContainsKey('httpclientsidemeasurements') ) { $payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ( $PSBoundParameters.ContainsKey('httppagetracking') ) { $payload.Add('httppagetracking', $httppagetracking) }
            if ( $PSBoundParameters.ContainsKey('httpurl') ) { $payload.Add('httpurl', $httpurl) }
            if ( $PSBoundParameters.ContainsKey('httphost') ) { $payload.Add('httphost', $httphost) }
            if ( $PSBoundParameters.ContainsKey('httpmethod') ) { $payload.Add('httpmethod', $httpmethod) }
            if ( $PSBoundParameters.ContainsKey('httpreferer') ) { $payload.Add('httpreferer', $httpreferer) }
            if ( $PSBoundParameters.ContainsKey('httpuseragent') ) { $payload.Add('httpuseragent', $httpuseragent) }
            if ( $PSBoundParameters.ContainsKey('httpcookie') ) { $payload.Add('httpcookie', $httpcookie) }
            if ( $PSBoundParameters.ContainsKey('httplocation') ) { $payload.Add('httplocation', $httplocation) }
            if ( $PSBoundParameters.ContainsKey('urlcategory') ) { $payload.Add('urlcategory', $urlcategory) }
            if ( $PSBoundParameters.ContainsKey('allhttpheaders') ) { $payload.Add('allhttpheaders', $allhttpheaders) }
            if ( $PSBoundParameters.ContainsKey('httpcontenttype') ) { $payload.Add('httpcontenttype', $httpcontenttype) }
            if ( $PSBoundParameters.ContainsKey('httpauthentication') ) { $payload.Add('httpauthentication', $httpauthentication) }
            if ( $PSBoundParameters.ContainsKey('httpvia') ) { $payload.Add('httpvia', $httpvia) }
            if ( $PSBoundParameters.ContainsKey('httpxforwardedforheader') ) { $payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie') ) { $payload.Add('httpsetcookie', $httpsetcookie) }
            if ( $PSBoundParameters.ContainsKey('httpsetcookie2') ) { $payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ( $PSBoundParameters.ContainsKey('httpdomainname') ) { $payload.Add('httpdomainname', $httpdomainname) }
            if ( $PSBoundParameters.ContainsKey('httpurlquery') ) { $payload.Add('httpurlquery', $httpurlquery) }
            if ( $PSBoundParameters.ContainsKey('tcpburstreporting') ) { $payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ( $PSBoundParameters.ContainsKey('cqareporting') ) { $payload.Add('cqareporting', $cqareporting) }
            if ( $PSBoundParameters.ContainsKey('integratedcache') ) { $payload.Add('integratedcache', $integratedcache) }
            if ( $PSBoundParameters.ContainsKey('grpcstatus') ) { $payload.Add('grpcstatus', $grpcstatus) }
            if ( $PSBoundParameters.ContainsKey('outputmode') ) { $payload.Add('outputmode', $outputmode) }
            if ( $PSBoundParameters.ContainsKey('metrics') ) { $payload.Add('metrics', $metrics) }
            if ( $PSBoundParameters.ContainsKey('events') ) { $payload.Add('events', $events) }
            if ( $PSBoundParameters.ContainsKey('auditlogs') ) { $payload.Add('auditlogs', $auditlogs) }
            if ( $PSCmdlet.ShouldProcess("analyticsprofile", "Add Analytics configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type analyticsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAnalyticsprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAnalyticsprofile: Finished"
    }
}

function Invoke-ADCGetAnalyticsprofile {
    <#
    .SYNOPSIS
        Get Analytics configuration object(s).
    .DESCRIPTION
        Configuration for Analytics profile resource.
    .PARAMETER Name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retrieve all analyticsprofile object(s).
    .PARAMETER Count
        If specified, the count of the analyticsprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAnalyticsprofile -GetAll 
        Get all analyticsprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAnalyticsprofile -Count 
        Get the number of analyticsprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsprofile -name <string>
        Get analyticsprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAnalyticsprofile -Filter @{ 'name'='<value>' }
        Get analyticsprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAnalyticsprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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
        Write-Verbose "Invoke-ADCGetAnalyticsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all analyticsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving analyticsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAnalyticsprofile: Ended"
    }
}


