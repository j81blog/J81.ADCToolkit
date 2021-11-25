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


