function Invoke-ADCAddLsnappsattributes {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Transportprotocol 
        Name of the protocol(TCP,UDP) for which the parameters of this LSN application port ATTRIBUTES applies. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Port 
        This is used for Displaying Port/Port range in CLI/Nitro.Lowport, Highport values are populated and used for displaying.Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnappsattributes -name <string> -transportprotocol <string>
        An example how to add lsnappsattributes configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnappsattributes
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Port,

        [ValidateRange(5, 600)]
        [double]$Sessiontimeout = '30',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                transportprotocol = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("lsnappsattributes", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsattributes -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnappsattributes: Finished"
    }
}

function Invoke-ADCDeleteLsnappsattributes {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnappsattributes -Name <string>
        An example how to delete lsnappsattributes configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsattributes
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        Write-Verbose "Invoke-ADCDeleteLsnappsattributes: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnappsattributes: Finished"
    }
}

function Invoke-ADCUpdateLsnappsattributes {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnappsattributes -name <string>
        An example how to update lsnappsattributes configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnappsattributes
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [ValidateRange(5, 600)]
        [double]$Sessiontimeout,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("lsnappsattributes", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsattributes -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnappsattributes: Finished"
    }
}

function Invoke-ADCUnsetLsnappsattributes {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnappsattributes -name <string>
        An example how to unset lsnappsattributes configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnappsattributes
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Boolean]$sessiontimeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnappsattributes: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnappsattributes -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnappsattributes: Finished"
    }
}

function Invoke-ADCGetLsnappsattributes {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN Application Attributes resource.
    .PARAMETER Name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsattributes object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsattributes object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsattributes
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsattributes -GetAll 
        Get all lsnappsattributes data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsattributes -Count 
        Get the number of lsnappsattributes objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsattributes -name <string>
        Get lsnappsattributes object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsattributes -Filter @{ 'name'='<value>' }
        Get lsnappsattributes data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnappsattributes
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnappsattributes: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnappsattributes objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsattributes objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsattributes objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsattributes configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsattributes configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnappsattributes: Ended"
    }
}

function Invoke-ADCAddLsnappsprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Transportprotocol 
        Name of the protocol for which the parameters of this LSN application profile applies. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
        This parameter is applicable to dynamic NAT allocation only. 
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnappsprofile -appsprofilename <string> -transportprotocol <string>
        An example how to add lsnappsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$Ippooling = 'RANDOM',

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Mapping = 'ADDRESS-PORT-DEPENDENT',

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Filtering = 'ADDRESS-PORT-DEPENDENT',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpproxy = 'DISABLED',

        [double]$Td = '4095',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L2info = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename
                transportprotocol         = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnappsprofile: Finished"
    }
}

function Invoke-ADCDeleteLsnappsprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnappsprofile -Appsprofilename <string>
        An example how to delete lsnappsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [string]$Appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnappsprofile: Finished"
    }
}

function Invoke-ADCUpdateLsnappsprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
        This parameter is applicable to dynamic NAT allocation only. 
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnappsprofile -appsprofilename <string>
        An example how to update lsnappsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnappsprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$Ippooling,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Mapping,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$Filtering,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Tcpproxy,

        [double]$Td,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$L2info,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnappsprofile: Finished"
    }
}

function Invoke-ADCUnsetLsnappsprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber. 
        Available options function as follows: 
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber. 
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber. 
        This parameter is applicable to dynamic NAT allocation only. 
        Possible values = PAIRED, RANDOM 
    .PARAMETER Mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port. 
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port. 
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port. 
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Filtering 
        Type of filter to apply to packets originating from external hosts. 
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y). 
        Available options function as follows: 
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber. 
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address. 
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port. 
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER Tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN. 
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
    .PARAMETER L2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnappsprofile -appsprofilename <string>
        An example how to unset lsnappsprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnappsprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Boolean]$ippooling,

        [Boolean]$mapping,

        [Boolean]$filtering,

        [Boolean]$tcpproxy,

        [Boolean]$td,

        [Boolean]$l2info 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnappsprofile: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('ippooling') ) { $payload.Add('ippooling', $ippooling) }
            if ( $PSBoundParameters.ContainsKey('mapping') ) { $payload.Add('mapping', $mapping) }
            if ( $PSBoundParameters.ContainsKey('filtering') ) { $payload.Add('filtering', $filtering) }
            if ( $PSBoundParameters.ContainsKey('tcpproxy') ) { $payload.Add('tcpproxy', $tcpproxy) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('l2info') ) { $payload.Add('l2info', $l2info) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnappsprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnappsprofile: Finished"
    }
}

function Invoke-ADCGetLsnappsprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN Application Profile resource.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofile -GetAll 
        Get all lsnappsprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofile -Count 
        Get the number of lsnappsprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofile -name <string>
        Get lsnappsprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofile -Filter @{ 'name'='<value>' }
        Get lsnappsprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnappsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnappsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnappsprofile: Ended"
    }
}

function Invoke-ADCGetLsnappsprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofilebinding -GetAll 
        Get all lsnappsprofile_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilebinding -name <string>
        Get lsnappsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilebinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnappsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnappsprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsnappsprofilelsnappsattributesbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Appsattributesname 
        Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES. 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_lsnappsattributes_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnappsprofilelsnappsattributesbinding -appsprofilename <string>
        An example how to add lsnappsprofile_lsnappsattributes_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofilelsnappsattributesbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [string]$Appsattributesname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofilelsnappsattributesbinding: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('appsattributesname') ) { $payload.Add('appsattributesname', $appsattributesname) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile_lsnappsattributes_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_lsnappsattributes_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnappsprofilelsnappsattributesbinding: Finished"
    }
}

function Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Appsattributesname 
        Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding -Appsprofilename <string>
        An example how to delete lsnappsprofile_lsnappsattributes_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [string]$Appsprofilename,

        [string]$Appsattributesname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Appsattributesname') ) { $arguments.Add('appsattributesname', $Appsattributesname) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding: Finished"
    }
}

function Invoke-ADCGetLsnappsprofilelsnappsattributesbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnappsattributes that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_lsnappsattributes_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_lsnappsattributes_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilelsnappsattributesbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -GetAll 
        Get all lsnappsprofile_lsnappsattributes_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Count 
        Get the number of lsnappsprofile_lsnappsattributes_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -name <string>
        Get lsnappsprofile_lsnappsattributes_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_lsnappsattributes_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofilelsnappsattributesbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnappsprofilelsnappsattributesbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnappsprofilelsnappsattributesbinding: Ended"
    }
}

function Invoke-ADCAddLsnappsprofileportbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Lsnport 
        Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90. 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_port_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnappsprofileportbinding -appsprofilename <string>
        An example how to add lsnappsprofile_port_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofileportbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lsnport,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofileportbinding: Starting"
    }
    process {
        try {
            $payload = @{ appsprofilename = $appsprofilename }
            if ( $PSBoundParameters.ContainsKey('lsnport') ) { $payload.Add('lsnport', $lsnport) }
            if ( $PSCmdlet.ShouldProcess("lsnappsprofile_port_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_port_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnappsprofileportbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnappsprofileportbinding: Finished"
    }
}

function Invoke-ADCDeleteLsnappsprofileportbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER Lsnport 
        Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnappsprofileportbinding -Appsprofilename <string>
        An example how to delete lsnappsprofile_port_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofileportbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [string]$Appsprofilename,

        [string]$Lsnport 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofileportbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lsnport') ) { $arguments.Add('lsnport', $Lsnport) }
            if ( $PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnappsprofileportbinding: Finished"
    }
}

function Invoke-ADCGetLsnappsprofileportbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the port that can be bound to lsnappsprofile.
    .PARAMETER Appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnappsprofile_port_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_port_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofileportbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofileportbinding -GetAll 
        Get all lsnappsprofile_port_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnappsprofileportbinding -Count 
        Get the number of lsnappsprofile_port_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofileportbinding -name <string>
        Get lsnappsprofile_port_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnappsprofileportbinding -Filter @{ 'name'='<value>' }
        Get lsnappsprofile_port_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofileportbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnappsprofileportbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnappsprofile_port_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_port_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnappsprofileportbinding: Ended"
    }
}

function Invoke-ADCAddLsnclient {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER PassThru 
        Return details about the created lsnclient item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnclient -clientname <string>
        An example how to add lsnclient configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnclient
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclient: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }

            if ( $PSCmdlet.ShouldProcess("lsnclient", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnclient -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnclient -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnclient: Finished"
    }
}

function Invoke-ADCDeleteLsnclient {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnclient -Clientname <string>
        An example how to delete lsnclient configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnclient
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [string]$Clientname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclient: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnclient: Finished"
    }
}

function Invoke-ADCGetLsnclient {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for lsn client resource.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclient
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclient -GetAll 
        Get all lsnclient data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclient -Count 
        Get the number of lsnclient objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclient -name <string>
        Get lsnclient object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclient -Filter @{ 'name'='<value>' }
        Get lsnclient data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclient
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

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
        Write-Verbose "Invoke-ADCGetLsnclient: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnclient objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclient: Ended"
    }
}

function Invoke-ADCGetLsnclientbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientbinding -GetAll 
        Get all lsnclient_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientbinding -name <string>
        Get lsnclient_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientbinding -Filter @{ 'name'='<value>' }
        Get lsnclient_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclientbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclientbinding: Ended"
    }
}

function Invoke-ADCAddLsnclientnetwork6binding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Network6 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network6_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnclientnetwork6binding -clientname <string>
        An example how to add lsnclient_network6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnclientnetwork6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network,

        [string]$Netmask,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network6,

        [ValidateRange(0, 4094)]
        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnetwork6binding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_network6_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnclientnetwork6binding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnclientnetwork6binding: Finished"
    }
}

function Invoke-ADCDeleteLsnclientnetwork6binding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Network6 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnclientnetwork6binding -Clientname <string>
        An example how to delete lsnclient_network6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnetwork6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [string]$Network6,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnetwork6binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Network') ) { $arguments.Add('network', $Network) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSBoundParameters.ContainsKey('Network6') ) { $arguments.Add('network6', $Network6) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnclientnetwork6binding: Finished"
    }
}

function Invoke-ADCGetLsnclientnetwork6binding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the network6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_network6_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_network6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetwork6binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnetwork6binding -GetAll 
        Get all lsnclient_network6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnetwork6binding -Count 
        Get the number of lsnclient_network6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetwork6binding -name <string>
        Get lsnclient_network6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetwork6binding -Filter @{ 'name'='<value>' }
        Get lsnclient_network6_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclientnetwork6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientnetwork6binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_network6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclientnetwork6binding: Ended"
    }
}

function Invoke-ADCAddLsnclientnetworkbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnclientnetworkbinding -clientname <string>
        An example how to add lsnclient_network_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnclientnetworkbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network,

        [string]$Netmask,

        [ValidateRange(0, 4094)]
        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnetworkbinding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_network_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnclientnetworkbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnclientnetworkbinding: Finished"
    }
}

function Invoke-ADCDeleteLsnclientnetworkbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnclientnetworkbinding -Clientname <string>
        An example how to delete lsnclient_network_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnetworkbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnetworkbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Network') ) { $arguments.Add('network', $Network) }
            if ( $PSBoundParameters.ContainsKey('Netmask') ) { $arguments.Add('netmask', $Netmask) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnclientnetworkbinding: Finished"
    }
}

function Invoke-ADCGetLsnclientnetworkbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the network that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_network_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_network_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetworkbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnetworkbinding -GetAll 
        Get all lsnclient_network_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnetworkbinding -Count 
        Get the number of lsnclient_network_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetworkbinding -name <string>
        Get lsnclient_network_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnetworkbinding -Filter @{ 'name'='<value>' }
        Get lsnclient_network_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclientnetworkbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientnetworkbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_network_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclientnetworkbinding: Ended"
    }
}

function Invoke-ADCAddLsnclientnsacl6binding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Acl6name 
        Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl6_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnclientnsacl6binding -clientname <string>
        An example how to add lsnclient_nsacl6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnclientnsacl6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Acl6name,

        [ValidateRange(0, 4094)]
        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnsacl6binding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('acl6name') ) { $payload.Add('acl6name', $acl6name) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_nsacl6_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl6_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnclientnsacl6binding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnclientnsacl6binding: Finished"
    }
}

function Invoke-ADCDeleteLsnclientnsacl6binding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Acl6name 
        Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client. 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnclientnsacl6binding -Clientname <string>
        An example how to delete lsnclient_nsacl6_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnsacl6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [string]$Clientname,

        [string]$Acl6name,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnsacl6binding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Acl6name') ) { $arguments.Add('acl6name', $Acl6name) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnclientnsacl6binding: Finished"
    }
}

function Invoke-ADCGetLsnclientnsacl6binding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the nsacl6 that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_nsacl6_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl6_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsacl6binding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnsacl6binding -GetAll 
        Get all lsnclient_nsacl6_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnsacl6binding -Count 
        Get the number of lsnclient_nsacl6_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsacl6binding -name <string>
        Get lsnclient_nsacl6_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsacl6binding -Filter @{ 'name'='<value>' }
        Get lsnclient_nsacl6_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclientnsacl6binding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientnsacl6binding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_nsacl6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclientnsacl6binding: Ended"
    }
}

function Invoke-ADCAddLsnclientnsaclbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Aclname 
        Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. . 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain. 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnclientnsaclbinding -clientname <string>
        An example how to add lsnclient_nsacl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnclientnsaclbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Aclname,

        [ValidateRange(0, 4094)]
        [double]$Td = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnsaclbinding: Starting"
    }
    process {
        try {
            $payload = @{ clientname = $clientname }
            if ( $PSBoundParameters.ContainsKey('aclname') ) { $payload.Add('aclname', $aclname) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSCmdlet.ShouldProcess("lsnclient_nsacl_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnclientnsaclbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnclientnsaclbinding: Finished"
    }
}

function Invoke-ADCDeleteLsnclientnsaclbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER Aclname 
        Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. . 
    .PARAMETER Td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnclientnsaclbinding -Clientname <string>
        An example how to delete lsnclient_nsacl_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnsaclbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [string]$Clientname,

        [string]$Aclname,

        [double]$Td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnsaclbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Aclname') ) { $arguments.Add('aclname', $Aclname) }
            if ( $PSBoundParameters.ContainsKey('Td') ) { $arguments.Add('td', $Td) }
            if ( $PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnclientnsaclbinding: Finished"
    }
}

function Invoke-ADCGetLsnclientnsaclbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the nsacl that can be bound to lsnclient.
    .PARAMETER Clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retrieve all lsnclient_nsacl_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsaclbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnsaclbinding -GetAll 
        Get all lsnclient_nsacl_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnclientnsaclbinding -Count 
        Get the number of lsnclient_nsacl_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsaclbinding -name <string>
        Get lsnclient_nsacl_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnclientnsaclbinding -Filter @{ 'name'='<value>' }
        Get lsnclient_nsacl_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnclientnsaclbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientnsaclbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnclient_nsacl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnclientnsaclbinding: Ended"
    }
}

function Invoke-ADCGetLsndeterministicnat {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for deterministic NAT resource.
    .PARAMETER Clientname 
        The name of the LSN Client. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Subscrip 
        The Client IP address. 
    .PARAMETER Td 
        The LSN client TD. 
    .PARAMETER Natip 
        The NAT IP address. 
    .PARAMETER GetAll 
        Retrieve all lsndeterministicnat object(s).
    .PARAMETER Count
        If specified, the count of the lsndeterministicnat object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsndeterministicnat
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsndeterministicnat -GetAll 
        Get all lsndeterministicnat data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsndeterministicnat -Count 
        Get the number of lsndeterministicnat objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsndeterministicnat -name <string>
        Get lsndeterministicnat object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsndeterministicnat -Filter @{ 'name'='<value>' }
        Get lsndeterministicnat data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsndeterministicnat
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsndeterministicnat/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network6,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Subscrip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4094)]
        [double]$Td,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Natip,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetLsndeterministicnat: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsndeterministicnat objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsndeterministicnat objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsndeterministicnat objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('clientname') ) { $arguments.Add('clientname', $clientname) } 
                if ( $PSBoundParameters.ContainsKey('network6') ) { $arguments.Add('network6', $network6) } 
                if ( $PSBoundParameters.ContainsKey('subscrip') ) { $arguments.Add('subscrip', $subscrip) } 
                if ( $PSBoundParameters.ContainsKey('td') ) { $arguments.Add('td', $td) } 
                if ( $PSBoundParameters.ContainsKey('natip') ) { $arguments.Add('natip', $natip) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsndeterministicnat configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsndeterministicnat configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsndeterministicnat: Ended"
    }
}

function Invoke-ADCAddLsngroup {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Clientname 
        Name of the LSN client entity to be associated with the LSN group. You can associate only one LSN client entity with an LSN group.You cannot remove this association or replace with another LSN client entity once the LSN group is created. 
    .PARAMETER Nattype 
        Type of NAT IP address and port allocation (from the bound LSN pools) for subscribers: 
        Available options function as follows: 
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port. The maximum number of LSN subscribers allowed, globally, is 1 million. 
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER Allocpolicy 
        NAT IP and PORT block allocation policy for Deterministic NAT. Supported Policies are, 
        1: PORTS: Port blocks from single NATIP will be allocated to LSN subscribers sequentially. After all blocks are exhausted, port blocks from next NATIP will be allocated and so on. 
        2: IPADDRS(Default): One port block from each NATIP will be allocated and once all the NATIPs are over second port block from each NATIP will be allocated and so on. 
        To understand better if we assume port blocks of all NAT IPs as two dimensional array, PORTS policy follows "row major order" and IPADDRS policy follows "column major order" while allocating port blocks. 
        Example: 
        Client IPs: 2.2.2.1, 2.2.2.2 and 2.2.2.3 
        NAT IPs and PORT Blocks: 
        4.4.4.1:PB1, PB2, PB3,., PBn 
        4.4.4.2: PB1, PB2, PB3,., PBn 
        PORTS Policy: 
        2.2.2.1 => 4.4.4.1:PB1 
        2.2.2.2 => 4.4.4.1:PB2 
        2.2.2.3 => 4.4.4.1:PB3 
        IPADDRS Policy: 
        2.2.2.1 => 4.4.4.1:PB1 
        2.2.2.2 => 4.4.4.2:PB1 
        2.2.2.3 => 4.4.4.1:PB2. 
        Possible values = PORTS, IPADDRS 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
        For this setting to work, you must enable the global session synchronization parameter. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ip6profile 
        Name of the LSN ip6 profile to associate with the specified LSN group. An ip6 profile can be associated with a group only during group creation. 
        By default, no LSN ip6 profile is associated with an LSN group during its creation. Only one ip6profile can be associated with a group. 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngroup -groupname <string> -clientname <string>
        An example how to add lsngroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngroup
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(Mandatory)]
        [string]$Clientname,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$Nattype = 'DYNAMIC',

        [ValidateSet('PORTS', 'IPADDRS')]
        [string]$Allocpolicy = 'PORTS',

        [ValidateRange(256, 65536)]
        [double]$Portblocksize = '0',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionlogging = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync = 'ENABLED',

        [ValidateRange(0, 10000)]
        [double]$Snmptraplimit = '100',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftp = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pptp = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sipalg = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rtspalg = 'DISABLED',

        [ValidateLength(1, 127)]
        [string]$Ip6profile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftpcm = 'DISABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname
                clientname          = $clientname
            }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('allocpolicy') ) { $payload.Add('allocpolicy', $allocpolicy) }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ip6profile') ) { $payload.Add('ip6profile', $ip6profile) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("lsngroup", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsngroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngroup: Finished"
    }
}

function Invoke-ADCDeleteLsngroup {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngroup -Groupname <string>
        An example how to delete lsngroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngroup
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [string]$Groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngroup: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngroup: Finished"
    }
}

function Invoke-ADCUpdateLsngroup {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
        For this setting to work, you must enable the global session synchronization parameter. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsngroup -groupname <string>
        An example how to update lsngroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsngroup
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [ValidateRange(256, 65536)]
        [double]$Portblocksize,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionlogging,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync,

        [ValidateRange(0, 10000)]
        [double]$Snmptraplimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Pptp,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sipalg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rtspalg,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Ftpcm,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("lsngroup", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngroup -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsngroup: Finished"
    }
}

