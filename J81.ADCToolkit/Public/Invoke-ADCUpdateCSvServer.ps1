function Invoke-ADCUpdateCSvServer {
    <#
        .SYNOPSIS
            Update an existing Content Switch Virtual Server
        .DESCRIPTION
            Update an existing Content Switch Virtual Server
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name for the virtual server. 
        .PARAMETER IPAddress
            IPv4 or IPv6 address to assign to the virtual server.
        .PARAMETER Port
            Port number for the virtual server.
        .PARAMETER Comment
            Information about this virtual server.
        .PARAMETER PassThru
            Return details about the created virtual server.
        .EXAMPLE
            Invoke-ADCUpdateCSvServer -Name "cs_domain.com_https" -IPAddress 10.2.0.11
        .NOTES
            File Name : Invoke-ADCUpdateCSvServer
            Version   : v0.3
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name = (Read-Host -Prompt "LB Virtual Server Name"),
        
        [ValidateScript( { $_ -match [IPAddress]$_ })]
        [string]$IPAddress,
        
        [ValidateRange(1, 65534)]
        [int]$Port = 80,
        
        [ValidateLength(0, 256)]
        [string]$Comment = "",
        
        [Switch]$PassThru
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCSvServer: Starting"
    }
    process {
        $Payload = @{
            name = $Name
        }    
        try {
            if ($PSBoundParameters.ContainsKey('IPAddress')) { $Payload.Add('ipv46', $IPAddress) }
            if ($PSBoundParameters.ContainsKey('Port')) { $Payload.Add('port', $Port) }
            if ($PSBoundParameters.ContainsKey('Comment')) { $Payload.Add('comment', $Comment) }
            if ($PSCmdlet.ShouldProcess($Name, 'Update Content Switch Virtual Server')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type csvserver -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) { 
                    Write-Output (Invoke-ADCGetCSvServer -Name $Name)
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
        Write-Verbose "Invoke-ADCUpdateCSvServer: Finished"
    }
}
