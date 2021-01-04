function Invoke-ADCUpdateProtocolhttpband {
<#
    .SYNOPSIS
        Update Protocol configuration Object
    .DESCRIPTION
        Update Protocol configuration Object 
    .PARAMETER reqbandsize 
        Band size, in bytes, for HTTP request band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges:  
        0 - 99 bytes  
        100 - 199 bytes  
        200 - 299 bytes and so on.  
        Default value: 100  
        Minimum value = 50 
    .PARAMETER respbandsize 
        Band size, in bytes, for HTTP response band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size ranges:  
        0 - 99 bytes  
        100 - 199 bytes  
        200 - 299 bytes and so on.  
        Default value: 1024  
        Minimum value = 50
    .EXAMPLE
        Invoke-ADCUpdateProtocolhttpband 
    .NOTES
        File Name : Invoke-ADCUpdateProtocolhttpband
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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

        [ValidateRange(0, 99)]
        [int]$reqbandsize ,

        [ValidateRange(0, 99)]
        [int]$respbandsize 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateProtocolhttpband: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('reqbandsize')) { $Payload.Add('reqbandsize', $reqbandsize) }
            if ($PSBoundParameters.ContainsKey('respbandsize')) { $Payload.Add('respbandsize', $respbandsize) }
 
            if ($PSCmdlet.ShouldProcess("protocolhttpband", "Update Protocol configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type protocolhttpband -Payload $Payload -GetWarning
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
        Unset Protocol configuration Object
    .DESCRIPTION
        Unset Protocol configuration Object 
   .PARAMETER reqbandsize 
       Band size, in bytes, for HTTP request band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size  bytes  
       100 - 199 bytes  
       200 - 299 bytes and so on. 
   .PARAMETER respbandsize 
       Band size, in bytes, for HTTP response band statistics. For example, if you specify a band size of 100 bytes, statistics will be maintained and displayed for the following size  bytes  
       100 - 199 bytes  
       200 - 299 bytes and so on.
    .EXAMPLE
        Invoke-ADCUnsetProtocolhttpband 
    .NOTES
        File Name : Invoke-ADCUnsetProtocolhttpband
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband
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

        [Boolean]$reqbandsize ,

        [Boolean]$respbandsize 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetProtocolhttpband: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('reqbandsize')) { $Payload.Add('reqbandsize', $reqbandsize) }
            if ($PSBoundParameters.ContainsKey('respbandsize')) { $Payload.Add('respbandsize', $respbandsize) }
            if ($PSCmdlet.ShouldProcess("protocolhttpband", "Unset Protocol configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type protocolhttpband -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Clear Protocol configuration Object
    .DESCRIPTION
        Clear Protocol configuration Object 
    .PARAMETER type 
        Type of statistics to display.  
        Possible values = REQUEST, RESPONSE
    .EXAMPLE
        Invoke-ADCClearProtocolhttpband -type <string>
    .NOTES
        File Name : Invoke-ADCClearProtocolhttpband
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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
        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$type 

    )
    begin {
        Write-Verbose "Invoke-ADCClearProtocolhttpband: Starting"
    }
    process {
        try {
            $Payload = @{
                type = $type
            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear Protocol configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type protocolhttpband -Action clear -Payload $Payload -GetWarning
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
        Get Protocol configuration object(s)
    .DESCRIPTION
        Get Protocol configuration object(s)
    .PARAMETER type 
       Type of statistics to display.  
       Possible values = REQUEST, RESPONSE 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all protocolhttpband object(s)
    .PARAMETER Count
        If specified, the count of the protocolhttpband object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetProtocolhttpband
    .EXAMPLE 
        Invoke-ADCGetProtocolhttpband -GetAll
    .EXAMPLE
        Invoke-ADCGetProtocolhttpband -name <string>
    .EXAMPLE
        Invoke-ADCGetProtocolhttpband -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetProtocolhttpband
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/protocol/protocolhttpband/
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
        [ValidateSet('REQUEST', 'RESPONSE')]
        [string]$type ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetProtocolhttpband: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all protocolhttpband objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for protocolhttpband objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving protocolhttpband objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('type')) { $Arguments.Add('type', $type) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving protocolhttpband configuration for property ''"

            } else {
                Write-Verbose "Retrieving protocolhttpband configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type protocolhttpband -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


