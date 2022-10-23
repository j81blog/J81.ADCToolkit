function Invoke-ADCAddUlfdserver {
    <#
    .SYNOPSIS
        Add Ulfd configuration Object.
    .DESCRIPTION
        Configuration for ulfd server resource.
    .PARAMETER Loggerip 
        IP address of the server where ulfd service is running. 
    .PARAMETER PassThru 
        Return details about the created ulfdserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddUlfdserver -loggerip <string>
        An example how to add ulfdserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddUlfdserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Loggerip,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddUlfdserver: Starting"
    }
    process {
        try {
            $payload = @{ loggerip = $loggerip }

            if ( $PSCmdlet.ShouldProcess("ulfdserver", "Add Ulfd configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type ulfdserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetUlfdserver -Filter $payload)
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
        Delete Ulfd configuration Object.
    .DESCRIPTION
        Configuration for ulfd server resource.
    .PARAMETER Loggerip 
        IP address of the server where ulfd service is running.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteUlfdserver -Loggerip <string>
        An example how to delete ulfdserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteUlfdserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(Mandatory)]
        [string]$Loggerip 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteUlfdserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$loggerip", "Delete Ulfd configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type ulfdserver -NitroPath nitro/v1/config -Resource $loggerip -Arguments $arguments
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
        Get Ulfd configuration object(s).
    .DESCRIPTION
        Configuration for ulfd server resource.
    .PARAMETER Loggerip 
        IP address of the server where ulfd service is running. 
    .PARAMETER GetAll 
        Retrieve all ulfdserver object(s).
    .PARAMETER Count
        If specified, the count of the ulfdserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUlfdserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUlfdserver -GetAll 
        Get all ulfdserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetUlfdserver -Count 
        Get the number of ulfdserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUlfdserver -name <string>
        Get ulfdserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetUlfdserver -Filter @{ 'name'='<value>' }
        Get ulfdserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetUlfdserver
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/ulfd/ulfdserver/
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

        [Parameter(ParameterSetName = 'GetByResource')]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Loggerip,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all ulfdserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for ulfdserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving ulfdserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving ulfdserver configuration for property 'loggerip'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Resource $loggerip -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving ulfdserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type ulfdserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


