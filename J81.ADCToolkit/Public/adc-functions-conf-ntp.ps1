function Invoke-ADCUpdateNtpparam {
<#
    .SYNOPSIS
        Update NTP configuration Object
    .DESCRIPTION
        Update NTP configuration Object 
    .PARAMETER authentication 
        Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted.  
        Default value: YES  
        Possible values = YES, NO 
    .PARAMETER trustedkey 
        Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file.  
        Minimum value = 1  
        Maximum value = 65534 
    .PARAMETER autokeylogsec 
        Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2.  
        Default value: 12  
        Minimum value = 0  
        Maximum value = 32 
    .PARAMETER revokelogsec 
        Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms.  
        Default value: 16  
        Minimum value = 0  
        Maximum value = 32
    .EXAMPLE
        Invoke-ADCUpdateNtpparam 
    .NOTES
        File Name : Invoke-ADCUpdateNtpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam/
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

        [ValidateSet('YES', 'NO')]
        [string]$authentication ,

        [ValidateRange(1, 65534)]
        [double[]]$trustedkey ,

        [ValidateRange(0, 32)]
        [double]$autokeylogsec ,

        [ValidateRange(0, 32)]
        [double]$revokelogsec 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateNtpparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('trustedkey')) { $Payload.Add('trustedkey', $trustedkey) }
            if ($PSBoundParameters.ContainsKey('autokeylogsec')) { $Payload.Add('autokeylogsec', $autokeylogsec) }
            if ($PSBoundParameters.ContainsKey('revokelogsec')) { $Payload.Add('revokelogsec', $revokelogsec) }
 
            if ($PSCmdlet.ShouldProcess("ntpparam", "Update NTP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ntpparam -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateNtpparam: Finished"
    }
}

function Invoke-ADCUnsetNtpparam {
<#
    .SYNOPSIS
        Unset NTP configuration Object
    .DESCRIPTION
        Unset NTP configuration Object 
   .PARAMETER authentication 
       Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted.  
       Possible values = YES, NO 
   .PARAMETER trustedkey 
       Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file. 
   .PARAMETER autokeylogsec 
       Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2. 
   .PARAMETER revokelogsec 
       Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms.
    .EXAMPLE
        Invoke-ADCUnsetNtpparam 
    .NOTES
        File Name : Invoke-ADCUnsetNtpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam
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

        [Boolean]$authentication ,

        [Boolean]$trustedkey ,

        [Boolean]$autokeylogsec ,

        [Boolean]$revokelogsec 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetNtpparam: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('trustedkey')) { $Payload.Add('trustedkey', $trustedkey) }
            if ($PSBoundParameters.ContainsKey('autokeylogsec')) { $Payload.Add('autokeylogsec', $autokeylogsec) }
            if ($PSBoundParameters.ContainsKey('revokelogsec')) { $Payload.Add('revokelogsec', $revokelogsec) }
            if ($PSCmdlet.ShouldProcess("ntpparam", "Unset NTP configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ntpparam -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetNtpparam: Finished"
    }
}

function Invoke-ADCGetNtpparam {
<#
    .SYNOPSIS
        Get NTP configuration object(s)
    .DESCRIPTION
        Get NTP configuration object(s)
    .PARAMETER GetAll 
        Retreive all ntpparam object(s)
    .PARAMETER Count
        If specified, the count of the ntpparam object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNtpparam
    .EXAMPLE 
        Invoke-ADCGetNtpparam -GetAll
    .EXAMPLE
        Invoke-ADCGetNtpparam -name <string>
    .EXAMPLE
        Invoke-ADCGetNtpparam -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNtpparam
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam/
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
        Write-Verbose "Invoke-ADCGetNtpparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ntpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpparam objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNtpparam: Ended"
    }
}

