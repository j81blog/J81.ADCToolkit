function Invoke-ADCUpdateReputationsettings {
    <#
    .SYNOPSIS
        Update Reputation configuration Object.
    .DESCRIPTION
        Configuration for Reputation service settings resource.
    .PARAMETER Proxyserver 
        Proxy server IP to get Reputation data. 
    .PARAMETER Proxyport 
        Proxy server port.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateReputationsettings 
        An example how to update reputationsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateReputationsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Proxyserver,

        [double]$Proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateReputationsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSCmdlet.ShouldProcess("reputationsettings", "Update Reputation configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type reputationsettings -Payload $payload -GetWarning
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
        Unset Reputation configuration Object.
    .DESCRIPTION
        Configuration for Reputation service settings resource.
    .PARAMETER Proxyserver 
        Proxy server IP to get Reputation data. 
    .PARAMETER Proxyport 
        Proxy server port.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetReputationsettings 
        An example how to unset reputationsettings configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetReputationsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Low")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),

        [Boolean]$proxyserver,

        [Boolean]$proxyport 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetReputationsettings: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('proxyserver') ) { $payload.Add('proxyserver', $proxyserver) }
            if ( $PSBoundParameters.ContainsKey('proxyport') ) { $payload.Add('proxyport', $proxyport) }
            if ( $PSCmdlet.ShouldProcess("reputationsettings", "Unset Reputation configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type reputationsettings -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Get Reputation configuration object(s).
    .DESCRIPTION
        Configuration for Reputation service settings resource.
    .PARAMETER GetAll 
        Retrieve all reputationsettings object(s).
    .PARAMETER Count
        If specified, the count of the reputationsettings object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReputationsettings
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetReputationsettings -GetAll 
        Get all reputationsettings data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReputationsettings -name <string>
        Get reputationsettings object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetReputationsettings -Filter @{ 'name'='<value>' }
        Get reputationsettings data with a filter.
    .NOTES
        File Name : Invoke-ADCGetReputationsettings
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/reputation/reputationsettings/
        Requires  : PowerShell v5.1 and up
                    ADC 13.x and up.
                    ADC 12 and lower may work, not guaranteed.
    .LINK
        https://blog.j81.nl
    #>
    [CmdletBinding(DefaultParameterSetName = "GetAll")]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPasswordParams', '')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseBOMForUnicodeEncodedFile', '')]
    param(
        [Parameter(DontShow)]
        [Object]$ADCSession = (Get-ADCSession),
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetReputationsettings: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all reputationsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for reputationsettings objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving reputationsettings objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving reputationsettings configuration for property ''"

            } else {
                Write-Verbose "Retrieving reputationsettings configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type reputationsettings -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


