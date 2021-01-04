function Invoke-ADCUpdateSmppparam {
<#
    .SYNOPSIS
        Update Smpp configuration Object
    .DESCRIPTION
        Update Smpp configuration Object 
    .PARAMETER clientmode 
        Mode in which the client binds to the ADC. Applicable settings function as follows:  
        * TRANSCEIVER - Client can send and receive messages to and from the message center.  
        * TRANSMITTERONLY - Client can only send messages.  
        * RECEIVERONLY - Client can only receive messages.  
        Default value: TRANSCEIVER  
        Possible values = TRANSCEIVER, TRANSMITTERONLY, RECEIVERONLY 
    .PARAMETER msgqueue 
        Queue SMPP messages if a client that is capable of receiving the destination address messages is not available.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER msgqueuesize 
        Maximum number of SMPP messages that can be queued. After the limit is reached, the Citrix ADC sends a deliver_sm_resp PDU, with an appropriate error message, to the message center.  
        Default value: 10000 
    .PARAMETER addrton 
        Type of Number, such as an international number or a national number, used in the ESME address sent in the bind request.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 256 
    .PARAMETER addrnpi 
        Numbering Plan Indicator, such as landline, data, or WAP client, used in the ESME address sent in the bind request.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 256 
    .PARAMETER addrrange 
        Set of SME addresses, sent in the bind request, serviced by the ESME.  
        Default value: "\\d*"
    .EXAMPLE
        Invoke-ADCUpdateSmppparam 
    .NOTES
        File Name : Invoke-ADCUpdateSmppparam
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam/
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

        [ValidateSet('TRANSCEIVER', 'TRANSMITTERONLY', 'RECEIVERONLY')]
        [string]$clientmode ,

        [ValidateSet('ON', 'OFF')]
        [string]$msgqueue ,

        [double]$msgqueuesize ,

        [ValidateRange(0, 256)]
        [double]$addrton ,

        [ValidateRange(0, 256)]
        [double]$addrnpi ,

        [string]$addrrange 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSmppparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('clientmode')) { $Payload.Add('clientmode', $clientmode) }
            if ($PSBoundParameters.ContainsKey('msgqueue')) { $Payload.Add('msgqueue', $msgqueue) }
            if ($PSBoundParameters.ContainsKey('msgqueuesize')) { $Payload.Add('msgqueuesize', $msgqueuesize) }
            if ($PSBoundParameters.ContainsKey('addrton')) { $Payload.Add('addrton', $addrton) }
            if ($PSBoundParameters.ContainsKey('addrnpi')) { $Payload.Add('addrnpi', $addrnpi) }
            if ($PSBoundParameters.ContainsKey('addrrange')) { $Payload.Add('addrrange', $addrrange) }
 
            if ($PSCmdlet.ShouldProcess("smppparam", "Update Smpp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type smppparam -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateSmppparam: Finished"
    }
}

function Invoke-ADCUnsetSmppparam {
<#
    .SYNOPSIS
        Unset Smpp configuration Object
    .DESCRIPTION
        Unset Smpp configuration Object 
   .PARAMETER clientmode 
       Mode in which the client binds to the ADC. Applicable settings function as follows:  
       * TRANSCEIVER - Client can send and receive messages to and from the message center.  
       * TRANSMITTERONLY - Client can only send messages.  
       * RECEIVERONLY - Client can only receive messages.  
       Possible values = TRANSCEIVER, TRANSMITTERONLY, RECEIVERONLY 
   .PARAMETER msgqueue 
       Queue SMPP messages if a client that is capable of receiving the destination address messages is not available.  
       Possible values = ON, OFF 
   .PARAMETER msgqueuesize 
       Maximum number of SMPP messages that can be queued. After the limit is reached, the Citrix ADC sends a deliver_sm_resp PDU, with an appropriate error message, to the message center. 
   .PARAMETER addrton 
       Type of Number, such as an international number or a national number, used in the ESME address sent in the bind request. 
   .PARAMETER addrnpi 
       Numbering Plan Indicator, such as landline, data, or WAP client, used in the ESME address sent in the bind request. 
   .PARAMETER addrrange 
       Set of SME addresses, sent in the bind request, serviced by the ESME.
    .EXAMPLE
        Invoke-ADCUnsetSmppparam 
    .NOTES
        File Name : Invoke-ADCUnsetSmppparam
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam
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

        [Boolean]$clientmode ,

        [Boolean]$msgqueue ,

        [Boolean]$msgqueuesize ,

        [Boolean]$addrton ,

        [Boolean]$addrnpi ,

        [Boolean]$addrrange 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSmppparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('clientmode')) { $Payload.Add('clientmode', $clientmode) }
            if ($PSBoundParameters.ContainsKey('msgqueue')) { $Payload.Add('msgqueue', $msgqueue) }
            if ($PSBoundParameters.ContainsKey('msgqueuesize')) { $Payload.Add('msgqueuesize', $msgqueuesize) }
            if ($PSBoundParameters.ContainsKey('addrton')) { $Payload.Add('addrton', $addrton) }
            if ($PSBoundParameters.ContainsKey('addrnpi')) { $Payload.Add('addrnpi', $addrnpi) }
            if ($PSBoundParameters.ContainsKey('addrrange')) { $Payload.Add('addrrange', $addrrange) }
            if ($PSCmdlet.ShouldProcess("smppparam", "Unset Smpp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type smppparam -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSmppparam: Finished"
    }
}

