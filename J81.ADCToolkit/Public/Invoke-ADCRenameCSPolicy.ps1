function Invoke-ADCRenameCSPolicy {
    <#
        .SYNOPSIS
            Rename Content Switch Policy
        .DESCRIPTION
            Rename Content Switch Policy
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER PolicyName
            Name of the Content Switching Policy.
        .PARAMETER NewName
            The new name for the Content Switching Policy. Must begin with an ASCII alphanumeric or underscore (_) character, 
            and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), 
            equal sign (=), and hyphen (-) characters.
        .EXAMPLE
            Invoke-ADCRenameCSPolicy
        .EXAMPLE
            Invoke-ADCRenameCSPolicy -PolicyName "csp_www.domain1.com_https" -NewName "csp_www.domain2.com_https"
        .NOTES
            File Name : Invoke-ADCRenameCSPolicy
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
        [String]$PolicyName,
            
        [ValidateLength(1, 65534)]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([\x00-\x7F]|[_]|[#]|[.][s]|[:]|[@]|[=]|[-])+)$', Options = 'None')]
        [Parameter(Mandatory = $true)]
        [String]$NewName
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCSPolicy: Starting"
    }
    process {
        $Payload = @{
            policyname = $PolicyName
            newname    = $NewName
        }
        Write-Verbose "Renaming `"$PolicyName`" to `"$NewName`""
        if ($PSCmdlet.ShouldProcess($PolicyName, "Rename Content Switch Policy")) {
            $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cspolicy -Action rename -Payload $Payload -GetWarning
            Write-Output $response
        }
    }
    end {
        Write-Verbose "Invoke-ADCRenameCSPolicy: Finished"
    }
}