function Invoke-ADCAddNtpserver {
<#
    .SYNOPSIS
        Add NTP configuration Object
    .DESCRIPTION
        Add NTP configuration Object 
    .PARAMETER serverip 
        IP address of the NTP server.  
        Minimum length = 1 
    .PARAMETER servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2.  
        Minimum value = 4  
        Maximum value = 17 
    .PARAMETER maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2.  
        Minimum value = 4  
        Maximum value = 17 
    .PARAMETER autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.  
        Minimum value = 1  
        Maximum value = 65534
    .EXAMPLE
        Invoke-ADCAddNtpserver 
    .NOTES
        File Name : Invoke-ADCAddNtpserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [string]$servername ,

        [ValidateRange(4, 17)]
        [double]$minpoll ,

        [ValidateRange(4, 17)]
        [double]$maxpoll ,

        [boolean]$autokey ,

        [ValidateRange(1, 65534)]
        [double]$key 

    )
    begin {
        Write-Verbose "Invoke-ADCAddNtpserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('minpoll')) { $Payload.Add('minpoll', $minpoll) }
            if ($PSBoundParameters.ContainsKey('maxpoll')) { $Payload.Add('maxpoll', $maxpoll) }
            if ($PSBoundParameters.ContainsKey('autokey')) { $Payload.Add('autokey', $autokey) }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
 
            if ($PSCmdlet.ShouldProcess("ntpserver", "Add NTP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
            Write-Output $result

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddNtpserver: Finished"
    }
}

function Invoke-ADCDeleteNtpserver {
<#
    .SYNOPSIS
        Delete NTP configuration Object
    .DESCRIPTION
        Delete NTP configuration Object
    .PARAMETER serverip 
       IP address of the NTP server.  
       Minimum length = 1    .PARAMETER servername 
       Fully qualified domain name of the NTP server.
    .EXAMPLE
        Invoke-ADCDeleteNtpserver -serverip <string>
    .NOTES
        File Name : Invoke-ADCDeleteNtpserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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
        [string]$serverip ,

        [string]$servername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteNtpserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('servername')) { $Arguments.Add('servername', $servername) }
            if ($PSCmdlet.ShouldProcess("$serverip", "Delete NTP configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ntpserver -NitroPath nitro/v1/config -Resource $serverip -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteNtpserver: Finished"
    }
}

function Invoke-ADCUpdateNtpserver {
<#
    .SYNOPSIS
        Update NTP configuration Object
    .DESCRIPTION
        Update NTP configuration Object 
    .PARAMETER serverip 
        IP address of the NTP server.  
        Minimum length = 1 
    .PARAMETER servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2.  
        Minimum value = 4  
        Maximum value = 17 
    .PARAMETER maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2.  
        Minimum value = 4  
        Maximum value = 17 
    .PARAMETER preferredntpserver 
        Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.  
        Minimum value = 1  
        Maximum value = 65534
    .EXAMPLE
        Invoke-ADCUpdateNtpserver 
    .NOTES
        File Name : Invoke-ADCUpdateNtpserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$serverip ,

        [string]$servername ,

        [ValidateRange(4, 17)]
        [double]$minpoll ,

        [ValidateRange(4, 17)]
        [double]$maxpoll ,

        [ValidateSet('YES', 'NO')]
        [string]$preferredntpserver ,

        [boolean]$autokey ,

        [ValidateRange(1, 65534)]
        [double]$key 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateNtpserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('minpoll')) { $Payload.Add('minpoll', $minpoll) }
            if ($PSBoundParameters.ContainsKey('maxpoll')) { $Payload.Add('maxpoll', $maxpoll) }
            if ($PSBoundParameters.ContainsKey('preferredntpserver')) { $Payload.Add('preferredntpserver', $preferredntpserver) }
            if ($PSBoundParameters.ContainsKey('autokey')) { $Payload.Add('autokey', $autokey) }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
 
            if ($PSCmdlet.ShouldProcess("ntpserver", "Update NTP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ntpserver -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateNtpserver: Finished"
    }
}

function Invoke-ADCUnsetNtpserver {
<#
    .SYNOPSIS
        Unset NTP configuration Object
    .DESCRIPTION
        Unset NTP configuration Object 
   .PARAMETER serverip 
       IP address of the NTP server. 
   .PARAMETER servername 
       Fully qualified domain name of the NTP server. 
   .PARAMETER autokey 
       Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
   .PARAMETER minpoll 
       Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
   .PARAMETER maxpoll 
       Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
   .PARAMETER preferredntpserver 
       Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts.  
       Possible values = YES, NO 
   .PARAMETER key 
       Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.
    .EXAMPLE
        Invoke-ADCUnsetNtpserver 
    .NOTES
        File Name : Invoke-ADCUnsetNtpserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver
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

        [Boolean]$serverip ,

        [Boolean]$servername ,

        [Boolean]$autokey ,

        [Boolean]$minpoll ,

        [Boolean]$maxpoll ,

        [Boolean]$preferredntpserver ,

        [Boolean]$key 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetNtpserver: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('serverip')) { $Payload.Add('serverip', $serverip) }
            if ($PSBoundParameters.ContainsKey('servername')) { $Payload.Add('servername', $servername) }
            if ($PSBoundParameters.ContainsKey('autokey')) { $Payload.Add('autokey', $autokey) }
            if ($PSBoundParameters.ContainsKey('minpoll')) { $Payload.Add('minpoll', $minpoll) }
            if ($PSBoundParameters.ContainsKey('maxpoll')) { $Payload.Add('maxpoll', $maxpoll) }
            if ($PSBoundParameters.ContainsKey('preferredntpserver')) { $Payload.Add('preferredntpserver', $preferredntpserver) }
            if ($PSBoundParameters.ContainsKey('key')) { $Payload.Add('key', $key) }
            if ($PSCmdlet.ShouldProcess("ntpserver", "Unset NTP configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ntpserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetNtpserver: Finished"
    }
}

function Invoke-ADCGetNtpserver {
<#
    .SYNOPSIS
        Get NTP configuration object(s)
    .DESCRIPTION
        Get NTP configuration object(s)
    .PARAMETER GetAll 
        Retreive all ntpserver object(s)
    .PARAMETER Count
        If specified, the count of the ntpserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNtpserver
    .EXAMPLE 
        Invoke-ADCGetNtpserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetNtpserver -Count
    .EXAMPLE
        Invoke-ADCGetNtpserver -name <string>
    .EXAMPLE
        Invoke-ADCGetNtpserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNtpserver
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetNtpserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ntpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNtpserver: Ended"
    }
}

