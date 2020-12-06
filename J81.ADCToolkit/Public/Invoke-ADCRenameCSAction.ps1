function Invoke-ADCRenameCSAction {
    <#
        .SYNOPSIS
            Rename Content Switch Action
        .DESCRIPTION
            Rename Content Switch Action
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER Name
            Name of the Content Switching Action.
        .PARAMETER NewName
            The new name for the Content Switching Action. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters.
        .EXAMPLE
            Invoke-ADCRenameCSAction
        .EXAMPLE
            Invoke-ADCRenameCSAction -Name "csa_www.domain1.com_https" -NewName "csa_www.domain2.com_https"
        .NOTES
            File Name : Invoke-ADCRenameCSAction
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
        [String]$Name,
            
        [ValidateLength(1, 65534)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][s]|[:]|[@]|[=]|[-])+)$', Options = 'None')]
        [Parameter(Mandatory = $true)]
        [String]$NewName
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCSAction: Starting"
    }
    process {
        $Payload = @{
            name    = $Name
            newname = $NewName
        }
        Write-Verbose "Renaming `"$Name`" to `"$NewName`""
        if ($PSCmdlet.ShouldProcess($Name, "Rename Content Switch Action")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csaction -Action rename -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCRenameCSAction: Finished"
    }
}
