function Invoke-ADCUpdateLBvServer {
    <#
        .SYNOPSIS
            Update an existing Load Balance Virtual Server
        .DESCRIPTION
            Update an existing Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the virtual server. 
        .PARAMETER IPAddress
            IPv4 or IPv6 address to assign to the virtual server.
        .PARAMETER Port
            Port number for the virtual server.
        .PARAMETER ServiceType
            Protocol used by the service (also called the service type)
        .PARAMETER LBMethod
            Specify a Load Balance Virtual Server Name
        .PARAMETER PersistenceType
            Type of persistence for the virtual server.
        .PARAMETER RedirectFromPort
            Port number for the virtual server, from which we absorb the traffic for http redirect.
        .PARAMETER HTTPSRedirectURL
            URL to which to redirect traffic if the traffic is recieved from redirect port.
        .PARAMETER ICMPvSrResponse
            How the Citrix ADC responds to ping requests received for an IP address that is common to one or more virtual servers. 
        .PARAMETER Timeout
            Time period for which a persistence session is in effect.
        .PARAMETER Comment
            Information about this virtual server.
        .PARAMETER PassThru
            Return details about the created virtual server.
        .EXAMPLE
            Invoke-ADCUpdateLBvServer -Name "lb_domain.com_https" -LBMethod ROUNDROBIN
        .NOTES
            File Name : Invoke-ADCUpdateLBvServer
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
        [string]$Name = (Read-Host -Prompt "LB Virtual Server Name"),
        
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$IPAddress,
        
        [ValidateRange(1, 65534)]
        [int]$Port = 80,
        
        [ValidateLength(0, 256)]
        [string]$Comment = "",
        
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
        Write-Verbose "Invoke-ADCUpdateLBvServer: Starting"
    }
    process {
        $Payload = @{
            name = $Name
        }    
        try {
            if ($PSBoundParameters.ContainsKey('IPAddress')) { $Payload.Add('ipv46', $IPAddress) }
            if ($PSBoundParameters.ContainsKey('Port')) { $Payload.Add('port', $Port) }
            if ($PSBoundParameters.ContainsKey('LBMethod')) { $Payload.Add('lbmethod', $LBMethod) }
            if ($PSBoundParameters.ContainsKey('ICMPvSrResponse')) { $Payload.Add('icmpvsrresponse', $ICMPvSrResponse) }
            if ($PSBoundParameters.ContainsKey('Comment')) { $Payload.Add('comment', $Comment) }
            if ($PSBoundParameters.ContainsKey('PersistenceType')) { $Payload.Add('persistencetype', $PersistenceType) }
            if ($PSBoundParameters.ContainsKey('RedirectFromPort')) { $Payload.Add('redirectfromport', $RedirectFromPort) }
            if ($PSBoundParameters.ContainsKey('HTTPSRedirectURL')) { $Payload.Add('httpsredirecturl', $HTTPSRedirectURL) }
            if ($PSBoundParameters.ContainsKey('Timeout')) { $Payload.Add('timeout', $Timeout) }
            if ($PSCmdlet.ShouldProcess($Name, 'Update Load Balance Virtual Server')) {
                $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type lbvserver -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) { 
                    Write-Output (Invoke-ADCGetLBvServer -Name $Name)
                }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateLBvServer: Finished"
    }
}