function Invoke-ADCGetNtpstatus {
<#
    .SYNOPSIS
        Get NTP configuration object(s)
    .DESCRIPTION
        Get NTP configuration object(s)
    .PARAMETER GetAll 
        Retreive all ntpstatus object(s)
    .PARAMETER Count
        If specified, the count of the ntpstatus object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNtpstatus
    .EXAMPLE 
        Invoke-ADCGetNtpstatus -GetAll
    .EXAMPLE
        Invoke-ADCGetNtpstatus -name <string>
    .EXAMPLE
        Invoke-ADCGetNtpstatus -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNtpstatus
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpstatus/
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
        Write-Verbose "Invoke-ADCGetNtpstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ntpstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpstatus objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNtpstatus: Ended"
    }
}

function Invoke-ADCEnableNtpsync {
<#
    .SYNOPSIS
        Enable NTP configuration Object
    .DESCRIPTION
        Enable NTP configuration Object 
    .EXAMPLE
        Invoke-ADCEnableNtpsync 
    .NOTES
        File Name : Invoke-ADCEnableNtpsync
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCEnableNtpsync: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable NTP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action enable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableNtpsync: Finished"
    }
}

function Invoke-ADCDisableNtpsync {
<#
    .SYNOPSIS
        Disable NTP configuration Object
    .DESCRIPTION
        Disable NTP configuration Object 
    .EXAMPLE
        Invoke-ADCDisableNtpsync 
    .NOTES
        File Name : Invoke-ADCDisableNtpsync
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCDisableNtpsync: Starting"
    }
    process {
        try {
            $Payload = @{

            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable NTP configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action disable -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableNtpsync: Finished"
    }
}

function Invoke-ADCGetNtpsync {
<#
    .SYNOPSIS
        Get NTP configuration object(s)
    .DESCRIPTION
        Get NTP configuration object(s)
    .PARAMETER GetAll 
        Retreive all ntpsync object(s)
    .PARAMETER Count
        If specified, the count of the ntpsync object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetNtpsync
    .EXAMPLE 
        Invoke-ADCGetNtpsync -GetAll
    .EXAMPLE
        Invoke-ADCGetNtpsync -name <string>
    .EXAMPLE
        Invoke-ADCGetNtpsync -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetNtpsync
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCGetNtpsync: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ntpsync objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpsync objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpsync objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpsync configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpsync configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetNtpsync: Ended"
    }
}


