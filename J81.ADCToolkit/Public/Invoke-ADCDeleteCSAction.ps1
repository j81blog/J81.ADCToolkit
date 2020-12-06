function Invoke-ADCDeleteCSAction {
    <#
    .SYNOPSIS
        Delete Content Switch Action
    .DESCRIPTION
        Delete Content Switch Action
    .PARAMETER ADCSession
        Specify an active session (Output from Connect-ADCNode)
    .PARAMETER Name
        Specify the Content Switch Action Name
    .EXAMPLE
        Invoke-ADCDeleteCSAction
    .EXAMPLE
        Invoke-ADCDeleteCSAction -Name "csa_www.domain.com_https"
    .NOTES
        File Name : Invoke-ADCDeleteCSAction
        Version   : v0.2
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCDeleteCSAction: Starting"
    }
    process {
        Write-Verbose "Deleting `"$Name`""
        if ($PSCmdlet.ShouldProcess($Name, "Delete Content Switch Action")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csaction -Resource $Name -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCDeleteCSAction: Finished"
    }
}
