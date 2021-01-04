function Invoke-ADCAddStreamidentifier {
<#
    .SYNOPSIS
        Add Stream configuration Object
    .DESCRIPTION
        Add Stream configuration Object 
    .PARAMETER name 
        The name of stream identifier. 
    .PARAMETER selectorname 
        Name of the selector to use with the stream identifier.  
        Minimum length = 1 
    .PARAMETER interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n).  
        Default value: REQUESTS  
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER snmptrap 
        Enable/disable SNMP trap for stream identifier.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER appflowlog 
        Enable/disable Appflow logging for stream identifier.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime.  
        By default transaction tracking is disabled.  
        Default value: NONE  
        Possible values = RESPTIME, NONE 
    .PARAMETER maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute.  
        Default value: 0 
    .PARAMETER mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute.  
        Default value: 0 
    .PARAMETER acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent.  
        Maximum of 6 decimal places is supported.  
        Default value: 0.000000  
        Maximum length = 10 
    .PARAMETER breachthreshold 
        Breaching transactions threshold calculated over interval.  
        Default value: 0 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        Invoke-ADCAddStreamidentifier -name <string> -selectorname <string>
    .NOTES
        File Name : Invoke-ADCAddStreamidentifier
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        [string]$selectorname ,

        [double]$interval = '1' ,

        [ValidateRange(1, 65535)]
        [double]$samplecount = '1' ,

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$sort = 'REQUESTS' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snmptrap = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$trackackonlypackets = 'DISABLED' ,

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$tracktransactions = 'NONE' ,

        [double]$maxtransactionthreshold = '0' ,

        [double]$mintransactionthreshold = '0' ,

        [string]$acceptancethreshold = '0.000000' ,

        [double]$breachthreshold = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddStreamidentifier: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                selectorname = $selectorname
            }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('samplecount')) { $Payload.Add('samplecount', $samplecount) }
            if ($PSBoundParameters.ContainsKey('sort')) { $Payload.Add('sort', $sort) }
            if ($PSBoundParameters.ContainsKey('snmptrap')) { $Payload.Add('snmptrap', $snmptrap) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('trackackonlypackets')) { $Payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ($PSBoundParameters.ContainsKey('tracktransactions')) { $Payload.Add('tracktransactions', $tracktransactions) }
            if ($PSBoundParameters.ContainsKey('maxtransactionthreshold')) { $Payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('mintransactionthreshold')) { $Payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('acceptancethreshold')) { $Payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ($PSBoundParameters.ContainsKey('breachthreshold')) { $Payload.Add('breachthreshold', $breachthreshold) }
 
            if ($PSCmdlet.ShouldProcess("streamidentifier", "Add Stream configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamidentifier -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetStreamidentifier -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddStreamidentifier: Finished"
    }
}

function Invoke-ADCUpdateStreamidentifier {
<#
    .SYNOPSIS
        Update Stream configuration Object
    .DESCRIPTION
        Update Stream configuration Object 
    .PARAMETER name 
        The name of stream identifier. 
    .PARAMETER selectorname 
        Name of the selector to use with the stream identifier.  
        Minimum length = 1 
    .PARAMETER interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals.  
        Default value: 1  
        Minimum value = 1 
    .PARAMETER samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 65535 
    .PARAMETER sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n).  
        Default value: REQUESTS  
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER snmptrap 
        Enable/disable SNMP trap for stream identifier.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER appflowlog 
        Enable/disable Appflow logging for stream identifier.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime.  
        By default transaction tracking is disabled.  
        Default value: NONE  
        Possible values = RESPTIME, NONE 
    .PARAMETER maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute.  
        Default value: 0 
    .PARAMETER mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute.  
        Default value: 0 
    .PARAMETER acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent.  
        Maximum of 6 decimal places is supported.  
        Default value: 0.000000  
        Maximum length = 10 
    .PARAMETER breachthreshold 
        Breaching transactions threshold calculated over interval.  
        Default value: 0 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        Invoke-ADCUpdateStreamidentifier -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateStreamidentifier
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$selectorname ,

        [double]$interval ,

        [ValidateRange(1, 65535)]
        [double]$samplecount ,

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$sort ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$snmptrap ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$trackackonlypackets ,

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$tracktransactions ,

        [double]$maxtransactionthreshold ,

        [double]$mintransactionthreshold ,

        [string]$acceptancethreshold ,

        [double]$breachthreshold ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateStreamidentifier: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('selectorname')) { $Payload.Add('selectorname', $selectorname) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('samplecount')) { $Payload.Add('samplecount', $samplecount) }
            if ($PSBoundParameters.ContainsKey('sort')) { $Payload.Add('sort', $sort) }
            if ($PSBoundParameters.ContainsKey('snmptrap')) { $Payload.Add('snmptrap', $snmptrap) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('trackackonlypackets')) { $Payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ($PSBoundParameters.ContainsKey('tracktransactions')) { $Payload.Add('tracktransactions', $tracktransactions) }
            if ($PSBoundParameters.ContainsKey('maxtransactionthreshold')) { $Payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('mintransactionthreshold')) { $Payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('acceptancethreshold')) { $Payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ($PSBoundParameters.ContainsKey('breachthreshold')) { $Payload.Add('breachthreshold', $breachthreshold) }
 
            if ($PSCmdlet.ShouldProcess("streamidentifier", "Update Stream configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type streamidentifier -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetStreamidentifier -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateStreamidentifier: Finished"
    }
}

function Invoke-ADCUnsetStreamidentifier {
<#
    .SYNOPSIS
        Unset Stream configuration Object
    .DESCRIPTION
        Unset Stream configuration Object 
   .PARAMETER name 
       The name of stream identifier. 
   .PARAMETER selectorname 
       Name of the selector to use with the stream identifier. 
   .PARAMETER interval 
       Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
   .PARAMETER samplecount 
       Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
   .PARAMETER sort 
       Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n).  
       Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
   .PARAMETER snmptrap 
       Enable/disable SNMP trap for stream identifier.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER appflowlog 
       Enable/disable Appflow logging for stream identifier.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER trackackonlypackets 
       Track ack only packets as well. This setting is applicable only when packet rate limiting is being used.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER tracktransactions 
       Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime.  
       By default transaction tracking is disabled.  
       Possible values = RESPTIME, NONE 
   .PARAMETER maxtransactionthreshold 
       Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
   .PARAMETER mintransactionthreshold 
       Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
   .PARAMETER acceptancethreshold 
       Non-Breaching transactions to Total transactions threshold expressed in percent.  
       Maximum of 6 decimal places is supported. 
   .PARAMETER breachthreshold 
       Breaching transactions threshold calculated over interval.
    .EXAMPLE
        Invoke-ADCUnsetStreamidentifier -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetStreamidentifier
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier
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

        [Boolean]$selectorname ,

        [Boolean]$interval ,

        [Boolean]$samplecount ,

        [Boolean]$sort ,

        [Boolean]$snmptrap ,

        [Boolean]$appflowlog ,

        [Boolean]$trackackonlypackets ,

        [Boolean]$tracktransactions ,

        [Boolean]$maxtransactionthreshold ,

        [Boolean]$mintransactionthreshold ,

        [Boolean]$acceptancethreshold ,

        [Boolean]$breachthreshold 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetStreamidentifier: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('selectorname')) { $Payload.Add('selectorname', $selectorname) }
            if ($PSBoundParameters.ContainsKey('interval')) { $Payload.Add('interval', $interval) }
            if ($PSBoundParameters.ContainsKey('samplecount')) { $Payload.Add('samplecount', $samplecount) }
            if ($PSBoundParameters.ContainsKey('sort')) { $Payload.Add('sort', $sort) }
            if ($PSBoundParameters.ContainsKey('snmptrap')) { $Payload.Add('snmptrap', $snmptrap) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('trackackonlypackets')) { $Payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ($PSBoundParameters.ContainsKey('tracktransactions')) { $Payload.Add('tracktransactions', $tracktransactions) }
            if ($PSBoundParameters.ContainsKey('maxtransactionthreshold')) { $Payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('mintransactionthreshold')) { $Payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ($PSBoundParameters.ContainsKey('acceptancethreshold')) { $Payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ($PSBoundParameters.ContainsKey('breachthreshold')) { $Payload.Add('breachthreshold', $breachthreshold) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Stream configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type streamidentifier -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetStreamidentifier: Finished"
    }
}

function Invoke-ADCDeleteStreamidentifier {
<#
    .SYNOPSIS
        Delete Stream configuration Object
    .DESCRIPTION
        Delete Stream configuration Object
    .PARAMETER name 
       The name of stream identifier. 
    .EXAMPLE
        Invoke-ADCDeleteStreamidentifier -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteStreamidentifier
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-ADCDeleteStreamidentifier: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Stream configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteStreamidentifier: Finished"
    }
}

function Invoke-ADCGetStreamidentifier {
<#
    .SYNOPSIS
        Get Stream configuration object(s)
    .DESCRIPTION
        Get Stream configuration object(s)
    .PARAMETER name 
       The name of stream identifier. 
    .PARAMETER GetAll 
        Retreive all streamidentifier object(s)
    .PARAMETER Count
        If specified, the count of the streamidentifier object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetStreamidentifier
    .EXAMPLE 
        Invoke-ADCGetStreamidentifier -GetAll 
    .EXAMPLE 
        Invoke-ADCGetStreamidentifier -Count
    .EXAMPLE
        Invoke-ADCGetStreamidentifier -name <string>
    .EXAMPLE
        Invoke-ADCGetStreamidentifier -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetStreamidentifier
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-ADCGetStreamidentifier: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetStreamidentifier: Ended"
    }
}

function Invoke-ADCGetStreamidentifierbinding {
<#
    .SYNOPSIS
        Get Stream configuration object(s)
    .DESCRIPTION
        Get Stream configuration object(s)
    .PARAMETER name 
       The name of stream identifier. 
    .PARAMETER GetAll 
        Retreive all streamidentifier_binding object(s)
    .PARAMETER Count
        If specified, the count of the streamidentifier_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetStreamidentifierbinding
    .EXAMPLE 
        Invoke-ADCGetStreamidentifierbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetStreamidentifierbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetStreamidentifierbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetStreamidentifierbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier_binding/
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
        Write-Verbose "Invoke-ADCGetStreamidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetStreamidentifierbinding: Ended"
    }
}

function Invoke-ADCGetStreamidentifierstreamsessionbinding {
<#
    .SYNOPSIS
        Get Stream configuration object(s)
    .DESCRIPTION
        Get Stream configuration object(s)
    .PARAMETER GetAll 
        Retreive all streamidentifier_streamsession_binding object(s)
    .PARAMETER Count
        If specified, the count of the streamidentifier_streamsession_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetStreamidentifierstreamsessionbinding
    .EXAMPLE 
        Invoke-ADCGetStreamidentifierstreamsessionbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetStreamidentifierstreamsessionbinding -Count
    .EXAMPLE
        Invoke-ADCGetStreamidentifierstreamsessionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetStreamidentifierstreamsessionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetStreamidentifierstreamsessionbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier_streamsession_binding/
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
        Write-Verbose "Invoke-ADCGetStreamidentifierstreamsessionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all streamidentifier_streamsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_streamsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetStreamidentifierstreamsessionbinding: Ended"
    }
}

