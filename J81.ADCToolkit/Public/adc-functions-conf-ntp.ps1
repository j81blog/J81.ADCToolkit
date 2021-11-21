function Invoke-ADCUpdateNtpparam {
    <#
    .SYNOPSIS
        Update NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER Authentication 
        Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted. 
        Possible values = YES, NO 
    .PARAMETER Trustedkey 
        Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file. 
    .PARAMETER Autokeylogsec 
        Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2. 
    .PARAMETER Revokelogsec 
        Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateNtpparam 
        An example how to update ntpparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateNtpparam
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam/
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

        [ValidateSet('YES', 'NO')]
        [string]$Authentication,

        [ValidateRange(1, 65534)]
        [double[]]$Trustedkey,

        [ValidateRange(0, 32)]
        [double]$Autokeylogsec,

        [ValidateRange(0, 32)]
        [double]$Revokelogsec 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateNtpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('trustedkey') ) { $payload.Add('trustedkey', $trustedkey) }
            if ( $PSBoundParameters.ContainsKey('autokeylogsec') ) { $payload.Add('autokeylogsec', $autokeylogsec) }
            if ( $PSBoundParameters.ContainsKey('revokelogsec') ) { $payload.Add('revokelogsec', $revokelogsec) }
            if ( $PSCmdlet.ShouldProcess("ntpparam", "Update NTP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ntpparam -Payload $payload -GetWarning
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
        Unset NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER Authentication 
        Apply NTP authentication, which enables the NTP client (Citrix ADC) to verify that the server is in fact known and trusted. 
        Possible values = YES, NO 
    .PARAMETER Trustedkey 
        Key identifiers that are trusted for server authentication with symmetric key cryptography in the keys file. 
    .PARAMETER Autokeylogsec 
        Autokey protocol requires the keys to be refreshed periodically. This parameter specifies the interval between regenerations of new session keys. In seconds, expressed as a power of 2. 
    .PARAMETER Revokelogsec 
        Interval between re-randomizations of the autokey seeds to prevent brute-force attacks on the autokey algorithms.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetNtpparam 
        An example how to unset ntpparam configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetNtpparam
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam
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

        [Boolean]$authentication,

        [Boolean]$trustedkey,

        [Boolean]$autokeylogsec,

        [Boolean]$revokelogsec 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetNtpparam: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('trustedkey') ) { $payload.Add('trustedkey', $trustedkey) }
            if ( $PSBoundParameters.ContainsKey('autokeylogsec') ) { $payload.Add('autokeylogsec', $autokeylogsec) }
            if ( $PSBoundParameters.ContainsKey('revokelogsec') ) { $payload.Add('revokelogsec', $revokelogsec) }
            if ( $PSCmdlet.ShouldProcess("ntpparam", "Unset NTP configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ntpparam -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get NTP configuration object(s).
    .DESCRIPTION
        Configuration for NTP parameter resource.
    .PARAMETER GetAll 
        Retrieve all ntpparam object(s).
    .PARAMETER Count
        If specified, the count of the ntpparam object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpparam
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNtpparam -GetAll 
        Get all ntpparam data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpparam -name <string>
        Get ntpparam object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpparam -Filter @{ 'name'='<value>' }
        Get ntpparam data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNtpparam
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpparam/
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
        Write-Verbose "Invoke-ADCGetNtpparam: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpparam objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpparam objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpparam configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpparam configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpparam -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.
    .EXAMPLE
        PS C:\>Invoke-ADCAddNtpserver 
        An example how to add ntpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddNtpserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [string]$Servername,

        [ValidateRange(4, 17)]
        [double]$Minpoll,

        [ValidateRange(4, 17)]
        [double]$Maxpoll,

        [boolean]$Autokey,

        [ValidateRange(1, 65534)]
        [double]$Key 
    )
    begin {
        Write-Verbose "Invoke-ADCAddNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Add NTP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpserver -Payload $payload -GetWarning
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
        Delete NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteNtpserver -Serverip <string>
        An example how to delete ntpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteNtpserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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
        [string]$Serverip,

        [string]$Servername 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteNtpserver: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Servername') ) { $arguments.Add('servername', $Servername) }
            if ( $PSCmdlet.ShouldProcess("$serverip", "Delete NTP configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ntpserver -NitroPath nitro/v1/config -Resource $serverip -Arguments $arguments
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
        Update NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Preferredntpserver 
        Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts. 
        Possible values = YES, NO 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateNtpserver 
        An example how to update ntpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateNtpserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Serverip,

        [string]$Servername,

        [ValidateRange(4, 17)]
        [double]$Minpoll,

        [ValidateRange(4, 17)]
        [double]$Maxpoll,

        [ValidateSet('YES', 'NO')]
        [string]$Preferredntpserver,

        [boolean]$Autokey,

        [ValidateRange(1, 65534)]
        [double]$Key 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('preferredntpserver') ) { $payload.Add('preferredntpserver', $preferredntpserver) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Update NTP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type ntpserver -Payload $payload -GetWarning
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
        Unset NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER Serverip 
        IP address of the NTP server. 
    .PARAMETER Servername 
        Fully qualified domain name of the NTP server. 
    .PARAMETER Autokey 
        Use the Autokey protocol for key management for this server, with the cryptographic values (for example, symmetric key, host and public certificate files, and sign key) generated by the ntp-keygen utility. To require authentication for communication with the server, you must set either the value of this parameter or the key parameter. 
    .PARAMETER Minpoll 
        Minimum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Maxpoll 
        Maximum time after which the NTP server must poll the NTP messages. In seconds, expressed as a power of 2. 
    .PARAMETER Preferredntpserver 
        Preferred NTP server. The Citrix ADC chooses this NTP server for time synchronization among a set of correctly operating hosts. 
        Possible values = YES, NO 
    .PARAMETER Key 
        Key to use for encrypting authentication fields. All packets sent to and received from the server must include authentication fields encrypted by using this key. To require authentication for communication with the server, you must set either the value of this parameter or the autokey parameter.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetNtpserver 
        An example how to unset ntpserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetNtpserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver
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

        [Boolean]$serverip,

        [Boolean]$servername,

        [Boolean]$autokey,

        [Boolean]$minpoll,

        [Boolean]$maxpoll,

        [Boolean]$preferredntpserver,

        [Boolean]$key 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetNtpserver: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('serverip') ) { $payload.Add('serverip', $serverip) }
            if ( $PSBoundParameters.ContainsKey('servername') ) { $payload.Add('servername', $servername) }
            if ( $PSBoundParameters.ContainsKey('autokey') ) { $payload.Add('autokey', $autokey) }
            if ( $PSBoundParameters.ContainsKey('minpoll') ) { $payload.Add('minpoll', $minpoll) }
            if ( $PSBoundParameters.ContainsKey('maxpoll') ) { $payload.Add('maxpoll', $maxpoll) }
            if ( $PSBoundParameters.ContainsKey('preferredntpserver') ) { $payload.Add('preferredntpserver', $preferredntpserver) }
            if ( $PSBoundParameters.ContainsKey('key') ) { $payload.Add('key', $key) }
            if ( $PSCmdlet.ShouldProcess("ntpserver", "Unset NTP configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type ntpserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get NTP configuration object(s).
    .DESCRIPTION
        Configuration for NTP server resource.
    .PARAMETER GetAll 
        Retrieve all ntpserver object(s).
    .PARAMETER Count
        If specified, the count of the ntpserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNtpserver -GetAll 
        Get all ntpserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNtpserver -Count 
        Get the number of ntpserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpserver -name <string>
        Get ntpserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpserver -Filter @{ 'name'='<value>' }
        Get ntpserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNtpserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpserver/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpserver configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get NTP configuration object(s).
    .DESCRIPTION
        Configuration for ntp status resource.
    .PARAMETER GetAll 
        Retrieve all ntpstatus object(s).
    .PARAMETER Count
        If specified, the count of the ntpstatus object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpstatus
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNtpstatus -GetAll 
        Get all ntpstatus data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpstatus -name <string>
        Get ntpstatus object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpstatus -Filter @{ 'name'='<value>' }
        Get ntpstatus data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNtpstatus
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpstatus/
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
        Write-Verbose "Invoke-ADCGetNtpstatus: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpstatus objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpstatus objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpstatus configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpstatus configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpstatus -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Enable NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP sync resource.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableNtpsync 
        An example how to enable ntpsync configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableNtpsync
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCEnableNtpsync: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable NTP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action enable -Payload $payload -GetWarning
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
        Disable NTP configuration Object.
    .DESCRIPTION
        Configuration for NTP sync resource.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableNtpsync 
        An example how to disable ntpsync configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableNtpsync
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCDisableNtpsync: Starting"
    }
    process {
        try {
            $payload = @{ }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable NTP configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ntpsync -Action disable -Payload $payload -GetWarning
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
        Get NTP configuration object(s).
    .DESCRIPTION
        Configuration for NTP sync resource.
    .PARAMETER GetAll 
        Retrieve all ntpsync object(s).
    .PARAMETER Count
        If specified, the count of the ntpsync object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpsync
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetNtpsync -GetAll 
        Get all ntpsync data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpsync -name <string>
        Get ntpsync object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetNtpsync -Filter @{ 'name'='<value>' }
        Get ntpsync data with a filter.
    .NOTES
        File Name : Invoke-ADCGetNtpsync
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ntp/ntpsync/
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
        Write-Verbose "Invoke-ADCGetNtpsync: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ntpsync objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ntpsync objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ntpsync objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ntpsync configuration for property ''"

            } else {
                Write-Verbose "Retrieving ntpsync configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ntpsync -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


