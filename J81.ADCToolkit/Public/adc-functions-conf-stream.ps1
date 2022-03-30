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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Version   : v2111.2521
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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
        Version   : v2111.2521
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

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDWmvMpWbp/SPm8
# 0G7ccMlNDnDHRGuESsxFp3vPjGDdeaCCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWsw
# DQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4X
# DTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRsw
# GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGlt
# ZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DW
# mn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJre
# TAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fW
# uCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2H
# YxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv
# 53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKV
# KoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRX
# yCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEV
# YFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzG
# PATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4s
# rjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCC
# AXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1
# N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
# AQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1Ud
# HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRp
# bWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0
# dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcN
# AQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu6
# 6ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIV
# y0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQ
# Lt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55
# aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9o
# GsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkW
# mcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiG
# oDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6
# R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TU
# JikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbW
# w/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFkzCC
# BY8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
# c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
# MSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL
# /bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgkPTjc9nUshEAT5v4LLAqLerT
# hn079p5u0TRH1b0Si34wDQYJKoZIhvcNAQEBBQAEggEANX33hcJNpeijdHPdlvPa
# Hvu4l5hpt68p2LGMk5nXW8KXdAdbLTk3sejdzTOCfAP1BHv7YK7i/ZSyk6nmdo3P
# zAanBl9KzaQkAPXJcqnLLmVegsba/QEmA/pc9Pv5W2pc0h2IoV6cvE5+mTEDxuzQ
# 02wtjtHJweRqxLa/mF6chWvKfuU6QkWddMxfXfQYg/hLs6zh8LPrxvaTmR9li7xr
# F/6MRkWoWXAVA5Lb0/JfMXGJKkLnmFwLtLWzKY0mcW2Kp5/0Vz24BKC8cmioHdRb
# KDcbBVVmwCVnrQmRn/Tb4oTvFvWlfUciBmBQb2Pfg2hFuP1oX6rK99/G/IQocG+O
# d6GCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwMzMwMTkzMzM4WjA/BgkqhkiG9w0BCQQxMgQwNo1CTvll/NXp2zoJIHynG0sy
# SA6Egmq+M4o9idyMXYuoFps5/ZQleba4O6FnykvHMA0GCSqGSIb3DQEBAQUABIIC
# AB9S+okzdukPs943dWflbxdcLVI2vFfUeCl8t4fZBamNm6djr0/ZDhFln4ThUpdA
# laWLqxuAsGmhtS1no0w1r/6wEIyMWnecRHBNDsaS2IMHCfbTbsTuq9yGeKpM/22x
# 3UQFcbV7JZXwZx9YgykrOaj8a13lRPL/TQOF994s+TsYqUkDOQ5HGDytsRKkltfx
# r+9Ml/NhvEWiAL6+feY7SnkyaPH7XIsf1W9Mxby8FvQHL0fJYGPMgaEKcnPs8/Ny
# 8uzMnz1mVZwS8ZHaQW21VAWAYI7KC7XRXl1VMUgSk3Oad5VfFO4DB1huhSm60hgj
# bVgR68bkWPDrog1Ctj9WzFJeGSJMgqaSDv7J6UUcSpqDFordyXUtnm6eMtqE8l9a
# fDcAHxG3ecL9Q6gObkVoFW4GLh+1q5neOyrP0O6d5Os1s8G/uT8Zi3VXkRCsD6mU
# llcCm9tGmEOl2QzqedrO8964xWpNGBcHerPSPS9rOFh13apbrSONEeLOrVWlDkpe
# VcqnTlViT5AhR+zKxkkiasvylYoyNkfs/WaaCazmVF9K7oVU7+UTl0+i3Tu343Gi
# 21MuSKSFlpG0T4BU/bL7slFmv72d3X2L6eCF/m3wYl4TlgPw9Q074cHa2zbx6JpD
# Or72S9cjC3toEXGmk2MrZmj/SO669ufJIU5pqdEJVCvl
# SIG # End signature block
