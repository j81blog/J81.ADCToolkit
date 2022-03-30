function Invoke-ADCUpdateIpsecparameter {
    <#
    .SYNOPSIS
        Update Ipsec configuration Object.
    .DESCRIPTION
        Configuration for IPSEC paramter resource.
    .PARAMETER Ikeversion 
        IKE Protocol Version. 
        Possible values = V1, V2 
    .PARAMETER Encalgo 
        Type of encryption algorithm (Note: Selection of AES enables AES128). 
        Possible values = AES, 3DES, AES192, AES256 
    .PARAMETER Hashalgo 
        Type of hashing algorithm. 
        Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
    .PARAMETER Lifetime 
        Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8). 
    .PARAMETER Livenesscheckinterval 
        Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks. 
    .PARAMETER Replaywindowsize 
        IPSec Replay window size for the data traffic. 
    .PARAMETER Ikeretryinterval 
        IKE retry interval for bringing up the connection. 
    .PARAMETER Perfectforwardsecrecy 
        Enable/Disable PFS. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Retransmissiontime 
        The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure, 
        increases for every retransmit till 6 retransmits.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateIpsecparameter 
        An example how to update ipsecparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateIpsecparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter/
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

        [ValidateSet('V1', 'V2')]
        [string]$Ikeversion,

        [ValidateSet('AES', '3DES', 'AES192', 'AES256')]
        [string[]]$Encalgo,

        [ValidateSet('HMAC_SHA1', 'HMAC_SHA256', 'HMAC_SHA384', 'HMAC_SHA512', 'HMAC_MD5')]
        [string[]]$Hashalgo,

        [ValidateRange(480, 31536000)]
        [double]$Lifetime,

        [ValidateRange(0, 64999)]
        [double]$Livenesscheckinterval,

        [ValidateRange(0, 16384)]
        [double]$Replaywindowsize,

        [ValidateRange(60, 3600)]
        [double]$Ikeretryinterval,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Perfectforwardsecrecy,

        [ValidateRange(1, 99)]
        [double]$Retransmissiontime 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIpsecparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ikeversion') ) { $payload.Add('ikeversion', $ikeversion) }
            if ( $PSBoundParameters.ContainsKey('encalgo') ) { $payload.Add('encalgo', $encalgo) }
            if ( $PSBoundParameters.ContainsKey('hashalgo') ) { $payload.Add('hashalgo', $hashalgo) }
            if ( $PSBoundParameters.ContainsKey('lifetime') ) { $payload.Add('lifetime', $lifetime) }
            if ( $PSBoundParameters.ContainsKey('livenesscheckinterval') ) { $payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ( $PSBoundParameters.ContainsKey('replaywindowsize') ) { $payload.Add('replaywindowsize', $replaywindowsize) }
            if ( $PSBoundParameters.ContainsKey('ikeretryinterval') ) { $payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ( $PSBoundParameters.ContainsKey('perfectforwardsecrecy') ) { $payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
            if ( $PSBoundParameters.ContainsKey('retransmissiontime') ) { $payload.Add('retransmissiontime', $retransmissiontime) }
            if ( $PSCmdlet.ShouldProcess("ipsecparameter", "Update Ipsec configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ipsecparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateIpsecparameter: Finished"
    }
}

function Invoke-ADCUnsetIpsecparameter {
    <#
    .SYNOPSIS
        Unset Ipsec configuration Object.
    .DESCRIPTION
        Configuration for IPSEC paramter resource.
    .PARAMETER Ikeversion 
        IKE Protocol Version. 
        Possible values = V1, V2 
    .PARAMETER Encalgo 
        Type of encryption algorithm (Note: Selection of AES enables AES128). 
        Possible values = AES, 3DES, AES192, AES256 
    .PARAMETER Hashalgo 
        Type of hashing algorithm. 
        Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
    .PARAMETER Lifetime 
        Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8). 
    .PARAMETER Livenesscheckinterval 
        Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks. 
    .PARAMETER Replaywindowsize 
        IPSec Replay window size for the data traffic. 
    .PARAMETER Ikeretryinterval 
        IKE retry interval for bringing up the connection. 
    .PARAMETER Perfectforwardsecrecy 
        Enable/Disable PFS. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER Retransmissiontime 
        The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure, 
        increases for every retransmit till 6 retransmits.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetIpsecparameter 
        An example how to unset ipsecparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetIpsecparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter
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

        [Boolean]$ikeversion,

        [Boolean]$encalgo,

        [Boolean]$hashalgo,

        [Boolean]$lifetime,

        [Boolean]$livenesscheckinterval,

        [Boolean]$replaywindowsize,

        [Boolean]$ikeretryinterval,

        [Boolean]$perfectforwardsecrecy,

        [Boolean]$retransmissiontime 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIpsecparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('ikeversion') ) { $payload.Add('ikeversion', $ikeversion) }
            if ( $PSBoundParameters.ContainsKey('encalgo') ) { $payload.Add('encalgo', $encalgo) }
            if ( $PSBoundParameters.ContainsKey('hashalgo') ) { $payload.Add('hashalgo', $hashalgo) }
            if ( $PSBoundParameters.ContainsKey('lifetime') ) { $payload.Add('lifetime', $lifetime) }
            if ( $PSBoundParameters.ContainsKey('livenesscheckinterval') ) { $payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ( $PSBoundParameters.ContainsKey('replaywindowsize') ) { $payload.Add('replaywindowsize', $replaywindowsize) }
            if ( $PSBoundParameters.ContainsKey('ikeretryinterval') ) { $payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ( $PSBoundParameters.ContainsKey('perfectforwardsecrecy') ) { $payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
            if ( $PSBoundParameters.ContainsKey('retransmissiontime') ) { $payload.Add('retransmissiontime', $retransmissiontime) }
            if ( $PSCmdlet.ShouldProcess("ipsecparameter", "Unset Ipsec configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ipsecparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetIpsecparameter: Finished"
    }
}

function Invoke-ADCGetIpsecparameter {
    <#
    .SYNOPSIS
        Get Ipsec configuration object(s).
    .DESCRIPTION
        Configuration for IPSEC paramter resource.
    .PARAMETER GetAll 
        Retrieve all ipsecparameter object(s).
    .PARAMETER Count
        If specified, the count of the ipsecparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecparameter -GetAll 
        Get all ipsecparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecparameter -name <string>
        Get ipsecparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecparameter -Filter @{ 'name'='<value>' }
        Get ipsecparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIpsecparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter/
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
        Write-Verbose "Invoke-ADCGetIpsecparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ipsecparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving ipsecparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIpsecparameter: Ended"
    }
}

function Invoke-ADCAddIpsecprofile {
    <#
    .SYNOPSIS
        Add Ipsec configuration Object.
    .DESCRIPTION
        Configuration for IPSEC profile resource.
    .PARAMETER Name 
        The name of the ipsec profile. 
    .PARAMETER Ikeversion 
        IKE Protocol Version. 
        Possible values = V1, V2 
    .PARAMETER Encalgo 
        Type of encryption algorithm (Note: Selection of AES enables AES128). 
        Possible values = AES, 3DES, AES192, AES256 
    .PARAMETER Hashalgo 
        Type of hashing algorithm. 
        Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
    .PARAMETER Lifetime 
        Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8). 
    .PARAMETER Psk 
        Pre shared key value. 
    .PARAMETER Publickey 
        Public key file path. 
    .PARAMETER Privatekey 
        Private key file path. 
    .PARAMETER Peerpublickey 
        Peer public key file path. 
    .PARAMETER Livenesscheckinterval 
        Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks. 
    .PARAMETER Replaywindowsize 
        IPSec Replay window size for the data traffic. 
    .PARAMETER Ikeretryinterval 
        IKE retry interval for bringing up the connection. 
    .PARAMETER Retransmissiontime 
        The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure. 
    .PARAMETER Perfectforwardsecrecy 
        Enable/Disable PFS. 
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created ipsecprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddIpsecprofile -name <string>
        An example how to add ipsecprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddIpsecprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        [ValidateLength(1, 32)]
        [string]$Name,

        [ValidateSet('V1', 'V2')]
        [string]$Ikeversion,

        [ValidateSet('AES', '3DES', 'AES192', 'AES256')]
        [string[]]$Encalgo,

        [ValidateSet('HMAC_SHA1', 'HMAC_SHA256', 'HMAC_SHA384', 'HMAC_SHA512', 'HMAC_MD5')]
        [string[]]$Hashalgo,

        [ValidateRange(480, 31536000)]
        [double]$Lifetime,

        [string]$Psk,

        [string]$Publickey,

        [string]$Privatekey,

        [string]$Peerpublickey,

        [ValidateRange(0, 64999)]
        [double]$Livenesscheckinterval,

        [ValidateRange(0, 16384)]
        [double]$Replaywindowsize,

        [ValidateRange(60, 3600)]
        [double]$Ikeretryinterval,

        [ValidateRange(1, 99)]
        [double]$Retransmissiontime,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$Perfectforwardsecrecy,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddIpsecprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ikeversion') ) { $payload.Add('ikeversion', $ikeversion) }
            if ( $PSBoundParameters.ContainsKey('encalgo') ) { $payload.Add('encalgo', $encalgo) }
            if ( $PSBoundParameters.ContainsKey('hashalgo') ) { $payload.Add('hashalgo', $hashalgo) }
            if ( $PSBoundParameters.ContainsKey('lifetime') ) { $payload.Add('lifetime', $lifetime) }
            if ( $PSBoundParameters.ContainsKey('psk') ) { $payload.Add('psk', $psk) }
            if ( $PSBoundParameters.ContainsKey('publickey') ) { $payload.Add('publickey', $publickey) }
            if ( $PSBoundParameters.ContainsKey('privatekey') ) { $payload.Add('privatekey', $privatekey) }
            if ( $PSBoundParameters.ContainsKey('peerpublickey') ) { $payload.Add('peerpublickey', $peerpublickey) }
            if ( $PSBoundParameters.ContainsKey('livenesscheckinterval') ) { $payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ( $PSBoundParameters.ContainsKey('replaywindowsize') ) { $payload.Add('replaywindowsize', $replaywindowsize) }
            if ( $PSBoundParameters.ContainsKey('ikeretryinterval') ) { $payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ( $PSBoundParameters.ContainsKey('retransmissiontime') ) { $payload.Add('retransmissiontime', $retransmissiontime) }
            if ( $PSBoundParameters.ContainsKey('perfectforwardsecrecy') ) { $payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
            if ( $PSCmdlet.ShouldProcess("ipsecprofile", "Add Ipsec configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetIpsecprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddIpsecprofile: Finished"
    }
}

function Invoke-ADCDeleteIpsecprofile {
    <#
    .SYNOPSIS
        Delete Ipsec configuration Object.
    .DESCRIPTION
        Configuration for IPSEC profile resource.
    .PARAMETER Name 
        The name of the ipsec profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteIpsecprofile -Name <string>
        An example how to delete ipsecprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteIpsecprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        Write-Verbose "Invoke-ADCDeleteIpsecprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Ipsec configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ipsecprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteIpsecprofile: Finished"
    }
}

function Invoke-ADCGetIpsecprofile {
    <#
    .SYNOPSIS
        Get Ipsec configuration object(s).
    .DESCRIPTION
        Configuration for IPSEC profile resource.
    .PARAMETER Name 
        The name of the ipsec profile. 
    .PARAMETER GetAll 
        Retrieve all ipsecprofile object(s).
    .PARAMETER Count
        If specified, the count of the ipsecprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecprofile -GetAll 
        Get all ipsecprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetIpsecprofile -Count 
        Get the number of ipsecprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecprofile -name <string>
        Get ipsecprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetIpsecprofile -Filter @{ 'name'='<value>' }
        Get ipsecprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetIpsecprofile
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        [ValidateLength(1, 32)]
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
        Write-Verbose "Invoke-ADCGetIpsecprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ipsecprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ipsecprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetIpsecprofile: Ended"
    }
}

# SIG # Begin signature block
# MIITYgYJKoZIhvcNAQcCoIITUzCCE08CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBNBhBGGuuDunuN
# 1i5li0OOPjItXyuULbHC3KOK/DhouqCCEHUwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMYICQzCCAj8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZ
# BgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
# A1UEChMPU2VjdGlnbyBMaW1pdGVkMSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2Rl
# IFNpZ25pbmcgQ0ECECwnTfNkELSL/bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQx
# IgQgYnLVdHTYGeIImjhCl7eC3NuV025DBrUyRb91Elfu2g8wDQYJKoZIhvcNAQEB
# BQAEggEAmS7D2JANCQ00PDkX6qJ4uxVVlg0xpdN9+t7+h5Lai6dEuBAKi0fqhWMY
# la3kTjkgKcuy9vBu6HFBEqmUGOpx9aH1oZdEBKVsvOvD4T3btluT3ZGCif8UOZRJ
# Xi+3QYtJXrq/HPyiCdjSp27tjJUQ+3Z4r5oLJH/4k0WRPwGcRAvhx3Frn+fv5Vsb
# ULOnN9qroLYKtNVRrSPX8KAHW9ak8m77b8hKKSlyLOeBKf0wPJyIhSaFrktbwvAR
# Ee8KWOw8DhgwFYsdF7vCvkTmuCd1zhCrbfUSJenevyv8ojZx7tFG23xVlhEIZ2c7
# FAa5+QRdI/V1BLsGvA9ydWa08UAO1g==
# SIG # End signature block
