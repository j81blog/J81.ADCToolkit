function Invoke-ADCAddLsnappsattributes {
<#
    .SYNOPSIS
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER transportprotocol 
        Name of the protocol(TCP,UDP) for which the parameters of this LSN application port ATTRIBUTES applies.  
        Possible values = TCP, UDP, ICMP 
    .PARAMETER port 
        This is used for Displaying Port/Port range in CLI/Nitro.Lowport, Highport values are populated and used for displaying.Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90.  
        Minimum length = 1 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints.  
        Default value: 30  
        Minimum value = 5  
        Maximum value = 600 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        Invoke-ADCAddLsnappsattributes -name <string> -transportprotocol <string>
    .NOTES
        File Name : Invoke-ADCAddLsnappsattributes
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$transportprotocol ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidateRange(40, 90)]
        [string]$port ,

        [ValidateRange(5, 600)]
        [double]$sessiontimeout = '30' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsattributes: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                transportprotocol = $transportprotocol
            }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsattributes", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsattributes -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER name 
       Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnappsattributes -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsattributes
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        Write-Verbose "Invoke-ADCDeleteLsnappsattributes: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER name 
        Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints.  
        Default value: 30  
        Minimum value = 5  
        Maximum value = 600 
    .PARAMETER PassThru 
        Return details about the created lsnappsattributes item.
    .EXAMPLE
        Invoke-ADCUpdateLsnappsattributes -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnappsattributes
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [ValidateRange(5, 600)]
        [double]$sessiontimeout ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnappsattributes: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsattributes", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsattributes -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsattributes -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER name 
       Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
   .PARAMETER sessiontimeout 
       Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints.
    .EXAMPLE
        Invoke-ADCUnsetLsnappsattributes -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnappsattributes
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [Boolean]$sessiontimeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnappsattributes: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnappsattributes -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER name 
       Name for the LSN Application Port ATTRIBUTES. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnappsattributes object(s)
    .PARAMETER Count
        If specified, the count of the lsnappsattributes object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnappsattributes
    .EXAMPLE 
        Invoke-ADCGetLsnappsattributes -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnappsattributes -Count
    .EXAMPLE
        Invoke-ADCGetLsnappsattributes -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnappsattributes -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnappsattributes
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsattributes/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnappsattributes: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnappsattributes objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsattributes objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsattributes objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsattributes configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsattributes configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsattributes -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER transportprotocol 
        Name of the protocol for which the parameters of this LSN application profile applies.  
        Possible values = TCP, UDP, ICMP 
    .PARAMETER ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber.  
        Available options function as follows:  
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber.  
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber.  
        This parameter is applicable to dynamic NAT allocation only.  
        Default value: RANDOM  
        Possible values = PAIRED, RANDOM 
    .PARAMETER mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port.  
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
        Available options function as follows:  
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port.  
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port.  
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active.  
        Default value: ADDRESS-PORT-DEPENDENT  
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER filtering 
        Type of filter to apply to packets originating from external hosts.  
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
        Available options function as follows:  
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber.  
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address.  
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port.  
        Default value: ADDRESS-PORT-DEPENDENT  
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN.  
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0.  
        Default value: 4095 
    .PARAMETER l2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        Invoke-ADCAddLsnappsprofile -appsprofilename <string> -transportprotocol <string>
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$transportprotocol ,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$ippooling = 'RANDOM' ,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$mapping = 'ADDRESS-PORT-DEPENDENT' ,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$filtering = 'ADDRESS-PORT-DEPENDENT' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tcpproxy = 'DISABLED' ,

        [double]$td = '4095' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$l2info = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                appsprofilename = $appsprofilename
                transportprotocol = $transportprotocol
            }
            if ($PSBoundParameters.ContainsKey('ippooling')) { $Payload.Add('ippooling', $ippooling) }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('filtering')) { $Payload.Add('filtering', $filtering) }
            if ($PSBoundParameters.ContainsKey('tcpproxy')) { $Payload.Add('tcpproxy', $tcpproxy) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('l2info')) { $Payload.Add('l2info', $l2info) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsprofile -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnappsprofile -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [string]$appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER ippooling 
        NAT IP address allocation options for sessions associated with the same subscriber.  
        Available options function as follows:  
        * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber.  
        * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber.  
        This parameter is applicable to dynamic NAT allocation only.  
        Default value: RANDOM  
        Possible values = PAIRED, RANDOM 
    .PARAMETER mapping 
        Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port.  
        Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
        Available options function as follows:  
        * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port.  
        * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port.  
        * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active.  
        Default value: ADDRESS-PORT-DEPENDENT  
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER filtering 
        Type of filter to apply to packets originating from external hosts.  
        Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
        Available options function as follows:  
        * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber.  
        * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address.  
        * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port.  
        Default value: ADDRESS-PORT-DEPENDENT  
        Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
    .PARAMETER tcpproxy 
        Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER td 
        ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN.  
        If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0.  
        Default value: 4095 
    .PARAMETER l2info 
        Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsnappsprofile -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnappsprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename ,

        [ValidateSet('PAIRED', 'RANDOM')]
        [string]$ippooling ,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$mapping ,

        [ValidateSet('ENDPOINT-INDEPENDENT', 'ADDRESS-DEPENDENT', 'ADDRESS-PORT-DEPENDENT')]
        [string]$filtering ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$tcpproxy ,

        [double]$td ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$l2info ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnappsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                appsprofilename = $appsprofilename
            }
            if ($PSBoundParameters.ContainsKey('ippooling')) { $Payload.Add('ippooling', $ippooling) }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('filtering')) { $Payload.Add('filtering', $filtering) }
            if ($PSBoundParameters.ContainsKey('tcpproxy')) { $Payload.Add('tcpproxy', $tcpproxy) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('l2info')) { $Payload.Add('l2info', $l2info) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
   .PARAMETER ippooling 
       NAT IP address allocation options for sessions associated with the same subscriber.  
       Available options function as follows:  
       * Paired - The Citrix ADC allocates the same NAT IP address for all sessions associated with the same subscriber. When all the ports of a NAT IP address are used in LSN sessions (for same or multiple subscribers), the Citrix ADC ADC drops any new connection from the subscriber.  
       * Random - The Citrix ADC allocates random NAT IP addresses, from the pool, for different sessions associated with the same subscriber.  
       This parameter is applicable to dynamic NAT allocation only.  
       Possible values = PAIRED, RANDOM 
   .PARAMETER mapping 
       Type of LSN mapping to apply to subsequent packets originating from the same subscriber IP address and port.  
       Consider an example of an LSN mapping that includes the mapping of the subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
       Available options function as follows:  
       * ENDPOINT-INDEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to any external IP address and port.  
       * ADDRESS-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same subscriber IP address and port (X:x) to the same external IP address (Y), regardless of the external port.  
       * ADDRESS-PORT-DEPENDENT - Reuse the LSN mapping for subsequent packets sent from the same internal IP address and port (X:x) to the same external IP address and port (Y:y) while the mapping is still active.  
       Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
   .PARAMETER filtering 
       Type of filter to apply to packets originating from external hosts.  
       Consider an example of an LSN mapping that includes the mapping of subscriber IP:port (X:x), NAT IP:port (N:n), and external host IP:port (Y:y).  
       Available options function as follows:  
       * ENDPOINT INDEPENDENT - Filters out only packets not destined to the subscriber IP address and port X:x, regardless of the external host IP address and port source (Z:z). The Citrix ADC forwards any packets destined to X:x. In other words, sending packets from the subscriber to any external IP address is sufficient to allow packets from any external hosts to the subscriber.  
       * ADDRESS DEPENDENT - Filters out packets not destined to subscriber IP address and port X:x. In addition, the ADC filters out packets from Y:y destined for the subscriber (X:x) if the client has not previously sent packets to Y:anyport (external port independent). In other words, receiving packets from a specific external host requires that the subscriber first send packets to that specific external host's IP address.  
       * ADDRESS PORT DEPENDENT (the default) - Filters out packets not destined to subscriber IP address and port (X:x). In addition, the Citrix ADC filters out packets from Y:y destined for the subscriber (X:x) if the subscriber has not previously sent packets to Y:y. In other words, receiving packets from a specific external host requires that the subscriber first send packets first to that external IP address and port.  
       Possible values = ENDPOINT-INDEPENDENT, ADDRESS-DEPENDENT, ADDRESS-PORT-DEPENDENT 
   .PARAMETER tcpproxy 
       Enable TCP proxy, which enables the Citrix ADC to optimize the TCP traffic by using Layer 4 features.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER td 
       ID of the traffic domain through which the Citrix ADC sends the outbound traffic after performing LSN.  
       If you do not specify an ID, the ADC sends the outbound traffic through the default traffic domain, which has an ID of 0. 
   .PARAMETER l2info 
       Enable l2info by creating natpcbs for LSN, which enables the Citrix ADC to use L2CONN/MBF with LSN.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsnappsprofile -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnappsprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename ,

        [Boolean]$ippooling ,

        [Boolean]$mapping ,

        [Boolean]$filtering ,

        [Boolean]$tcpproxy ,

        [Boolean]$td ,

        [Boolean]$l2info 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnappsprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                appsprofilename = $appsprofilename
            }
            if ($PSBoundParameters.ContainsKey('ippooling')) { $Payload.Add('ippooling', $ippooling) }
            if ($PSBoundParameters.ContainsKey('mapping')) { $Payload.Add('mapping', $mapping) }
            if ($PSBoundParameters.ContainsKey('filtering')) { $Payload.Add('filtering', $filtering) }
            if ($PSBoundParameters.ContainsKey('tcpproxy')) { $Payload.Add('tcpproxy', $tcpproxy) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('l2info')) { $Payload.Add('l2info', $l2info) }
            if ($PSCmdlet.ShouldProcess("$appsprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnappsprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnappsprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsnappsprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnappsprofile
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsnappsprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnappsprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnappsprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnappsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnappsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofilebinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnappsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER appsattributesname 
        Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES. 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_lsnappsattributes_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnappsprofilelsnappsattributesbinding -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofilelsnappsattributesbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename ,

        [string]$appsattributesname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofilelsnappsattributesbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                appsprofilename = $appsprofilename
            }
            if ($PSBoundParameters.ContainsKey('appsattributesname')) { $Payload.Add('appsattributesname', $appsattributesname) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsprofile_lsnappsattributes_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_lsnappsattributes_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.    .PARAMETER appsattributesname 
       Name of the LSN application port ATTRIBUTES command to bind to the specified LSN Appsprofile. Properties of the Appsprofile will be applicable to this APPSATTRIBUTES.
    .EXAMPLE
        Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [string]$appsprofilename ,

        [string]$appsattributesname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofilelsnappsattributesbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('appsattributesname')) { $Arguments.Add('appsattributesname', $appsattributesname) }
            if ($PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnappsprofile_lsnappsattributes_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_lsnappsattributes_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilelsnappsattributesbinding
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnappsprofilelsnappsattributesbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofilelsnappsattributesbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_lsnappsattributes_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_lsnappsattributes_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_lsnappsattributes_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_lsnappsattributes_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER appsprofilename 
        Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER lsnport 
        Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lsnappsprofile_port_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnappsprofileportbinding -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddLsnappsprofileportbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidateRange(40, 90)]
        [string]$lsnport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnappsprofileportbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                appsprofilename = $appsprofilename
            }
            if ($PSBoundParameters.ContainsKey('lsnport')) { $Payload.Add('lsnport', $lsnport) }
 
            if ($PSCmdlet.ShouldProcess("lsnappsprofile_port_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnappsprofile_port_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnappsprofileportbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created.    .PARAMETER lsnport 
       Port numbers or range of port numbers to match against the destination port of the incoming packet from a subscriber. When the destination port is matched, the LSN application profile is applied for the LSN session. Separate a range of ports with a hyphen. For example, 40-90.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLsnappsprofileportbinding -appsprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnappsprofileportbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [string]$appsprofilename ,

        [string]$lsnport 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnappsprofileportbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('lsnport')) { $Arguments.Add('lsnport', $lsnport) }
            if ($PSCmdlet.ShouldProcess("$appsprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER appsprofilename 
       Name for the LSN application profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN application profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnappsprofile_port_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnappsprofile_port_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnappsprofileportbinding
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofileportbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnappsprofileportbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnappsprofileportbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnappsprofileportbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnappsprofileportbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnappsprofile_port_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$appsprofilename,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnappsprofile_port_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnappsprofile_port_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration for property 'appsprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Resource $appsprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnappsprofile_port_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnappsprofile_port_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER PassThru 
        Return details about the created lsnclient item.
    .EXAMPLE
        Invoke-ADCAddLsnclient -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnclient
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclient: Starting"
    }
    process {
        try {
            $Payload = @{
                clientname = $clientname
            }

 
            if ($PSCmdlet.ShouldProcess("lsnclient", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnclient -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnclient -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnclient -clientname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnclient
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [string]$clientname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclient: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclient
    .EXAMPLE 
        Invoke-ADCGetLsnclient -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnclient -Count
    .EXAMPLE
        Invoke-ADCGetLsnclient -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclient -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclient
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,

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
        Write-Verbose "Invoke-ADCGetLsnclient: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnclient objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclientbinding
    .EXAMPLE 
        Invoke-ADCGetLsnclientbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnclientbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclientbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclientbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnclientbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnclient_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
        Minimum length = 1 
    .PARAMETER netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER network6 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
        Minimum length = 1 
    .PARAMETER td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network6_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnclientnetwork6binding -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnclientnetwork6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$network ,

        [string]$netmask ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$network6 ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnetwork6binding: Starting"
    }
    process {
        try {
            $Payload = @{
                clientname = $clientname
            }
            if ($PSBoundParameters.ContainsKey('network')) { $Payload.Add('network', $network) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('network6')) { $Payload.Add('network6', $network6) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lsnclient_network6_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network6_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnclientnetwork6binding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.    .PARAMETER network 
       IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
       Minimum length = 1    .PARAMETER netmask 
       Subnet mask for the IPv4 address specified in the Network parameter.    .PARAMETER network6 
       IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
       Minimum length = 1    .PARAMETER td 
       ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLsnclientnetwork6binding -clientname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnetwork6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [string]$clientname ,

        [string]$network ,

        [string]$netmask ,

        [string]$network6 ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnetwork6binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('network')) { $Arguments.Add('network', $network) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('network6')) { $Arguments.Add('network6', $network6) }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient_network6_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient_network6_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclientnetwork6binding
    .EXAMPLE 
        Invoke-ADCGetLsnclientnetwork6binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnclientnetwork6binding -Count
    .EXAMPLE
        Invoke-ADCGetLsnclientnetwork6binding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclientnetwork6binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclientnetwork6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnclient_network6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER network 
        IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
        Minimum length = 1 
    .PARAMETER netmask 
        Subnet mask for the IPv4 address specified in the Network parameter. 
    .PARAMETER td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_network_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnclientnetworkbinding -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnclientnetworkbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$network ,

        [string]$netmask ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnetworkbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                clientname = $clientname
            }
            if ($PSBoundParameters.ContainsKey('network')) { $Payload.Add('network', $network) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lsnclient_network_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_network_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnclientnetworkbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.    .PARAMETER network 
       IPv4 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT.  
       Minimum length = 1    .PARAMETER netmask 
       Subnet mask for the IPv4 address specified in the Network parameter.    .PARAMETER td 
       ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLsnclientnetworkbinding -clientname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnetworkbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [string]$clientname ,

        [string]$network ,

        [string]$netmask ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnetworkbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('network')) { $Arguments.Add('network', $network) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient_network_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient_network_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclientnetworkbinding
    .EXAMPLE 
        Invoke-ADCGetLsnclientnetworkbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnclientnetworkbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnclientnetworkbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclientnetworkbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclientnetworkbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_network_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnclient_network_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_network_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_network_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_network_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_network_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_network_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER acl6name 
        Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client.  
        Minimum length = 1 
    .PARAMETER td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl6_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnclientnsacl6binding -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnclientnsacl6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$acl6name ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnsacl6binding: Starting"
    }
    process {
        try {
            $Payload = @{
                clientname = $clientname
            }
            if ($PSBoundParameters.ContainsKey('acl6name')) { $Payload.Add('acl6name', $acl6name) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lsnclient_nsacl6_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl6_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnclientnsacl6binding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.    .PARAMETER acl6name 
       Name of any configured extended ACL6 whose action is ALLOW. The condition specified in the extended ACL6 rule is used as the condition for the LSN client.  
       Minimum length = 1    .PARAMETER td 
       ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLsnclientnsacl6binding -clientname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnsacl6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [string]$clientname ,

        [string]$acl6name ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnsacl6binding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('acl6name')) { $Arguments.Add('acl6name', $acl6name) }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient_nsacl6_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl6_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclientnsacl6binding
    .EXAMPLE 
        Invoke-ADCGetLsnclientnsacl6binding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnclientnsacl6binding -Count
    .EXAMPLE
        Invoke-ADCGetLsnclientnsacl6binding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclientnsacl6binding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclientnsacl6binding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl6_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnclient_nsacl6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl6_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl6_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl6_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER clientname 
        Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER aclname 
        Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. .  
        Minimum length = 1 
    .PARAMETER td 
        ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnclient_nsacl_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnclientnsaclbinding -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnclientnsaclbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$aclname ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnclientnsaclbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                clientname = $clientname
            }
            if ($PSBoundParameters.ContainsKey('aclname')) { $Payload.Add('aclname', $aclname) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
 
            if ($PSCmdlet.ShouldProcess("lsnclient_nsacl_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnclient_nsacl_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnclientnsaclbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created.    .PARAMETER aclname 
       Name(s) of any configured extended ACL(s) whose action is ALLOW. The condition specified in the extended ACL rule identifies the traffic from an LSN subscriber for which the Citrix ADC is to perform large scale NAT. .  
       Minimum length = 1    .PARAMETER td 
       ID of the traffic domain on which this subscriber or the subscriber network (as specified by the network parameter) belongs. If you do not specify an ID, the subscriber or the subscriber network becomes part of the default traffic domain.  
       Default value: 0  
       Minimum value = 0  
       Maximum value = 4094
    .EXAMPLE
        Invoke-ADCDeleteLsnclientnsaclbinding -clientname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnclientnsaclbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [string]$clientname ,

        [string]$aclname ,

        [double]$td 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnclientnsaclbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('aclname')) { $Arguments.Add('aclname', $aclname) }
            if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) }
            if ($PSCmdlet.ShouldProcess("$clientname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       Name for the LSN client entity. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN client is created. 
    .PARAMETER GetAll 
        Retreive all lsnclient_nsacl_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnclient_nsacl_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnclientnsaclbinding
    .EXAMPLE 
        Invoke-ADCGetLsnclientnsaclbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnclientnsaclbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnclientnsaclbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnclientnsaclbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnclientnsaclbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnclient_nsacl_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$clientname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnclient_nsacl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnclient_nsacl_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration for property 'clientname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Resource $clientname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnclient_nsacl_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnclient_nsacl_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER clientname 
       The name of the LSN Client. 
    .PARAMETER network6 
       IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER subscrip 
       The Client IP address. 
    .PARAMETER td 
       The LSN client TD. 
    .PARAMETER natip 
       The NAT IP address. 
    .PARAMETER GetAll 
        Retreive all lsndeterministicnat object(s)
    .PARAMETER Count
        If specified, the count of the lsndeterministicnat object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsndeterministicnat
    .EXAMPLE 
        Invoke-ADCGetLsndeterministicnat -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsndeterministicnat -Count
    .EXAMPLE
        Invoke-ADCGetLsndeterministicnat -name <string>
    .EXAMPLE
        Invoke-ADCGetLsndeterministicnat -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsndeterministicnat
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsndeterministicnat/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$clientname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$network6 ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$subscrip ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4094)]
        [double]$td ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$natip,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsndeterministicnat objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsndeterministicnat objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsndeterministicnat objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('clientname')) { $Arguments.Add('clientname', $clientname) } 
                if ($PSBoundParameters.ContainsKey('network6')) { $Arguments.Add('network6', $network6) } 
                if ($PSBoundParameters.ContainsKey('subscrip')) { $Arguments.Add('subscrip', $subscrip) } 
                if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) } 
                if ($PSBoundParameters.ContainsKey('natip')) { $Arguments.Add('natip', $natip) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsndeterministicnat configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsndeterministicnat configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsndeterministicnat -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER clientname 
        Name of the LSN client entity to be associated with the LSN group. You can associate only one LSN client entity with an LSN group.You cannot remove this association or replace with another LSN client entity once the LSN group is created. 
    .PARAMETER nattype 
        Type of NAT IP address and port allocation (from the bound LSN pools) for subscribers:  
        Available options function as follows:  
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port. The maximum number of LSN subscribers allowed, globally, is 1 million.  
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber.  
        Default value: DYNAMIC  
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER allocpolicy 
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
        Default value: IPADDRS  
        Possible values = PORTS, IPADDRS 
    .PARAMETER portblocksize 
        Size of the NAT port block to be allocated for each subscriber.  
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it.  
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber.  
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT.  
        Default value: 0  
        Minimum value = 256  
        Maximum value = 65536 
    .PARAMETER logging 
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
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionlogging 
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
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary).  
        For this setting to work, you must enable the global session synchronization parameter.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute.  
        Default value: 100  
        Minimum value = 0  
        Maximum value = 10000 
    .PARAMETER ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN.  
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pptp 
        Enable the PPTP Application Layer Gateway.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sipalg 
        Enable the SIP ALG.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER rtspalg 
        Enable the RTSP ALG.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ip6profile 
        Name of the LSN ip6 profile to associate with the specified LSN group. An ip6 profile can be associated with a group only during group creation.  
        By default, no LSN ip6 profile is associated with an LSN group during its creation. Only one ip6profile can be associated with a group.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        Invoke-ADCAddLsngroup -groupname <string> -clientname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [Parameter(Mandatory = $true)]
        [string]$clientname ,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$nattype = 'DYNAMIC' ,

        [ValidateSet('PORTS', 'IPADDRS')]
        [string]$allocpolicy = 'IPADDRS' ,

        [ValidateRange(256, 65536)]
        [double]$portblocksize = '0' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionlogging = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionsync = 'ENABLED' ,

        [ValidateRange(0, 10000)]
        [double]$snmptraplimit = '100' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ftp = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pptp = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sipalg = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$rtspalg = 'DISABLED' ,

        [ValidateLength(1, 127)]
        [string]$ip6profile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ftpcm = 'DISABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
                clientname = $clientname
            }
            if ($PSBoundParameters.ContainsKey('nattype')) { $Payload.Add('nattype', $nattype) }
            if ($PSBoundParameters.ContainsKey('allocpolicy')) { $Payload.Add('allocpolicy', $allocpolicy) }
            if ($PSBoundParameters.ContainsKey('portblocksize')) { $Payload.Add('portblocksize', $portblocksize) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('sessionlogging')) { $Payload.Add('sessionlogging', $sessionlogging) }
            if ($PSBoundParameters.ContainsKey('sessionsync')) { $Payload.Add('sessionsync', $sessionsync) }
            if ($PSBoundParameters.ContainsKey('snmptraplimit')) { $Payload.Add('snmptraplimit', $snmptraplimit) }
            if ($PSBoundParameters.ContainsKey('ftp')) { $Payload.Add('ftp', $ftp) }
            if ($PSBoundParameters.ContainsKey('pptp')) { $Payload.Add('pptp', $pptp) }
            if ($PSBoundParameters.ContainsKey('sipalg')) { $Payload.Add('sipalg', $sipalg) }
            if ($PSBoundParameters.ContainsKey('rtspalg')) { $Payload.Add('rtspalg', $rtspalg) }
            if ($PSBoundParameters.ContainsKey('ip6profile')) { $Payload.Add('ip6profile', $ip6profile) }
            if ($PSBoundParameters.ContainsKey('ftpcm')) { $Payload.Add('ftpcm', $ftpcm) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsngroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngroup -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsngroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [string]$groupname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngroup: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER portblocksize 
        Size of the NAT port block to be allocated for each subscriber.  
        To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it.  
        In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber.  
        The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT.  
        Default value: 0  
        Minimum value = 256  
        Maximum value = 65536 
    .PARAMETER logging 
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
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionlogging 
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
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sessionsync 
        In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary).  
        For this setting to work, you must enable the global session synchronization parameter.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER snmptraplimit 
        Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute.  
        Default value: 100  
        Minimum value = 0  
        Maximum value = 10000 
    .PARAMETER ftp 
        Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN.  
        Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pptp 
        Enable the PPTP Application Layer Gateway.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sipalg 
        Enable the SIP ALG.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER rtspalg 
        Enable the RTSP ALG.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER ftpcm 
        Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsngroup item.
    .EXAMPLE
        Invoke-ADCUpdateLsngroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsngroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [ValidateRange(256, 65536)]
        [double]$portblocksize ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionlogging ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionsync ,

        [ValidateRange(0, 10000)]
        [double]$snmptraplimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ftp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$pptp ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sipalg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$rtspalg ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$ftpcm ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsngroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('portblocksize')) { $Payload.Add('portblocksize', $portblocksize) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('sessionlogging')) { $Payload.Add('sessionlogging', $sessionlogging) }
            if ($PSBoundParameters.ContainsKey('sessionsync')) { $Payload.Add('sessionsync', $sessionsync) }
            if ($PSBoundParameters.ContainsKey('snmptraplimit')) { $Payload.Add('snmptraplimit', $snmptraplimit) }
            if ($PSBoundParameters.ContainsKey('ftp')) { $Payload.Add('ftp', $ftp) }
            if ($PSBoundParameters.ContainsKey('pptp')) { $Payload.Add('pptp', $pptp) }
            if ($PSBoundParameters.ContainsKey('sipalg')) { $Payload.Add('sipalg', $sipalg) }
            if ($PSBoundParameters.ContainsKey('rtspalg')) { $Payload.Add('rtspalg', $rtspalg) }
            if ($PSBoundParameters.ContainsKey('ftpcm')) { $Payload.Add('ftpcm', $ftpcm) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngroup -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
   .PARAMETER portblocksize 
       Size of the NAT port block to be allocated for each subscriber.  
       To set this parameter for Dynamic NAT, you must enable the port block allocation parameter in the bound LSN pool. For Deterministic NAT, the port block allocation parameter is always enabled, and you cannot disable it.  
       In Dynamic NAT, the Citrix ADC allocates a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber.  
       The default port block size is 256 for Deterministic NAT, and 0 for Dynamic NAT. 
   .PARAMETER logging 
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
   .PARAMETER sessionlogging 
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
   .PARAMETER sessionsync 
       In a high availability (HA) deployment, synchronize information of all LSN sessions related to this LSN group with the secondary node. After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary).  
       For this setting to work, you must enable the global session synchronization parameter.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER snmptraplimit 
       Maximum number of SNMP Trap messages that can be generated for the LSN group in one minute. 
   .PARAMETER ftp 
       Enable Application Layer Gateway (ALG) for the FTP protocol. For some application-layer protocols, the IP addresses and protocol port numbers are usually communicated in the packet's payload. When acting as an ALG, the Citrix ADC changes the packet's payload to ensure that the protocol continues to work over LSN.  
       Note: The Citrix ADC also includes ALG for ICMP and TFTP protocols. ALG for the ICMP protocol is enabled by default, and there is no provision to disable it. ALG for the TFTP protocol is disabled by default. ALG is enabled automatically for an LSN group when you bind a UDP LSN application profile, with endpoint-independent-mapping, endpoint-independent filtering, and destination port as 69 (well-known port for TFTP), to the LSN group.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER pptp 
       Enable the PPTP Application Layer Gateway.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sipalg 
       Enable the SIP ALG.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER rtspalg 
       Enable the RTSP ALG.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER ftpcm 
       Enable the FTP connection mirroring for specified LSN group. Connection mirroring (CM or connection failover) refers to keeping active an established TCP or UDP connection when a failover occurs.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsngroup -groupname <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsngroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [Boolean]$portblocksize ,

        [Boolean]$logging ,

        [Boolean]$sessionlogging ,

        [Boolean]$sessionsync ,

        [Boolean]$snmptraplimit ,

        [Boolean]$ftp ,

        [Boolean]$pptp ,

        [Boolean]$sipalg ,

        [Boolean]$rtspalg ,

        [Boolean]$ftpcm 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsngroup: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('portblocksize')) { $Payload.Add('portblocksize', $portblocksize) }
            if ($PSBoundParameters.ContainsKey('logging')) { $Payload.Add('logging', $logging) }
            if ($PSBoundParameters.ContainsKey('sessionlogging')) { $Payload.Add('sessionlogging', $sessionlogging) }
            if ($PSBoundParameters.ContainsKey('sessionsync')) { $Payload.Add('sessionsync', $sessionsync) }
            if ($PSBoundParameters.ContainsKey('snmptraplimit')) { $Payload.Add('snmptraplimit', $snmptraplimit) }
            if ($PSBoundParameters.ContainsKey('ftp')) { $Payload.Add('ftp', $ftp) }
            if ($PSBoundParameters.ContainsKey('pptp')) { $Payload.Add('pptp', $pptp) }
            if ($PSBoundParameters.ContainsKey('sipalg')) { $Payload.Add('sipalg', $sipalg) }
            if ($PSBoundParameters.ContainsKey('rtspalg')) { $Payload.Add('rtspalg', $rtspalg) }
            if ($PSBoundParameters.ContainsKey('ftpcm')) { $Payload.Add('ftpcm', $ftpcm) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsngroup -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngroup
    .EXAMPLE 
        Invoke-ADCGetLsngroup -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngroup -Count
    .EXAMPLE
        Invoke-ADCGetLsngroup -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngroup -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngroup
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

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
        Write-Verbose "Invoke-ADCGetLsngroup: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngroupbinding
    .EXAMPLE 
        Invoke-ADCGetLsngroupbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsngroupbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngroupbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngroupbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsngroupbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER ipsecalgprofile 
        Name of the IPSec ALG profile to bind to the specified LSN group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_ipsecalgprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngroupipsecalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngroupipsecalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$ipsecalgprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngroupipsecalgprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('ipsecalgprofile')) { $Payload.Add('ipsecalgprofile', $ipsecalgprofile) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_ipsecalgprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_ipsecalgprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngroupipsecalgprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER ipsecalgprofile 
       Name of the IPSec ALG profile to bind to the specified LSN group.
    .EXAMPLE
        Invoke-ADCDeleteLsngroupipsecalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngroupipsecalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [string]$groupname ,

        [string]$ipsecalgprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngroupipsecalgprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ipsecalgprofile')) { $Arguments.Add('ipsecalgprofile', $ipsecalgprofile) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_ipsecalgprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_ipsecalgprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngroupipsecalgprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngroupipsecalgprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngroupipsecalgprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngroupipsecalgprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngroupipsecalgprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngroupipsecalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_ipsecalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_ipsecalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_ipsecalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_ipsecalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER appsprofilename 
        Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnappsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnappsprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnappsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$appsprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnappsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('appsprofilename')) { $Payload.Add('appsprofilename', $appsprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnappsprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnappsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnappsprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER appsprofilename 
       Name of the LSN application profile to bind to the specified LSN group. For each set of destination ports, bind a profile for each protocol for which you want to specify settings. By default, one LSN application profile with default settings for TCP, UDP, and ICMP protocols for all destination ports is bound to an LSN group during its creation. This profile is called a default application profile. When you bind an LSN application profile, with a specified set of destination ports, to an LSN group, the bound profile overrides the default LSN application profile for that protocol at that set of destination ports.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnappsprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnappsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [string]$groupname ,

        [string]$appsprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnappsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('appsprofilename')) { $Arguments.Add('appsprofilename', $appsprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnappsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnappsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnappsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnappsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnappsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnappsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnappsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnappsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnappsprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnappsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnappsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnappsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER httphdrlogprofilename 
        The name of the LSN HTTP header logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnhttphdrlogprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$httphdrlogprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnhttphdrlogprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('httphdrlogprofilename')) { $Payload.Add('httphdrlogprofilename', $httphdrlogprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnhttphdrlogprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnhttphdrlogprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER httphdrlogprofilename 
       The name of the LSN HTTP header logging Profile.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [string]$groupname ,

        [string]$httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnhttphdrlogprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('httphdrlogprofilename')) { $Arguments.Add('httphdrlogprofilename', $httphdrlogprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnhttphdrlogprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnhttphdrlogprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnhttphdrlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnhttphdrlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnhttphdrlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnhttphdrlogprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnhttphdrlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER logprofilename 
        The name of the LSN logging Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnlogprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnlogprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$logprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnlogprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('logprofilename')) { $Payload.Add('logprofilename', $logprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnlogprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnlogprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnlogprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER logprofilename 
       The name of the LSN logging Profile.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnlogprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [string]$groupname ,

        [string]$logprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnlogprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('logprofilename')) { $Arguments.Add('logprofilename', $logprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnlogprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnlogprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnlogprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnlogprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnlogprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnlogprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnlogprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnlogprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnlogprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnlogprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnlogprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnlogprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER poolname 
        Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnpool_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnpoolbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnpoolbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$poolname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnpoolbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('poolname')) { $Payload.Add('poolname', $poolname) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnpool_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnpool_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnpoolbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER poolname 
       Name of the LSN pool to bind to the specified LSN group. Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. For Deterministic NAT, pools bound to an LSN group cannot be bound to other LSN groups. For Dynamic NAT, pools bound to an LSN group can be bound to multiple LSN groups.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnpoolbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnpoolbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [string]$groupname ,

        [string]$poolname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnpoolbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('poolname')) { $Arguments.Add('poolname', $poolname) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnpool_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnpool_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnpoolbinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnpoolbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnpoolbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnpoolbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnpoolbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnpoolbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnpool_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER rtspalgprofilename 
        The name of the LSN RTSP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnrtspalgprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnrtspalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnrtspalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$rtspalgprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnrtspalgprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('rtspalgprofilename')) { $Payload.Add('rtspalgprofilename', $rtspalgprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnrtspalgprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnrtspalgprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER rtspalgprofilename 
       The name of the LSN RTSP ALG Profile.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [string]$groupname ,

        [string]$rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnrtspalgprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('rtspalgprofilename')) { $Arguments.Add('rtspalgprofilename', $rtspalgprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnrtspalgprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnrtspalgprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnrtspalgprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnrtspalgprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnrtspalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnrtspalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnrtspalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnrtspalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnrtspalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER sipalgprofilename 
        The name of the LSN SIP ALG Profile. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsnsipalgprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsnsipalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsnsipalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$sipalgprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsnsipalgprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('sipalgprofilename')) { $Payload.Add('sipalgprofilename', $sipalgprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsnsipalgprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsnsipalgprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER sipalgprofilename 
       The name of the LSN SIP ALG Profile.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [string]$groupname ,

        [string]$sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsnsipalgprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('sipalgprofilename')) { $Arguments.Add('sipalgprofilename', $sipalgprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsnsipalgprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsnsipalgprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnsipalgprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnsipalgprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnsipalgprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsnsipalgprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsnsipalgprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsnsipalgprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsnsipalgprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsnsipalgprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsnsipalgprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER transportprofilename 
        Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_lsntransportprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouplsntransportprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouplsntransportprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$transportprofilename ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouplsntransportprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('transportprofilename')) { $Payload.Add('transportprofilename', $transportprofilename) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_lsntransportprofile_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_lsntransportprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouplsntransportprofilebinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER transportprofilename 
       Name of the LSN transport profile to bind to the specified LSN group. Bind a profile for each protocol for which you want to specify settings. By default, one LSN transport profile with default settings for TCP, UDP, and ICMP protocols is bound to an LSN group during its creation. This profile is called a default transport. An LSN transport profile that you bind to an LSN group overrides the default LSN transport profile for that protocol.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouplsntransportprofilebinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouplsntransportprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [string]$groupname ,

        [string]$transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouplsntransportprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('transportprofilename')) { $Arguments.Add('transportprofilename', $transportprofilename) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_lsntransportprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_lsntransportprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouplsntransportprofilebinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsntransportprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouplsntransportprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouplsntransportprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouplsntransportprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouplsntransportprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_lsntransportprofile_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_lsntransportprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_lsntransportprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_lsntransportprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER groupname 
        Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER pcpserver 
        Name of the PCP server to be associated with lsn group. 
    .PARAMETER PassThru 
        Return details about the created lsngroup_pcpserver_binding item.
    .EXAMPLE
        Invoke-ADCAddLsngrouppcpserverbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCAddLsngrouppcpserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname ,

        [string]$pcpserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsngrouppcpserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                groupname = $groupname
            }
            if ($PSBoundParameters.ContainsKey('pcpserver')) { $Payload.Add('pcpserver', $pcpserver) }
 
            if ($PSCmdlet.ShouldProcess("lsngroup_pcpserver_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsngroup_pcpserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsngrouppcpserverbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created.    .PARAMETER pcpserver 
       Name of the PCP server to be associated with lsn group.
    .EXAMPLE
        Invoke-ADCDeleteLsngrouppcpserverbinding -groupname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsngrouppcpserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [string]$groupname ,

        [string]$pcpserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsngrouppcpserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('pcpserver')) { $Arguments.Add('pcpserver', $pcpserver) }
            if ($PSCmdlet.ShouldProcess("$groupname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER groupname 
       Name for the LSN group. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsngroup_pcpserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsngroup_pcpserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsngrouppcpserverbinding
    .EXAMPLE 
        Invoke-ADCGetLsngrouppcpserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsngrouppcpserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsngrouppcpserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsngrouppcpserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsngrouppcpserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsngroup_pcpserver_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$groupname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsngroup_pcpserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsngroup_pcpserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration for property 'groupname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Resource $groupname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsngroup_pcpserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsngroup_pcpserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER httphdrlogprofilename 
        The name of the HTTP header logging Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER logurl 
        URL information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logmethod 
        HTTP method information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logversion 
        Version information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER loghost 
        Host information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        Invoke-ADCAddLsnhttphdrlogprofile -httphdrlogprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddLsnhttphdrlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$httphdrlogprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logurl = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logmethod = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logversion = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$loghost = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                httphdrlogprofilename = $httphdrlogprofilename
            }
            if ($PSBoundParameters.ContainsKey('logurl')) { $Payload.Add('logurl', $logurl) }
            if ($PSBoundParameters.ContainsKey('logmethod')) { $Payload.Add('logmethod', $logmethod) }
            if ($PSBoundParameters.ContainsKey('logversion')) { $Payload.Add('logversion', $logversion) }
            if ($PSBoundParameters.ContainsKey('loghost')) { $Payload.Add('loghost', $loghost) }
 
            if ($PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnhttphdrlogprofile -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER httphdrlogprofilename 
       The name of the HTTP header logging Profile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteLsnhttphdrlogprofile -httphdrlogprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnhttphdrlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [string]$httphdrlogprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER httphdrlogprofilename 
        The name of the HTTP header logging Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER logurl 
        URL information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logmethod 
        HTTP method information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logversion 
        Version information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER loghost 
        Host information is logged if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnhttphdrlogprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsnhttphdrlogprofile -httphdrlogprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnhttphdrlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$httphdrlogprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logurl ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logmethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logversion ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$loghost ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                httphdrlogprofilename = $httphdrlogprofilename
            }
            if ($PSBoundParameters.ContainsKey('logurl')) { $Payload.Add('logurl', $logurl) }
            if ($PSBoundParameters.ContainsKey('logmethod')) { $Payload.Add('logmethod', $logmethod) }
            if ($PSBoundParameters.ContainsKey('logversion')) { $Payload.Add('logversion', $logversion) }
            if ($PSBoundParameters.ContainsKey('loghost')) { $Payload.Add('loghost', $loghost) }
 
            if ($PSCmdlet.ShouldProcess("lsnhttphdrlogprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnhttphdrlogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnhttphdrlogprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER httphdrlogprofilename 
       The name of the HTTP header logging Profile. 
   .PARAMETER logurl 
       URL information is logged if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER logmethod 
       HTTP method information is logged if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER logversion 
       Version information is logged if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER loghost 
       Host information is logged if option is enabled.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsnhttphdrlogprofile -httphdrlogprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnhttphdrlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile
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
        [ValidateLength(1, 127)]
        [string]$httphdrlogprofilename ,

        [Boolean]$logurl ,

        [Boolean]$logmethod ,

        [Boolean]$logversion ,

        [Boolean]$loghost 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnhttphdrlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                httphdrlogprofilename = $httphdrlogprofilename
            }
            if ($PSBoundParameters.ContainsKey('logurl')) { $Payload.Add('logurl', $logurl) }
            if ($PSBoundParameters.ContainsKey('logmethod')) { $Payload.Add('logmethod', $logmethod) }
            if ($PSBoundParameters.ContainsKey('logversion')) { $Payload.Add('logversion', $logversion) }
            if ($PSBoundParameters.ContainsKey('loghost')) { $Payload.Add('loghost', $loghost) }
            if ($PSCmdlet.ShouldProcess("$httphdrlogprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER httphdrlogprofilename 
       The name of the HTTP header logging Profile. 
    .PARAMETER GetAll 
        Retreive all lsnhttphdrlogprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsnhttphdrlogprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnhttphdrlogprofile
    .EXAMPLE 
        Invoke-ADCGetLsnhttphdrlogprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnhttphdrlogprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsnhttphdrlogprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnhttphdrlogprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnhttphdrlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnhttphdrlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$httphdrlogprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnhttphdrlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnhttphdrlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnhttphdrlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration for property 'httphdrlogprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Resource $httphdrlogprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnhttphdrlogprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnhttphdrlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER name 
        Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER type 
        IPv6 translation type for which to set the LSN IP6 profile parameters.  
        Possible values = DS-Lite, NAT64 
    .PARAMETER natprefix 
        IPv6 address(es) of the LSN subscriber(s) or subscriber network(s) on whose traffic you want the Citrix ADC to perform Large Scale NAT. 
    .PARAMETER network6 
        IPv6 address of the Citrix ADC AFTR device. 
    .PARAMETER PassThru 
        Return details about the created lsnip6profile item.
    .EXAMPLE
        Invoke-ADCAddLsnip6profile -name <string> -type <string>
    .NOTES
        File Name : Invoke-ADCAddLsnip6profile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('DS-Lite', 'NAT64')]
        [string]$type ,

        [string]$natprefix ,

        [string]$network6 ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnip6profile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
            }
            if ($PSBoundParameters.ContainsKey('natprefix')) { $Payload.Add('natprefix', $natprefix) }
            if ($PSBoundParameters.ContainsKey('network6')) { $Payload.Add('network6', $network6) }
 
            if ($PSCmdlet.ShouldProcess("lsnip6profile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnip6profile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnip6profile -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER name 
       Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnip6profile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnip6profile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        Write-Verbose "Invoke-ADCDeleteLsnip6profile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER name 
       Name for the LSN ip6 profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN ip6 profile is created. 
    .PARAMETER GetAll 
        Retreive all lsnip6profile object(s)
    .PARAMETER Count
        If specified, the count of the lsnip6profile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnip6profile
    .EXAMPLE 
        Invoke-ADCGetLsnip6profile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnip6profile -Count
    .EXAMPLE
        Invoke-ADCGetLsnip6profile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnip6profile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnip6profile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnip6profile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnip6profile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnip6profile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnip6profile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnip6profile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnip6profile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnip6profile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnip6profile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER logprofilename 
        The name of the logging Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER logsubscrinfo 
        Subscriber ID information is logged if option is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logcompact 
        Logs in Compact Logging format if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logipfix 
        Logs in IPFIX format if option is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER logsessdeletion 
        LSN Session deletion will not be logged if disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        Invoke-ADCAddLsnlogprofile -logprofilename <string>
    .NOTES
        File Name : Invoke-ADCAddLsnlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$logprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logsubscrinfo = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logcompact = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logipfix = 'DISABLED' ,

        [string]$analyticsprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logsessdeletion = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                logprofilename = $logprofilename
            }
            if ($PSBoundParameters.ContainsKey('logsubscrinfo')) { $Payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ($PSBoundParameters.ContainsKey('logcompact')) { $Payload.Add('logcompact', $logcompact) }
            if ($PSBoundParameters.ContainsKey('logipfix')) { $Payload.Add('logipfix', $logipfix) }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
            if ($PSBoundParameters.ContainsKey('logsessdeletion')) { $Payload.Add('logsessdeletion', $logsessdeletion) }
 
            if ($PSCmdlet.ShouldProcess("lsnlogprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnlogprofile -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER logprofilename 
       The name of the logging Profile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteLsnlogprofile -logprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [string]$logprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnlogprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$logprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER logprofilename 
        The name of the logging Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER logsubscrinfo 
        Subscriber ID information is logged if option is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logcompact 
        Logs in Compact Logging format if option is enabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER logipfix 
        Logs in IPFIX format if option is enabled.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER analyticsprofile 
        Name of the Analytics Profile attached to this lsn profile. 
    .PARAMETER logsessdeletion 
        LSN Session deletion will not be logged if disabled.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnlogprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsnlogprofile -logprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$logprofilename ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logsubscrinfo ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logcompact ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logipfix ,

        [string]$analyticsprofile ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$logsessdeletion ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                logprofilename = $logprofilename
            }
            if ($PSBoundParameters.ContainsKey('logsubscrinfo')) { $Payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ($PSBoundParameters.ContainsKey('logcompact')) { $Payload.Add('logcompact', $logcompact) }
            if ($PSBoundParameters.ContainsKey('logipfix')) { $Payload.Add('logipfix', $logipfix) }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
            if ($PSBoundParameters.ContainsKey('logsessdeletion')) { $Payload.Add('logsessdeletion', $logsessdeletion) }
 
            if ($PSCmdlet.ShouldProcess("lsnlogprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnlogprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnlogprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER logprofilename 
       The name of the logging Profile. 
   .PARAMETER logsubscrinfo 
       Subscriber ID information is logged if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER logcompact 
       Logs in Compact Logging format if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER logipfix 
       Logs in IPFIX format if option is enabled.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER analyticsprofile 
       Name of the Analytics Profile attached to this lsn profile. 
   .PARAMETER logsessdeletion 
       LSN Session deletion will not be logged if disabled.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsnlogprofile -logprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile
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
        [ValidateLength(1, 127)]
        [string]$logprofilename ,

        [Boolean]$logsubscrinfo ,

        [Boolean]$logcompact ,

        [Boolean]$logipfix ,

        [Boolean]$analyticsprofile ,

        [Boolean]$logsessdeletion 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnlogprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                logprofilename = $logprofilename
            }
            if ($PSBoundParameters.ContainsKey('logsubscrinfo')) { $Payload.Add('logsubscrinfo', $logsubscrinfo) }
            if ($PSBoundParameters.ContainsKey('logcompact')) { $Payload.Add('logcompact', $logcompact) }
            if ($PSBoundParameters.ContainsKey('logipfix')) { $Payload.Add('logipfix', $logipfix) }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
            if ($PSBoundParameters.ContainsKey('logsessdeletion')) { $Payload.Add('logsessdeletion', $logsessdeletion) }
            if ($PSCmdlet.ShouldProcess("$logprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnlogprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER logprofilename 
       The name of the logging Profile. 
    .PARAMETER GetAll 
        Retreive all lsnlogprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsnlogprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnlogprofile
    .EXAMPLE 
        Invoke-ADCGetLsnlogprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnlogprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsnlogprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnlogprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnlogprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnlogprofile/
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
        [ValidateLength(1, 127)]
        [string]$logprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnlogprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnlogprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnlogprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnlogprofile configuration for property 'logprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Resource $logprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnlogprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnlogprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER memlimit 
        Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB.  
        Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.  
        This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
    .PARAMETER sessionsync 
        Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary).  
        The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default.  
        For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER subscrsessionremoval 
        LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateLsnparameter 
    .NOTES
        File Name : Invoke-ADCUpdateLsnparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter/
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

        [double]$memlimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sessionsync ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$subscrsessionremoval 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('sessionsync')) { $Payload.Add('sessionsync', $sessionsync) }
            if ($PSBoundParameters.ContainsKey('subscrsessionremoval')) { $Payload.Add('subscrsessionremoval', $subscrsessionremoval) }
 
            if ($PSCmdlet.ShouldProcess("lsnparameter", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnparameter -Payload $Payload -GetWarning
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER memlimit 
       Amount of Citrix ADC memory to reserve for the LSN feature, in multiples of 2MB.  
       Note: If you later reduce the value of this parameter, the amount of active memory is not reduced. Changing the configured memory limit can only increase the amount of active memory.  
       This command is deprecated, use 'set extendedmemoryparam -memlimit' instead. 
   .PARAMETER sessionsync 
       Synchronize all LSN sessions with the secondary node in a high availability (HA) deployment (global synchronization). After a failover, established TCP connections and UDP packet flows are kept active and resumed on the secondary node (new primary).  
       The global session synchronization parameter and session synchronization parameters (group level) of all LSN groups are enabled by default.  
       For a group, when both the global level and the group level LSN session synchronization parameters are enabled, the primary node synchronizes information of all LSN sessions related to this LSN group with the secondary node.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER subscrsessionremoval 
       LSN global setting for controlling subscriber aware session removal, when this is enabled, when ever the subscriber info is deleted from subscriber database, sessions corresponding to that subscriber will be removed. if this setting is disabled, subscriber sessions will be timed out as per the idle time out settings.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsnparameter 
    .NOTES
        File Name : Invoke-ADCUnsetLsnparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter
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

        [Boolean]$memlimit ,

        [Boolean]$sessionsync ,

        [Boolean]$subscrsessionremoval 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('memlimit')) { $Payload.Add('memlimit', $memlimit) }
            if ($PSBoundParameters.ContainsKey('sessionsync')) { $Payload.Add('sessionsync', $sessionsync) }
            if ($PSBoundParameters.ContainsKey('subscrsessionremoval')) { $Payload.Add('subscrsessionremoval', $subscrsessionremoval) }
            if ($PSCmdlet.ShouldProcess("lsnparameter", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER GetAll 
        Retreive all lsnparameter object(s)
    .PARAMETER Count
        If specified, the count of the lsnparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnparameter
    .EXAMPLE 
        Invoke-ADCGetLsnparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnparameter/
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
        Write-Verbose "Invoke-ADCGetLsnparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER nattype 
        Type of NAT IP address and port allocation (from the LSN pools bound to an LSN group) for subscribers (of the LSN client entity bound to the LSN group):  
        Available options function as follows:  
        * Deterministic - Allocate a NAT IP address and a block of ports to each subscriber (of the LSN client bound to the LSN group). The Citrix ADC sequentially allocates NAT resources to these subscribers. The Citrix ADC ADC assigns the first block of ports (block size determined by the port block size parameter of the LSN group) on the beginning NAT IP address to the beginning subscriber IP address. The next range of ports is assigned to the next subscriber, and so on, until the NAT address does not have enough ports for the next subscriber. In this case, the first port block on the next NAT address is used for the subscriber, and so on. Because each subscriber now receives a deterministic NAT IP address and a block of ports, a subscriber can be identified without any need for logging. For a connection, a subscriber can be identified based only on the NAT IP address and port, and the destination IP address and port.  
        * Dynamic - Allocate a random NAT IP address and a port from the LSN NAT pool for a subscriber's connection. If port block allocation is enabled (in LSN pool) and a port block size is specified (in the LSN group), the Citrix ADC allocates a random NAT IP address and a block of ports for a subscriber when it initiates a connection for the first time. The ADC allocates this NAT IP address and a port (from the allocated block of ports) for different connections from this subscriber. If all the ports are allocated (for different subscriber's connections) from the subscriber's allocated port block, the ADC allocates a new random port block for the subscriber.  
        Only LSN Pools and LSN groups with the same NAT type settings can be bound together. Multiples LSN pools can be bound to an LSN group. A maximum of 16 LSN pools can be bound to an LSN group. .  
        Default value: DYNAMIC  
        Possible values = DYNAMIC, DETERMINISTIC 
    .PARAMETER portblockallocation 
        Allocate a random NAT port block, from the available NAT port pool of an NAT IP address, for each subscriber when the NAT allocation is set as Dynamic NAT. For any connection initiated from a subscriber, the Citrix ADC allocates a NAT port from the subscriber's allocated NAT port block to create the LSN session.  
        You must set the port block size in the bound LSN group. For a subscriber, if all the ports are allocated from the subscriber's allocated port block, the Citrix ADC allocates a new random port block for the subscriber.  
        For Deterministic NAT, this parameter is enabled by default, and you cannot disable it.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in:  
        * Deterministic NAT  
        * Address-Dependent filtering and Address-Port-Dependent filtering  
        * Dynamic NAT with port block allocation  
        In these cases, ports are immediately reallocated.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 600 
    .PARAMETER maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address.  
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session.  
        Default value: 65536  
        Minimum value = 0  
        Maximum value = 65536 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        Invoke-ADCAddLsnpool -poolname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnpool
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname ,

        [ValidateSet('DYNAMIC', 'DETERMINISTIC')]
        [string]$nattype = 'DYNAMIC' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$portblockallocation = 'DISABLED' ,

        [ValidateRange(0, 600)]
        [double]$portrealloctimeout = '0' ,

        [ValidateRange(0, 65536)]
        [double]$maxportrealloctmq = '65536' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnpool: Starting"
    }
    process {
        try {
            $Payload = @{
                poolname = $poolname
            }
            if ($PSBoundParameters.ContainsKey('nattype')) { $Payload.Add('nattype', $nattype) }
            if ($PSBoundParameters.ContainsKey('portblockallocation')) { $Payload.Add('portblockallocation', $portblockallocation) }
            if ($PSBoundParameters.ContainsKey('portrealloctimeout')) { $Payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ($PSBoundParameters.ContainsKey('maxportrealloctmq')) { $Payload.Add('maxportrealloctmq', $maxportrealloctmq) }
 
            if ($PSCmdlet.ShouldProcess("lsnpool", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnpool -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnpool -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnpool -poolname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnpool
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [string]$poolname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnpool: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$poolname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER portrealloctimeout 
        The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in:  
        * Deterministic NAT  
        * Address-Dependent filtering and Address-Port-Dependent filtering  
        * Dynamic NAT with port block allocation  
        In these cases, ports are immediately reallocated.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 600 
    .PARAMETER maxportrealloctmq 
        Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address.  
        When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session.  
        Default value: 65536  
        Minimum value = 0  
        Maximum value = 65536 
    .PARAMETER PassThru 
        Return details about the created lsnpool item.
    .EXAMPLE
        Invoke-ADCUpdateLsnpool -poolname <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnpool
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname ,

        [ValidateRange(0, 600)]
        [double]$portrealloctimeout ,

        [ValidateRange(0, 65536)]
        [double]$maxportrealloctmq ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnpool: Starting"
    }
    process {
        try {
            $Payload = @{
                poolname = $poolname
            }
            if ($PSBoundParameters.ContainsKey('portrealloctimeout')) { $Payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ($PSBoundParameters.ContainsKey('maxportrealloctmq')) { $Payload.Add('maxportrealloctmq', $maxportrealloctmq) }
 
            if ($PSCmdlet.ShouldProcess("lsnpool", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnpool -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
   .PARAMETER portrealloctimeout 
       The waiting time, in seconds, between deallocating LSN NAT ports (when an LSN mapping is removed) and reallocating them for a new LSN session. This parameter is necessary in order to prevent collisions between old and new mappings and sessions. It ensures that all established sessions are broken instead of redirected to a different subscriber. This is not applicable for ports used in:  
       * Deterministic NAT  
       * Address-Dependent filtering and Address-Port-Dependent filtering  
       * Dynamic NAT with port block allocation  
       In these cases, ports are immediately reallocated. 
   .PARAMETER maxportrealloctmq 
       Maximum number of ports for which the port reallocation timeout applies for each NAT IP address. In other words, the maximum deallocated-port queue size for which the reallocation timeout applies for each NAT IP address.  
       When the queue size is full, the next port deallocated is reallocated immediately for a new LSN session.
    .EXAMPLE
        Invoke-ADCUnsetLsnpool -poolname <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnpool
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname ,

        [Boolean]$portrealloctimeout ,

        [Boolean]$maxportrealloctmq 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnpool: Starting"
    }
    process {
        try {
            $Payload = @{
                poolname = $poolname
            }
            if ($PSBoundParameters.ContainsKey('portrealloctimeout')) { $Payload.Add('portrealloctimeout', $portrealloctimeout) }
            if ($PSBoundParameters.ContainsKey('maxportrealloctmq')) { $Payload.Add('maxportrealloctmq', $maxportrealloctmq) }
            if ($PSCmdlet.ShouldProcess("$poolname", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnpool -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retreive all lsnpool object(s)
    .PARAMETER Count
        If specified, the count of the lsnpool object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnpool
    .EXAMPLE 
        Invoke-ADCGetLsnpool -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnpool -Count
    .EXAMPLE
        Invoke-ADCGetLsnpool -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnpool -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnpool
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname,

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
        Write-Verbose "Invoke-ADCGetLsnpool: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retreive all lsnpool_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnpool_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnpoolbinding
    .EXAMPLE 
        Invoke-ADCGetLsnpoolbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnpoolbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnpoolbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnpoolbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnpoolbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_binding configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER poolname 
        Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER ownernode 
        ID(s) of cluster node(s) on which command is to be executed.  
        Minimum value = 0  
        Maximum value = 31 
    .PARAMETER lsnip 
        IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default , arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" .  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created lsnpool_lsnip_binding item.
    .EXAMPLE
        Invoke-ADCAddLsnpoollsnipbinding -poolname <string>
    .NOTES
        File Name : Invoke-ADCAddLsnpoollsnipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname ,

        [ValidateRange(0, 31)]
        [double]$ownernode ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidateRange(30, 10)]
        [string]$lsnip ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnpoollsnipbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                poolname = $poolname
            }
            if ($PSBoundParameters.ContainsKey('ownernode')) { $Payload.Add('ownernode', $ownernode) }
            if ($PSBoundParameters.ContainsKey('lsnip')) { $Payload.Add('lsnip', $lsnip) }
 
            if ($PSCmdlet.ShouldProcess("lsnpool_lsnip_binding", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnpool_lsnip_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnpoollsnipbinding -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created.    .PARAMETER ownernode 
       ID(s) of cluster node(s) on which command is to be executed.  
       Minimum value = 0  
       Maximum value = 31    .PARAMETER lsnip 
       IPv4 address or a range of IPv4 addresses to be used as NAT IP address(es) for LSN. After the pool is created, these IPv4 addresses are added to the Citrix ADC as Citrix ADC owned IP address of type LSN. A maximum of 4096 IP addresses can be bound to an LSN pool. An LSN IP address associated with an LSN pool cannot be shared with other LSN pools. IP addresses specified for this parameter must not already exist on the Citrix ADC as any Citrix ADC owned IP addresses. In the command line interface, separate the range with a hyphen. For example: 10.102.29.30-10.102.29.189. You can later remove some or all the LSN IP addresses from the pool, and add IP addresses to the LSN pool. By default , arp is enabled on LSN IP address but, you can disable it using command - "set ns ip" .  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteLsnpoollsnipbinding -poolname <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnpoollsnipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [string]$poolname ,

        [double]$ownernode ,

        [string]$lsnip 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnpoollsnipbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('ownernode')) { $Arguments.Add('ownernode', $ownernode) }
            if ($PSBoundParameters.ContainsKey('lsnip')) { $Arguments.Add('lsnip', $lsnip) }
            if ($PSCmdlet.ShouldProcess("$poolname", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER poolname 
       Name for the LSN pool. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN pool is created. 
    .PARAMETER GetAll 
        Retreive all lsnpool_lsnip_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnpool_lsnip_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnpoollsnipbinding
    .EXAMPLE 
        Invoke-ADCGetLsnpoollsnipbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnpoollsnipbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnpoollsnipbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnpoollsnipbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnpoollsnipbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnpool_lsnip_binding/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$poolname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnpool_lsnip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnpool_lsnip_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration for property 'poolname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Resource $poolname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnpool_lsnip_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnpool_lsnip_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER rtspalgprofilename 
        The name of the RTSPALG Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds.  
        Default value: 120 
    .PARAMETER rtspportrange 
        port for the RTSP. 
    .PARAMETER rtsptransportprotocol 
        RTSP ALG Profile transport protocol type.  
        Default value: TCP  
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        Invoke-ADCAddLsnrtspalgprofile -rtspalgprofilename <string> -rtspportrange <string>
    .NOTES
        File Name : Invoke-ADCAddLsnrtspalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$rtspalgprofilename ,

        [double]$rtspidletimeout = '120' ,

        [Parameter(Mandatory = $true)]
        [string]$rtspportrange ,

        [ValidateSet('TCP', 'UDP')]
        [string]$rtsptransportprotocol = 'TCP' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                rtspalgprofilename = $rtspalgprofilename
                rtspportrange = $rtspportrange
            }
            if ($PSBoundParameters.ContainsKey('rtspidletimeout')) { $Payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ($PSBoundParameters.ContainsKey('rtsptransportprotocol')) { $Payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
 
            if ($PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnrtspalgprofile -Filter $Payload)
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER rtspalgprofilename 
        The name of the RTSPALG Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER rtspidletimeout 
        Idle timeout for the rtsp sessions in seconds.  
        Default value: 120 
    .PARAMETER rtspportrange 
        port for the RTSP. 
    .PARAMETER rtsptransportprotocol 
        RTSP ALG Profile transport protocol type.  
        Default value: TCP  
        Possible values = TCP, UDP 
    .PARAMETER PassThru 
        Return details about the created lsnrtspalgprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsnrtspalgprofile -rtspalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnrtspalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$rtspalgprofilename ,

        [double]$rtspidletimeout ,

        [string]$rtspportrange ,

        [ValidateSet('TCP', 'UDP')]
        [string]$rtsptransportprotocol ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                rtspalgprofilename = $rtspalgprofilename
            }
            if ($PSBoundParameters.ContainsKey('rtspidletimeout')) { $Payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ($PSBoundParameters.ContainsKey('rtspportrange')) { $Payload.Add('rtspportrange', $rtspportrange) }
            if ($PSBoundParameters.ContainsKey('rtsptransportprotocol')) { $Payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
 
            if ($PSCmdlet.ShouldProcess("lsnrtspalgprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnrtspalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnrtspalgprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER rtspalgprofilename 
       The name of the RTSPALG Profile. 
   .PARAMETER rtspidletimeout 
       Idle timeout for the rtsp sessions in seconds. 
   .PARAMETER rtspportrange 
       port for the RTSP. 
   .PARAMETER rtsptransportprotocol 
       RTSP ALG Profile transport protocol type.  
       Possible values = TCP, UDP
    .EXAMPLE
        Invoke-ADCUnsetLsnrtspalgprofile -rtspalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnrtspalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile
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
        [ValidateLength(1, 127)]
        [string]$rtspalgprofilename ,

        [Boolean]$rtspidletimeout ,

        [Boolean]$rtspportrange ,

        [Boolean]$rtsptransportprotocol 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                rtspalgprofilename = $rtspalgprofilename
            }
            if ($PSBoundParameters.ContainsKey('rtspidletimeout')) { $Payload.Add('rtspidletimeout', $rtspidletimeout) }
            if ($PSBoundParameters.ContainsKey('rtspportrange')) { $Payload.Add('rtspportrange', $rtspportrange) }
            if ($PSBoundParameters.ContainsKey('rtsptransportprotocol')) { $Payload.Add('rtsptransportprotocol', $rtsptransportprotocol) }
            if ($PSCmdlet.ShouldProcess("$rtspalgprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER rtspalgprofilename 
       The name of the RTSPALG Profile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteLsnrtspalgprofile -rtspalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnrtspalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [string]$rtspalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnrtspalgprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$rtspalgprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER rtspalgprofilename 
       The name of the RTSPALG Profile. 
    .PARAMETER GetAll 
        Retreive all lsnrtspalgprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsnrtspalgprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgprofile
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$rtspalgprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnrtspalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration for property 'rtspalgprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Resource $rtspalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Lsn configuration Object
    .DESCRIPTION
        Flush Lsn configuration Object 
    .PARAMETER sessionid 
        Session ID for the RTSP call.
    .EXAMPLE
        Invoke-ADCFlushLsnrtspalgsession -sessionid <string>
    .NOTES
        File Name : Invoke-ADCFlushLsnrtspalgsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession/
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
        [string]$sessionid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnrtspalgsession: Starting"
    }
    process {
        try {
            $Payload = @{
                sessionid = $sessionid
            }

            if ($PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnrtspalgsession -Action flush -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER sessionid 
       Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retreive all lsnrtspalgsession object(s)
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsession
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgsession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgsession -Count
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsession -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession/
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
        [string]$sessionid,

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
        Write-Verbose "Invoke-ADCGetLsnrtspalgsession: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnrtspalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER sessionid 
       Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retreive all lsnrtspalgsession_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessionbinding
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgsessionbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessionbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessionbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsessionbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession_binding/
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
        [string]$sessionid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnrtspalgsessionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnrtspalgsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER sessionid 
       Session ID for the RTSP call. 
    .PARAMETER GetAll 
        Retreive all lsnrtspalgsession_datachannel_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnrtspalgsession_datachannel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessiondatachannelbinding
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnrtspalgsessiondatachannelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnrtspalgsessiondatachannelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnrtspalgsession_datachannel_binding/
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
        [string]$sessionid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnrtspalgsession_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration for property 'sessionid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Resource $sessionid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnrtspalgsession_datachannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnrtspalgsession_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Lsn configuration Object
    .DESCRIPTION
        Flush Lsn configuration Object 
    .PARAMETER nattype 
        Type of sessions to be displayed.  
        Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER clientname 
        Name of the LSN Client entity. 
    .PARAMETER network 
        IP address or network address of subscriber(s). 
    .PARAMETER netmask 
        Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER network6 
        IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER td 
        Traffic domain ID of the LSN client entity. 
    .PARAMETER natip 
        Mapped NAT IP address used in LSN sessions. 
    .PARAMETER natport2 
        Mapped NAT port used in the LSN sessions. 
    .PARAMETER nodeid 
        Unique number that identifies the cluster node.
    .EXAMPLE
        Invoke-ADCFlushLsnsession 
    .NOTES
        File Name : Invoke-ADCFlushLsnsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsession/
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

        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$nattype ,

        [string]$clientname ,

        [string]$network ,

        [string]$netmask ,

        [string]$network6 ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [string]$natip ,

        [int]$natport2 ,

        [ValidateRange(0, 31)]
        [double]$nodeid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnsession: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('nattype')) { $Payload.Add('nattype', $nattype) }
            if ($PSBoundParameters.ContainsKey('clientname')) { $Payload.Add('clientname', $clientname) }
            if ($PSBoundParameters.ContainsKey('network')) { $Payload.Add('network', $network) }
            if ($PSBoundParameters.ContainsKey('netmask')) { $Payload.Add('netmask', $netmask) }
            if ($PSBoundParameters.ContainsKey('network6')) { $Payload.Add('network6', $network6) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('natip')) { $Payload.Add('natip', $natip) }
            if ($PSBoundParameters.ContainsKey('natport2')) { $Payload.Add('natport2', $natport2) }
            if ($PSBoundParameters.ContainsKey('nodeid')) { $Payload.Add('nodeid', $nodeid) }
            if ($PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsession -Action flush -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER nattype 
       Type of sessions to be displayed.  
       Possible values = NAT44, DS-Lite, NAT64 
    .PARAMETER clientname 
       Name of the LSN Client entity. 
    .PARAMETER network 
       IP address or network address of subscriber(s). 
    .PARAMETER netmask 
       Subnet mask for the IP address specified by the network parameter. 
    .PARAMETER network6 
       IPv6 address of the LSN subscriber or B4 device. 
    .PARAMETER td 
       Traffic domain ID of the LSN client entity. 
    .PARAMETER natip 
       Mapped NAT IP address used in LSN sessions. 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all lsnsession object(s)
    .PARAMETER Count
        If specified, the count of the lsnsession object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsession
    .EXAMPLE 
        Invoke-ADCGetLsnsession -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnsession -Count
    .EXAMPLE
        Invoke-ADCGetLsnsession -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsession -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsession
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsession/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateSet('NAT44', 'DS-Lite', 'NAT64')]
        [string]$nattype ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$clientname ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$network ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$netmask ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$network6 ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 4094)]
        [double]$td ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$natip ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsession objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsession objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('nattype')) { $Arguments.Add('nattype', $nattype) } 
                if ($PSBoundParameters.ContainsKey('clientname')) { $Arguments.Add('clientname', $clientname) } 
                if ($PSBoundParameters.ContainsKey('network')) { $Arguments.Add('network', $network) } 
                if ($PSBoundParameters.ContainsKey('netmask')) { $Arguments.Add('netmask', $netmask) } 
                if ($PSBoundParameters.ContainsKey('network6')) { $Arguments.Add('network6', $network6) } 
                if ($PSBoundParameters.ContainsKey('td')) { $Arguments.Add('td', $td) } 
                if ($PSBoundParameters.ContainsKey('natip')) { $Arguments.Add('natip', $natip) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsession configuration for property ''"

            } else {
                Write-Verbose "Retrieving lsnsession configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsession -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Flush Lsn configuration Object
    .DESCRIPTION
        Flush Lsn configuration Object 
    .PARAMETER callid 
        Call ID for the SIP call.
    .EXAMPLE
        Invoke-ADCFlushLsnsipalgcall -callid <string>
    .NOTES
        File Name : Invoke-ADCFlushLsnsipalgcall
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall/
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
        [string]$callid 

    )
    begin {
        Write-Verbose "Invoke-ADCFlushLsnsipalgcall: Starting"
    }
    process {
        try {
            $Payload = @{
                callid = $callid
            }

            if ($PSCmdlet.ShouldProcess($Name, "Flush Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgcall -Action flush -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER callid 
       Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retreive all lsnsipalgcall object(s)
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcall
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcall -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcall -Count
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcall -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcall -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcall
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall/
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
        [string]$callid,

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
        Write-Verbose "Invoke-ADCGetLsnsipalgcall: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnsipalgcall objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER callid 
       Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retreive all lsnsipalgcall_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallbinding
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcallbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcallbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_binding/
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
        [string]$callid,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetLsnsipalgcallbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnsipalgcall_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER callid 
       Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retreive all lsnsipalgcall_controlchannel_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_controlchannel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallcontrolchannelbinding
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcallcontrolchannelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcallcontrolchannelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_controlchannel_binding/
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
        [string]$callid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_controlchannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_controlchannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_controlchannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER callid 
       Call ID for the SIP call. 
    .PARAMETER GetAll 
        Retreive all lsnsipalgcall_datachannel_binding object(s)
    .PARAMETER Count
        If specified, the count of the lsnsipalgcall_datachannel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcalldatachannelbinding
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcalldatachannelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgcalldatachannelbinding -Count
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcalldatachannelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsipalgcalldatachannelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgcalldatachannelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgcall_datachannel_binding/
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
        [string]$callid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgcall_datachannel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration for property 'callid'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Resource $callid -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgcall_datachannel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgcall_datachannel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER sipalgprofilename 
        The name of the SIPALG Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds.  
        Default value: 120 
    .PARAMETER sipsessiontimeout 
        SIP control channel session timeout in seconds.  
        Default value: 600 
    .PARAMETER registrationtimeout 
        SIP registration timeout in seconds.  
        Default value: 60 
    .PARAMETER sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER openviapinhole 
        ENABLE/DISABLE ViaPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER siptransportprotocol 
        SIP ALG Profile transport protocol type.  
        Possible values = TCP, UDP 
    .PARAMETER openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER rport 
        ENABLE/DISABLE rport.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        Invoke-ADCAddLsnsipalgprofile -sipalgprofilename <string> -siptransportprotocol <string>
    .NOTES
        File Name : Invoke-ADCAddLsnsipalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$sipalgprofilename ,

        [double]$datasessionidletimeout = '120' ,

        [double]$sipsessiontimeout = '600' ,

        [double]$registrationtimeout = '60' ,

        [string]$sipsrcportrange ,

        [string]$sipdstportrange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openregisterpinhole = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$opencontactpinhole = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openviapinhole = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openrecordroutepinhole = 'ENABLED' ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP', 'UDP')]
        [string]$siptransportprotocol ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openroutepinhole = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$rport = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnsipalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                sipalgprofilename = $sipalgprofilename
                siptransportprotocol = $siptransportprotocol
            }
            if ($PSBoundParameters.ContainsKey('datasessionidletimeout')) { $Payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ($PSBoundParameters.ContainsKey('sipsessiontimeout')) { $Payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('registrationtimeout')) { $Payload.Add('registrationtimeout', $registrationtimeout) }
            if ($PSBoundParameters.ContainsKey('sipsrcportrange')) { $Payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ($PSBoundParameters.ContainsKey('sipdstportrange')) { $Payload.Add('sipdstportrange', $sipdstportrange) }
            if ($PSBoundParameters.ContainsKey('openregisterpinhole')) { $Payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ($PSBoundParameters.ContainsKey('opencontactpinhole')) { $Payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ($PSBoundParameters.ContainsKey('openviapinhole')) { $Payload.Add('openviapinhole', $openviapinhole) }
            if ($PSBoundParameters.ContainsKey('openrecordroutepinhole')) { $Payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ($PSBoundParameters.ContainsKey('openroutepinhole')) { $Payload.Add('openroutepinhole', $openroutepinhole) }
            if ($PSBoundParameters.ContainsKey('rport')) { $Payload.Add('rport', $rport) }
 
            if ($PSCmdlet.ShouldProcess("lsnsipalgprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnsipalgprofile -Filter $Payload)
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER sipalgprofilename 
        The name of the SIPALG Profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER datasessionidletimeout 
        Idle timeout for the data channel sessions in seconds.  
        Default value: 120 
    .PARAMETER sipsessiontimeout 
        SIP control channel session timeout in seconds.  
        Default value: 600 
    .PARAMETER registrationtimeout 
        SIP registration timeout in seconds.  
        Default value: 60 
    .PARAMETER sipsrcportrange 
        Source port range for SIP_UDP and SIP_TCP. 
    .PARAMETER sipdstportrange 
        Destination port range for SIP_UDP and SIP_TCP. 
    .PARAMETER openregisterpinhole 
        ENABLE/DISABLE RegisterPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER opencontactpinhole 
        ENABLE/DISABLE ContactPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER openviapinhole 
        ENABLE/DISABLE ViaPinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER openrecordroutepinhole 
        ENABLE/DISABLE RecordRoutePinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER siptransportprotocol 
        SIP ALG Profile transport protocol type.  
        Possible values = TCP, UDP 
    .PARAMETER openroutepinhole 
        ENABLE/DISABLE RoutePinhole creation.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER rport 
        ENABLE/DISABLE rport.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsnsipalgprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsnsipalgprofile -sipalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsnsipalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$sipalgprofilename ,

        [double]$datasessionidletimeout ,

        [double]$sipsessiontimeout ,

        [double]$registrationtimeout ,

        [string]$sipsrcportrange ,

        [string]$sipdstportrange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openregisterpinhole ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$opencontactpinhole ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openviapinhole ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openrecordroutepinhole ,

        [ValidateSet('TCP', 'UDP')]
        [string]$siptransportprotocol ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$openroutepinhole ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$rport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsnsipalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                sipalgprofilename = $sipalgprofilename
            }
            if ($PSBoundParameters.ContainsKey('datasessionidletimeout')) { $Payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ($PSBoundParameters.ContainsKey('sipsessiontimeout')) { $Payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('registrationtimeout')) { $Payload.Add('registrationtimeout', $registrationtimeout) }
            if ($PSBoundParameters.ContainsKey('sipsrcportrange')) { $Payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ($PSBoundParameters.ContainsKey('sipdstportrange')) { $Payload.Add('sipdstportrange', $sipdstportrange) }
            if ($PSBoundParameters.ContainsKey('openregisterpinhole')) { $Payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ($PSBoundParameters.ContainsKey('opencontactpinhole')) { $Payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ($PSBoundParameters.ContainsKey('openviapinhole')) { $Payload.Add('openviapinhole', $openviapinhole) }
            if ($PSBoundParameters.ContainsKey('openrecordroutepinhole')) { $Payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ($PSBoundParameters.ContainsKey('siptransportprotocol')) { $Payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ($PSBoundParameters.ContainsKey('openroutepinhole')) { $Payload.Add('openroutepinhole', $openroutepinhole) }
            if ($PSBoundParameters.ContainsKey('rport')) { $Payload.Add('rport', $rport) }
 
            if ($PSCmdlet.ShouldProcess("lsnsipalgprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsnsipalgprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnsipalgprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER sipalgprofilename 
       The name of the SIPALG Profile. 
   .PARAMETER datasessionidletimeout 
       Idle timeout for the data channel sessions in seconds. 
   .PARAMETER sipsessiontimeout 
       SIP control channel session timeout in seconds. 
   .PARAMETER registrationtimeout 
       SIP registration timeout in seconds. 
   .PARAMETER sipsrcportrange 
       Source port range for SIP_UDP and SIP_TCP. 
   .PARAMETER sipdstportrange 
       Destination port range for SIP_UDP and SIP_TCP. 
   .PARAMETER openregisterpinhole 
       ENABLE/DISABLE RegisterPinhole creation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER opencontactpinhole 
       ENABLE/DISABLE ContactPinhole creation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER openviapinhole 
       ENABLE/DISABLE ViaPinhole creation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER openrecordroutepinhole 
       ENABLE/DISABLE RecordRoutePinhole creation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER siptransportprotocol 
       SIP ALG Profile transport protocol type.  
       Possible values = TCP, UDP 
   .PARAMETER openroutepinhole 
       ENABLE/DISABLE RoutePinhole creation.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER rport 
       ENABLE/DISABLE rport.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsnsipalgprofile -sipalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsnsipalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile
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
        [ValidateLength(1, 127)]
        [string]$sipalgprofilename ,

        [Boolean]$datasessionidletimeout ,

        [Boolean]$sipsessiontimeout ,

        [Boolean]$registrationtimeout ,

        [Boolean]$sipsrcportrange ,

        [Boolean]$sipdstportrange ,

        [Boolean]$openregisterpinhole ,

        [Boolean]$opencontactpinhole ,

        [Boolean]$openviapinhole ,

        [Boolean]$openrecordroutepinhole ,

        [Boolean]$siptransportprotocol ,

        [Boolean]$openroutepinhole ,

        [Boolean]$rport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsnsipalgprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                sipalgprofilename = $sipalgprofilename
            }
            if ($PSBoundParameters.ContainsKey('datasessionidletimeout')) { $Payload.Add('datasessionidletimeout', $datasessionidletimeout) }
            if ($PSBoundParameters.ContainsKey('sipsessiontimeout')) { $Payload.Add('sipsessiontimeout', $sipsessiontimeout) }
            if ($PSBoundParameters.ContainsKey('registrationtimeout')) { $Payload.Add('registrationtimeout', $registrationtimeout) }
            if ($PSBoundParameters.ContainsKey('sipsrcportrange')) { $Payload.Add('sipsrcportrange', $sipsrcportrange) }
            if ($PSBoundParameters.ContainsKey('sipdstportrange')) { $Payload.Add('sipdstportrange', $sipdstportrange) }
            if ($PSBoundParameters.ContainsKey('openregisterpinhole')) { $Payload.Add('openregisterpinhole', $openregisterpinhole) }
            if ($PSBoundParameters.ContainsKey('opencontactpinhole')) { $Payload.Add('opencontactpinhole', $opencontactpinhole) }
            if ($PSBoundParameters.ContainsKey('openviapinhole')) { $Payload.Add('openviapinhole', $openviapinhole) }
            if ($PSBoundParameters.ContainsKey('openrecordroutepinhole')) { $Payload.Add('openrecordroutepinhole', $openrecordroutepinhole) }
            if ($PSBoundParameters.ContainsKey('siptransportprotocol')) { $Payload.Add('siptransportprotocol', $siptransportprotocol) }
            if ($PSBoundParameters.ContainsKey('openroutepinhole')) { $Payload.Add('openroutepinhole', $openroutepinhole) }
            if ($PSBoundParameters.ContainsKey('rport')) { $Payload.Add('rport', $rport) }
            if ($PSCmdlet.ShouldProcess("$sipalgprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsnsipalgprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER sipalgprofilename 
       The name of the SIPALG Profile.  
       Minimum length = 1  
       Maximum length = 127 
    .EXAMPLE
        Invoke-ADCDeleteLsnsipalgprofile -sipalgprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnsipalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [string]$sipalgprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsnsipalgprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$sipalgprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER sipalgprofilename 
       The name of the SIPALG Profile. 
    .PARAMETER GetAll 
        Retreive all lsnsipalgprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsnsipalgprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnsipalgprofile
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnsipalgprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsnsipalgprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnsipalgprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnsipalgprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnsipalgprofile/
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
        [ValidateLength(1, 127)]
        [string]$sipalgprofilename,

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
        Write-Verbose "Invoke-ADCGetLsnsipalgprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnsipalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnsipalgprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnsipalgprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnsipalgprofile configuration for property 'sipalgprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Resource $sipalgprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnsipalgprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnsipalgprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER name 
        Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER transportprotocol 
        Protocol for the LSN mapping entry.  
        Possible values = TCP, UDP, ICMP, ALL 
    .PARAMETER subscrip 
        IPv4(NAT44 ; DS-Lite)/IPv6(NAT64) address of an LSN subscriber for the LSN static mapping entry. 
    .PARAMETER subscrport 
        Port of the LSN subscriber for the LSN mapping entry. * represents all ports being used. Used in case of static wildcard.  
        Minimum value = 0  
        Maximum value = 65535  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER network6 
        B4 address in DS-Lite setup.  
        Minimum length = 1 
    .PARAMETER td 
        ID of the traffic domain to which the subscriber belongs.  
        If you do not specify an ID, the subscriber is assumed to be a part of the default traffic domain.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER natip 
        IPv4 address, already existing on the Citrix ADC as type LSN, to be used as NAT IP address for this mapping entry. 
    .PARAMETER natport 
        NAT port for this LSN mapping entry. * represents all ports being used. Used in case of static wildcard.  
        Minimum value = 0  
        Maximum value = 65535  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER destip 
        Destination IP address for the LSN mapping entry. 
    .PARAMETER dsttd 
        ID of the traffic domain through which the destination IP address for this LSN mapping entry is reachable from the Citrix ADC.  
        If you do not specify an ID, the destination IP address is assumed to be reachable through the default traffic domain, which has an ID of 0.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER PassThru 
        Return details about the created lsnstatic item.
    .EXAMPLE
        Invoke-ADCAddLsnstatic -name <string> -transportprotocol <string> -subscrip <string> -subscrport <int>
    .NOTES
        File Name : Invoke-ADCAddLsnstatic
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP', 'UDP', 'ICMP', 'ALL')]
        [string]$transportprotocol ,

        [Parameter(Mandatory = $true)]
        [string]$subscrip ,

        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65535)]
        [int]$subscrport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$network6 ,

        [ValidateRange(0, 4094)]
        [double]$td = '0' ,

        [string]$natip ,

        [ValidateRange(1, 65535)]
        [int]$natport ,

        [string]$destip ,

        [ValidateRange(0, 4094)]
        [double]$dsttd = '0' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsnstatic: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                transportprotocol = $transportprotocol
                subscrip = $subscrip
                subscrport = $subscrport
            }
            if ($PSBoundParameters.ContainsKey('network6')) { $Payload.Add('network6', $network6) }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('natip')) { $Payload.Add('natip', $natip) }
            if ($PSBoundParameters.ContainsKey('natport')) { $Payload.Add('natport', $natport) }
            if ($PSBoundParameters.ContainsKey('destip')) { $Payload.Add('destip', $destip) }
            if ($PSBoundParameters.ContainsKey('dsttd')) { $Payload.Add('dsttd', $dsttd) }
 
            if ($PSCmdlet.ShouldProcess("lsnstatic", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsnstatic -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsnstatic -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER name 
       Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsnstatic -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsnstatic
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        Write-Verbose "Invoke-ADCDeleteLsnstatic: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER name 
       Name for the LSN static mapping entry. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN group is created. 
    .PARAMETER GetAll 
        Retreive all lsnstatic object(s)
    .PARAMETER Count
        If specified, the count of the lsnstatic object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsnstatic
    .EXAMPLE 
        Invoke-ADCGetLsnstatic -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsnstatic -Count
    .EXAMPLE
        Invoke-ADCGetLsnstatic -name <string>
    .EXAMPLE
        Invoke-ADCGetLsnstatic -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsnstatic
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsnstatic/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
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
        Write-Verbose "Invoke-ADCGetLsnstatic: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsnstatic objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsnstatic objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsnstatic objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsnstatic configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsnstatic configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsnstatic -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Lsn configuration Object
    .DESCRIPTION
        Add Lsn configuration Object 
    .PARAMETER transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER transportprotocol 
        Protocol for which to set the LSN transport profile parameters.  
        Possible values = TCP, UDP, ICMP 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.  
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. .  
        Default value: 120  
        Minimum value = 60 
    .PARAMETER finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints.  
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session.  
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection.  
        Default value: 30 
    .PARAMETER stuntimeout 
        STUN protocol timeout.  
        Default value: 600  
        Minimum value = 120  
        Maximum value = 1200 
    .PARAMETER synidletimeout 
        SYN Idle timeout.  
        Default value: 60  
        Minimum value = 30  
        Maximum value = 120 
    .PARAMETER portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol.  
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine.  
        Default value: 0 
    .PARAMETER portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection.  
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection.  
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports.  
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC.  
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection.  
        Following are some reasons for the Citrix ADC to receive such packets:  
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout.  
        * Such packets can be a part of a DoS attack.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        Invoke-ADCAddLsntransportprofile -transportprofilename <string> -transportprotocol <string>
    .NOTES
        File Name : Invoke-ADCAddLsntransportprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$transportprofilename ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP', 'UDP', 'ICMP')]
        [string]$transportprotocol ,

        [double]$sessiontimeout = '120' ,

        [double]$finrsttimeout = '30' ,

        [ValidateRange(120, 1200)]
        [double]$stuntimeout = '600' ,

        [ValidateRange(30, 120)]
        [double]$synidletimeout = '60' ,

        [ValidateRange(0, 65535)]
        [double]$portquota = '0' ,

        [ValidateRange(0, 65535)]
        [double]$sessionquota = '0' ,

        [double]$groupsessionlimit = '0' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$portpreserveparity = 'DISABLED' ,

        [ValidateRange(0, 1023)]
        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$portpreserverange = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$syncheck = 'ENABLED' ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddLsntransportprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                transportprofilename = $transportprofilename
                transportprotocol = $transportprotocol
            }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('finrsttimeout')) { $Payload.Add('finrsttimeout', $finrsttimeout) }
            if ($PSBoundParameters.ContainsKey('stuntimeout')) { $Payload.Add('stuntimeout', $stuntimeout) }
            if ($PSBoundParameters.ContainsKey('synidletimeout')) { $Payload.Add('synidletimeout', $synidletimeout) }
            if ($PSBoundParameters.ContainsKey('portquota')) { $Payload.Add('portquota', $portquota) }
            if ($PSBoundParameters.ContainsKey('sessionquota')) { $Payload.Add('sessionquota', $sessionquota) }
            if ($PSBoundParameters.ContainsKey('groupsessionlimit')) { $Payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ($PSBoundParameters.ContainsKey('portpreserveparity')) { $Payload.Add('portpreserveparity', $portpreserveparity) }
            if ($PSBoundParameters.ContainsKey('portpreserverange')) { $Payload.Add('portpreserverange', $portpreserverange) }
            if ($PSBoundParameters.ContainsKey('syncheck')) { $Payload.Add('syncheck', $syncheck) }
 
            if ($PSCmdlet.ShouldProcess("lsntransportprofile", "Add Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsntransportprofile -Filter $Payload)
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
        Delete Lsn configuration Object
    .DESCRIPTION
        Delete Lsn configuration Object
    .PARAMETER transportprofilename 
       Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .EXAMPLE
        Invoke-ADCDeleteLsntransportprofile -transportprofilename <string>
    .NOTES
        File Name : Invoke-ADCDeleteLsntransportprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [string]$transportprofilename 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteLsntransportprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$transportprofilename", "Delete Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Arguments $Arguments
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
        Update Lsn configuration Object
    .DESCRIPTION
        Update Lsn configuration Object 
    .PARAMETER transportprofilename 
        Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER sessiontimeout 
        Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.  
        This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. .  
        Default value: 120  
        Minimum value = 60 
    .PARAMETER finrsttimeout 
        Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints.  
        If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session.  
        Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection.  
        Default value: 30 
    .PARAMETER stuntimeout 
        STUN protocol timeout.  
        Default value: 600  
        Minimum value = 120  
        Maximum value = 1200 
    .PARAMETER synidletimeout 
        SYN Idle timeout.  
        Default value: 60  
        Minimum value = 30  
        Maximum value = 120 
    .PARAMETER portquota 
        Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER sessionquota 
        Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol.  
        When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions.  
        Default value: 0  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER groupsessionlimit 
        Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine.  
        Default value: 0 
    .PARAMETER portpreserveparity 
        Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection.  
        You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER portpreserverange 
        If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port range (0-1023) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection.  
        This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the range of ports allocated includes well-known ports.  
        When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER syncheck 
        Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC.  
        If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection.  
        Following are some reasons for the Citrix ADC to receive such packets:  
        * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout.  
        * Such packets can be a part of a DoS attack.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER PassThru 
        Return details about the created lsntransportprofile item.
    .EXAMPLE
        Invoke-ADCUpdateLsntransportprofile -transportprofilename <string>
    .NOTES
        File Name : Invoke-ADCUpdateLsntransportprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$transportprofilename ,

        [double]$sessiontimeout ,

        [double]$finrsttimeout ,

        [ValidateRange(120, 1200)]
        [double]$stuntimeout ,

        [ValidateRange(30, 120)]
        [double]$synidletimeout ,

        [ValidateRange(0, 65535)]
        [double]$portquota ,

        [ValidateRange(0, 65535)]
        [double]$sessionquota ,

        [double]$groupsessionlimit ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$portpreserveparity ,

        [ValidateRange(0, 1023)]
        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$portpreserverange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$syncheck ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateLsntransportprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                transportprofilename = $transportprofilename
            }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('finrsttimeout')) { $Payload.Add('finrsttimeout', $finrsttimeout) }
            if ($PSBoundParameters.ContainsKey('stuntimeout')) { $Payload.Add('stuntimeout', $stuntimeout) }
            if ($PSBoundParameters.ContainsKey('synidletimeout')) { $Payload.Add('synidletimeout', $synidletimeout) }
            if ($PSBoundParameters.ContainsKey('portquota')) { $Payload.Add('portquota', $portquota) }
            if ($PSBoundParameters.ContainsKey('sessionquota')) { $Payload.Add('sessionquota', $sessionquota) }
            if ($PSBoundParameters.ContainsKey('groupsessionlimit')) { $Payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ($PSBoundParameters.ContainsKey('portpreserveparity')) { $Payload.Add('portpreserveparity', $portpreserveparity) }
            if ($PSBoundParameters.ContainsKey('portpreserverange')) { $Payload.Add('portpreserverange', $portpreserverange) }
            if ($PSBoundParameters.ContainsKey('syncheck')) { $Payload.Add('syncheck', $syncheck) }
 
            if ($PSCmdlet.ShouldProcess("lsntransportprofile", "Update Lsn configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type lsntransportprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetLsntransportprofile -Filter $Payload)
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
        Unset Lsn configuration Object
    .DESCRIPTION
        Unset Lsn configuration Object 
   .PARAMETER transportprofilename 
       Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
   .PARAMETER sessiontimeout 
       Timeout, in seconds, for an idle LSN session. If an LSN session is idle for a time that exceeds this value, the Citrix ADC removes the session.  
       This timeout does not apply for a TCP LSN session when a FIN or RST message is received from either of the endpoints. . 
   .PARAMETER finrsttimeout 
       Timeout, in seconds, for a TCP LSN session after a FIN or RST message is received from one of the endpoints.  
       If a TCP LSN session is idle (after the Citrix ADC receives a FIN or RST message) for a time that exceeds this value, the Citrix ADC ADC removes the session.  
       Since the LSN feature of the Citrix ADC does not maintain state information of any TCP LSN sessions, this timeout accommodates the transmission of the FIN or RST, and ACK messages from the other endpoint so that both endpoints can properly close the connection. 
   .PARAMETER stuntimeout 
       STUN protocol timeout. 
   .PARAMETER synidletimeout 
       SYN Idle timeout. 
   .PARAMETER portquota 
       Maximum number of LSN NAT ports to be used at a time by each subscriber for the specified protocol. For example, each subscriber can be limited to a maximum of 500 TCP NAT ports. When the LSN NAT mappings for a subscriber reach the limit, the Citrix ADC does not allocate additional NAT ports for that subscriber. 
   .PARAMETER sessionquota 
       Maximum number of concurrent LSN sessions allowed for each subscriber for the specified protocol.  
       When the number of LSN sessions reaches the limit for a subscriber, the Citrix ADC does not allow the subscriber to open additional sessions. 
   .PARAMETER groupsessionlimit 
       Maximum number of concurrent LSN sessions(for the specified protocol) allowed for all subscriber of a group to which this profile has bound. This limit will get split across the Citrix ADCs packet engines and rounded down. When the number of LSN sessions reaches the limit for a group in packet engine, the Citrix ADC does not allow the subscriber of that group to open additional sessions through that packet engine. 
   .PARAMETER portpreserveparity 
       Enable port parity between a subscriber port and its mapped LSN NAT port. For example, if a subscriber initiates a connection from an odd numbered port, the Citrix ADC allocates an odd numbered LSN NAT port for this connection.  
       You must set this parameter for proper functioning of protocols that require the source port to be even or odd numbered, for example, in peer-to-peer applications that use RTP or RTCP protocol.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER portpreserverange 
       If a subscriber initiates a connection from a well-known port (0-1023), allocate a NAT port from the well-known port ) for this connection. For example, if a subscriber initiates a connection from port 80, the Citrix ADC can allocate port 100 as the NAT port for this connection.  
       This parameter applies to dynamic NAT without port block allocation. It also applies to Deterministic NAT if the known ports.  
       When all the well-known ports of all the available NAT IP addresses are used in different subscriber's connections (LSN sessions), and a subscriber initiates a connection from a well-known port, the Citrix ADC drops this connection.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER syncheck 
       Silently drop any non-SYN packets for connections for which there is no LSN-NAT session present on the Citrix ADC.  
       If you disable this parameter, the Citrix ADC accepts any non-SYN packets and creates a new LSN session entry for this connection.  
       Following are some reasons for the Citrix ADC to receive such packets:  
       * LSN session for a connection existed but the Citrix ADC removed this session because the LSN session was idle for a time that exceeded the configured session timeout.  
       * Such packets can be a part of a DoS attack.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetLsntransportprofile -transportprofilename <string>
    .NOTES
        File Name : Invoke-ADCUnsetLsntransportprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$transportprofilename ,

        [Boolean]$sessiontimeout ,

        [Boolean]$finrsttimeout ,

        [Boolean]$stuntimeout ,

        [Boolean]$synidletimeout ,

        [Boolean]$portquota ,

        [Boolean]$sessionquota ,

        [Boolean]$groupsessionlimit ,

        [Boolean]$portpreserveparity ,

        [Boolean]$portpreserverange ,

        [Boolean]$syncheck 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetLsntransportprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                transportprofilename = $transportprofilename
            }
            if ($PSBoundParameters.ContainsKey('sessiontimeout')) { $Payload.Add('sessiontimeout', $sessiontimeout) }
            if ($PSBoundParameters.ContainsKey('finrsttimeout')) { $Payload.Add('finrsttimeout', $finrsttimeout) }
            if ($PSBoundParameters.ContainsKey('stuntimeout')) { $Payload.Add('stuntimeout', $stuntimeout) }
            if ($PSBoundParameters.ContainsKey('synidletimeout')) { $Payload.Add('synidletimeout', $synidletimeout) }
            if ($PSBoundParameters.ContainsKey('portquota')) { $Payload.Add('portquota', $portquota) }
            if ($PSBoundParameters.ContainsKey('sessionquota')) { $Payload.Add('sessionquota', $sessionquota) }
            if ($PSBoundParameters.ContainsKey('groupsessionlimit')) { $Payload.Add('groupsessionlimit', $groupsessionlimit) }
            if ($PSBoundParameters.ContainsKey('portpreserveparity')) { $Payload.Add('portpreserveparity', $portpreserveparity) }
            if ($PSBoundParameters.ContainsKey('portpreserverange')) { $Payload.Add('portpreserverange', $portpreserverange) }
            if ($PSBoundParameters.ContainsKey('syncheck')) { $Payload.Add('syncheck', $syncheck) }
            if ($PSCmdlet.ShouldProcess("$transportprofilename", "Unset Lsn configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lsntransportprofile -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Lsn configuration object(s)
    .DESCRIPTION
        Get Lsn configuration object(s)
    .PARAMETER transportprofilename 
       Name for the LSN transport profile. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. Cannot be changed after the LSN transport profile is created. 
    .PARAMETER GetAll 
        Retreive all lsntransportprofile object(s)
    .PARAMETER Count
        If specified, the count of the lsntransportprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetLsntransportprofile
    .EXAMPLE 
        Invoke-ADCGetLsntransportprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetLsntransportprofile -Count
    .EXAMPLE
        Invoke-ADCGetLsntransportprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetLsntransportprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetLsntransportprofile
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lsn/lsntransportprofile/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [ValidateLength(1, 127)]
        [string]$transportprofilename,

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
        Write-Verbose "Invoke-ADCGetLsntransportprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all lsntransportprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for lsntransportprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving lsntransportprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving lsntransportprofile configuration for property 'transportprofilename'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Resource $transportprofilename -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving lsntransportprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type lsntransportprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


