function Invoke-ADCAddCSvServerCSPolicyBinding {
    <#
    .SYNOPSIS
        Add a new Content Switch Policy Binding to an existing Content Switch vServer
    .DESCRIPTION
        Add a new Content Switch Policy Binding to an existing Content Switch vServer
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Name of the content switching virtual server to which the content switching policy applies.
        Minimum length = 1
    .PARAMETER PolicyName
        Name of the Content Switch Policy
    .PARAMETER TargetLBvServer
        Target Load Balance Virtual Server name.
    .PARAMETER Priority
        Priority for the policy.
    .PARAMETER GoToPriorityExpression
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE.
    .PARAMETER BindPoint
        The bindpoint to which the policy is bound.
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST
    .PARAMETER Invoke
        Invoke flag.
    .PARAMETER LabelType
        The invocation type.
        Possible values = reqvserver, resvserver, policylabel
    .PARAMETER LabelName
        Name of the label invoked.
    .PARAMETER PassThru
        Return details about the created CertKey.
    .EXAMPLE
        Invoke-ADCAddCSvServerCSPolicyBinding -Name "cs_domain.com_https" -PolicyName "csp_www.domain.com_https" -Priority 110
    .NOTES
        File Name : Invoke-ADCAddCSvServerCSPolicyBinding
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        [parameter(Mandatory = $true)]
        [String]$Name,
        
        [String]$PolicyName,
        
        [String]$TargetLBvServer,
        
        [Double]$Priority,
        
        [String]$GoToPriorityExpression,

        [Switch]$Invoke,

        [ValidateSet("REQUEST", "RESPONSE", "ICA_REQUEST", "OTHERTCP_REQUEST")]
        [string]$BindPoint,

        [ValidateSet("reqvserver", "resvserver", "policylabel")]
        [String]$LabelType,

        [Switch]$LabelName,

        [Switch]$PassThru

    )
    begin {
        Write-Verbose "Invoke-ADCAddCSvServerCSPolicyBinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $Name
            }
            $Filter = @{ }
            if ($PSBoundParameters.ContainsKey('PolicyName')) { 
                $Payload.Add('policyname', $PolicyName) 
                $Filter.Add('policyname', $PolicyName) 
            }
            if ($PSBoundParameters.ContainsKey('TargetLBvServer')) { 
                $Payload.Add('targetlbvserver', $TargetLBvServer) 
                $Filter.Add('targetlbvserver', $TargetLBvServer) 
            }
            if ($PSBoundParameters.ContainsKey('Priority')) { 
                $Payload.Add('priority', $Priority) 
                $Filter.Add('priority', $Priority) 
            }
            if ($PSBoundParameters.ContainsKey('GoToPriorityExpression')) { 
                $Payload.Add('gotopriorityexpression', $GoToPriorityExpression)
                $Filter.Add('gotopriorityexpression', $GoToPriorityExpression)
            }
            if ($PSBoundParameters.ContainsKey('Invoke')) { 
                $Payload.Add('invoke', ($Invoke.ToString()).ToLower()) 
                $Filter.Add('invoke', ($Invoke.ToString()).ToLower()) 
            }
            if ($PSBoundParameters.ContainsKey('BindPoint')) { 
                $Payload.Add('bindpoint', $BindPoint) 
                $Filter.Add('bindpoint', $BindPoint) 
            }
            if ($PSBoundParameters.ContainsKey('LabelType')) { 
                $Payload.Add('labeltype', $LabelType) 
                $Filter.Add('labeltype', $LabelType) 
            }
            if ($PSBoundParameters.ContainsKey('LabelName')) { 
                $Payload.Add('labelname', $LabelName) 
                $Filter.Add('labelname', $LabelName) 
            }
            
            if ($PSCmdlet.ShouldProcess($Name, 'Create Content Switch Policy Binding')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver_cspolicy_binding -Payload $Payload -GetWarning
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCSvServerCSPolicyBinding -Name $Name -Filter $Filter)
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
        Write-Verbose "Invoke-ADCAddCSvServerCSPolicyBinding: Finished"
    }
}
