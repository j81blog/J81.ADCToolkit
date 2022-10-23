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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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
        Version   : v2210.2317
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

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDFRIp0Cm57kPLj
# e8HgZ9egNi9d40EEUG54Us8TeZbwzqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# IgQgbqGoz4FEbdSiM07jLKxt4dNA/FVpX/k5nSGTAVLWfjYwDQYJKoZIhvcNAQEB
# BQAEggEAg5+THKBb1/zg9Qv7X4nFLnoYR/9+SoKKUFr2OdNGoKA/69wDTyVxT+2X
# I1XtmzhJjftVKZW2aJ+5v3tMPqxZp6Lq/xVoF+lsD4W+UQPlBnzudtyWTVcIOmYZ
# nl5wiL4Q3aCvChc98rfaCZCNlaNwfZPvk/XnoQFNPnAYBk+hR0EI44dICR3xbErr
# hx1ppCXvVsKMExVem3PqxNkPU0y/R8cyk11dSDKDtze0y9TNyhX7vTVMGZyqpF1K
# Gj9bgUo5HH2hgvK1sqUKT1WowxgUsjVGi2ziLlPtVUfTPsfTd6I3jwQBO4vErZi2
# nHBkg7M1cfiTIDCXJiUA5Z9a/Ee1Ng==
# SIG # End signature block
