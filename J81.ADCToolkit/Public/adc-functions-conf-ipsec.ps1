function Invoke-ADCUpdateIpsecparameter {
<#
    .SYNOPSIS
        Update Ipsec configuration Object
    .DESCRIPTION
        Update Ipsec configuration Object 
    .PARAMETER ikeversion 
        IKE Protocol Version.  
        Default value: V2  
        Possible values = V1, V2 
    .PARAMETER encalgo 
        Type of encryption algorithm (Note: Selection of AES enables AES128).  
        Default value: AES  
        Possible values = AES, 3DES, AES192, AES256 
    .PARAMETER hashalgo 
        Type of hashing algorithm.  
        Default value: HMAC_SHA256  
        Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
    .PARAMETER lifetime 
        Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8).  
        Minimum value = 480  
        Maximum value = 31536000 
    .PARAMETER livenesscheckinterval 
        Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks.  
        Minimum value = 0  
        Maximum value = 64999 
    .PARAMETER replaywindowsize 
        IPSec Replay window size for the data traffic.  
        Minimum value = 0  
        Maximum value = 16384 
    .PARAMETER ikeretryinterval 
        IKE retry interval for bringing up the connection.  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER perfectforwardsecrecy 
        Enable/Disable PFS.  
        Default value: DISABLE  
        Possible values = ENABLE, DISABLE 
    .PARAMETER retransmissiontime 
        The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure,  
        increases for every retransmit till 6 retransmits.  
        Minimum value = 1  
        Maximum value = 99
    .EXAMPLE
        Invoke-ADCUpdateIpsecparameter 
    .NOTES
        File Name : Invoke-ADCUpdateIpsecparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter/
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

        [ValidateSet('V1', 'V2')]
        [string]$ikeversion ,

        [ValidateSet('AES', '3DES', 'AES192', 'AES256')]
        [string[]]$encalgo ,

        [ValidateSet('HMAC_SHA1', 'HMAC_SHA256', 'HMAC_SHA384', 'HMAC_SHA512', 'HMAC_MD5')]
        [string[]]$hashalgo ,

        [ValidateRange(480, 31536000)]
        [double]$lifetime ,

        [ValidateRange(0, 64999)]
        [double]$livenesscheckinterval ,

        [ValidateRange(0, 16384)]
        [double]$replaywindowsize ,

        [ValidateRange(60, 3600)]
        [double]$ikeretryinterval ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$perfectforwardsecrecy ,

        [ValidateRange(1, 99)]
        [double]$retransmissiontime 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateIpsecparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ikeversion')) { $Payload.Add('ikeversion', $ikeversion) }
            if ($PSBoundParameters.ContainsKey('encalgo')) { $Payload.Add('encalgo', $encalgo) }
            if ($PSBoundParameters.ContainsKey('hashalgo')) { $Payload.Add('hashalgo', $hashalgo) }
            if ($PSBoundParameters.ContainsKey('lifetime')) { $Payload.Add('lifetime', $lifetime) }
            if ($PSBoundParameters.ContainsKey('livenesscheckinterval')) { $Payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ($PSBoundParameters.ContainsKey('replaywindowsize')) { $Payload.Add('replaywindowsize', $replaywindowsize) }
            if ($PSBoundParameters.ContainsKey('ikeretryinterval')) { $Payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ($PSBoundParameters.ContainsKey('perfectforwardsecrecy')) { $Payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
            if ($PSBoundParameters.ContainsKey('retransmissiontime')) { $Payload.Add('retransmissiontime', $retransmissiontime) }
 
            if ($PSCmdlet.ShouldProcess("ipsecparameter", "Update Ipsec configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ipsecparameter -Payload $Payload -GetWarning
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
        Unset Ipsec configuration Object
    .DESCRIPTION
        Unset Ipsec configuration Object 
   .PARAMETER ikeversion 
       IKE Protocol Version.  
       Possible values = V1, V2 
   .PARAMETER encalgo 
       Type of encryption algorithm (Note: Selection of AES enables AES128).  
       Possible values = AES, 3DES, AES192, AES256 
   .PARAMETER hashalgo 
       Type of hashing algorithm.  
       Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
   .PARAMETER lifetime 
       Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8). 
   .PARAMETER livenesscheckinterval 
       Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks. 
   .PARAMETER replaywindowsize 
       IPSec Replay window size for the data traffic. 
   .PARAMETER ikeretryinterval 
       IKE retry interval for bringing up the connection. 
   .PARAMETER perfectforwardsecrecy 
       Enable/Disable PFS.  
       Possible values = ENABLE, DISABLE 
   .PARAMETER retransmissiontime 
       The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure,  
       increases for every retransmit till 6 retransmits.
    .EXAMPLE
        Invoke-ADCUnsetIpsecparameter 
    .NOTES
        File Name : Invoke-ADCUnsetIpsecparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter
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

        [Boolean]$ikeversion ,

        [Boolean]$encalgo ,

        [Boolean]$hashalgo ,

        [Boolean]$lifetime ,

        [Boolean]$livenesscheckinterval ,

        [Boolean]$replaywindowsize ,

        [Boolean]$ikeretryinterval ,

        [Boolean]$perfectforwardsecrecy ,

        [Boolean]$retransmissiontime 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetIpsecparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('ikeversion')) { $Payload.Add('ikeversion', $ikeversion) }
            if ($PSBoundParameters.ContainsKey('encalgo')) { $Payload.Add('encalgo', $encalgo) }
            if ($PSBoundParameters.ContainsKey('hashalgo')) { $Payload.Add('hashalgo', $hashalgo) }
            if ($PSBoundParameters.ContainsKey('lifetime')) { $Payload.Add('lifetime', $lifetime) }
            if ($PSBoundParameters.ContainsKey('livenesscheckinterval')) { $Payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ($PSBoundParameters.ContainsKey('replaywindowsize')) { $Payload.Add('replaywindowsize', $replaywindowsize) }
            if ($PSBoundParameters.ContainsKey('ikeretryinterval')) { $Payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ($PSBoundParameters.ContainsKey('perfectforwardsecrecy')) { $Payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
            if ($PSBoundParameters.ContainsKey('retransmissiontime')) { $Payload.Add('retransmissiontime', $retransmissiontime) }
            if ($PSCmdlet.ShouldProcess("ipsecparameter", "Unset Ipsec configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ipsecparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Ipsec configuration object(s)
    .DESCRIPTION
        Get Ipsec configuration object(s)
    .PARAMETER GetAll 
        Retreive all ipsecparameter object(s)
    .PARAMETER Count
        If specified, the count of the ipsecparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIpsecparameter
    .EXAMPLE 
        Invoke-ADCGetIpsecparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetIpsecparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetIpsecparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIpsecparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecparameter/
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
        Write-Verbose "Invoke-ADCGetIpsecparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ipsecparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving ipsecparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Ipsec configuration Object
    .DESCRIPTION
        Add Ipsec configuration Object 
    .PARAMETER name 
        The name of the ipsec profile.  
        Minimum length = 1  
        Maximum length = 32 
    .PARAMETER ikeversion 
        IKE Protocol Version.  
        Possible values = V1, V2 
    .PARAMETER encalgo 
        Type of encryption algorithm (Note: Selection of AES enables AES128).  
        Possible values = AES, 3DES, AES192, AES256 
    .PARAMETER hashalgo 
        Type of hashing algorithm.  
        Possible values = HMAC_SHA1, HMAC_SHA256, HMAC_SHA384, HMAC_SHA512, HMAC_MD5 
    .PARAMETER lifetime 
        Lifetime of IKE SA in seconds. Lifetime of IPSec SA will be (lifetime of IKE SA/8).  
        Minimum value = 480  
        Maximum value = 31536000 
    .PARAMETER psk 
        Pre shared key value. 
    .PARAMETER publickey 
        Public key file path. 
    .PARAMETER privatekey 
        Private key file path. 
    .PARAMETER peerpublickey 
        Peer public key file path. 
    .PARAMETER livenesscheckinterval 
        Number of seconds after which a notify payload is sent to check the liveliness of the peer. Additional retries are done as per retransmit interval setting. Zero value disables liveliness checks.  
        Minimum value = 0  
        Maximum value = 64999 
    .PARAMETER replaywindowsize 
        IPSec Replay window size for the data traffic.  
        Minimum value = 0  
        Maximum value = 16384 
    .PARAMETER ikeretryinterval 
        IKE retry interval for bringing up the connection.  
        Minimum value = 60  
        Maximum value = 3600 
    .PARAMETER retransmissiontime 
        The interval in seconds to retry sending the IKE messages to peer, three consecutive attempts are done with doubled interval after every failure.  
        Minimum value = 1  
        Maximum value = 99 
    .PARAMETER perfectforwardsecrecy 
        Enable/Disable PFS.  
        Possible values = ENABLE, DISABLE 
    .PARAMETER PassThru 
        Return details about the created ipsecprofile item.
    .EXAMPLE
        Invoke-ADCAddIpsecprofile -name <string>
    .NOTES
        File Name : Invoke-ADCAddIpsecprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        [ValidateLength(1, 32)]
        [string]$name ,

        [ValidateSet('V1', 'V2')]
        [string]$ikeversion ,

        [ValidateSet('AES', '3DES', 'AES192', 'AES256')]
        [string[]]$encalgo ,

        [ValidateSet('HMAC_SHA1', 'HMAC_SHA256', 'HMAC_SHA384', 'HMAC_SHA512', 'HMAC_MD5')]
        [string[]]$hashalgo ,

        [ValidateRange(480, 31536000)]
        [double]$lifetime ,

        [string]$psk ,

        [string]$publickey ,

        [string]$privatekey ,

        [string]$peerpublickey ,

        [ValidateRange(0, 64999)]
        [double]$livenesscheckinterval ,

        [ValidateRange(0, 16384)]
        [double]$replaywindowsize ,

        [ValidateRange(60, 3600)]
        [double]$ikeretryinterval ,

        [ValidateRange(1, 99)]
        [double]$retransmissiontime ,

        [ValidateSet('ENABLE', 'DISABLE')]
        [string]$perfectforwardsecrecy ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddIpsecprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ikeversion')) { $Payload.Add('ikeversion', $ikeversion) }
            if ($PSBoundParameters.ContainsKey('encalgo')) { $Payload.Add('encalgo', $encalgo) }
            if ($PSBoundParameters.ContainsKey('hashalgo')) { $Payload.Add('hashalgo', $hashalgo) }
            if ($PSBoundParameters.ContainsKey('lifetime')) { $Payload.Add('lifetime', $lifetime) }
            if ($PSBoundParameters.ContainsKey('psk')) { $Payload.Add('psk', $psk) }
            if ($PSBoundParameters.ContainsKey('publickey')) { $Payload.Add('publickey', $publickey) }
            if ($PSBoundParameters.ContainsKey('privatekey')) { $Payload.Add('privatekey', $privatekey) }
            if ($PSBoundParameters.ContainsKey('peerpublickey')) { $Payload.Add('peerpublickey', $peerpublickey) }
            if ($PSBoundParameters.ContainsKey('livenesscheckinterval')) { $Payload.Add('livenesscheckinterval', $livenesscheckinterval) }
            if ($PSBoundParameters.ContainsKey('replaywindowsize')) { $Payload.Add('replaywindowsize', $replaywindowsize) }
            if ($PSBoundParameters.ContainsKey('ikeretryinterval')) { $Payload.Add('ikeretryinterval', $ikeretryinterval) }
            if ($PSBoundParameters.ContainsKey('retransmissiontime')) { $Payload.Add('retransmissiontime', $retransmissiontime) }
            if ($PSBoundParameters.ContainsKey('perfectforwardsecrecy')) { $Payload.Add('perfectforwardsecrecy', $perfectforwardsecrecy) }
 
            if ($PSCmdlet.ShouldProcess("ipsecprofile", "Add Ipsec configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ipsecprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetIpsecprofile -Filter $Payload)
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
        Delete Ipsec configuration Object
    .DESCRIPTION
        Delete Ipsec configuration Object
    .PARAMETER name 
       The name of the ipsec profile.  
       Minimum length = 1  
       Maximum length = 32 
    .EXAMPLE
        Invoke-ADCDeleteIpsecprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteIpsecprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteIpsecprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Ipsec configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ipsecprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Ipsec configuration object(s)
    .DESCRIPTION
        Get Ipsec configuration object(s)
    .PARAMETER name 
       The name of the ipsec profile. 
    .PARAMETER GetAll 
        Retreive all ipsecprofile object(s)
    .PARAMETER Count
        If specified, the count of the ipsecprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetIpsecprofile
    .EXAMPLE 
        Invoke-ADCGetIpsecprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetIpsecprofile -Count
    .EXAMPLE
        Invoke-ADCGetIpsecprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetIpsecprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetIpsecprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ipsec/ipsecprofile/
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
        [ValidateLength(1, 32)]
        [string]$name,

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
        Write-Verbose "Invoke-ADCGetIpsecprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ipsecprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ipsecprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ipsecprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ipsecprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ipsecprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ipsecprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


