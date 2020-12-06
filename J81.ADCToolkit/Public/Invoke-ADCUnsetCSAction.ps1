function Invoke-ADCUnsetCSAction {
    <#
    .SYNOPSIS
        Unset a Content-Switching Action resource
    .DESCRIPTION
        Unset a Content-Switching Action resource
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Name for the content switching action.
    .PARAMETER Comment
        Comments associated with this cs action.
    .EXAMPLE
        Invoke-ADCUnsetCSAction -Name "csa_www.domain.com_https" -Comment
    .NOTES
        File Name : Invoke-ADCUnsetCSAction
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
        
        [Switch]$Comment

    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCSAction: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $PolicyName
            }
            if ($PSBoundParameters.ContainsKey('Comment')) { $Payload.Add('comment', ($LogAction.ToString()).ToLower()) }
 
            if ($PSCmdlet.ShouldProcess($Name, 'Unset Content Switch Action')) {
                $null = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csaction -Action unset -Payload $Payload -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetCSAction: Finished"
    }
}
