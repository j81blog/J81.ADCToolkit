function Invoke-ADCUpdateAdmparameter {
    <#
    .SYNOPSIS
        Update Adm configuration Object.
    .DESCRIPTION
        Configuration for ADM parameter resource.
    .PARAMETER Admserviceconnect 
        Parameter to enable/disable Citrix ADM Service Connect. This feature helps you discover your Citrix ADC instances effortlessly on Citrix ADM service and get insights and curated machine learning based recommendations for applications and Citrix ADC infrastructure. This feature lets the Citrix ADC instance automatically send system, usage and telemetry data to Citrix ADM service. View here [https://docs.citrix.com/en-us/citrix-adc/13/data-governance.html] to learn more about this feature. Use of this feature is subject to the Citrix End User ServiceAgreement. View here [https://www.citrix.com/buy/licensing/agreements.html]. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAdmparameter 
        An example how to update admparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAdmparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/adm/admparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Admserviceconnect 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAdmparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('admserviceconnect') ) { $payload.Add('admserviceconnect', $admserviceconnect) }
            if ( $PSCmdlet.ShouldProcess("admparameter", "Update Adm configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type admparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateAdmparameter: Finished"
    }
}

function Invoke-ADCUnsetAdmparameter {
    <#
    .SYNOPSIS
        Unset Adm configuration Object.
    .DESCRIPTION
        Configuration for ADM parameter resource.
    .PARAMETER Admserviceconnect 
        Parameter to enable/disable Citrix ADM Service Connect. This feature helps you discover your Citrix ADC instances effortlessly on Citrix ADM service and get insights and curated machine learning based recommendations for applications and Citrix ADC infrastructure. This feature lets the Citrix ADC instance automatically send system, usage and telemetry data to Citrix ADM service. View here [https://docs.citrix.com/en-us/citrix-adc/13/data-governance.html] to learn more about this feature. Use of this feature is subject to the Citrix End User ServiceAgreement. View here [https://www.citrix.com/buy/licensing/agreements.html]. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAdmparameter 
        An example how to unset admparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAdmparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/adm/admparameter
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

        [Boolean]$admserviceconnect 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAdmparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('admserviceconnect') ) { $payload.Add('admserviceconnect', $admserviceconnect) }
            if ( $PSCmdlet.ShouldProcess("admparameter", "Unset Adm configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type admparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAdmparameter: Finished"
    }
}

function Invoke-ADCGetAdmparameter {
    <#
    .SYNOPSIS
        Get Adm configuration object(s).
    .DESCRIPTION
        Configuration for ADM parameter resource.
    .PARAMETER GetAll 
        Retrieve all admparameter object(s).
    .PARAMETER Count
        If specified, the count of the admparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAdmparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAdmparameter -GetAll 
        Get all admparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAdmparameter -name <string>
        Get admparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAdmparameter -Filter @{ 'name'='<value>' }
        Get admparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAdmparameter
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/adm/admparameter/
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
        Write-Verbose "Invoke-ADCGetAdmparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all admparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type admparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for admparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type admparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving admparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type admparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving admparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving admparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type admparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAdmparameter: Ended"
    }
}


