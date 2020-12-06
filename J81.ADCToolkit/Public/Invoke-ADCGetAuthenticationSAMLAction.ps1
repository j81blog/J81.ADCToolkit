function Invoke-ADCGetAuthenticationSAMLAction {
    <#
        .SYNOPSIS
            Get Authentication SAML Action details
        .DESCRIPTION
            Get Authentication SAML Action details
        .PARAMETER ADCSession
            Specify an active session (Output from Connect-ADCNode)
        .PARAMETER PName
            Authentication SAML Action Name
        .PARAMETER Count
            If specified, the number of Authentication SAML Actions will be returned
        .PARAMETER Filter
            Specify a filter
            -Filter @{"samlsigningcertname"="AzureAD"}
        .PARAMETER Summary
            When specified, only a subset of information is returned
        .EXAMPLE
            Invoke-ADCGetAuthenticationSAMLAction
        .EXAMPLE
            Invoke-ADCGetAuthenticationSAMLAction -Name "aua_AzureAD_saml"
        .EXAMPLE
            Invoke-ADCGetAuthenticationSAMLAction -Filter @{"samlsigningcertname"="AzureAD"}
        .NOTES
            File Name : Invoke-ADCGetAuthenticationSAMLAction
            Version   : v0.2
            Author    : John Billekens
            Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
            Requires  : PowerShell v5.1 and up
                        ADC 11.x and up
        .LINK
            https://blog.j81.nl
        #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]  
    Param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [Parameter(ParameterSetName = "GetResource", Mandatory = $true)]
        [String]$PolicyName,
            
        [Parameter(ParameterSetName = "GetAll")]
        [Switch]$Count = $false,
			
        [hashtable]$Filter = @{ },
    
        [Switch]$Summary = $false
    )
    begin {
        Write-Verbose "Invoke-ADCGetAuthenticationSAMLAction: Starting"
    }
    process {
        try {
            $Query = @{}
            if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ "count" = "yes" } }

            if ($PSBoundParameters.ContainsKey('PolicyName')) {
                Write-Verbose "Retrieving Authentication SAML Action `"$PolicyName`""
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type authenticationsamlaction -Resource $PolicyName -Summary:$Summary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving all Authentication SAML Actions"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method Get -Type authenticationsamlaction -Summary:$Summary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAuthenticationSAMLAction: Finished"
    }
}
