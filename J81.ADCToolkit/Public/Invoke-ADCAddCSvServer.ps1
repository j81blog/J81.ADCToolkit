function Invoke-ADCAddCSvServer {
    <#
        .SYNOPSIS
            Add a new Content Switch Virtual Server
        .DESCRIPTION
            Add a new Content Switch Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters.
        .PARAMETER IPAddress
            IP address of the content switching virtual server
        .PARAMETER Port
            Specify a port number for the virtual server
        .PARAMETER ServiceType
            Protocol used by the virtual server.
        .PARAMETER Comment
            Information about this virtual server.
        .PARAMETER PassThru
            Return details about the created virtual server.
        .EXAMPLE
            Invoke-ADCAddCSvServer -Name "cs_domain.com_https" -IPAddress 10.0.1.51 -Port 80 -ServiceType HTTP -Comment "HTTP vServer for domain.com"
        .NOTES
            File Name : Invoke-ADCAddCSvServer
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        [string[]]$Name = (Read-Host -Prompt "CS Virtual Server Name"),
        
        [Parameter(Mandatory = $true)]
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$IPAddress,
        
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, 65534)]
        [int]$Port = 80,
        
        [ValidateLength(0, 256)]
        [string]$Comment = "",
        
        [ValidateSet('HTTP', 'SSL', 'TCP', 'FTP', 'RTSP', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'DNS_TCP', 'ORACLE', 'SMPP', 'PROXY', 'MONGO', 'MONGO_TLS')]
        [string]$ServiceType = 'HTTP',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]
        $State = 'ENABLED',

        [Switch]$PassThru

    )
    begin {
        Write-Verbose "Invoke-ADCAddCSvServer: Starting"
    }
    process {
        foreach ($item in $Name) {
            try {
                $Payload = @{
                    name        = $item
                    servicetype = $ServiceType
                    ipv46       = $IPAddress
                    port        = $Port
                    comment     = $Comment
                    state       = $State
                }
                if ($PSCmdlet.ShouldProcess($item, 'Create Content Switch Virtual Server')) {
                    $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver -Payload $Payload -Action add -GetWarning

                    if ($PSBoundParameters.ContainsKey('PassThru')) {
                        Write-Output (Invoke-ADCGetCSvServer -Name $item)
                    }
                }
            } catch {
                Write-Verbose "ERROR: $($_.Exception.Message)"
                throw $_
            }
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddCSvServer: Finished"
    }
}