function Invoke-ADCUnsetLsngroup {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Portblocksize 
        Size of the NAT port block to be allocated for each subscriber. 
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it. 
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
    .PARAMETER Logging 
        Log mapping entries and sessions created or deleted for this LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        The ADC uses its existing syslog and audit log framework to log LSN information. You must enable global level LSN logging by enabling the LSN parameter in the related NSLOG action and SYLOG action entities. When the Logging parameter is enabled, the Citrix ADC generates log messages related to LSN mappings and LSN sessions of this LSN group. The ADC then sends these log messages to servers associated with the NSLOG action and SYSLOG actions entities. 
        A log message for an LSN mapping entry consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN mapping entry is created or deleted 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID might be present, depending on the following conditions: 
        ** Destination IP address and port are not logged for Endpoint-Independent mapping 
        ** Only Destination IP address (and not port) is logged for Address-Dependent mapping 
        ** Destination IP address and port are logged for Address-Port-Dependent mapping. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionlogging 
        Log sessions created or deleted for the LSN group. The Citrix ADC logs LSN sessions for this LSN group only when both logging and session logging parameters are enabled. 
        A log message for an LSN session consists of the following information: 
        * NSIP address of the Citrix ADC 
        * Time stamp 
        * Entry type (MAPPING or SESSION) 
        * Whether the LSN session is created or removed 
        * Subscriber's IP address, port, and traffic domain ID 
        * NAT IP address and port 
        * Protocol name 
        * Destination IP address, port, and traffic domain ID. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
        For this setting to work, you must enable the global session synchronization parameter. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
    .PARAMETER Ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN. 
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pptp 
        Enable the PPTP Application Layer Gateway. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sipalg 
        Enable the SIP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rtspalg 
        Enable the RTSP ALG. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsngroup -groupname <string>
        An example how to unset lsngroup configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsngroup
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Boolean]$portblocksize,

        [Boolean]$logging,

        [Boolean]$sessionlogging,

        [Boolean]$sessionsync,

        [Boolean]$snmptraplimit,

        [Boolean]$ftp,

        [Boolean]$pptp,

        [Boolean]$sipalg,

        [Boolean]$rtspalg,

        [Boolean]$ftpcm 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsngroup: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('portblocksize') ) { $payload.Add('portblocksize', $portblocksize) }
            if ( $PSBoundParameters.ContainsKey('logging') ) { $payload.Add('logging', $logging) }
            if ( $PSBoundParameters.ContainsKey('sessionlogging') ) { $payload.Add('sessionlogging', $sessionlogging) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('snmptraplimit') ) { $payload.Add('snmptraplimit', $snmptraplimit) }
            if ( $PSBoundParameters.ContainsKey('ftp') ) { $payload.Add('ftp', $ftp) }
            if ( $PSBoundParameters.ContainsKey('pptp') ) { $payload.Add('pptp', $pptp) }
            if ( $PSBoundParameters.ContainsKey('sipalg') ) { $payload.Add('sipalg', $sipalg) }
            if ( $PSBoundParameters.ContainsKey('rtspalg') ) { $payload.Add('rtspalg', $rtspalg) }
            if ( $PSBoundParameters.ContainsKey('ftpcm') ) { $payload.Add('ftpcm', $ftpcm) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsngroup -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsngroup: Finished"
    }
}

function Invoke-ADCGetLsngroup {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN group resource.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroup
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngroup -GetAll 
        Get all lsngroup data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngroup -Count 
        Get the number of lsngroup objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroup -name <string>
        Get lsngroup object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroup -Filter @{ 'name'='<value>' }
        Get lsngroup data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngroup
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

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
        Write-Verbose "Invoke-ADCGetLsngroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngroup: Ended"
    }
}

function Invoke-ADCGetLsngroupbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngroupbinding -GetAll 
        Get all lsngroup_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupbinding -name <string>
        Get lsngroup_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupbinding -Filter @{ 'name'='<value>' }
        Get lsngroup_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngroupbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngroupbinding: Ended"
    }
}

function Invoke-ADCAddLsngroupipsecalgprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Ipsecalgprofile 
        Name of the IPSec ALG profile to bind to the specified LSN group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_ipsecalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngroupipsecalgprofilebinding -groupname <string>
        An example how to add lsngroup_ipsecalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngroupipsecalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Ipsecalgprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngroupipsecalgprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('ipsecalgprofile') ) { $payload.Add('ipsecalgprofile', $ipsecalgprofile) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_ipsecalgprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_ipsecalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngroupipsecalgprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngroupipsecalgprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngroupipsecalgprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Ipsecalgprofile 
        Name of the IPSec ALG profile to bind to the specified LSN group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngroupipsecalgprofilebinding -Groupname <string>
        An example how to delete lsngroup_ipsecalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngroupipsecalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [string]$Groupname,

        [string]$Ipsecalgprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngroupipsecalgprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ipsecalgprofile') ) { $arguments.Add('ipsecalgprofile', $Ipsecalgprofile) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngroupipsecalgprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngroupipsecalgprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the ipsecalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_ipsecalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_ipsecalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupipsecalgprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngroupipsecalgprofilebinding -GetAll 
        Get all lsngroup_ipsecalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngroupipsecalgprofilebinding -Count 
        Get the number of lsngroup_ipsecalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupipsecalgprofilebinding -name <string>
        Get lsngroup_ipsecalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngroupipsecalgprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_ipsecalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngroupipsecalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngroupipsecalgprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngroupipsecalgprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnappsprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Appsprofilename 
        Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnappsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnappsprofilebinding -groupname <string>
        An example how to add lsngroup_lsnappsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnappsprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Appsprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnappsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('appsprofilename') ) { $payload.Add('appsprofilename', $appsprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnappsprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnappsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnappsprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnappsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnappsprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Appsprofilename 
        Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnappsprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsnappsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnappsprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [string]$Groupname,

        [string]$Appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnappsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Appsprofilename') ) { $arguments.Add('appsprofilename', $Appsprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnappsprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnappsprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnappsprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnappsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnappsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnappsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnappsprofilebinding -GetAll 
        Get all lsngroup_lsnappsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnappsprofilebinding -Count 
        Get the number of lsngroup_lsnappsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnappsprofilebinding -name <string>
        Get lsngroup_lsnappsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnappsprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnappsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnappsprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnappsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnappsprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Httphdrlogprofilename 
        The name of the LSN HTTP header logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnhttphdrlogprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding -groupname <string>
        An example how to add lsngroup_lsnhttphdrlogprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Httphdrlogprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('httphdrlogprofilename') ) { $payload.Add('httphdrlogprofilename', $httphdrlogprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnhttphdrlogprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnhttphdrlogprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Httphdrlogprofilename 
        The name of the LSN HTTP header logging Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsnhttphdrlogprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [string]$Groupname,

        [string]$Httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Httphdrlogprofilename') ) { $arguments.Add('httphdrlogprofilename', $Httphdrlogprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnhttphdrlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnhttphdrlogprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnhttphdrlogprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -GetAll 
        Get all lsngroup_lsnhttphdrlogprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Count 
        Get the number of lsngroup_lsnhttphdrlogprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -name <string>
        Get lsngroup_lsnhttphdrlogprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnhttphdrlogprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnlogprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Logprofilename 
        The name of the LSN logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnlogprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnlogprofilebinding -groupname <string>
        An example how to add lsngroup_lsnlogprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Logprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnlogprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('logprofilename') ) { $payload.Add('logprofilename', $logprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnlogprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnlogprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnlogprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnlogprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnlogprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Logprofilename 
        The name of the LSN logging Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnlogprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsnlogprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [string]$Groupname,

        [string]$Logprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnlogprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Logprofilename') ) { $arguments.Add('logprofilename', $Logprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnlogprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnlogprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnlogprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnlogprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnlogprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnlogprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnlogprofilebinding -GetAll 
        Get all lsngroup_lsnlogprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnlogprofilebinding -Count 
        Get the number of lsngroup_lsnlogprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnlogprofilebinding -name <string>
        Get lsngroup_lsnlogprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnlogprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnlogprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnlogprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnlogprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnlogprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnpoolbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Poolname 
        Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnpool_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnpoolbinding -groupname <string>
        An example how to add lsngroup_lsnpool_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnpoolbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Poolname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnpoolbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('poolname') ) { $payload.Add('poolname', $poolname) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnpool_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnpool_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnpoolbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnpoolbinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnpoolbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Poolname 
        Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnpoolbinding -Groupname <string>
        An example how to delete lsngroup_lsnpool_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnpoolbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [string]$Groupname,

        [string]$Poolname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnpoolbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Poolname') ) { $arguments.Add('poolname', $Poolname) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnpoolbinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnpoolbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnpool that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnpool_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnpool_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnpoolbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnpoolbinding -GetAll 
        Get all lsngroup_lsnpool_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnpoolbinding -Count 
        Get the number of lsngroup_lsnpool_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnpoolbinding -name <string>
        Get lsngroup_lsnpool_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnpoolbinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnpool_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnpoolbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnpoolbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnpoolbinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnrtspalgprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Rtspalgprofilename 
        The name of the LSN RTSP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnrtspalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnrtspalgprofilebinding -groupname <string>
        An example how to add lsngroup_lsnrtspalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnrtspalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Rtspalgprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnrtspalgprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('rtspalgprofilename') ) { $payload.Add('rtspalgprofilename', $rtspalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnrtspalgprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnrtspalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnrtspalgprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Rtspalgprofilename 
        The name of the LSN RTSP ALG Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsnrtspalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [string]$Groupname,

        [string]$Rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Rtspalgprofilename') ) { $arguments.Add('rtspalgprofilename', $Rtspalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnrtspalgprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnrtspalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnrtspalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnrtspalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnrtspalgprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -GetAll 
        Get all lsngroup_lsnrtspalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Count 
        Get the number of lsngroup_lsnrtspalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -name <string>
        Get lsngroup_lsnrtspalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnrtspalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnrtspalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnrtspalgprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnrtspalgprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsnsipalgprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Sipalgprofilename 
        The name of the LSN SIP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnsipalgprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsnsipalgprofilebinding -groupname <string>
        An example how to add lsngroup_lsnsipalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnsipalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Sipalgprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnsipalgprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('sipalgprofilename') ) { $payload.Add('sipalgprofilename', $sipalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsnsipalgprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnsipalgprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsnsipalgprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Sipalgprofilename 
        The name of the LSN SIP ALG Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsnsipalgprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [string]$Groupname,

        [string]$Sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Sipalgprofilename') ) { $arguments.Add('sipalgprofilename', $Sipalgprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsnsipalgprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnsipalgprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsnsipalgprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnsipalgprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnsipalgprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnsipalgprofilebinding -GetAll 
        Get all lsngroup_lsnsipalgprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Count 
        Get the number of lsngroup_lsnsipalgprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnsipalgprofilebinding -name <string>
        Get lsngroup_lsnsipalgprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsnsipalgprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnsipalgprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsnsipalgprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsnsipalgprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouplsntransportprofilebinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprofilename 
        Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsntransportprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouplsntransportprofilebinding -groupname <string>
        An example how to add lsngroup_lsntransportprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsntransportprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Transportprofilename,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsntransportprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('transportprofilename') ) { $payload.Add('transportprofilename', $transportprofilename) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_lsntransportprofile_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsntransportprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouplsntransportprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouplsntransportprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouplsntransportprofilebinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprofilename 
        Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouplsntransportprofilebinding -Groupname <string>
        An example how to delete lsngroup_lsntransportprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsntransportprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [string]$Groupname,

        [string]$Transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsntransportprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Transportprofilename') ) { $arguments.Add('transportprofilename', $Transportprofilename) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouplsntransportprofilebinding: Finished"
    }
}

function Invoke-ADCGetLsngrouplsntransportprofilebinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsntransportprofile that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_lsntransportprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_lsntransportprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsntransportprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsntransportprofilebinding -GetAll 
        Get all lsngroup_lsntransportprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouplsntransportprofilebinding -Count 
        Get the number of lsngroup_lsntransportprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsntransportprofilebinding -name <string>
        Get lsngroup_lsntransportprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouplsntransportprofilebinding -Filter @{ 'name'='<value>' }
        Get lsngroup_lsntransportprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsntransportprofilebinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouplsntransportprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouplsntransportprofilebinding: Ended"
    }
}

function Invoke-ADCAddLsngrouppcpserverbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Pcpserver 
        Name of the PCP server to be associated with lsn group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_pcpserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsngrouppcpserverbinding -groupname <string>
        An example how to add lsngroup_pcpserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsngrouppcpserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [string]$Pcpserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouppcpserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ groupname = $groupname }
            if ( $PSBoundParameters.ContainsKey('pcpserver') ) { $payload.Add('pcpserver', $pcpserver) }
            if ( $PSCmdlet.ShouldProcess("lsngroup_pcpserver_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_pcpserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsngrouppcpserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsngrouppcpserverbinding: Finished"
    }
}

function Invoke-ADCDeleteLsngrouppcpserverbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Pcpserver 
        Name of the PCP server to be associated with lsn group.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsngrouppcpserverbinding -Groupname <string>
        An example how to delete lsngroup_pcpserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouppcpserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [string]$Groupname,

        [string]$Pcpserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouppcpserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Pcpserver') ) { $arguments.Add('pcpserver', $Pcpserver) }
            if ( $PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsngrouppcpserverbinding: Finished"
    }
}

