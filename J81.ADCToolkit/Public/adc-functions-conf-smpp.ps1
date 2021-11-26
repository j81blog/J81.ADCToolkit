function Invoke-ADCUpdateSmppparam {
    <#
    .SYNOPSIS
        Update Smpp configuration Object.
    .DESCRIPTION
        Configuration for SMPP configuration parameters resource.
    .PARAMETER Clientmode 
        Mode in which the client binds to the ADC. Applicable settings function as follows: 
        * TRANSCEIVER - Client can send and receive messages to and from the message center. 
        * TRANSMITTERONLY - Client can only send messages. 
        * RECEIVERONLY - Client can only receive messages. 
        Possible values = TRANSCEIVER, TRANSMITTERONLY, RECEIVERONLY 
    .PARAMETER Msgqueue 
        Queue SMPP messages if a client that is capable of receiving the destination address messages is not available. 
        Possible values = ON, OFF 
    .PARAMETER Msgqueuesize 
        Maximum number of SMPP messages that can be queued. After the limit is reached, the Citrix ADC sends a deliver_sm_resp PDU, with an appropriate error message, to the message center. 
    .PARAMETER Addrton 
        Type of Number, such as an international number or a national number, used in the ESME address sent in the bind request. 
    .PARAMETER Addrnpi 
        Numbering Plan Indicator, such as landline, data, or WAP client, used in the ESME address sent in the bind request. 
    .PARAMETER Addrrange 
        Set of SME addresses, sent in the bind request, serviced by the ESME.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSmppparam 
        An example how to update smppparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSmppparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam/
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

        [ValidateSet('TRANSCEIVER', 'TRANSMITTERONLY', 'RECEIVERONLY')]
        [string]$Clientmode,

        [ValidateSet('ON', 'OFF')]
        [string]$Msgqueue,

        [double]$Msgqueuesize,

        [ValidateRange(0, 256)]
        [double]$Addrton,

        [ValidateRange(0, 256)]
        [double]$Addrnpi,

        [string]$Addrrange 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSmppparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('clientmode') ) { $payload.Add('clientmode', $clientmode) }
            if ( $PSBoundParameters.ContainsKey('msgqueue') ) { $payload.Add('msgqueue', $msgqueue) }
            if ( $PSBoundParameters.ContainsKey('msgqueuesize') ) { $payload.Add('msgqueuesize', $msgqueuesize) }
            if ( $PSBoundParameters.ContainsKey('addrton') ) { $payload.Add('addrton', $addrton) }
            if ( $PSBoundParameters.ContainsKey('addrnpi') ) { $payload.Add('addrnpi', $addrnpi) }
            if ( $PSBoundParameters.ContainsKey('addrrange') ) { $payload.Add('addrrange', $addrrange) }
            if ( $PSCmdlet.ShouldProcess("smppparam", "Update Smpp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type smppparam -Payload $payload -GetWarning
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
        Unset Smpp configuration Object.
    .DESCRIPTION
        Configuration for SMPP configuration parameters resource.
    .PARAMETER Clientmode 
        Mode in which the client binds to the ADC. Applicable settings function as follows: 
        * TRANSCEIVER - Client can send and receive messages to and from the message center. 
        * TRANSMITTERONLY - Client can only send messages. 
        * RECEIVERONLY - Client can only receive messages. 
        Possible values = TRANSCEIVER, TRANSMITTERONLY, RECEIVERONLY 
    .PARAMETER Msgqueue 
        Queue SMPP messages if a client that is capable of receiving the destination address messages is not available. 
        Possible values = ON, OFF 
    .PARAMETER Msgqueuesize 
        Maximum number of SMPP messages that can be queued. After the limit is reached, the Citrix ADC sends a deliver_sm_resp PDU, with an appropriate error message, to the message center. 
    .PARAMETER Addrton 
        Type of Number, such as an international number or a national number, used in the ESME address sent in the bind request. 
    .PARAMETER Addrnpi 
        Numbering Plan Indicator, such as landline, data, or WAP client, used in the ESME address sent in the bind request. 
    .PARAMETER Addrrange 
        Set of SME addresses, sent in the bind request, serviced by the ESME.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSmppparam 
        An example how to unset smppparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSmppparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam
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

        [Boolean]$clientmode,

        [Boolean]$msgqueue,

        [Boolean]$msgqueuesize,

        [Boolean]$addrton,

        [Boolean]$addrnpi,

        [Boolean]$addrrange 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSmppparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('clientmode') ) { $payload.Add('clientmode', $clientmode) }
            if ( $PSBoundParameters.ContainsKey('msgqueue') ) { $payload.Add('msgqueue', $msgqueue) }
            if ( $PSBoundParameters.ContainsKey('msgqueuesize') ) { $payload.Add('msgqueuesize', $msgqueuesize) }
            if ( $PSBoundParameters.ContainsKey('addrton') ) { $payload.Add('addrton', $addrton) }
            if ( $PSBoundParameters.ContainsKey('addrnpi') ) { $payload.Add('addrnpi', $addrnpi) }
            if ( $PSBoundParameters.ContainsKey('addrrange') ) { $payload.Add('addrrange', $addrrange) }
            if ( $PSCmdlet.ShouldProcess("smppparam", "Unset Smpp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type smppparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Smpp configuration object(s).
    .DESCRIPTION
        Configuration for SMPP configuration parameters resource.
    .PARAMETER GetAll 
        Retrieve all smppparam object(s).
    .PARAMETER Count
        If specified, the count of the smppparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSmppparam -GetAll 
        Get all smppparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppparam -name <string>
        Get smppparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppparam -Filter @{ 'name'='<value>' }
        Get smppparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSmppparam
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppparam/
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
        Write-Verbose "Invoke-ADCGetSmppparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all smppparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for smppparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving smppparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving smppparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving smppparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Smpp configuration Object.
    .DESCRIPTION
        Configuration for SMPP user resource.
    .PARAMETER Username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server. 
    .PARAMETER Password 
        Password for binding to the SMPP server. Must be the same as the password specified in the SMPP server. 
    .PARAMETER PassThru 
        Return details about the created smppuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSmppuser -username <string>
        An example how to add smppuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSmppuser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSmppuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("smppuser", "Add Smpp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type smppuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSmppuser -Filter $payload)
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
        Delete Smpp configuration Object.
    .DESCRIPTION
        Configuration for SMPP user resource.
    .PARAMETER Username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSmppuser -Username <string>
        An example how to delete smppuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSmppuser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$Username 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteSmppuser: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$username", "Delete Smpp configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type smppuser -NitroPath nitro/v1/config -Resource $username -Arguments $arguments
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
        Update Smpp configuration Object.
    .DESCRIPTION
        Configuration for SMPP user resource.
    .PARAMETER Username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server. 
    .PARAMETER Password 
        Password for binding to the SMPP server. Must be the same as the password specified in the SMPP server. 
    .PARAMETER PassThru 
        Return details about the created smppuser item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSmppuser -username <string>
        An example how to update smppuser configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSmppuser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [string]$Username,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Password,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSmppuser: Starting"
    }
    process {
        try {
            $payload = @{ username = $username }
            if ( $PSBoundParameters.ContainsKey('password') ) { $payload.Add('password', $password) }
            if ( $PSCmdlet.ShouldProcess("smppuser", "Update Smpp configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type smppuser -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSmppuser -Filter $payload)
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
        Get Smpp configuration object(s).
    .DESCRIPTION
        Configuration for SMPP user resource.
    .PARAMETER Username 
        Name of the SMPP user. Must be the same as the user name specified in the SMPP server. 
    .PARAMETER GetAll 
        Retrieve all smppuser object(s).
    .PARAMETER Count
        If specified, the count of the smppuser object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppuser
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSmppuser -GetAll 
        Get all smppuser data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSmppuser -Count 
        Get the number of smppuser objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppuser -name <string>
        Get smppuser object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSmppuser -Filter @{ 'name'='<value>' }
        Get smppuser data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSmppuser
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/smpp/smppuser/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Username,

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
        Write-Verbose "Invoke-ADCGetSmppuser: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all smppuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for smppuser objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving smppuser objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving smppuser configuration for property 'username'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Resource $username -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving smppuser configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type smppuser -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