function Invoke-ADCAddStreamselector {
<#
    .SYNOPSIS
        Add Stream configuration Object
    .DESCRIPTION
        Add Stream configuration Object 
    .PARAMETER name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL).  
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        Invoke-ADCAddStreamselector -name <string> -rule <string[]>
    .NOTES
        File Name : Invoke-ADCAddStreamselector
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$rule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddStreamselector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
            }

 
            if ($PSCmdlet.ShouldProcess("streamselector", "Add Stream configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamselector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetStreamselector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddStreamselector: Finished"
    }
}

function Invoke-ADCUpdateStreamselector {
<#
    .SYNOPSIS
        Update Stream configuration Object
    .DESCRIPTION
        Update Stream configuration Object 
    .PARAMETER name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL).  
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        Invoke-ADCUpdateStreamselector -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateStreamselector
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$rule ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateStreamselector: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
 
            if ($PSCmdlet.ShouldProcess("streamselector", "Update Stream configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type streamselector -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetStreamselector -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateStreamselector: Finished"
    }
}

function Invoke-ADCDeleteStreamselector {
<#
    .SYNOPSIS
        Delete Stream configuration Object
    .DESCRIPTION
        Delete Stream configuration Object
    .PARAMETER name 
       Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .EXAMPLE
        Invoke-ADCDeleteStreamselector -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteStreamselector
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-ADCDeleteStreamselector: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Stream configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type streamselector -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteStreamselector: Finished"
    }
}

