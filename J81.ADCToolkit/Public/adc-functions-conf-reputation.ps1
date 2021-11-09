function Invoke-ADCUpdateReputationsettings {
<#
    .SYNOPSIS
        Update Reputation configuration Object
    .DESCRIPTION
        Update Reputation configuration Object 
    .PARAMETER proxyserver 
        Proxy server IP to get Reputation data.  
        Minimum length = 1 
    .PARAMETER proxyport 
        Proxy server port.
    .EXAMPLE
        Invoke-ADCUpdateReputationsettings 
    .NOTES
        File Name : Invoke-ADCUpdateReputationsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$proxyserver ,

        [double]$proxyport 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateReputationsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('proxyserver')) { $Payload.Add('proxyserver', $proxyserver) }
            if ($PSBoundParameters.ContainsKey('proxyport')) { $Payload.Add('proxyport', $proxyport) }
 
            if ($PSCmdlet.ShouldProcess("reputationsettings", "Update Reputation configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type reputationsettings -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
            Write-Output $result

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUpdateReputationsettings: Finished"
    }
}

function Invoke-ADCUnsetReputationsettings {
<#
    .SYNOPSIS
        Unset Reputation configuration Object
    .DESCRIPTION
        Unset Reputation configuration Object 
   .PARAMETER proxyserver 
       Proxy server IP to get Reputation data. 
   .PARAMETER proxyport 
       Proxy server port.
    .EXAMPLE
        Invoke-ADCUnsetReputationsettings 
    .NOTES
        File Name : Invoke-ADCUnsetReputationsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),

        [Boolean]$proxyserver ,

        [Boolean]$proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetReputationsettings: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('proxyserver')) { $Payload.Add('proxyserver', $proxyserver) }
            if ($PSBoundParameters.ContainsKey('proxyport')) { $Payload.Add('proxyport', $proxyport) }
            if ($PSCmdlet.ShouldProcess("reputationsettings", "Unset Reputation configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type reputationsettings -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $response
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCUnsetReputationsettings: Finished"
    }
}

function Invoke-ADCGetReputationsettings {
<#
    .SYNOPSIS
        Get Reputation configuration object(s)
    .DESCRIPTION
        Get Reputation configuration object(s)
    .PARAMETER GetAll 
        Retreive all reputationsettings object(s)
    .PARAMETER Count
        If specified, the count of the reputationsettings object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetReputationsettings
    .EXAMPLE 
        Invoke-ADCGetReputationsettings -GetAll
    .EXAMPLE
        Invoke-ADCGetReputationsettings -name <string>
    .EXAMPLE
        Invoke-ADCGetReputationsettings -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetReputationsettings
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings/
        Requires  : PowerShell v5.1 and up
                    ADC 11.x and up
    .LINK
        https://blog.j81.nl
#>
    [CmdletBinding(DefaultParameterSetName = "Getall")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [parameter(DontShow)]
        [hashtable]$ADCSession = (Invoke-ADCGetActiveSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetReputationsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all reputationsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reputationsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reputationsettings objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reputationsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving reputationsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetReputationsettings: Ended"
    }
}


