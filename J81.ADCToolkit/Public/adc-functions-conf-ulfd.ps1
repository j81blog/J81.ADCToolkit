function Invoke-ADCAddUlfdserver {
<#
    .SYNOPSIS
        Add Ulfd configuration Object
    .DESCRIPTION
        Add Ulfd configuration Object 
    .PARAMETER loggerip 
        IP address of the server where ulfd service is running.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created ulfdserver item.
    .EXAMPLE
        Invoke-ADCAddUlfdserver -loggerip <string>
    .NOTES
        File Name : Invoke-ADCAddUlfdserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$loggerip ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddUlfdserver: Starting"
    }
    process {
        try {
            $Payload = @{
                loggerip = $loggerip
            }

 
            if ($PSCmdlet.ShouldProcess("ulfdserver", "Add Ulfd configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ulfdserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetUlfdserver -Filter $Payload)
                } else {
                    Write-Output $result
                }

            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddUlfdserver: Finished"
    }
}

function Invoke-ADCDeleteUlfdserver {
<#
    .SYNOPSIS
        Delete Ulfd configuration Object
    .DESCRIPTION
        Delete Ulfd configuration Object
    .PARAMETER loggerip 
       IP address of the server where ulfd service is running.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteUlfdserver -loggerip <string>
    .NOTES
        File Name : Invoke-ADCDeleteUlfdserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(Mandatory = $true)]
        [string]$loggerip 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteUlfdserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$loggerip", "Delete Ulfd configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ulfdserver -NitroPath nitro/v1/config -Resource $loggerip -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteUlfdserver: Finished"
    }
}

function Invoke-ADCGetUlfdserver {
<#
    .SYNOPSIS
        Get Ulfd configuration object(s)
    .DESCRIPTION
        Get Ulfd configuration object(s)
    .PARAMETER loggerip 
       IP address of the server where ulfd service is running. 
    .PARAMETER GetAll 
        Retreive all ulfdserver object(s)
    .PARAMETER Count
        If specified, the count of the ulfdserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetUlfdserver
    .EXAMPLE 
        Invoke-ADCGetUlfdserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetUlfdserver -Count
    .EXAMPLE
        Invoke-ADCGetUlfdserver -name <string>
    .EXAMPLE
        Invoke-ADCGetUlfdserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetUlfdserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$loggerip,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetUlfdserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all ulfdserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ulfdserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ulfdserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ulfdserver configuration for property 'loggerip'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Resource $loggerip -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ulfdserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetUlfdserver: Ended"
    }
}


