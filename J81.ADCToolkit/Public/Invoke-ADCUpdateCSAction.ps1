function Invoke-ADCUpdateCSAction {
    <#
    .SYNOPSIS
        Update an existing Content-Switching Action resource
    .DESCRIPTION
        Update an existing Content-Switching Action resource
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Name for the content switching policy.
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
        Invoke-ADCUpdateCSAction -PolicyName csp_www.domain.com_https -Rule 'HTTP.REQ.HOSTNAME.TO_LOWER.CONTAINS("www.domain.com")'
    .NOTES
        File Name : Invoke-ADCUpdateCSAction
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

        [Parameter(Mandatory = $true)]
        [String]$Name = (Read-Host -Prompt "Name of the existing Content Switch Action"),
        
        [String]$TargetLBvServer,
        
        [String]$TargetvServer,
        
        [ValidateLength(1, 1499)]
        [String]$TargetvServerExpr,
        
        [String]$Comment,

        [Switch]$PassThru

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCSAction: Starting"
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
 
            if ($PSCmdlet.ShouldProcess($Name, 'Updating Content Switch Action')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type csaction -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCSAction -Name $Name)
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
        Write-Verbose "Invoke-ADCUpdateCSAction: Finished"
    }
}
