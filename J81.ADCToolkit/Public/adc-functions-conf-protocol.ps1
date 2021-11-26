function Invoke-ADCUpdateProtocolhttpband {
    <#
    .SYNOPSIS
        Update Protocol configuration Object.
    .DESCRIPTION
        Configuration for HTTP request/response band resource.
    .PARAMETER Reqbandsize 
        Band size, in bytes, for HTTP request band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges: 
        0 - 99 bytes 
        100 - 199 bytes 
        200 - 299 bytes and so on. 
    .PARAMETER Respbandsize 
        Band size, in bytes, for HTTP response band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges: 
        0 - 99 bytes 
        100 - 199 bytes 
        200 - 299 bytes and so on.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateProtocolhttpband 
        An example how to update protocolhttpband configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateProtocolhttpband
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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

        [int]$Reqbandsize,

        [int]$Respbandsize 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateProtocolhttpband: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('reqbandsize') ) { $payload.Add('reqbandsize', $reqbandsize) }
            if ( $PSBoundParameters.ContainsKey('respbandsize') ) { $payload.Add('respbandsize', $respbandsize) }
            if ( $PSCmdlet.ShouldProcess("protocolhttpband", "Update Protocol configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type protocolhttpband -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateProtocolhttpband: Finished"
    }
}

function Invoke-ADCUnsetProtocolhttpband {
    <#
    .SYNOPSIS
        Unset Protocol configuration Object.
    .DESCRIPTION
        Configuration for HTTP request/response band resource.
    .PARAMETER Reqbandsize 
        Band size, in bytes, for HTTP request band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges: 
        0 - 99 bytes 
        100 - 199 bytes 
        200 - 299 bytes and so on. 
    .PARAMETER Respbandsize 
        Band size, in bytes, for HTTP response band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges: 
        0 - 99 bytes 
        100 - 199 bytes 
        200 - 299 bytes and so on.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetProtocolhttpband 
        An example how to unset protocolhttpband configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetProtocolhttpband
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband
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

        [Boolean]$reqbandsize,

        [Boolean]$respbandsize 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetProtocolhttpband: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('reqbandsize') ) { $payload.Add('reqbandsize', $reqbandsize) }
            if ( $PSBoundParameters.ContainsKey('respbandsize') ) { $payload.Add('respbandsize', $respbandsize) }
            if ( $PSCmdlet.ShouldProcess("protocolhttpband", "Unset Protocol configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type protocolhttpband -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetProtocolhttpband: Finished"
    }
}

function Invoke-ADCClearProtocolhttpband {
    <#
    .SYNOPSIS
        Clear Protocol configuration Object.
    .DESCRIPTION
        Configuration for HTTP request/response band resource.
    .PARAMETER Type 
        Type of statistics to display. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ
    .EXAMPLE
        PS C:\>Invoke-ADCClearProtocolhttpband -type <string>
        An example how to clear protocolhttpband configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearProtocolhttpband
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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
        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Type 

    )
    begin {
        Write-Verbose "Invoke-ADCClearProtocolhttpband: Starting"
    }
    process {
        try {
            $payload = @{ type = $type }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear Protocol configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type protocolhttpband -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearProtocolhttpband: Finished"
    }
}

function Invoke-ADCGetProtocolhttpband {
    <#
    .SYNOPSIS
        Get Protocol configuration object(s).
    .DESCRIPTION
        Configuration for HTTP request/response band resource.
    .PARAMETER Type 
        Type of statistics to display. 
        Possible values = REQUEST, RESPONSE, MQTT_JUMBO_REQ 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all protocolhttpband object(s).
    .PARAMETER Count
        If specified, the count of the protocolhttpband object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetProtocolhttpband
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetProtocolhttpband -GetAll 
        Get all protocolhttpband data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetProtocolhttpband -name <string>
        Get protocolhttpband object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetProtocolhttpband -Filter @{ 'name'='<value>' }
        Get protocolhttpband data with a filter.
    .NOTES
        File Name : Invoke-ADCGetProtocolhttpband
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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
        [ValidateSet('REQUEST', 'RESPONSE', 'MQTT_JUMBO_REQ')]
        [string]$Type,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetProtocolhttpband: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all protocolhttpband objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for protocolhttpband objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving protocolhttpband objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('type') ) { $arguments.Add('type', $type) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving protocolhttpband configuration for property ''"

            } else {
                Write-Verbose "Retrieving protocolhttpband configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetProtocolhttpband: Ended"
    }
}


