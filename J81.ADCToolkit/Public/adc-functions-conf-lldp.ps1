function Invoke-ADCClearLldpneighbors {
    <#
    .SYNOPSIS
        Clear LLDP configuration Object.
    .DESCRIPTION
        Configuration for lldp neighbors resource.
    .EXAMPLE
        PS C:\>Invoke-ADCClearLldpneighbors 
        An example how to clear lldpneighbors configuration Object(s).
    .NOTES
        File Name : Invoke-ADCClearLldpneighbors
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpneighbors/
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
        Write-Verbose "Invoke-ADCClearLldpneighbors: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Clear LLDP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lldpneighbors -Action clear -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCClearLldpneighbors: Finished"
    }
}

function Invoke-ADCGetLldpneighbors {
    <#
    .SYNOPSIS
        Get LLDP configuration object(s).
    .DESCRIPTION
        Configuration for lldp neighbors resource.
    .PARAMETER Ifnum 
        Interface Name. 
    .PARAMETER GetAll 
        Retrieve all lldpneighbors object(s).
    .PARAMETER Count
        If specified, the count of the lldpneighbors object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpneighbors
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLldpneighbors -GetAll 
        Get all lldpneighbors data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLldpneighbors -Count 
        Get the number of lldpneighbors objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpneighbors -name <string>
        Get lldpneighbors object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpneighbors -Filter @{ 'name'='<value>' }
        Get lldpneighbors data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLldpneighbors
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpneighbors/
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
        [string]$Ifnum,

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
        Write-Verbose "Invoke-ADCGetLldpneighbors: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lldpneighbors objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldpneighbors objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldpneighbors objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldpneighbors configuration for property 'ifnum'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Resource $ifnum -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lldpneighbors configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLldpneighbors: Ended"
    }
}

function Invoke-ADCUpdateLldpparam {
    <#
    .SYNOPSIS
        Update LLDP configuration Object.
    .DESCRIPTION
        Configuration for lldp params resource.
    .PARAMETER Holdtimetxmult 
        A multiplier for calculating the duration for which the receiving device stores the LLDP information in its database before discarding or removing it. The duration is calculated as the holdtimeTxMult (Holdtime Multiplier) parameter value multiplied by the timer (Timer) parameter value. 
    .PARAMETER Timer 
        Interval, in seconds, between LLDP packet data units (LLDPDUs). that the Citrix ADC sends to a directly connected device. 
    .PARAMETER Mode 
        Global mode of Link Layer Discovery Protocol (LLDP) on the Citrix ADC. The resultant LLDP mode of an interface depends on the LLDP mode configured at the global and the interface levels. 
        Possible values = NONE, TRANSMITTER, RECEIVER, TRANSCEIVER
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLldpparam 
        An example how to update lldpparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLldpparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam/
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

        [ValidateRange(1, 20)]
        [double]$Holdtimetxmult,

        [ValidateRange(1, 3000)]
        [double]$Timer,

        [ValidateSet('NONE', 'TRANSMITTER', 'RECEIVER', 'TRANSCEIVER')]
        [string]$Mode 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLldpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('holdtimetxmult') ) { $payload.Add('holdtimetxmult', $holdtimetxmult) }
            if ( $PSBoundParameters.ContainsKey('timer') ) { $payload.Add('timer', $timer) }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSCmdlet.ShouldProcess("lldpparam", "Update LLDP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lldpparam -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateLldpparam: Finished"
    }
}

function Invoke-ADCUnsetLldpparam {
    <#
    .SYNOPSIS
        Unset LLDP configuration Object.
    .DESCRIPTION
        Configuration for lldp params resource.
    .PARAMETER Holdtimetxmult 
        A multiplier for calculating the duration for which the receiving device stores the LLDP information in its database before discarding or removing it. The duration is calculated as the holdtimeTxMult (Holdtime Multiplier) parameter value multiplied by the timer (Timer) parameter value. 
    .PARAMETER Timer 
        Interval, in seconds, between LLDP packet data units (LLDPDUs). that the Citrix ADC sends to a directly connected device. 
    .PARAMETER Mode 
        Global mode of Link Layer Discovery Protocol (LLDP) on the Citrix ADC. The resultant LLDP mode of an interface depends on the LLDP mode configured at the global and the interface levels. 
        Possible values = NONE, TRANSMITTER, RECEIVER, TRANSCEIVER
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLldpparam 
        An example how to unset lldpparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLldpparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam
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

        [Boolean]$holdtimetxmult,

        [Boolean]$timer,

        [Boolean]$mode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLldpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('holdtimetxmult') ) { $payload.Add('holdtimetxmult', $holdtimetxmult) }
            if ( $PSBoundParameters.ContainsKey('timer') ) { $payload.Add('timer', $timer) }
            if ( $PSBoundParameters.ContainsKey('mode') ) { $payload.Add('mode', $mode) }
            if ( $PSCmdlet.ShouldProcess("lldpparam", "Unset LLDP configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lldpparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLldpparam: Finished"
    }
}

function Invoke-ADCGetLldpparam {
    <#
    .SYNOPSIS
        Get LLDP configuration object(s).
    .DESCRIPTION
        Configuration for lldp params resource.
    .PARAMETER GetAll 
        Retrieve all lldpparam object(s).
    .PARAMETER Count
        If specified, the count of the lldpparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLldpparam -GetAll 
        Get all lldpparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpparam -name <string>
        Get lldpparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLldpparam -Filter @{ 'name'='<value>' }
        Get lldpparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLldpparam
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam/
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
        Write-Verbose "Invoke-ADCGetLldpparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lldpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldpparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldpparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving lldpparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLldpparam: Ended"
    }
}