function Invoke-ADCGetStreamselector {
<#
    .SYNOPSIS
        Get Stream configuration object(s)
    .DESCRIPTION
        Get Stream configuration object(s)
    .PARAMETER name 
       Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER GetAll 
        Retreive all streamselector object(s)
    .PARAMETER Count
        If specified, the count of the streamselector object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetStreamselector
    .EXAMPLE 
        Invoke-ADCGetStreamselector -GetAll 
    .EXAMPLE 
        Invoke-ADCGetStreamselector -Count
    .EXAMPLE
        Invoke-ADCGetStreamselector -name <string>
    .EXAMPLE
        Invoke-ADCGetStreamselector -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetStreamselector
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-ADCGetStreamselector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all streamselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamselector objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamselector configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamselector configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetStreamselector: Ended"
    }
}

function Invoke-ADCClearStreamsession {
<#
    .SYNOPSIS
        Clear Stream configuration Object
    .DESCRIPTION
        Clear Stream configuration Object 
    .PARAMETER name 
        Name of the stream identifier.
    .EXAMPLE
        Invoke-ADCClearStreamsession -name <string>
    .NOTES
        File Name : Invoke-ADCClearStreamsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamsession/
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
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCClearStreamsession: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear Stream configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamsession -Action clear -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearStreamsession: Finished"
    }
}


