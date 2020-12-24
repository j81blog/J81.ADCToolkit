function Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding {
<#
    .SYNOPSIS
        Add Analytics configuration Object
    .DESCRIPTION
        Add Analytics configuration Object 
    .PARAMETER analyticsprofile 
        Name of the analytics profile bound. 
    .PARAMETER PassThru 
        Return details about the created analyticsglobal_analyticsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding -analyticsprofile <string>
    .NOTES
        File Name : Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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
        [string]$analyticsprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAnalyticsglobalanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                analyticsprofile = $analyticsprofile
            }

 
            if ($PSCmdlet.ShouldProcess("analyticsglobal_analyticsprofile_binding", "Add Analytics configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type analyticsglobal_analyticsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Filter $Payload)
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
        Delete Analytics configuration Object
    .DESCRIPTION
        Delete Analytics configuration Object
     .PARAMETER analyticsprofile 
       Name of the analytics profile bound.
    .EXAMPLE
        Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding 
    .NOTES
        File Name : Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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

        [string]$analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteAnalyticsglobalanalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Arguments.Add('analyticsprofile', $analyticsprofile) }
            if ($PSCmdlet.ShouldProcess("analyticsglobal_analyticsprofile_binding", "Delete Analytics configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type analyticsglobal_analyticsprofile_binding -Resource $ -Arguments $Arguments
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
        Get Analytics configuration object(s)
    .DESCRIPTION
        Get Analytics configuration object(s)
    .PARAMETER GetAll 
        Retreive all analyticsglobal_analyticsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the analyticsglobal_analyticsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCGetAnalyticsglobalanalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all analyticsglobal_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsglobal_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving analyticsglobal_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_analyticsprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Analytics configuration object(s)
    .DESCRIPTION
        Get Analytics configuration object(s)
    .PARAMETER GetAll 
        Retreive all analyticsglobal_binding object(s)
    .PARAMETER Count
        If specified, the count of the analyticsglobal_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalbinding
    .EXAMPLE 
        Invoke-ADCGetAnalyticsglobalbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAnalyticsglobalbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAnalyticsglobalbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsglobal_binding/
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
        Write-Verbose "Invoke-ADCGetAnalyticsglobalbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all analyticsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsglobal_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsglobal_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsglobal_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving analyticsglobal_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsglobal_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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

function Invoke-ADCAddAnalyticsprofile {
<#
    .SYNOPSIS
        Add Analytics configuration Object
    .DESCRIPTION
        Add Analytics configuration Object 
    .PARAMETER name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER collectors 
        The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced.  
        Minimum length = 1 
    .PARAMETER type 
        This option indicates what information needs to be collected and exported.  
        Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
    .PARAMETER httpclientsidemeasurements 
        On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httppagetracking 
        On enabling this option, the Citrix ADC will link the embedded objects of a page together.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpurl 
        On enabling this option, the Citrix ADC will log the URL in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httphost 
        On enabling this option, the Citrix ADC will log the Host header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpmethod 
        On enabling this option, the Citrix ADC will log the method header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpreferer 
        On enabling this option, the Citrix ADC will log the referer header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpuseragent 
        On enabling this option, the Citrix ADC will log User-Agent header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpcookie 
        On enabling this option, the Citrix ADC will log cookie header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httplocation 
        On enabling this option, the Citrix ADC will log location header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlcategory 
        On enabling this option, the Citrix ADC will send the URL category record.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER allhttpheaders 
        On enabling this option, the Citrix ADC will log all the request and response headers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpcontenttype 
        On enabling this option, the Citrix ADC will log content-length header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpauthentication 
        On enabling this option, the Citrix ADC will log Authentication header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpvia 
        On enabling this option, the Citrix ADC will Via header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpxforwardedforheader 
        On enabling this option, the Citrix ADC will log X-Forwarded-For header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie 
        On enabling this option, the Citrix ADC will log set-cookie header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie2 
        On enabling this option, the Citrix ADC will log set-cookie2 header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpdomainname 
        On enabling this option, the Citrix ADC will log domain name.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpurlquery 
        On enabling this option, the Citrix ADC will log URL Query.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpburstreporting 
        On enabling this option, the Citrix ADC will log TCP burst parameters.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cqareporting 
        On enabling this option, the Citrix ADC will log TCP CQA parameters.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER integratedcache 
        On enabling this option, the Citrix ADC will log the Integrated Caching appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER grpcstatus 
        On enabling this option, the Citrix ADC will log the gRPC status headers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER outputmode 
        This option indicates the format of REST API POST body. It depends on the consumer of the analytics data.  
        Default value: avro,  
        Possible values = avro, prometheus, influx 
    .PARAMETER metrics 
        This option indicates the whether metrics should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER events 
        This option indicates the whether events should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER auditlogs 
        This option indicates the whether auditlog should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER aaainsight 
        On enabling this option, the Citrix ADC will send the AAA Insight record.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created analyticsprofile item.
    .EXAMPLE
        Invoke-ADCAddAnalyticsprofile -name <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddAnalyticsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$collectors ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('global', 'webinsight', 'tcpinsight', 'securityinsight', 'videoinsight', 'hdxinsight', 'gatewayinsight', 'timeseries', 'lsninsight', 'botinsight', 'CIinsight')]
        [string]$type ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpclientsidemeasurements = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httppagetracking = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpurl = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httphost = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpmethod = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpreferer = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpuseragent = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcookie = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httplocation = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlcategory = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$allhttpheaders = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcontenttype = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpauthentication = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpvia = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpxforwardedforheader = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie2 = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpdomainname = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpurlquery = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tcpburstreporting = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cqareporting = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$integratedcache = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$grpcstatus = 'DISABLED' ,

        [ValidateSet('avro', 'prometheus', 'influx')]
        [string]$outputmode = 'avro' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$metrics = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$events = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$auditlogs = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$aaainsight = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAnalyticsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('collectors')) { $Payload.Add('collectors', $collectors) }
            if ($PSBoundParameters.ContainsKey('httpclientsidemeasurements')) { $Payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('httppagetracking')) { $Payload.Add('httppagetracking', $httppagetracking) }
            if ($PSBoundParameters.ContainsKey('httpurl')) { $Payload.Add('httpurl', $httpurl) }
            if ($PSBoundParameters.ContainsKey('httphost')) { $Payload.Add('httphost', $httphost) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('httpreferer')) { $Payload.Add('httpreferer', $httpreferer) }
            if ($PSBoundParameters.ContainsKey('httpuseragent')) { $Payload.Add('httpuseragent', $httpuseragent) }
            if ($PSBoundParameters.ContainsKey('httpcookie')) { $Payload.Add('httpcookie', $httpcookie) }
            if ($PSBoundParameters.ContainsKey('httplocation')) { $Payload.Add('httplocation', $httplocation) }
            if ($PSBoundParameters.ContainsKey('urlcategory')) { $Payload.Add('urlcategory', $urlcategory) }
            if ($PSBoundParameters.ContainsKey('allhttpheaders')) { $Payload.Add('allhttpheaders', $allhttpheaders) }
            if ($PSBoundParameters.ContainsKey('httpcontenttype')) { $Payload.Add('httpcontenttype', $httpcontenttype) }
            if ($PSBoundParameters.ContainsKey('httpauthentication')) { $Payload.Add('httpauthentication', $httpauthentication) }
            if ($PSBoundParameters.ContainsKey('httpvia')) { $Payload.Add('httpvia', $httpvia) }
            if ($PSBoundParameters.ContainsKey('httpxforwardedforheader')) { $Payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie')) { $Payload.Add('httpsetcookie', $httpsetcookie) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie2')) { $Payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ($PSBoundParameters.ContainsKey('httpdomainname')) { $Payload.Add('httpdomainname', $httpdomainname) }
            if ($PSBoundParameters.ContainsKey('httpurlquery')) { $Payload.Add('httpurlquery', $httpurlquery) }
            if ($PSBoundParameters.ContainsKey('tcpburstreporting')) { $Payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ($PSBoundParameters.ContainsKey('cqareporting')) { $Payload.Add('cqareporting', $cqareporting) }
            if ($PSBoundParameters.ContainsKey('integratedcache')) { $Payload.Add('integratedcache', $integratedcache) }
            if ($PSBoundParameters.ContainsKey('grpcstatus')) { $Payload.Add('grpcstatus', $grpcstatus) }
            if ($PSBoundParameters.ContainsKey('outputmode')) { $Payload.Add('outputmode', $outputmode) }
            if ($PSBoundParameters.ContainsKey('metrics')) { $Payload.Add('metrics', $metrics) }
            if ($PSBoundParameters.ContainsKey('events')) { $Payload.Add('events', $events) }
            if ($PSBoundParameters.ContainsKey('auditlogs')) { $Payload.Add('auditlogs', $auditlogs) }
            if ($PSBoundParameters.ContainsKey('aaainsight')) { $Payload.Add('aaainsight', $aaainsight) }
 
            if ($PSCmdlet.ShouldProcess("analyticsprofile", "Add Analytics configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type analyticsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAnalyticsprofile -Filter $Payload)
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

function Invoke-ADCUpdateAnalyticsprofile {
<#
    .SYNOPSIS
        Update Analytics configuration Object
    .DESCRIPTION
        Update Analytics configuration Object 
    .PARAMETER name 
        Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters. 
    .PARAMETER collectors 
        The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced.  
        Minimum length = 1 
    .PARAMETER type 
        This option indicates what information needs to be collected and exported.  
        Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
    .PARAMETER httpclientsidemeasurements 
        On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httppagetracking 
        On enabling this option, the Citrix ADC will link the embedded objects of a page together.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpurl 
        On enabling this option, the Citrix ADC will log the URL in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httphost 
        On enabling this option, the Citrix ADC will log the Host header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpmethod 
        On enabling this option, the Citrix ADC will log the method header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpreferer 
        On enabling this option, the Citrix ADC will log the referer header in appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpuseragent 
        On enabling this option, the Citrix ADC will log User-Agent header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpcookie 
        On enabling this option, the Citrix ADC will log cookie header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httplocation 
        On enabling this option, the Citrix ADC will log location header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER urlcategory 
        On enabling this option, the Citrix ADC will send the URL category record.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER allhttpheaders 
        On enabling this option, the Citrix ADC will log all the request and response headers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpcontenttype 
        On enabling this option, the Citrix ADC will log content-length header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpauthentication 
        On enabling this option, the Citrix ADC will log Authentication header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpvia 
        On enabling this option, the Citrix ADC will Via header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpxforwardedforheader 
        On enabling this option, the Citrix ADC will log X-Forwarded-For header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie 
        On enabling this option, the Citrix ADC will log set-cookie header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpsetcookie2 
        On enabling this option, the Citrix ADC will log set-cookie2 header.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpdomainname 
        On enabling this option, the Citrix ADC will log domain name.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER httpurlquery 
        On enabling this option, the Citrix ADC will log URL Query.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tcpburstreporting 
        On enabling this option, the Citrix ADC will log TCP burst parameters.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER cqareporting 
        On enabling this option, the Citrix ADC will log TCP CQA parameters.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER integratedcache 
        On enabling this option, the Citrix ADC will log the Integrated Caching appflow records.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER grpcstatus 
        On enabling this option, the Citrix ADC will log the gRPC status headers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER outputmode 
        This option indicates the format of REST API POST body. It depends on the consumer of the analytics data.  
        Default value: avro,  
        Possible values = avro, prometheus, influx 
    .PARAMETER metrics 
        This option indicates the whether metrics should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER events 
        This option indicates the whether events should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER auditlogs 
        This option indicates the whether auditlog should be sent to the REST collector.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER aaainsight 
        On enabling this option, the Citrix ADC will send the AAA Insight record.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created analyticsprofile item.
    .EXAMPLE
        Invoke-ADCUpdateAnalyticsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAnalyticsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$collectors ,

        [ValidateSet('global', 'webinsight', 'tcpinsight', 'securityinsight', 'videoinsight', 'hdxinsight', 'gatewayinsight', 'timeseries', 'lsninsight', 'botinsight', 'CIinsight')]
        [string]$type ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpclientsidemeasurements ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httppagetracking ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httphost ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpmethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpreferer ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpuseragent ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httplocation ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$urlcategory ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$allhttpheaders ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpcontenttype ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpauthentication ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpvia ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpxforwardedforheader ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpsetcookie2 ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpdomainname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$httpurlquery ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tcpburstreporting ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$cqareporting ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$integratedcache ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$grpcstatus ,

        [ValidateSet('avro', 'prometheus', 'influx')]
        [string]$outputmode ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$metrics ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$events ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$auditlogs ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$aaainsight ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAnalyticsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('collectors')) { $Payload.Add('collectors', $collectors) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('httpclientsidemeasurements')) { $Payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('httppagetracking')) { $Payload.Add('httppagetracking', $httppagetracking) }
            if ($PSBoundParameters.ContainsKey('httpurl')) { $Payload.Add('httpurl', $httpurl) }
            if ($PSBoundParameters.ContainsKey('httphost')) { $Payload.Add('httphost', $httphost) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('httpreferer')) { $Payload.Add('httpreferer', $httpreferer) }
            if ($PSBoundParameters.ContainsKey('httpuseragent')) { $Payload.Add('httpuseragent', $httpuseragent) }
            if ($PSBoundParameters.ContainsKey('httpcookie')) { $Payload.Add('httpcookie', $httpcookie) }
            if ($PSBoundParameters.ContainsKey('httplocation')) { $Payload.Add('httplocation', $httplocation) }
            if ($PSBoundParameters.ContainsKey('urlcategory')) { $Payload.Add('urlcategory', $urlcategory) }
            if ($PSBoundParameters.ContainsKey('allhttpheaders')) { $Payload.Add('allhttpheaders', $allhttpheaders) }
            if ($PSBoundParameters.ContainsKey('httpcontenttype')) { $Payload.Add('httpcontenttype', $httpcontenttype) }
            if ($PSBoundParameters.ContainsKey('httpauthentication')) { $Payload.Add('httpauthentication', $httpauthentication) }
            if ($PSBoundParameters.ContainsKey('httpvia')) { $Payload.Add('httpvia', $httpvia) }
            if ($PSBoundParameters.ContainsKey('httpxforwardedforheader')) { $Payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie')) { $Payload.Add('httpsetcookie', $httpsetcookie) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie2')) { $Payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ($PSBoundParameters.ContainsKey('httpdomainname')) { $Payload.Add('httpdomainname', $httpdomainname) }
            if ($PSBoundParameters.ContainsKey('httpurlquery')) { $Payload.Add('httpurlquery', $httpurlquery) }
            if ($PSBoundParameters.ContainsKey('tcpburstreporting')) { $Payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ($PSBoundParameters.ContainsKey('cqareporting')) { $Payload.Add('cqareporting', $cqareporting) }
            if ($PSBoundParameters.ContainsKey('integratedcache')) { $Payload.Add('integratedcache', $integratedcache) }
            if ($PSBoundParameters.ContainsKey('grpcstatus')) { $Payload.Add('grpcstatus', $grpcstatus) }
            if ($PSBoundParameters.ContainsKey('outputmode')) { $Payload.Add('outputmode', $outputmode) }
            if ($PSBoundParameters.ContainsKey('metrics')) { $Payload.Add('metrics', $metrics) }
            if ($PSBoundParameters.ContainsKey('events')) { $Payload.Add('events', $events) }
            if ($PSBoundParameters.ContainsKey('auditlogs')) { $Payload.Add('auditlogs', $auditlogs) }
            if ($PSBoundParameters.ContainsKey('aaainsight')) { $Payload.Add('aaainsight', $aaainsight) }
 
            if ($PSCmdlet.ShouldProcess("analyticsprofile", "Update Analytics configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type analyticsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAnalyticsprofile -Filter $Payload)
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

function Invoke-ADCUnsetAnalyticsprofile {
<#
    .SYNOPSIS
        Unset Analytics configuration Object
    .DESCRIPTION
        Unset Analytics configuration Object 
   .PARAMETER name 
       Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
   .PARAMETER collectors 
       The collector can be an IP, an appflow collector name, a service or a vserver. If IP is specified, the transport is considered as logstream and default port of 5557 is taken. If collector name is specified, the collector properties are taken from the configured collector. If service is specified, the configured service is assumed as the collector. If vserver is specified, the services bound to it are considered as collectors and the records are load balanced. 
   .PARAMETER type 
       This option indicates what information needs to be collected and exported.  
       Possible values = global, webinsight, tcpinsight, securityinsight, videoinsight, hdxinsight, gatewayinsight, timeseries, lsninsight, botinsight, CIinsight 
   .PARAMETER httpclientsidemeasurements 
       On enabling this option, the Citrix ADC will insert a javascript into the HTTP response to collect the client side page-timings and will send the same to the configured collectors.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httppagetracking 
       On enabling this option, the Citrix ADC will link the embedded objects of a page together.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpurl 
       On enabling this option, the Citrix ADC will log the URL in appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httphost 
       On enabling this option, the Citrix ADC will log the Host header in appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpmethod 
       On enabling this option, the Citrix ADC will log the method header in appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpreferer 
       On enabling this option, the Citrix ADC will log the referer header in appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpuseragent 
       On enabling this option, the Citrix ADC will log User-Agent header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpcookie 
       On enabling this option, the Citrix ADC will log cookie header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httplocation 
       On enabling this option, the Citrix ADC will log location header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER urlcategory 
       On enabling this option, the Citrix ADC will send the URL category record.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER allhttpheaders 
       On enabling this option, the Citrix ADC will log all the request and response headers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpcontenttype 
       On enabling this option, the Citrix ADC will log content-length header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpauthentication 
       On enabling this option, the Citrix ADC will log Authentication header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpvia 
       On enabling this option, the Citrix ADC will Via header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpxforwardedforheader 
       On enabling this option, the Citrix ADC will log X-Forwarded-For header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpsetcookie 
       On enabling this option, the Citrix ADC will log set-cookie header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpsetcookie2 
       On enabling this option, the Citrix ADC will log set-cookie2 header.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpdomainname 
       On enabling this option, the Citrix ADC will log domain name.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER httpurlquery 
       On enabling this option, the Citrix ADC will log URL Query.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tcpburstreporting 
       On enabling this option, the Citrix ADC will log TCP burst parameters.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER cqareporting 
       On enabling this option, the Citrix ADC will log TCP CQA parameters.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER integratedcache 
       On enabling this option, the Citrix ADC will log the Integrated Caching appflow records.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER grpcstatus 
       On enabling this option, the Citrix ADC will log the gRPC status headers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER outputmode 
       This option indicates the format of REST API POST body. It depends on the consumer of the analytics data.  
       Possible values = avro, prometheus, influx 
   .PARAMETER metrics 
       This option indicates the whether metrics should be sent to the REST collector.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER events 
       This option indicates the whether events should be sent to the REST collector.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER auditlogs 
       This option indicates the whether auditlog should be sent to the REST collector.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER aaainsight 
       On enabling this option, the Citrix ADC will send the AAA Insight record.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetAnalyticsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAnalyticsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile
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

        [Boolean]$collectors ,

        [Boolean]$type ,

        [Boolean]$httpclientsidemeasurements ,

        [Boolean]$httppagetracking ,

        [Boolean]$httpurl ,

        [Boolean]$httphost ,

        [Boolean]$httpmethod ,

        [Boolean]$httpreferer ,

        [Boolean]$httpuseragent ,

        [Boolean]$httpcookie ,

        [Boolean]$httplocation ,

        [Boolean]$urlcategory ,

        [Boolean]$allhttpheaders ,

        [Boolean]$httpcontenttype ,

        [Boolean]$httpauthentication ,

        [Boolean]$httpvia ,

        [Boolean]$httpxforwardedforheader ,

        [Boolean]$httpsetcookie ,

        [Boolean]$httpsetcookie2 ,

        [Boolean]$httpdomainname ,

        [Boolean]$httpurlquery ,

        [Boolean]$tcpburstreporting ,

        [Boolean]$cqareporting ,

        [Boolean]$integratedcache ,

        [Boolean]$grpcstatus ,

        [Boolean]$outputmode ,

        [Boolean]$metrics ,

        [Boolean]$events ,

        [Boolean]$auditlogs ,

        [Boolean]$aaainsight 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAnalyticsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('collectors')) { $Payload.Add('collectors', $collectors) }
            if ($PSBoundParameters.ContainsKey('type')) { $Payload.Add('type', $type) }
            if ($PSBoundParameters.ContainsKey('httpclientsidemeasurements')) { $Payload.Add('httpclientsidemeasurements', $httpclientsidemeasurements) }
            if ($PSBoundParameters.ContainsKey('httppagetracking')) { $Payload.Add('httppagetracking', $httppagetracking) }
            if ($PSBoundParameters.ContainsKey('httpurl')) { $Payload.Add('httpurl', $httpurl) }
            if ($PSBoundParameters.ContainsKey('httphost')) { $Payload.Add('httphost', $httphost) }
            if ($PSBoundParameters.ContainsKey('httpmethod')) { $Payload.Add('httpmethod', $httpmethod) }
            if ($PSBoundParameters.ContainsKey('httpreferer')) { $Payload.Add('httpreferer', $httpreferer) }
            if ($PSBoundParameters.ContainsKey('httpuseragent')) { $Payload.Add('httpuseragent', $httpuseragent) }
            if ($PSBoundParameters.ContainsKey('httpcookie')) { $Payload.Add('httpcookie', $httpcookie) }
            if ($PSBoundParameters.ContainsKey('httplocation')) { $Payload.Add('httplocation', $httplocation) }
            if ($PSBoundParameters.ContainsKey('urlcategory')) { $Payload.Add('urlcategory', $urlcategory) }
            if ($PSBoundParameters.ContainsKey('allhttpheaders')) { $Payload.Add('allhttpheaders', $allhttpheaders) }
            if ($PSBoundParameters.ContainsKey('httpcontenttype')) { $Payload.Add('httpcontenttype', $httpcontenttype) }
            if ($PSBoundParameters.ContainsKey('httpauthentication')) { $Payload.Add('httpauthentication', $httpauthentication) }
            if ($PSBoundParameters.ContainsKey('httpvia')) { $Payload.Add('httpvia', $httpvia) }
            if ($PSBoundParameters.ContainsKey('httpxforwardedforheader')) { $Payload.Add('httpxforwardedforheader', $httpxforwardedforheader) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie')) { $Payload.Add('httpsetcookie', $httpsetcookie) }
            if ($PSBoundParameters.ContainsKey('httpsetcookie2')) { $Payload.Add('httpsetcookie2', $httpsetcookie2) }
            if ($PSBoundParameters.ContainsKey('httpdomainname')) { $Payload.Add('httpdomainname', $httpdomainname) }
            if ($PSBoundParameters.ContainsKey('httpurlquery')) { $Payload.Add('httpurlquery', $httpurlquery) }
            if ($PSBoundParameters.ContainsKey('tcpburstreporting')) { $Payload.Add('tcpburstreporting', $tcpburstreporting) }
            if ($PSBoundParameters.ContainsKey('cqareporting')) { $Payload.Add('cqareporting', $cqareporting) }
            if ($PSBoundParameters.ContainsKey('integratedcache')) { $Payload.Add('integratedcache', $integratedcache) }
            if ($PSBoundParameters.ContainsKey('grpcstatus')) { $Payload.Add('grpcstatus', $grpcstatus) }
            if ($PSBoundParameters.ContainsKey('outputmode')) { $Payload.Add('outputmode', $outputmode) }
            if ($PSBoundParameters.ContainsKey('metrics')) { $Payload.Add('metrics', $metrics) }
            if ($PSBoundParameters.ContainsKey('events')) { $Payload.Add('events', $events) }
            if ($PSBoundParameters.ContainsKey('auditlogs')) { $Payload.Add('auditlogs', $auditlogs) }
            if ($PSBoundParameters.ContainsKey('aaainsight')) { $Payload.Add('aaainsight', $aaainsight) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Analytics configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type analyticsprofile -Action unset -Payload $Payload -GetWarning
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

function Invoke-ADCDeleteAnalyticsprofile {
<#
    .SYNOPSIS
        Delete Analytics configuration Object
    .DESCRIPTION
        Delete Analytics configuration Object
    .PARAMETER name 
       Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .EXAMPLE
        Invoke-ADCDeleteAnalyticsprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAnalyticsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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
        Write-Verbose "Invoke-ADCDeleteAnalyticsprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Analytics configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type analyticsprofile -Resource $name -Arguments $Arguments
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

function Invoke-ADCGetAnalyticsprofile {
<#
    .SYNOPSIS
        Get Analytics configuration object(s)
    .DESCRIPTION
        Get Analytics configuration object(s)
    .PARAMETER name 
       Name for the analytics profile. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
       (@), equals (=), and hyphen (-) characters. 
    .PARAMETER GetAll 
        Retreive all analyticsprofile object(s)
    .PARAMETER Count
        If specified, the count of the analyticsprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAnalyticsprofile
    .EXAMPLE 
        Invoke-ADCGetAnalyticsprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAnalyticsprofile -Count
    .EXAMPLE
        Invoke-ADCGetAnalyticsprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetAnalyticsprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAnalyticsprofile
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/analytics/analyticsprofile/
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
        Write-Verbose "Invoke-ADCGetAnalyticsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all analyticsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for analyticsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving analyticsprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving analyticsprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving analyticsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type analyticsprofile -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