function Invoke-ADCGetLsngrouppcpserverbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the pcpserver that can be bound to lsngroup.
    .PARAMETER Groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsngroup_pcpserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsngroup_pcpserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouppcpserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouppcpserverbinding -GetAll 
        Get all lsngroup_pcpserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsngrouppcpserverbinding -Count 
        Get the number of lsngroup_pcpserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouppcpserverbinding -name <string>
        Get lsngroup_pcpserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsngrouppcpserverbinding -Filter @{ 'name'='<value>' }
        Get lsngroup_pcpserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsngrouppcpserverbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngrouppcpserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsngroup_pcpserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_pcpserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsngrouppcpserverbinding: Ended"
    }
}

function Invoke-ADCAddLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to add lsnhttphdrlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnhttphdrlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logurl = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logmethod = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logversion = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loghost = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnhttphdrlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-ADCDeleteLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnhttphdrlogprofile -Httphdrlogprofilename <string>
        An example how to delete lsnhttphdrlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnhttphdrlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [string]$Httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-ADCUpdateLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to update lsnhttphdrlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnhttphdrlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logurl,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logmethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logversion,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Loghost,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnhttphdrlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-ADCUnsetLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER Logurl 
        URL information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logmethod 
        HTTP method information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logversion 
        Version information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Loghost 
        Host information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnhttphdrlogprofile -httphdrlogprofilename <string>
        An example how to unset lsnhttphdrlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnhttphdrlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile
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

        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

        [Boolean]$logurl,

        [Boolean]$logmethod,

        [Boolean]$logversion,

        [Boolean]$loghost 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ httphdrlogprofilename = $httphdrlogprofilename }
            if ( $PSBoundParameters.ContainsKey('logurl') ) { $payload.Add('logurl', $logurl) }
            if ( $PSBoundParameters.ContainsKey('logmethod') ) { $payload.Add('logmethod', $logmethod) }
            if ( $PSBoundParameters.ContainsKey('logversion') ) { $payload.Add('logversion', $logversion) }
            if ( $PSBoundParameters.ContainsKey('loghost') ) { $payload.Add('loghost', $loghost) }
            if ( $PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnhttphdrlogprofile: Finished"
    }
}

function Invoke-ADCGetLsnhttphdrlogprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN HTTP header logging Profile resource.
    .PARAMETER Httphdrlogprofilename 
        The name of the HTTP header logging Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnhttphdrlogprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnhttphdrlogprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnhttphdrlogprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnhttphdrlogprofile -GetAll 
        Get all lsnhttphdrlogprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnhttphdrlogprofile -Count 
        Get the number of lsnhttphdrlogprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnhttphdrlogprofile -name <string>
        Get lsnhttphdrlogprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnhttphdrlogprofile -Filter @{ 'name'='<value>' }
        Get lsnhttphdrlogprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnhttphdrlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Httphdrlogprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnhttphdrlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnhttphdrlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnhttphdrlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration for property 'httphdrlogprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnhttphdrlogprofile: Ended"
    }
}

function Invoke-ADCAddLsnip6profile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER Type 
        IPv6 translation type for which to set the LSN IP6 profile parameters. 
        Possible values = DS-Lite, NAT64 
    .PARAMETER Natprefix 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER Network6 
        IPv6 address of the Citrix ADC AFTR device. 
    .PARAMETER PassThru 
        Return details about the created lsnip6profile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnip6profile -name <string> -type <string>
        An example how to add lsnip6profile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnip6profile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('DS-Lite', 'NAT64')]
        [string]$Type,

        [string]$Natprefix,

        [string]$Network6,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnip6profile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('natprefix') ) { $payload.Add('natprefix', $natprefix) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSCmdlet.ShouldProcess("lsnip6profile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnip6profile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnip6profile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnip6profile: Finished"
    }
}

function Invoke-ADCDeleteLsnip6profile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnip6profile -Name <string>
        An example how to delete lsnip6profile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnip6profile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        Write-Verbose "Invoke-ADCDeleteLsnip6profile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnip6profile: Finished"
    }
}

function Invoke-ADCGetLsnip6profile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN ip6 Profile resource.
    .PARAMETER Name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsnip6profile object(s).
    .PARAMETER Count
        If specified, the count of the lsnip6profile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnip6profile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnip6profile -GetAll 
        Get all lsnip6profile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnip6profile -Count 
        Get the number of lsnip6profile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnip6profile -name <string>
        Get lsnip6profile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnip6profile -Filter @{ 'name'='<value>' }
        Get lsnip6profile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnip6profile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnip6profile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnip6profile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnip6profile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnip6profile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnip6profile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnip6profile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnip6profile: Ended"
    }
}

function Invoke-ADCAddLsnlogprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnlogprofile -logprofilename <string>
        An example how to add lsnlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsubscrinfo = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logcompact = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logipfix = 'DISABLED',

        [string]$Analyticsprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsessdeletion = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("lsnlogprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnlogprofile: Finished"
    }
}

function Invoke-ADCDeleteLsnlogprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnlogprofile -Logprofilename <string>
        An example how to delete lsnlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [string]$Logprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnlogprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$logprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnlogprofile: Finished"
    }
}

function Invoke-ADCUpdateLsnlogprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnlogprofile -logprofilename <string>
        An example how to update lsnlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsubscrinfo,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logcompact,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logipfix,

        [string]$Analyticsprofile,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Logsessdeletion,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("lsnlogprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnlogprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnlogprofile: Finished"
    }
}

function Invoke-ADCUnsetLsnlogprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER Logsubscrinfo 
        Subscriber ID information is logged if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logcompact 
        Logs in Compact Logging format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Logipfix 
        Logs in IPFIX format if option is enabled. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER Logsessdeletion 
        LSN Session deletion will not be logged if disabled. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnlogprofile -logprofilename <string>
        An example how to unset lsnlogprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile
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

        [ValidateLength(1, 127)]
        [string]$Logprofilename,

        [Boolean]$logsubscrinfo,

        [Boolean]$logcompact,

        [Boolean]$logipfix,

        [Boolean]$analyticsprofile,

        [Boolean]$logsessdeletion 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnlogprofile: Starting"
    }
    process {
        try {
            $payload = @{ logprofilename = $logprofilename }
            if ( $PSBoundParameters.ContainsKey('logsubscrinfo') ) { $payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ( $PSBoundParameters.ContainsKey('logcompact') ) { $payload.Add('logcompact', $logcompact) }
            if ( $PSBoundParameters.ContainsKey('logipfix') ) { $payload.Add('logipfix', $logipfix) }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSBoundParameters.ContainsKey('logsessdeletion') ) { $payload.Add('logsessdeletion', $logsessdeletion) }
            if ( $PSCmdlet.ShouldProcess("$logprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnlogprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnlogprofile: Finished"
    }
}

function Invoke-ADCGetLsnlogprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN logging Profile resource.
    .PARAMETER Logprofilename 
        The name of the logging Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnlogprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnlogprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnlogprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnlogprofile -GetAll 
        Get all lsnlogprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnlogprofile -Count 
        Get the number of lsnlogprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnlogprofile -name <string>
        Get lsnlogprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnlogprofile -Filter @{ 'name'='<value>' }
        Get lsnlogprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnlogprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$Logprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnlogprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnlogprofile configuration for property 'logprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnlogprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnlogprofile: Ended"
    }
}

function Invoke-ADCUpdateLsnparameter {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB. 
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory. 
        This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
    .PARAMETER Sessionsync 
        Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
        The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default. 
        For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscrsessionremoval 
        LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnparameter 
        An example how to update lsnparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter/
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

        [double]$Memlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sessionsync,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Subscrsessionremoval 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('subscrsessionremoval') ) { $payload.Add('subscrsessionremoval', $subscrsessionremoval) }
            if ( $PSCmdlet.ShouldProcess("lsnparameter", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateLsnparameter: Finished"
    }
}

