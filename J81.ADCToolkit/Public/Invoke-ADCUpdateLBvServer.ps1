function Invoke-ADCUpdateLBvServer {
    <#
        .SYNOPSIS
            Update an existing Load Balance Virtual Server
        .DESCRIPTION
            Update an existing Load Balance Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Specify a Load Balance Virtual Server Name
        .EXAMPLE
            Invoke-ADCUpdateLBvServer 
        .NOTES
            File Name : Invoke-ADCUpdateLBvServer
            Version   : v0.1
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
        $ICMPVSResponse = "PASSIVE",

        [int]
        $Timeout,

        [Switch]$PassThru
    )
    process {
        $Payload = @{
            name = $Name
        }    
        try {
            if ($PSBoundParameters.ContainsKey('IPAddress')) { $Payload.Add('ipv46', $IPAddress) }
            if ($PSBoundParameters.ContainsKey('Port')) { $Payload.Add('port', $Port) }
            if ($PSBoundParameters.ContainsKey('LBMethod')) { $Payload.Add('lbmethod', $LBMethod) }
            if ($PSBoundParameters.ContainsKey('ICMPVSResponse')) { $Payload.Add('icmpvsrresponse', $ICMPVSResponse) }
            if ($PSBoundParameters.ContainsKey('Comment')) { $Payload.Add('comment', $Comment) }
            if ($PSBoundParameters.ContainsKey('PersistenceType')) { $Payload.Add('persistencetype', $PersistenceType) }
            if ($PSBoundParameters.ContainsKey('RedirectFromPort')) { $Payload.Add('redirectfromport', $RedirectFromPort) }
            if ($PSBoundParameters.ContainsKey('HTTPSRedirectURL')) { $Payload.Add('httpsredirecturl', $HTTPSRedirectURL) }
            if ($PSBoundParameters.ContainsKey('Timeout')) { $Payload.Add('timeout', $Timeout) }
            if ($PSCmdlet.ShouldProcess($Name, 'Update Load Balance Virtual Server')) {
                $null = Invoke-ADCNitroApi -Session $ADCSession -Method PUT -Type lbvserver -Payload $Payload -GetWarning

                if ($PSBoundParameters.ContainsKey('PassThru')) { return Invoke-ADCGetLBvServer -Name $Name }
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
}
