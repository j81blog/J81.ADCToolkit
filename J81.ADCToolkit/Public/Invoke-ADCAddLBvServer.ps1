function Invoke-ADCAddLBvServer {
    <#
        .SYNOPSIS
            Add a new Load Balance Virtual Server
        .DESCRIPTION
            Add a new Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters. Can be changed after the virtual server is created.
        .PARAMETER IPAddress
            IPv4 or IPv6 address to assign to the virtual server.
        .PARAMETER Port
            Port number for the virtual server.
        .PARAMETER NonAddressable
            Specify instead of an IP Address, an Non Addressable LB vServer will be created.
        .PARAMETER ServiceType
            Protocol used by the service (also called the service type)
        .PARAMETER LBMethod
            Specify a Load Balance Virtual Server Name
        .PARAMETER PersistenceType
            Type of persistence for the virtual server.
        .PARAMETER RedirectFromPort
            Port number for the virtual server, from which we absorb the traffic for http redirect.
        .PARAMETER HTTPSRedirectURL
            URL to which to redirect traffic if the traffic is received from redirect port.
        .PARAMETER ICMPvSrResponse
            How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. 
        .PARAMETER Timeout
            Time period for which a persistence session is in effect.
        .PARAMETER Comment
            Information about this virtual server.
        .PARAMETER PassThru
            Return details about the created virtual server.
        .EXAMPLE
            Invoke-ADCAddLBvServer -Name "bl_domain.com_https" -NonAddressable -ServiceType HTTP -Comment "HTTP vServer for domain.com" -LBMethod LEASTCONNECTION 
        .NOTES
            File Name : Invoke-ADCAddLBvServer
            Version   : v0.3
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/lb/lbvserver/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidatePattern('^(([a-zA-Z0-9]|\_)+([\x00-\x7F]|_|\#|\.|\s|\:|@|=|-)+)$', Options = 'None')]
        [string[]]$Name = (Read-Host -Prompt "LB Virtual Server Name"),
        
        [Parameter(Mandatory = $true, ParameterSetName = "Addressable")]
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$IPAddress,
        
        [Parameter(Mandatory = $true, ParameterSetName = "NonAddressable")]
        [Switch]$NonAddressable,
        
        [Parameter(Mandatory = $true, ParameterSetName = "Addressable")]
        [ValidateRange(1, 65534)]
        [int]$Port = 80,
        
        [ValidateLength(0, 256)]
        [string]$Comment = "",
        
        [ValidateSet("HTTP", "FTP", "TCP", "UDP", "SSL", "SSL_BRIDGE", "SSL_TCP", "DTLS", "NNTP", "DNS", "DHCPRA", "ANY", "SIP_UDP", "SIP_TCP", "SIP_SSL", "DNS_TCP", "RTSP", "PUSH", "SSL_PUSH", "RADIUS", "RDP", "MYSQL", "MSSQL", "DIAMETER", "SSL_DIAMETER", "TFTP", "ORACLE", "SMPP", "SYSLOGTCP", "SYSLOGUDP", "FIX", "SSL_FIX", "PROXY", "USER_TCP", "USER_SSL_TCP", "QUIC", "IPFIX", "LOGSTREAM", "MONGO", "MONGO_TLS")]
        [string]$ServiceType = "HTTP",

        [ValidateSet("ROUNDROBIN", "LEASTCONNECTION", "LEASTRESPONSETIME", "LEASTBANDWIDTH", "LEASTPACKETS", "CUSTOMLOAD", "LRTM", "URLHASH", "DOMAINHASH", "DESTINATIONIPHASH", "SOURCEIPHASH", "TOKEN", "SRCIPDESTIPHASH", "SRCIPSRCPORTHASH", "CALLIDHASH", "USER_TOKEN")]
        [string]$LBMethod = "LEASTCONNECTION",

        [ValidateSet("SOURCEIP", "COOKIEINSERT", "SSLSESSION", "CUSTOMSERVERID", "RULE", "URLPASSIVE", "DESTIP", "SRCIPDESTIP", "CALLID" , "RTSPID", "FIXSESSION", "NONE")]
        [string]
        $PersistenceType,

        [ValidateRange(1, 65535)]
        [int]
        $RedirectFromPort,

        [string]
        $HTTPSRedirectURL,

        [ValidateSet("PASSIVE", "ACTIVE")]
        [string]
        $ICMPvSrResponse = "PASSIVE",

        [int]
        $Timeout,

        [Switch]$PassThru
    )
    begin {
        Write-Verbose "Invoke-ADCAddLBvServer: Starting"
    }
    process {
        foreach ($item in $Name) {
            try {
                if ($NonAddressable) {
                    $Payload = @{
                        name            = $item
                        servicetype     = $ServiceType
                        ipv46           = "0.0.0.0"
                        port            = "0"
                        lbmethod        = $LBMethod
                        icmpvsrresponse = $ICMPvSrResponse
                        comment         = $Comment
                    }
                } else {
                    $Payload = @{
                        name            = $item
                        servicetype     = $ServiceType
                        ipv46           = $IPAddress
                        port            = $Port
                        lbmethod        = $LBMethod
                        icmpvsrresponse = $ICMPvSrResponse
                        comment         = $Comment
                    }
                }
                if ($PSBoundParameters.ContainsKey('PersistenceType')) { $Payload.Add('persistencetype', $PersistenceType) }
                if ($PSBoundParameters.ContainsKey('RedirectFromPort')) { $Payload.Add('redirectfromport', $RedirectFromPort) }
                if ($PSBoundParameters.ContainsKey('HTTPSRedirectURL')) { $Payload.Add('httpsredirecturl', $HTTPSRedirectURL) }
                if ($PSBoundParameters.ContainsKey('Timeout')) { $Payload.Add('timeout', $Timeout) }
                            
                if ($PSCmdlet.ShouldProcess($item, 'Create Load Balance Virtual Server')) {
                    $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type lbvserver -Payload $Payload -Action add -GetWarning

                    if ($PSBoundParameters.ContainsKey('PassThru')) {
                        Write-Output (Invoke-ADCGetLBvServer -Name $item)
                    }
                }
            } catch {
                Write-Verbose "ERROR: $($_.Exception.Message)"
                throw $_
            }
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddLBvServer: Finished"
    }
}