function Invoke-ADCUnsetLsnparameter {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER Memlimit 
        Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB. 
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory. 
        This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
    .PARAMETER Sessionsync 
        Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary). 
        The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default. 
        For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Subscrsessionremoval 
        LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnparameter 
        An example how to unset lsnparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter
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

        [Boolean]$memlimit,

        [Boolean]$sessionsync,

        [Boolean]$subscrsessionremoval 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('memlimit') ) { $payload.Add('memlimit', $memlimit) }
            if ( $PSBoundParameters.ContainsKey('sessionsync') ) { $payload.Add('sessionsync', $sessionsync) }
            if ( $PSBoundParameters.ContainsKey('subscrsessionremoval') ) { $payload.Add('subscrsessionremoval', $subscrsessionremoval) }
            if ( $PSCmdlet.ShouldProcess("lsnparameter", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnparameter: Finished"
    }
}

function Invoke-ADCGetLsnparameter {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN parameter resource.
    .PARAMETER GetAll 
        Retrieve all lsnparameter object(s).
    .PARAMETER Count
        If specified, the count of the lsnparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnparameter -GetAll 
        Get all lsnparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnparameter -name <string>
        Get lsnparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnparameter -Filter @{ 'name'='<value>' }
        Get lsnparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnparameter
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter/
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
        Write-Verbose "Invoke-ADCGetLsnparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnparameter: Ended"
    }
}

function Invoke-ADCAddLsnpool {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Nattype 
        Type of NAT IP address and port allocation (from the LSN pools bound to an LSN group) for subscribers (of the LSN client entity bound to the LSN group): 
        Available options function as follows: 
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port. 
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber. 
        Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. A maximum of 16 LSN pools can be bound to an LSN group. . 
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER Portblockallocation 
        Allocate a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber when the NAT allocation is set as Dynamic NAT. For any connection initiated from a subscriber, the Citrix ADC allocates a NAT port from the subscriber's allocated NAT port block to create the LSN session. 
        You must set the port block size in the bound LSN group. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the Citrix ADC allocates a new random port block for the subscriber. 
        For Deterministic NAT, this parameter is enabled by default, and you cannot disable it. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session. 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnpool -poolname <string>
        An example how to add lsnpool configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnpool
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$Nattype = 'DYNAMIC',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portblockallocation = 'DISABLED',

        [ValidateRange(0, 600)]
        [double]$Portrealloctimeout = '0',

        [ValidateRange(0, 65536)]
        [double]$Maxportrealloctmq = '65536',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('portblockallocation') ) { $payload.Add('portblockallocation', $portblockallocation) }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("lsnpool", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnpool -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnpool -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnpool: Finished"
    }
}

function Invoke-ADCDeleteLsnpool {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnpool -Poolname <string>
        An example how to delete lsnpool configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnpool
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [string]$Poolname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnpool: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$poolname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnpool: Finished"
    }
}

function Invoke-ADCUpdateLsnpool {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session. 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnpool -poolname <string>
        An example how to update lsnpool configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnpool
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [ValidateRange(0, 600)]
        [double]$Portrealloctimeout,

        [ValidateRange(0, 65536)]
        [double]$Maxportrealloctmq,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("lsnpool", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnpool -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnpool: Finished"
    }
}

function Invoke-ADCUnsetLsnpool {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in: 
        * Deterministic NAT 
        * Address-Dependent filtering and Address-Port-Dependent filtering 
        * Dynamic NAT with port block allocation 
        In these cases, ports are immediately reallocated. 
    .PARAMETER Maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address. 
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnpool -poolname <string>
        An example how to unset lsnpool configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnpool
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [Boolean]$portrealloctimeout,

        [Boolean]$maxportrealloctmq 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnpool: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('portrealloctimeout') ) { $payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ( $PSBoundParameters.ContainsKey('maxportrealloctmq') ) { $payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ( $PSCmdlet.ShouldProcess("$poolname", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnpool -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnpool: Finished"
    }
}

function Invoke-ADCGetLsnpool {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN pool resource.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpool
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnpool -GetAll 
        Get all lsnpool data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnpool -Count 
        Get the number of lsnpool objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpool -name <string>
        Get lsnpool object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpool -Filter @{ 'name'='<value>' }
        Get lsnpool data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnpool
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

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
        Write-Verbose "Invoke-ADCGetLsnpool: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnpool: Ended"
    }
}

function Invoke-ADCGetLsnpoolbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoolbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnpoolbinding -GetAll 
        Get all lsnpool_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoolbinding -name <string>
        Get lsnpool_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoolbinding -Filter @{ 'name'='<value>' }
        Get lsnpool_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnpoolbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnpoolbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_binding configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnpoolbinding: Ended"
    }
}

function Invoke-ADCAddLsnpoollsnipbinding {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Ownernode 
        ID(s) of cluster node(s) on which command is to be executed. 
    .PARAMETER Lsnip 
        IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default, arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" . 
    .PARAMETER PassThru 
        Return details about the created lsnpool_lsnip_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnpoollsnipbinding -poolname <string>
        An example how to add lsnpool_lsnip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnpoollsnipbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [ValidateRange(0, 31)]
        [double]$Ownernode,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lsnip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnpoollsnipbinding: Starting"
    }
    process {
        try {
            $payload = @{ poolname = $poolname }
            if ( $PSBoundParameters.ContainsKey('ownernode') ) { $payload.Add('ownernode', $ownernode) }
            if ( $PSBoundParameters.ContainsKey('lsnip') ) { $payload.Add('lsnip', $lsnip) }
            if ( $PSCmdlet.ShouldProcess("lsnpool_lsnip_binding", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool_lsnip_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnpoollsnipbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnpoollsnipbinding: Finished"
    }
}

function Invoke-ADCDeleteLsnpoollsnipbinding {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER Ownernode 
        ID(s) of cluster node(s) on which command is to be executed. 
    .PARAMETER Lsnip 
        IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default, arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" .
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnpoollsnipbinding -Poolname <string>
        An example how to delete lsnpool_lsnip_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnpoollsnipbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [string]$Poolname,

        [double]$Ownernode,

        [string]$Lsnip 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnpoollsnipbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Ownernode') ) { $arguments.Add('ownernode', $Ownernode) }
            if ( $PSBoundParameters.ContainsKey('Lsnip') ) { $arguments.Add('lsnip', $Lsnip) }
            if ( $PSCmdlet.ShouldProcess("$poolname", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnpoollsnipbinding: Finished"
    }
}

function Invoke-ADCGetLsnpoollsnipbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the lsnip that can be bound to lsnpool.
    .PARAMETER Poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retrieve all lsnpool_lsnip_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnpool_lsnip_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoollsnipbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnpoollsnipbinding -GetAll 
        Get all lsnpool_lsnip_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnpoollsnipbinding -Count 
        Get the number of lsnpool_lsnip_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoollsnipbinding -name <string>
        Get lsnpool_lsnip_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnpoollsnipbinding -Filter @{ 'name'='<value>' }
        Get lsnpool_lsnip_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnpoollsnipbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Poolname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnpoollsnipbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnpool_lsnip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_lsnip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnpoollsnipbinding: Ended"
    }
}

function Invoke-ADCAddLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnrtspalgprofile -rtspalgprofilename <string> -rtspportrange <string>
        An example how to add lsnrtspalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnrtspalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [double]$Rtspidletimeout = '120',

        [Parameter(Mandatory)]
        [string]$Rtspportrange,

        [ValidateSet('TCP', 'UDP')]
        [string]$Rtsptransportprotocol = 'TCP',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename
                rtspportrange                = $rtspportrange
            }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnrtspalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnrtspalgprofile: Finished"
    }
}

function Invoke-ADCUpdateLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnrtspalgprofile -rtspalgprofilename <string>
        An example how to update lsnrtspalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnrtspalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [double]$Rtspidletimeout,

        [string]$Rtspportrange,

        [ValidateSet('TCP', 'UDP')]
        [string]$Rtsptransportprotocol,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtspportrange') ) { $payload.Add('rtspportrange', $rtspportrange) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnrtspalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnrtspalgprofile: Finished"
    }
}

function Invoke-ADCUnsetLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER Rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds. 
    .PARAMETER Rtspportrange 
        port for the RTSP. 
    .PARAMETER Rtsptransportprotocol 
        RTSP ALG Profile transport protocol type. 
        Possible values = TCP, UDP
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnrtspalgprofile -rtspalgprofilename <string>
        An example how to unset lsnrtspalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnrtspalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile
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

        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

        [Boolean]$rtspidletimeout,

        [Boolean]$rtspportrange,

        [Boolean]$rtsptransportprotocol 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ rtspalgprofilename = $rtspalgprofilename }
            if ( $PSBoundParameters.ContainsKey('rtspidletimeout') ) { $payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ( $PSBoundParameters.ContainsKey('rtspportrange') ) { $payload.Add('rtspportrange', $rtspportrange) }
            if ( $PSBoundParameters.ContainsKey('rtsptransportprotocol') ) { $payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ( $PSCmdlet.ShouldProcess("$rtspalgprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnrtspalgprofile: Finished"
    }
}

function Invoke-ADCDeleteLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnrtspalgprofile -Rtspalgprofilename <string>
        An example how to delete lsnrtspalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnrtspalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [string]$Rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$rtspalgprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnrtspalgprofile: Finished"
    }
}

function Invoke-ADCGetLsnrtspalgprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN RTSPALG Profile resource.
    .PARAMETER Rtspalgprofilename 
        The name of the RTSPALG Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgprofile -GetAll 
        Get all lsnrtspalgprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgprofile -Count 
        Get the number of lsnrtspalgprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgprofile -name <string>
        Get lsnrtspalgprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgprofile -Filter @{ 'name'='<value>' }
        Get lsnrtspalgprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Rtspalgprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnrtspalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration for property 'rtspalgprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnrtspalgprofile: Ended"
    }
}

