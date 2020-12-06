function Invoke-ADCUnsetCSPolicy {
    <#
    .SYNOPSIS
        Unset a Content-Switching Policy resource
    .DESCRIPTION
        Unset a Content-Switching Policy resource
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER PolicyName
        Name for the content switching policy.
    .PARAMETER Url
        Unset the URL string.
    .PARAMETER Rule
        Unset the Expression.
    .PARAMETER Domain
        Unset the domain name.
    .PARAMETER LogAction
        Unset the log action.
    .EXAMPLE
        Invoke-ADCUnsetCSPolicy -PolicyName "csp_www.domain.com_https" -Url
    .NOTES
        File Name : Invoke-ADCUnsetCSPolicy
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        [String]$PolicyName = (Read-Host -Prompt "Name of the existing Content Switch Policy"),
        
        [Switch]$Url,
        
        [Switch]$Rule,
        
        [Switch]$Domain,

        [Switch]$LogAction

    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCSPolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $PolicyName
            }
            if ($PSBoundParameters.ContainsKey('Url')) { $Payload.Add('url', ($Url.ToString()).ToLower()) }
            if ($PSBoundParameters.ContainsKey('Rule')) { $Payload.Add('rule', ($Rule.ToString()).ToLower()) }
            if ($PSBoundParameters.ContainsKey('Domain')) { $Payload.Add('domain', ($Domain.ToString()).ToLower()) }
            if ($PSBoundParameters.ContainsKey('LogAction')) { $Payload.Add('logaction', ($LogAction.ToString()).ToLower()) }
 
            if ($PSCmdlet.ShouldProcess($PolicyName, 'Unset Content Switch Policy')) {
                $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cspolicy -Action unset -Payload $Payload -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetCSPolicy: Finished"
    }
}
