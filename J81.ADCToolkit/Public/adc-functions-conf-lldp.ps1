function Invoke-ADCClearLldpneighbors {
<#
    .SYNOPSIS
        Clear LLDP configuration Object
    .DESCRIPTION
        Clear LLDP configuration Object 
    .EXAMPLE
        Invoke-ADCClearLldpneighbors 
    .NOTES
        File Name : Invoke-ADCClearLldpneighbors
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpneighbors/
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
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession) 

    )
    begin {
        Write-Verbose "Invoke-ADCClearLldpneighbors: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Clear LLDP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lldpneighbors -Action clear -Payload $Payload -GetWarning
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
        Get LLDP configuration object(s)
    .DESCRIPTION
        Get LLDP configuration object(s)
    .PARAMETER ifnum 
       Interface Name. 
    .PARAMETER GetAll 
        Retreive all lldpneighbors object(s)
    .PARAMETER Count
        If specified, the count of the lldpneighbors object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLldpneighbors
    .EXAMPLE 
        Invoke-ADCGetLldpneighbors -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLldpneighbors -Count
    .EXAMPLE
        Invoke-ADCGetLldpneighbors -name <string>
    .EXAMPLE
        Invoke-ADCGetLldpneighbors -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLldpneighbors
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpneighbors/
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
        [string]$ifnum,

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
        Write-Verbose "Invoke-ADCGetLldpneighbors: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lldpneighbors objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldpneighbors objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldpneighbors objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldpneighbors configuration for property 'ifnum'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Resource $ifnum -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lldpneighbors configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpneighbors -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update LLDP configuration Object
    .DESCRIPTION
        Update LLDP configuration Object 
    .PARAMETER holdtimetxmult 
        A multiplier for calculating the duration for which the receiving device stores the LLDP information in its database before discarding or removing it. The duration is calculated as the holdtimeTxMult (Holdtime Multiplier) parameter value multiplied by the timer (Timer) parameter value.  
        Default value: 4  
        Minimum value = 1  
        Maximum value = 20 
    .PARAMETER timer 
        Interval, in seconds, between LLDP packet data units (LLDPDUs). that the Citrix ADC sends to a directly connected device.  
        Default value: 30  
        Minimum value = 1  
        Maximum value = 3000 
    .PARAMETER mode 
        Global mode of Link Layer Discovery Protocol (LLDP) on the Citrix ADC. The resultant LLDP mode of an interface depends on the LLDP mode configured at the global and the interface levels.  
        Possible values = NONE, TRANSMITTER, RECEIVER, TRANSCEIVER
    .EXAMPLE
        Invoke-ADCUpdateLldpparam 
    .NOTES
        File Name : Invoke-ADCUpdateLldpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam/
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

        [ValidateRange(1, 20)]
        [double]$holdtimetxmult ,

        [ValidateRange(1, 3000)]
        [double]$timer ,

        [ValidateSet('NONE', 'TRANSMITTER', 'RECEIVER', 'TRANSCEIVER')]
        [string]$mode 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLldpparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('holdtimetxmult')) { $Payload.Add('holdtimetxmult', $holdtimetxmult) }
            if ($PSBoundParameters.ContainsKey('timer')) { $Payload.Add('timer', $timer) }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
 
            if ($PSCmdlet.ShouldProcess("lldpparam", "Update LLDP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lldpparam -Payload $Payload -GetWarning
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
        Unset LLDP configuration Object
    .DESCRIPTION
        Unset LLDP configuration Object 
   .PARAMETER holdtimetxmult 
       A multiplier for calculating the duration for which the receiving device stores the LLDP information in its database before discarding or removing it. The duration is calculated as the holdtimeTxMult (Holdtime Multiplier) parameter value multiplied by the timer (Timer) parameter value. 
   .PARAMETER timer 
       Interval, in seconds, between LLDP packet data units (LLDPDUs). that the Citrix ADC sends to a directly connected device. 
   .PARAMETER mode 
       Global mode of Link Layer Discovery Protocol (LLDP) on the Citrix ADC. The resultant LLDP mode of an interface depends on the LLDP mode configured at the global and the interface levels.  
       Possible values = NONE, TRANSMITTER, RECEIVER, TRANSCEIVER
    .EXAMPLE
        Invoke-ADCUnsetLldpparam 
    .NOTES
        File Name : Invoke-ADCUnsetLldpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam
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

        [Boolean]$holdtimetxmult ,

        [Boolean]$timer ,

        [Boolean]$mode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLldpparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('holdtimetxmult')) { $Payload.Add('holdtimetxmult', $holdtimetxmult) }
            if ($PSBoundParameters.ContainsKey('timer')) { $Payload.Add('timer', $timer) }
            if ($PSBoundParameters.ContainsKey('mode')) { $Payload.Add('mode', $mode) }
            if ($PSCmdlet.ShouldProcess("lldpparam", "Unset LLDP configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lldpparam -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get LLDP configuration object(s)
    .DESCRIPTION
        Get LLDP configuration object(s)
    .PARAMETER GetAll 
        Retreive all lldpparam object(s)
    .PARAMETER Count
        If specified, the count of the lldpparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLldpparam
    .EXAMPLE 
        Invoke-ADCGetLldpparam -GetAll
    .EXAMPLE
        Invoke-ADCGetLldpparam -name <string>
    .EXAMPLE
        Invoke-ADCGetLldpparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLldpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lldp/lldpparam/
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
        Write-Verbose "Invoke-ADCGetLldpparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lldpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lldpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lldpparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lldpparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving lldpparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lldpparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