function Invoke-ADCGetSmppparam {
<#
    .SYNOPSIS
        Get Smpp configuration object(s)
    .DESCRIPTION
        Get Smpp configuration object(s)
    .PARAMETER GetAll 
        Retreive all smppparam object(s)
    .PARAMETER Count
        If specified, the count of the smppparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSmppparam
    .EXAMPLE 
        Invoke-ADCGetSmppparam -GetAll
    .EXAMPLE
        Invoke-ADCGetSmppparam -name <string>
    .EXAMPLE
        Invoke-ADCGetSmppparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSmppparam
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam/
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
        Write-Verbose "Invoke-ADCGetSmppparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all smppparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for smppparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving smppparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving smppparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving smppparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSmppparam: Ended"
    }
}

function Invoke-ADCAddSmppuser {
<#
    .SYNOPSIS
        Add Smpp configuration Object
    .DESCRIPTION
        Add Smpp configuration Object 
    .PARAMETER username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server.  
        Minimum length = 1 
    .PARAMETER password 
        Password for binding to the SMPP server. Must be the same as the password specified in the SMPP server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created smppuser item.
    .EXAMPLE
        Invoke-ADCAddSmppuser -username <string>
    .NOTES
        File Name : Invoke-ADCAddSmppuser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSmppuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("smppuser", "Add Smpp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type smppuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSmppuser -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSmppuser: Finished"
    }
}

function Invoke-ADCDeleteSmppuser {
<#
    .SYNOPSIS
        Delete Smpp configuration Object
    .DESCRIPTION
        Delete Smpp configuration Object
    .PARAMETER username 
       Name of the SMPP user. Must be the same as the user name specified in the SMPP server.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteSmppuser -username <string>
    .NOTES
        File Name : Invoke-ADCDeleteSmppuser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSmppuser: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$username", "Delete Smpp configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type smppuser -NitroPath nitro/v1/config -Resource $username -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSmppuser: Finished"
    }
}

function Invoke-ADCUpdateSmppuser {
<#
    .SYNOPSIS
        Update Smpp configuration Object
    .DESCRIPTION
        Update Smpp configuration Object 
    .PARAMETER username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server.  
        Minimum length = 1 
    .PARAMETER password 
        Password for binding to the SMPP server. Must be the same as the password specified in the SMPP server.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created smppuser item.
    .EXAMPLE
        Invoke-ADCUpdateSmppuser -username <string>
    .NOTES
        File Name : Invoke-ADCUpdateSmppuser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$username ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$password ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSmppuser: Starting"
    }
    process {
        try {
            $Payload = @{
                username = $username
            }
            if ($PSBoundParameters.ContainsKey('password')) { $Payload.Add('password', $password) }
 
            if ($PSCmdlet.ShouldProcess("smppuser", "Update Smpp configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type smppuser -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSmppuser -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSmppuser: Finished"
    }
}

function Invoke-ADCGetSmppuser {
<#
    .SYNOPSIS
        Get Smpp configuration object(s)
    .DESCRIPTION
        Get Smpp configuration object(s)
    .PARAMETER username 
       Name of the SMPP user. Must be the same as the user name specified in the SMPP server. 
    .PARAMETER GetAll 
        Retreive all smppuser object(s)
    .PARAMETER Count
        If specified, the count of the smppuser object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSmppuser
    .EXAMPLE 
        Invoke-ADCGetSmppuser -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSmppuser -Count
    .EXAMPLE
        Invoke-ADCGetSmppuser -name <string>
    .EXAMPLE
        Invoke-ADCGetSmppuser -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSmppuser
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$username,

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
        Write-Verbose "Invoke-ADCGetSmppuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all smppuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for smppuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving smppuser objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving smppuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving smppuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSmppuser: Ended"
    }
}


