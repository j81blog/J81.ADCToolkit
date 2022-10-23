function Invoke-ADCAddStreamidentifier {
    <#
    .SYNOPSIS
        Add Stream configuration Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval. 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddStreamidentifier -name <string> -selectorname <string>
        An example how to add streamidentifier configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddStreamidentifier
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        [string]$Selectorname,

        [double]$Interval = '1',

        [ValidateRange(1, 65535)]
        [double]$Samplecount = '1',

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$Sort = 'REQUESTS',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Snmptrap = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trackackonlypackets = 'DISABLED',

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$Tracktransactions = 'NONE',

        [double]$Maxtransactionthreshold = '0',

        [double]$Mintransactionthreshold = '0',

        [string]$Acceptancethreshold = '0.000000',

        [double]$Breachthreshold = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                selectorname   = $selectorname
            }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("streamidentifier", "Add Stream configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamidentifier -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetStreamidentifier -Filter $payload)
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
        Update Stream configuration Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval. 
    .PARAMETER PassThru 
        Return details about the created streamidentifier item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateStreamidentifier -name <string>
        An example how to update streamidentifier configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateStreamidentifier
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Selectorname,

        [double]$Interval,

        [ValidateRange(1, 65535)]
        [double]$Samplecount,

        [ValidateSet('REQUESTS', 'CONNECTIONS', 'RESPTIME', 'BANDWIDTH', 'RESPTIME_BREACHES', 'NONE')]
        [string]$Sort,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Snmptrap,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Trackackonlypackets,

        [ValidateSet('RESPTIME', 'NONE')]
        [string]$Tracktransactions,

        [double]$Maxtransactionthreshold,

        [double]$Mintransactionthreshold,

        [string]$Acceptancethreshold,

        [double]$Breachthreshold,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('selectorname') ) { $payload.Add('selectorname', $selectorname) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("streamidentifier", "Update Stream configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type streamidentifier -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetStreamidentifier -Filter $payload)
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
        Unset Stream configuration Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER Selectorname 
        Name of the selector to use with the stream identifier. 
    .PARAMETER Interval 
        Number of minutes of data to use when calculating session statistics (number of requests, bandwidth, and response times). The interval is a moving window that keeps the most recently collected data. Older data is discarded at regular intervals. 
    .PARAMETER Samplecount 
        Size of the sample from which to select a request for evaluation. The smaller the sample count, the more accurate is the statistical data. To evaluate all requests, set the sample count to 1. However, such a low setting can result in excessive consumption of memory and processing resources. 
    .PARAMETER Sort 
        Sort stored records by the specified statistics column, in descending order. Performed during data collection, the sorting enables real-time data evaluation through Citrix ADC policies (for example, compression and caching policies) that use functions such as IS_TOP(n). 
        Possible values = REQUESTS, CONNECTIONS, RESPTIME, BANDWIDTH, RESPTIME_BREACHES, NONE 
    .PARAMETER Snmptrap 
        Enable/disable SNMP trap for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Appflowlog 
        Enable/disable Appflow logging for stream identifier. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Trackackonlypackets 
        Track ack only packets as well. This setting is applicable only when packet rate limiting is being used. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Tracktransactions 
        Track transactions exceeding configured threshold. Transaction tracking can be enabled for following metric: ResponseTime. 
        By default transaction tracking is disabled. 
        Possible values = RESPTIME, NONE 
    .PARAMETER Maxtransactionthreshold 
        Maximum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Mintransactionthreshold 
        Minimum per transcation value of metric. Metric to be tracked is specified by tracktransactions attribute. 
    .PARAMETER Acceptancethreshold 
        Non-Breaching transactions to Total transactions threshold expressed in percent. 
        Maximum of 6 decimal places is supported. 
    .PARAMETER Breachthreshold 
        Breaching transactions threshold calculated over interval.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetStreamidentifier -name <string>
        An example how to unset streamidentifier configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetStreamidentifier
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier
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

        [Boolean]$selectorname,

        [Boolean]$interval,

        [Boolean]$samplecount,

        [Boolean]$sort,

        [Boolean]$snmptrap,

        [Boolean]$appflowlog,

        [Boolean]$trackackonlypackets,

        [Boolean]$tracktransactions,

        [Boolean]$maxtransactionthreshold,

        [Boolean]$mintransactionthreshold,

        [Boolean]$acceptancethreshold,

        [Boolean]$breachthreshold 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetStreamidentifier: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('selectorname') ) { $payload.Add('selectorname', $selectorname) }
            if ( $PSBoundParameters.ContainsKey('interval') ) { $payload.Add('interval', $interval) }
            if ( $PSBoundParameters.ContainsKey('samplecount') ) { $payload.Add('samplecount', $samplecount) }
            if ( $PSBoundParameters.ContainsKey('sort') ) { $payload.Add('sort', $sort) }
            if ( $PSBoundParameters.ContainsKey('snmptrap') ) { $payload.Add('snmptrap', $snmptrap) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('trackackonlypackets') ) { $payload.Add('trackackonlypackets', $trackackonlypackets) }
            if ( $PSBoundParameters.ContainsKey('tracktransactions') ) { $payload.Add('tracktransactions', $tracktransactions) }
            if ( $PSBoundParameters.ContainsKey('maxtransactionthreshold') ) { $payload.Add('maxtransactionthreshold', $maxtransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('mintransactionthreshold') ) { $payload.Add('mintransactionthreshold', $mintransactionthreshold) }
            if ( $PSBoundParameters.ContainsKey('acceptancethreshold') ) { $payload.Add('acceptancethreshold', $acceptancethreshold) }
            if ( $PSBoundParameters.ContainsKey('breachthreshold') ) { $payload.Add('breachthreshold', $breachthreshold) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Stream configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type streamidentifier -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Delete Stream configuration Object.
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteStreamidentifier -Name <string>
        An example how to delete streamidentifier configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteStreamidentifier
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-ADCDeleteStreamidentifier: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Stream configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Stream configuration object(s).
    .DESCRIPTION
        Configuration for identifier resource.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER GetAll 
        Retrieve all streamidentifier object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifier
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifier -GetAll 
        Get all streamidentifier data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifier -Count 
        Get the number of streamidentifier objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifier -name <string>
        Get streamidentifier object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifier -Filter @{ 'name'='<value>' }
        Get streamidentifier data with a filter.
    .NOTES
        File Name : Invoke-ADCGetStreamidentifier
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier/
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
        Write-Verbose "Invoke-ADCGetStreamidentifier: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Stream configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to streamidentifier.
    .PARAMETER Name 
        The name of stream identifier. 
    .PARAMETER GetAll 
        Retrieve all streamidentifier_binding object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifierbinding -GetAll 
        Get all streamidentifier_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierbinding -name <string>
        Get streamidentifier_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierbinding -Filter @{ 'name'='<value>' }
        Get streamidentifier_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetStreamidentifierbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier_binding/
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
        Write-Verbose "Invoke-ADCGetStreamidentifierbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamidentifier_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Stream configuration object(s).
    .DESCRIPTION
        Binding object showing the streamsession that can be bound to streamidentifier.
    .PARAMETER GetAll 
        Retrieve all streamidentifier_streamsession_binding object(s).
    .PARAMETER Count
        If specified, the count of the streamidentifier_streamsession_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierstreamsessionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifierstreamsessionbinding -GetAll 
        Get all streamidentifier_streamsession_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamidentifierstreamsessionbinding -Count 
        Get the number of streamidentifier_streamsession_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierstreamsessionbinding -name <string>
        Get streamidentifier_streamsession_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamidentifierstreamsessionbinding -Filter @{ 'name'='<value>' }
        Get streamidentifier_streamsession_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetStreamidentifierstreamsessionbinding
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamidentifier_streamsession_binding/
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
        Write-Verbose "Invoke-ADCGetStreamidentifierstreamsessionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all streamidentifier_streamsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamidentifier_streamsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving streamidentifier_streamsession_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamidentifier_streamsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Stream configuration Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER Rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL). 
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector. 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddStreamselector -name <string> -rule <string[]>
        An example how to add streamselector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddStreamselector
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddStreamselector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
            }

            if ( $PSCmdlet.ShouldProcess("streamselector", "Add Stream configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetStreamselector -Filter $payload)
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
        Update Stream configuration Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER Rule 
        Set of up to five expressions. Maximum length: 7499 characters. Each expression must identify a specific request characteristic, such as the client's IP address (with CLIENT.IP.SRC) or requested server resource (with HTTP.REQ.URL). 
        Note: If two or more selectors contain the same expressions in different order, a separate set of records is created for each selector. 
    .PARAMETER PassThru 
        Return details about the created streamselector item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateStreamselector -name <string>
        An example how to update streamselector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateStreamselector
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string[]]$Rule,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateStreamselector: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSCmdlet.ShouldProcess("streamselector", "Update Stream configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type streamselector -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetStreamselector -Filter $payload)
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
        Delete Stream configuration Object.
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector').
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteStreamselector -Name <string>
        An example how to delete streamselector configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteStreamselector
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-ADCDeleteStreamselector: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Stream configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type streamselector -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Get Stream configuration object(s).
    .DESCRIPTION
        Configuration for selector resource.
    .PARAMETER Name 
        Name for the selector. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. If the name includes one or more spaces, and you are using the Citrix ADC CLI, enclose the name in double or single quotation marks (for example, "my selector" or 'my selector'). 
    .PARAMETER GetAll 
        Retrieve all streamselector object(s).
    .PARAMETER Count
        If specified, the count of the streamselector object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamselector
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamselector -GetAll 
        Get all streamselector data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetStreamselector -Count 
        Get the number of streamselector objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamselector -name <string>
        Get streamselector object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetStreamselector -Filter @{ 'name'='<value>' }
        Get streamselector data with a filter.
    .NOTES
        File Name : Invoke-ADCGetStreamselector
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamselector/
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
        Write-Verbose "Invoke-ADCGetStreamselector: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all streamselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for streamselector objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving streamselector objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving streamselector configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving streamselector configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type streamselector -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Clear Stream configuration Object.
    .DESCRIPTION
        Configuration for active connection resource.
    .PARAMETER Name 
        Name of the stream identifier.
    .EXAMPLE
        PS C:\>Invoke-ADCClearStreamsession -name <string>
        An example how to clear streamsession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearStreamsession
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/stream/streamsession/
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
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCClearStreamsession: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Stream configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type streamsession -Action clear -Payload $payload -GetWarning
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


