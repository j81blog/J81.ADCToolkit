function Invoke-ADCAddLBvServer {
    <#
        .SYNOPSIS
            Add a new Load Balance Virtual Server
        .DESCRIPTION
            Add a new Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify a Load Balance Virtual Server Name
        .EXAMPLE
            Invoke-ADCAddLBvServer 
        .NOTES
            File Name : Invoke-ADCAddLBvServer
            Version   : v0.2
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
        $ICMPVSResponse = "PASSIVE",

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
                        icmpvsrresponse = $ICMPVSResponse
                        comment         = $Comment
                    }
                } else {
                    $Payload = @{
                        name            = $item
                        servicetype     = $ServiceType
                        ipv46           = $IPAddress
                        port            = $Port
                        lbmethod        = $LBMethod
                        icmpvsrresponse = $ICMPVSResponse
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