function Invoke-ADCFlushLsnrtspalgsession {
    <#
    .SYNOPSIS
        Flush Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN RTSPALG session resource.
    .PARAMETER Sessionid 
        Session ID for the RTSP call.
    .EXAMPLE
        PS C:\>Invoke-ADCFlushLsnrtspalgsession -sessionid <string>
        An example how to flush lsnrtspalgsession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushLsnrtspalgsession
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession/
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
        [string]$Sessionid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnrtspalgsession: Starting"
    }
    process {
        try {
            $payload = @{ sessionid = $sessionid }

            if ( $PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgsession -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushLsnrtspalgsession: Finished"
    }
}

function Invoke-ADCGetLsnrtspalgsession {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN RTSPALG session resource.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgsession -GetAll 
        Get all lsnrtspalgsession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgsession -Count 
        Get the number of lsnrtspalgsession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsession -name <string>
        Get lsnrtspalgsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsession -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsession
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession/
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
        [string]$Sessionid,

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
        Write-Verbose "Invoke-ADCGetLsnrtspalgsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsession: Ended"
    }
}

function Invoke-ADCGetLsnrtspalgsessionbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnrtspalgsession.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgsessionbinding -GetAll 
        Get all lsnrtspalgsession_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessionbinding -name <string>
        Get lsnrtspalgsession_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessionbinding -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsessionbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession_binding/
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
        [string]$Sessionid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsessionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnrtspalgsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsessionbinding: Ended"
    }
}

function Invoke-ADCGetLsnrtspalgsessiondatachannelbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the datachannel that can be bound to lsnrtspalgsession.
    .PARAMETER Sessionid 
        Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retrieve all lsnrtspalgsession_datachannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_datachannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessiondatachannelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -GetAll 
        Get all lsnrtspalgsession_datachannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -Count 
        Get the number of lsnrtspalgsession_datachannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -name <string>
        Get lsnrtspalgsession_datachannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -Filter @{ 'name'='<value>' }
        Get lsnrtspalgsession_datachannel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsessiondatachannelbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession_datachannel_binding/
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
        [string]$Sessionid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsessiondatachannelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsessiondatachannelbinding: Ended"
    }
}

function Invoke-ADCFlushLsnsession {
    <#
    .SYNOPSIS
        Flush Lsn configuration Object.
    .DESCRIPTION
        Configuration for lsn session resource.
    .PARAMETER Nattype 
        Type of sessions to be displayed. 
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER Clientname 
        Name of the LSN Client entity. 
    .PARAMETER Network 
        IP address or network address of subscriber(s). 
    .PARAMETER Netmask 
        Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Td 
        Traffic domain ID of the LSN client entity. 
    .PARAMETER Natip 
        Mapped NAT IP address used in LSN sessions. 
    .PARAMETER Natport2 
        Mapped NAT port used in the LSN sessions. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node.
    .EXAMPLE
        PS C:\>Invoke-ADCFlushLsnsession 
        An example how to flush lsnsession configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushLsnsession
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsession/
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

        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$Nattype,

        [string]$Clientname,

        [string]$Network,

        [string]$Netmask,

        [string]$Network6,

        [ValidateRange(0, 4094)]
        [double]$Td,

        [string]$Natip,

        [int]$Natport2,

        [ValidateRange(0, 31)]
        [double]$Nodeid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnsession: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('nattype') ) { $payload.Add('nattype', $nattype) }
            if ( $PSBoundParameters.ContainsKey('clientname') ) { $payload.Add('clientname', $clientname) }
            if ( $PSBoundParameters.ContainsKey('network') ) { $payload.Add('network', $network) }
            if ( $PSBoundParameters.ContainsKey('netmask') ) { $payload.Add('netmask', $netmask) }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('natip') ) { $payload.Add('natip', $natip) }
            if ( $PSBoundParameters.ContainsKey('natport2') ) { $payload.Add('natport2', $natport2) }
            if ( $PSBoundParameters.ContainsKey('nodeid') ) { $payload.Add('nodeid', $nodeid) }
            if ( $PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsession -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushLsnsession: Finished"
    }
}

function Invoke-ADCGetLsnsession {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for lsn session resource.
    .PARAMETER Nattype 
        Type of sessions to be displayed. 
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER Clientname 
        Name of the LSN Client entity. 
    .PARAMETER Network 
        IP address or network address of subscriber(s). 
    .PARAMETER Netmask 
        Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER Network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER Td 
        Traffic domain ID of the LSN client entity. 
    .PARAMETER Natip 
        Mapped NAT IP address used in LSN sessions. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all lsnsession object(s).
    .PARAMETER Count
        If specified, the count of the lsnsession object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsession
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsession -GetAll 
        Get all lsnsession data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsession -Count 
        Get the number of lsnsession objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsession -name <string>
        Get lsnsession object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsession -Filter @{ 'name'='<value>' }
        Get lsnsession data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsession
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsession/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$Nattype,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Clientname,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Netmask,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Network6,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4094)]
        [double]$Td,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Natip,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsession objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('nattype') ) { $arguments.Add('nattype', $nattype) } 
                if ( $PSBoundParameters.ContainsKey('clientname') ) { $arguments.Add('clientname', $clientname) } 
                if ( $PSBoundParameters.ContainsKey('network') ) { $arguments.Add('network', $network) } 
                if ( $PSBoundParameters.ContainsKey('netmask') ) { $arguments.Add('netmask', $netmask) } 
                if ( $PSBoundParameters.ContainsKey('network6') ) { $arguments.Add('network6', $network6) } 
                if ( $PSBoundParameters.ContainsKey('td') ) { $arguments.Add('td', $td) } 
                if ( $PSBoundParameters.ContainsKey('natip') ) { $arguments.Add('natip', $natip) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsession: Ended"
    }
}

function Invoke-ADCFlushLsnsipalgcall {
    <#
    .SYNOPSIS
        Flush Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN SIPALG call resource.
    .PARAMETER Callid 
        Call ID for the SIP call.
    .EXAMPLE
        PS C:\>Invoke-ADCFlushLsnsipalgcall -callid <string>
        An example how to flush lsnsipalgcall configuration Object(s).
    .NOTES
        File Name : Invoke-ADCFlushLsnsipalgcall
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall/
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
        [string]$Callid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnsipalgcall: Starting"
    }
    process {
        try {
            $payload = @{ callid = $callid }

            if ( $PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgcall -Action flush -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCFlushLsnsipalgcall: Finished"
    }
}

function Invoke-ADCGetLsnsipalgcall {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN SIPALG call resource.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcall
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcall -GetAll 
        Get all lsnsipalgcall data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcall -Count 
        Get the number of lsnsipalgcall objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcall -name <string>
        Get lsnsipalgcall object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcall -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcall
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall/
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
        [string]$Callid,

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
        Write-Verbose "Invoke-ADCGetLsnsipalgcall: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsipalgcall objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsipalgcall: Ended"
    }
}

function Invoke-ADCGetLsnsipalgcallbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcallbinding -GetAll 
        Get all lsnsipalgcall_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallbinding -name <string>
        Get lsnsipalgcall_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallbinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcallbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_binding/
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
        [string]$Callid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnsipalgcallbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsipalgcallbinding: Ended"
    }
}

function Invoke-ADCGetLsnsipalgcallcontrolchannelbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the controlchannel that can be bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_controlchannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_controlchannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallcontrolchannelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -GetAll 
        Get all lsnsipalgcall_controlchannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -Count 
        Get the number of lsnsipalgcall_controlchannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -name <string>
        Get lsnsipalgcall_controlchannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_controlchannel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcallcontrolchannelbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_controlchannel_binding/
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
        [string]$Callid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnsipalgcallcontrolchannelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsipalgcallcontrolchannelbinding: Ended"
    }
}

function Invoke-ADCGetLsnsipalgcalldatachannelbinding {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Binding object showing the datachannel that can be bound to lsnsipalgcall.
    .PARAMETER Callid 
        Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgcall_datachannel_binding object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_datachannel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcalldatachannelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcalldatachannelbinding -GetAll 
        Get all lsnsipalgcall_datachannel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgcalldatachannelbinding -Count 
        Get the number of lsnsipalgcall_datachannel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcalldatachannelbinding -name <string>
        Get lsnsipalgcall_datachannel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgcalldatachannelbinding -Filter @{ 'name'='<value>' }
        Get lsnsipalgcall_datachannel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcalldatachannelbinding
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_datachannel_binding/
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
        [string]$Callid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnsipalgcalldatachannelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsipalgcalldatachannelbinding: Ended"
    }
}

function Invoke-ADCAddLsnsipalgprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnsipalgprofile -sipalgprofilename <string> -siptransportprotocol <string>
        An example how to add lsnsipalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnsipalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [double]$Datasessionidletimeout = '120',

        [double]$Sipsessiontimeout = '600',

        [double]$Registrationtimeout = '60',

        [string]$Sipsrcportrange,

        [string]$Sipdstportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openregisterpinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Opencontactpinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openviapinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openrecordroutepinhole = 'ENABLED',

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP')]
        [string]$Siptransportprotocol,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openroutepinhole = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rport = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename
                siptransportprotocol        = $siptransportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("lsnsipalgprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnsipalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnsipalgprofile: Finished"
    }
}

function Invoke-ADCUpdateLsnsipalgprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsnsipalgprofile -sipalgprofilename <string>
        An example how to update lsnsipalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsnsipalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [double]$Datasessionidletimeout,

        [double]$Sipsessiontimeout,

        [double]$Registrationtimeout,

        [string]$Sipsrcportrange,

        [string]$Sipdstportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openregisterpinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Opencontactpinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openviapinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openrecordroutepinhole,

        [ValidateSet('TCP', 'UDP')]
        [string]$Siptransportprotocol,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Openroutepinhole,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Rport,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('siptransportprotocol') ) { $payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("lsnsipalgprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnsipalgprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsnsipalgprofile: Finished"
    }
}

function Invoke-ADCUnsetLsnsipalgprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER Datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds. 
    .PARAMETER Sipsessiontimeout 
        SIP control channel session timeout in seconds. 
    .PARAMETER Registrationtimeout 
        SIP registration timeout in seconds. 
    .PARAMETER Sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER Openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openviapinhole 
        ENABLE/DISABLE ViaPinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Siptransportprotocol 
        SIP ALG Profile transport protocol type. 
        Possible values = TCP, UDP 
    .PARAMETER Openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Rport 
        ENABLE/DISABLE rport. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsnsipalgprofile -sipalgprofilename <string>
        An example how to unset lsnsipalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsnsipalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile
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

        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

        [Boolean]$datasessionidletimeout,

        [Boolean]$sipsessiontimeout,

        [Boolean]$registrationtimeout,

        [Boolean]$sipsrcportrange,

        [Boolean]$sipdstportrange,

        [Boolean]$openregisterpinhole,

        [Boolean]$opencontactpinhole,

        [Boolean]$openviapinhole,

        [Boolean]$openrecordroutepinhole,

        [Boolean]$siptransportprotocol,

        [Boolean]$openroutepinhole,

        [Boolean]$rport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnsipalgprofile: Starting"
    }
    process {
        try {
            $payload = @{ sipalgprofilename = $sipalgprofilename }
            if ( $PSBoundParameters.ContainsKey('datasessionidletimeout') ) { $payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsessiontimeout') ) { $payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('registrationtimeout') ) { $payload.Add('registrationtimeout', $registrationtimeout) }
            if ( $PSBoundParameters.ContainsKey('sipsrcportrange') ) { $payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ( $PSBoundParameters.ContainsKey('sipdstportrange') ) { $payload.Add('sipdstportrange', $sipdstportrange) }
            if ( $PSBoundParameters.ContainsKey('openregisterpinhole') ) { $payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ( $PSBoundParameters.ContainsKey('opencontactpinhole') ) { $payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ( $PSBoundParameters.ContainsKey('openviapinhole') ) { $payload.Add('openviapinhole', $openviapinhole) }
            if ( $PSBoundParameters.ContainsKey('openrecordroutepinhole') ) { $payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('siptransportprotocol') ) { $payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ( $PSBoundParameters.ContainsKey('openroutepinhole') ) { $payload.Add('openroutepinhole', $openroutepinhole) }
            if ( $PSBoundParameters.ContainsKey('rport') ) { $payload.Add('rport', $rport) }
            if ( $PSCmdlet.ShouldProcess("$sipalgprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnsipalgprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsnsipalgprofile: Finished"
    }
}

function Invoke-ADCDeleteLsnsipalgprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnsipalgprofile -Sipalgprofilename <string>
        An example how to delete lsnsipalgprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnsipalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [string]$Sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnsipalgprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$sipalgprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnsipalgprofile: Finished"
    }
}

function Invoke-ADCGetLsnsipalgprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN SIPALG Profile resource.
    .PARAMETER Sipalgprofilename 
        The name of the SIPALG Profile. 
    .PARAMETER GetAll 
        Retrieve all lsnsipalgprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsnsipalgprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgprofile -GetAll 
        Get all lsnsipalgprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnsipalgprofile -Count 
        Get the number of lsnsipalgprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgprofile -name <string>
        Get lsnsipalgprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnsipalgprofile -Filter @{ 'name'='<value>' }
        Get lsnsipalgprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$Sipalgprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnsipalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnsipalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgprofile configuration for property 'sipalgprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnsipalgprofile: Ended"
    }
}

function Invoke-ADCAddLsnstatic {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER Transportprotocol 
        Protocol for the LSN mapping entry. 
        Possible values = TCP, UDP, ICMP, ALL 
    .PARAMETER Subscrip 
        IPv4(NAT44 ; DS-Lite)/IPv6(NAT64) address of an LSN subscriber for the LSN static mapping entry. 
    .PARAMETER Subscrport 
        Port of the LSN subscriber for the LSN mapping entry. * represents all ports being used. Used in case of static wildcard. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Network6 
        B4 address in DS-Lite setup. 
    .PARAMETER Td 
        ID of the traffic domain to which the subscriber belongs. 
        If you do not specify an ID, the subscriber is assumed to be a part of the default traffic domain. 
    .PARAMETER Natip 
        IPv4 address, already existing on the Citrix ADC as type LSN, to be used as NAT IP address for this mapping entry. 
    .PARAMETER Natport 
        NAT port for this LSN mapping entry. * represents all ports being used. Used in case of static wildcard. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Destip 
        Destination IP address for the LSN mapping entry. 
    .PARAMETER Dsttd 
        ID of the traffic domain through which the destination IP address for this LSN mapping entry is reachable from the Citrix ADC. 
        If you do not specify an ID, the destination IP address is assumed to be reachable through the default traffic domain, which has an ID of 0. 
    .PARAMETER PassThru 
        Return details about the created lsnstatic item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsnstatic -name <string> -transportprotocol <string> -subscrip <string> -subscrport <int>
        An example how to add lsnstatic configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsnstatic
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP', 'ALL')]
        [string]$Transportprotocol,

        [Parameter(Mandatory)]
        [string]$Subscrip,

        [Parameter(Mandatory)]
        [ValidateRange(1, 65535)]
        [int]$Subscrport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Network6,

        [ValidateRange(0, 4094)]
        [double]$Td = '0',

        [string]$Natip,

        [ValidateRange(1, 65535)]
        [int]$Natport,

        [string]$Destip,

        [ValidateRange(0, 4094)]
        [double]$Dsttd = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnstatic: Starting"
    }
    process {
        try {
            $payload = @{ name    = $name
                transportprotocol = $transportprotocol
                subscrip          = $subscrip
                subscrport        = $subscrport
            }
            if ( $PSBoundParameters.ContainsKey('network6') ) { $payload.Add('network6', $network6) }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('natip') ) { $payload.Add('natip', $natip) }
            if ( $PSBoundParameters.ContainsKey('natport') ) { $payload.Add('natport', $natport) }
            if ( $PSBoundParameters.ContainsKey('destip') ) { $payload.Add('destip', $destip) }
            if ( $PSBoundParameters.ContainsKey('dsttd') ) { $payload.Add('dsttd', $dsttd) }
            if ( $PSCmdlet.ShouldProcess("lsnstatic", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnstatic -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsnstatic -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsnstatic: Finished"
    }
}

function Invoke-ADCDeleteLsnstatic {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsnstatic -Name <string>
        An example how to delete lsnstatic configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsnstatic
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        Write-Verbose "Invoke-ADCDeleteLsnstatic: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsnstatic: Finished"
    }
}

function Invoke-ADCGetLsnstatic {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for static mapping resource.
    .PARAMETER Name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retrieve all lsnstatic object(s).
    .PARAMETER Count
        If specified, the count of the lsnstatic object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnstatic
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnstatic -GetAll 
        Get all lsnstatic data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsnstatic -Count 
        Get the number of lsnstatic objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnstatic -name <string>
        Get lsnstatic object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsnstatic -Filter @{ 'name'='<value>' }
        Get lsnstatic data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsnstatic
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnstatic: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsnstatic objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnstatic objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnstatic objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnstatic configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnstatic configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsnstatic: Ended"
    }
}

function Invoke-ADCAddLsntransportprofile {
    <#
    .SYNOPSIS
        Add Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Transportprotocol 
        Protocol for which to set the LSN transport profile parameters. 
        Possible values = TCP, UDP, ICMP 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
        Following are some reasons for the Citrix ADC to receive such packets: 
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddLsntransportprofile -transportprofilename <string> -transportprotocol <string>
        An example how to add lsntransportprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddLsntransportprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [Parameter(Mandatory)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$Transportprotocol,

        [double]$Sessiontimeout = '120',

        [double]$Finrsttimeout = '30',

        [ValidateRange(120, 1200)]
        [double]$Stuntimeout = '600',

        [ValidateRange(30, 120)]
        [double]$Synidletimeout = '60',

        [ValidateRange(0, 65535)]
        [double]$Portquota = '0',

        [ValidateRange(0, 65535)]
        [double]$Sessionquota = '0',

        [double]$Groupsessionlimit = '0',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserveparity = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserverange = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncheck = 'ENABLED',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename
                transportprotocol              = $transportprotocol
            }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("lsntransportprofile", "Add Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsntransportprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddLsntransportprofile: Finished"
    }
}

function Invoke-ADCDeleteLsntransportprofile {
    <#
    .SYNOPSIS
        Delete Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteLsntransportprofile -Transportprofilename <string>
        An example how to delete lsntransportprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteLsntransportprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [string]$Transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsntransportprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$transportprofilename", "Delete Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteLsntransportprofile: Finished"
    }
}

function Invoke-ADCUpdateLsntransportprofile {
    <#
    .SYNOPSIS
        Update Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
        Following are some reasons for the Citrix ADC to receive such packets: 
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateLsntransportprofile -transportprofilename <string>
        An example how to update lsntransportprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateLsntransportprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [double]$Sessiontimeout,

        [double]$Finrsttimeout,

        [ValidateRange(120, 1200)]
        [double]$Stuntimeout,

        [ValidateRange(30, 120)]
        [double]$Synidletimeout,

        [ValidateRange(0, 65535)]
        [double]$Portquota,

        [ValidateRange(0, 65535)]
        [double]$Sessionquota,

        [double]$Groupsessionlimit,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserveparity,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Portpreserverange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Syncheck,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("lsntransportprofile", "Update Lsn configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetLsntransportprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateLsntransportprofile: Finished"
    }
}

function Invoke-ADCUnsetLsntransportprofile {
    <#
    .SYNOPSIS
        Unset Lsn configuration Object.
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER Sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session. 
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
    .PARAMETER Finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints. 
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session. 
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
    .PARAMETER Stuntimeout 
        STUN protocol timeout. 
    .PARAMETER Synidletimeout 
        SYN Idle timeout. 
    .PARAMETER Portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
    .PARAMETER Sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol. 
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
    .PARAMETER Groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
    .PARAMETER Portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection. 
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection. 
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports. 
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC. 
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection. 
        Following are some reasons for the Citrix ADC to receive such packets: 
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout. 
        * Such packets can be a part of a DoS attack. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetLsntransportprofile -transportprofilename <string>
        An example how to unset lsntransportprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetLsntransportprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

        [Boolean]$sessiontimeout,

        [Boolean]$finrsttimeout,

        [Boolean]$stuntimeout,

        [Boolean]$synidletimeout,

        [Boolean]$portquota,

        [Boolean]$sessionquota,

        [Boolean]$groupsessionlimit,

        [Boolean]$portpreserveparity,

        [Boolean]$portpreserverange,

        [Boolean]$syncheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsntransportprofile: Starting"
    }
    process {
        try {
            $payload = @{ transportprofilename = $transportprofilename }
            if ( $PSBoundParameters.ContainsKey('sessiontimeout') ) { $payload.Add('sessiontimeout', $sessiontimeout) }
            if ( $PSBoundParameters.ContainsKey('finrsttimeout') ) { $payload.Add('finrsttimeout', $finrsttimeout) }
            if ( $PSBoundParameters.ContainsKey('stuntimeout') ) { $payload.Add('stuntimeout', $stuntimeout) }
            if ( $PSBoundParameters.ContainsKey('synidletimeout') ) { $payload.Add('synidletimeout', $synidletimeout) }
            if ( $PSBoundParameters.ContainsKey('portquota') ) { $payload.Add('portquota', $portquota) }
            if ( $PSBoundParameters.ContainsKey('sessionquota') ) { $payload.Add('sessionquota', $sessionquota) }
            if ( $PSBoundParameters.ContainsKey('groupsessionlimit') ) { $payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ( $PSBoundParameters.ContainsKey('portpreserveparity') ) { $payload.Add('portpreserveparity', $portpreserveparity) }
            if ( $PSBoundParameters.ContainsKey('portpreserverange') ) { $payload.Add('portpreserverange', $portpreserverange) }
            if ( $PSBoundParameters.ContainsKey('syncheck') ) { $payload.Add('syncheck', $syncheck) }
            if ( $PSCmdlet.ShouldProcess("$transportprofilename", "Unset Lsn configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsntransportprofile -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetLsntransportprofile: Finished"
    }
}

function Invoke-ADCGetLsntransportprofile {
    <#
    .SYNOPSIS
        Get Lsn configuration object(s).
    .DESCRIPTION
        Configuration for LSN Transport Profile resource.
    .PARAMETER Transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER GetAll 
        Retrieve all lsntransportprofile object(s).
    .PARAMETER Count
        If specified, the count of the lsntransportprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsntransportprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsntransportprofile -GetAll 
        Get all lsntransportprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetLsntransportprofile -Count 
        Get the number of lsntransportprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsntransportprofile -name <string>
        Get lsntransportprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetLsntransportprofile -Filter @{ 'name'='<value>' }
        Get lsntransportprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetLsntransportprofile
        Version   : v2204.0320
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$Transportprofilename,

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
        Write-Verbose "Invoke-ADCGetLsntransportprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all lsntransportprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsntransportprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsntransportprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsntransportprofile configuration for property 'transportprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsntransportprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetLsntransportprofile: Ended"
    }
}

# SIG # Begin signature block
# MIIkrQYJKoZIhvcNAQcCoIIknjCCJJoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDfcKeQjtWqzb9A
# fZKFeJvPIiBumPbu2PyrPjTHvwq986CCHnAwggTzMIID26ADAgECAhAsJ03zZBC0
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
# LqPzW0sH3DJZ84enGm1YMIIG7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTAN
# BgkqhkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJz
# ZXkxFDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNU
# IE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkwHhcNMTkwNTAyMDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYD
# VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
# YWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3Rp
# Z28gUlNBIFRpbWUgU3RhbXBpbmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDIGwGv2Sx+iJl9AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7Xr
# xMxJNMvzRWW5+adkFiYJ+9UyUnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ
# 29ddSU1yVg/cyeNTmDoqHvzOWEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+z
# xXKsLgp3/A2UUrf8H5VzJD0BKLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REK
# V4TJf1bgvUacgr6Unb+0ILBgfrhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NT
# IMdgaZtYClT0Bef9Maz5yIUXx7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxg
# zKi7nw0U1BjEMJh0giHPYla1IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE
# 8NfwKMVPZIMC1Pvi3vG8Aij0bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WY
# nJee647BeFbGRCXfBhKaBi2fA179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2
# +opBJNQb/HKlFKLUrUMcpEmLQTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7
# Sn1FNsH3jYL6uckNU4B9+rY5WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IB
# WjCCAVYwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYE
# FBqh+GEZIA/DQXdFKI7RNV8GEgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMBMGA1UdJQQMMAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0g
# ADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
# UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEE
# ajBoMD8GCCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRy
# dXN0UlNBQWRkVHJ1c3RDQS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVz
# ZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oy
# Cy0lhBGysNsqfSoF9bw7J/RaoLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/x
# QuUQff+wdB+PxlwJ+TNe6qAcJlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5
# OGK/EwHFhaNMxcyyUzCVpNb0llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFt
# Z83Jb5A9f0VywRsj1sJVhGbks8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY
# 3NdK0z2vgwY4Eh0khy3k/ALWPncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqn
# yTdlHb7qvNhCg0MFpYumCf/RoZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSW
# mglfjv33sVKRzj+J9hyhtal1H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTM
# ze4nmuWgwAxyh8FuTVrTHurwROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg
# 3qj5PObBMLvAoGMs/FwWAKjQxH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/36
# 0KOE2See+wFmd7lWEOEgbsausfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr
# 4/kKyVRd1LlqdJ69SK6YMIIHBzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWsw
# DQYJKoZIhvcNAQEMBQAwfTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
# TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBM
# aW1pdGVkMSUwIwYDVQQDExxTZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4X
# DTIwMTAyMzAwMDAwMFoXDTMyMDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRsw
# GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAW
# BgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGlt
# ZSBTdGFtcGluZyBTaWduZXIgIzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQCRh0ssi8HxHqCe0wfGAcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DW
# mn4yyGqBfbRcPlYQgTU6IjaM+/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJre
# TAdOhcxwxQ177MPZ45fpyxnbVkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fW
# uCVJwjkbh4E5y8O3Os2fUAQfGpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2H
# YxiOdMuEh0FpY4G89h+qfNfBQc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv
# 53mTDTJjU67MximKIMFgxvICLMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKV
# KoVUrvH9Pkl0dPyOrj+lcvTDWgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRX
# yCYFevyBI19UCTgqYtWqyt/tz1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEV
# YFClsezPuOjJC77FhPfdCp3avClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzG
# PATWMcV+7z3oUX5xrSR0Gyzc+Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4s
# rjcS8bxWw+StQ8O3ZpZelDL6oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCC
# AXQwHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1
# N3u7nTVCTr9X05rbnwHRrt7QMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAA
# MBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQEC
# AQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1Ud
# HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRp
# bWVTdGFtcGluZ0NBLmNybDB0BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0
# dHA6Ly9jcnQuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNy
# dDAjBggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcN
# AQEMBQADggIBAEoDeJBCM+x7GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu6
# 6ZWQNze93/tk7OWCt5XMV1VwS070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIV
# y0RQmYzsProDd6aCApDCLpOpviE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQ
# Lt/qiBcW62nW4SW9RQiXgNdUIChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55
# aJo2i0OuNtRhcjwOhWINoF5w22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9o
# GsRlKTUqLYi86q501oLnwIi44U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkW
# mcmqt4hJ9+gLJTO1P22vn18KVt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiG
# oDCni6GftCzMwBYjyZHlQgNLgM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6
# R4nomIGpdcAO39BolHmhoJ6OtrdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TU
# JikmQI54L7nu+i/x8Y/+ULh43RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbW
# w/HXaONPB3mBCBP+smRe6bE85tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFkzCC
# BY8CAQEwgZAwfDELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
# c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVk
# MSQwIgYDVQQDExtTZWN0aWdvIFJTQSBDb2RlIFNpZ25pbmcgQ0ECECwnTfNkELSL
# /bju5S9Y3lMwDQYJYIZIAWUDBAIBBQCggYQwGAYKKwYBBAGCNwIBDDEKMAigAoAA
# oQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4w
# DAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgBDzoP62gV9pnvWVuyCMZj9Em
# wDX5ttW8MOk21xTG4MIwDQYJKoZIhvcNAQEBBQAEggEAktESniToROvnWDMmqzh2
# WScSRZ2hGB2qcc77NPWLH487KVOSOeDW1VkHrD89v3NpgV7twaYkwQEEYP81ehNF
# bUzUZ81hLGk/SozfdYx2FGlql6LdvfqYwzC1E/jLW06p/s8eM5e+94nQzIPZDPaI
# sMdwwe+L7VSUm8ag4S3SC0oOfmPxH50LzDQXmjavUa2cJZKqTt4Ab0OnAxVY60WO
# PouCVHCTu9lTpwSU3/qnx+5PyKaK8MuwTrTmitLMwzy8kvN0D7NQOVb/eju10IqG
# 8MPqQgrdjVbMfAbkt6lf+3mhGm+KWbtRrYtx4HrT06Fkr483+CWmGfOuaJB7Z+pr
# B6GCA0wwggNIBgkqhkiG9w0BCQYxggM5MIIDNQIBATCBkjB9MQswCQYDVQQGEwJH
# QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
# MRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNB
# IFRpbWUgU3RhbXBpbmcgQ0ECEQCMd6AAj/TRsMY9nzpIg41rMA0GCWCGSAFlAwQC
# AgUAoHkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MjIwNDAzMTkwNjE3WjA/BgkqhkiG9w0BCQQxMgQwKFn8fI1LWu4Ske6em7n2bOLE
# 69ux0RoWzXmb1UkIa9a3DdYfW1z5F9uLUiJBw//nMA0GCSqGSIb3DQEBAQUABIIC
# AEJD61fnGJSXraKvoENS6DkefYo7RHfbKXqMGAfUmdodsUs10S5rtKUkVSqDEu4+
# IX9keYXiYVEW9FDyfq2rbUNFSRIHu4jfSl59WU7UYIlYJe8Skwot03knh8VV0rjN
# CGUo9SP+k3yArUaDn7sfEds4P/1R+ALcjj8y8WmehGeZg4ry46OCj0uEDksS6fAA
# lmECR9L4Qp7c8EBq4CYHm8eoUmhIorffGAXvG69ERs6sCvySKVsUzLLC/o5DqmdJ
# nD2OWrMgXlyk7dbgDsDT8iPvqGZI+D9/LXureNeoHzbJrTc/J0BFZohDgZuJ/XdQ
# DNtd++ktWzD8OfMW0EUJi1i9ai8q9kbzmeqTrT5F+vIUezranUsr3AmDjv4TqOaj
# W/Xhu2QLG+3lG23Gd/NstGtvlbCvHzKKJOeqsOCrxOonJBhCiPL43+TC3TuArvJM
# GCMxUytmJP5v/Dc58W87R5LnylZY8HA4C5j6ZVIXpCiQkAYC1KehHqoLQlBxfasL
# oLdVOTAG2xnC+7eAlVFVUuV2BQiKMP47yEx3fC5PvXbm73Xb1dCQ8BmcLE+sk+Fw
# oSi27K6AVaj6L846OoKaygxCWUmeAE6W/rMtc9sk7mPTvsOll5JMNSIn7V381sop
# JoG9Hl/rSc8g5cqmTz82GmGxbHE3eBs1n9hYchirNSzN
# SIG # End signature block
