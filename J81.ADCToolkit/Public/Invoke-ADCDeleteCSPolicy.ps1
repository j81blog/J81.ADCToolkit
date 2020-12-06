function Invoke-ADCDeleteCSPolicy {
    <#
    .SYNOPSIS
        Delete Content Switch Policy
    .DESCRIPTION
        Delete Content Switch Policy
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER PolicyName
        Specify the Content Switch Policy Name
    .EXAMPLE
        Invoke-ADCDeleteCSPolicy
    .EXAMPLE
        Invoke-ADCDeleteCSPolicy -Name "csp_www.domain.com_https"
    .NOTES
        File Name : Invoke-ADCDeleteCSPolicy
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]  
    Param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCSPolicy: Starting"
    }
    process {
        Write-Verbose "Deleting `"$PolicyName`""
        if ($PSCmdlet.ShouldProcess($PolicyName, "Delete Content Switch Policy")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicy -Resource $PolicyName -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteCSPolicy: Finished"
    }
}
