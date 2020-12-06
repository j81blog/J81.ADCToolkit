function Invoke-ADCAddCSAction {
    <#
    .SYNOPSIS
        Add a new Content-Switching Action resource
    .DESCRIPTION
        Add a new Content-Switching Action resource
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, 
        underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.
        Can be changed after the content switching action is created.
        Minimum length = 1
    .PARAMETER TargetLBvServer
        Name of the load balancing virtual server to which the content is switched.
    .PARAMETER TargetvServer
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched.
    .PARAMETER TargetvServerExpr
        Information about this content switching action.
        Maximum length = 1499
    .PARAMETER Comment
        Comments associated with this cs action.
    .PARAMETER PassThru
        Return details about the created CertKey.
    .EXAMPLE
        Invoke-ADCAddCSAction -Name csa_www.domain.com_https -TargetLBvServer lb_www.domain.com_https -Comment "www.domain.com Web Server"
    .NOTES
        File Name : Invoke-ADCAddCSAction
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateLength(1, 65534)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][s]|[:]|[@]|[=]|[-])+)$', Options = 'None')]
        [Parameter(Mandatory = $true)]
        [String]$Name = (Read-Host -Prompt "Name of the new Content Switch Action"),
        
        [ValidateLength(1, 208)]
        [String]$TargetLBvServer,
        
        [String]$TargetvServer,
        
        [ValidateLength(1, 1499)]
        [String]$TargetvServerExpr,

        [String]$Comment,

        [Switch]$PassThru

    )
    begin {
        Write-Verbose "Invoke-ADCAddCSAction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $Name
            }
            if ($PSBoundParameters.ContainsKey('TargetLBvServer')) { $Payload.Add('targetlbvserver', $TargetLBvServer) }
            if ($PSBoundParameters.ContainsKey('TargetvServer')) { $Payload.Add('targetvserver', $TargetvServer) }
            if ($PSBoundParameters.ContainsKey('TargetvServerExpr')) { $Payload.Add('targetvserverexpr', $TargetvServerExpr) }
            if ($PSBoundParameters.ContainsKey('Comment')) { $Payload.Add('comment', $Comment) }
 
            if ($PSCmdlet.ShouldProcess($Name, 'Create Content Switch Action')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csaction -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSSLCertKey -Name $Name)
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
        Write-Verbose "Invoke-ADCAddCSAction: Finished"
    }
}
