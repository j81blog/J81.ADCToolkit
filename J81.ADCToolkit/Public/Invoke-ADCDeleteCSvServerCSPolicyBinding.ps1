function Invoke-ADCDeleteCSvServerCSPolicyBinding {
    <#
    .SYNOPSIS
        Delete a Content Switch Policy Binding on an Content Switch vServer
    .DESCRIPTION
        Delete a Content Switch Policy Binding on an Content Switch vServer
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Name of the content switching virtual server to which the content switching policy applies.
        Minimum length = 1
    .PARAMETER PolicyName
        Name of the Content Switch Policy
    .PARAMETER Priority
        Priority of the policy.
    .PARAMETER BindPoint
        The bindpoint to which the policy is bound.
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST
    .EXAMPLE
        Invoke-ADCDeleteCSvServerCSPolicyBinding 
    .NOTES
        File Name : Invoke-ADCDeleteCSvServerCSPolicyBinding
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
        
        [Double]$Priority,
        
        [ValidateSet("REQUEST", "RESPONSE", "ICA_REQUEST", "OTHERTCP_REQUEST")]
        [string]$BindPoint
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCSvServerCSPolicyBinding: Starting"
    }
    process {
        try {
            $Args = @{ }
            if ($PSBoundParameters.ContainsKey('PolicyName')) { $Args.Add('policyname', $PolicyName) }
            if ($PSBoundParameters.ContainsKey('Priority')) { $Args.Add('priority', $Priority) }
            if ($PSBoundParameters.ContainsKey('BindPoint')) { $Args.Add('bindpoint', $BindPoint) }
            
            if ($PSCmdlet.ShouldProcess($Name, 'Delete Content Switch Policy Binding')) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cspolicy_binding -Resource $Name -Arguments $Args -GetWarning
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteCSvServerCSPolicyBinding: Finished"
    }
}
