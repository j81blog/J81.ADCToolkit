function Invoke-ADCAddRouterdynamicrouting {
    <#
    .SYNOPSIS
        Add Router configuration Object.
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed.
    .EXAMPLE
        PS C:\>Invoke-ADCAddRouterdynamicrouting 
        An example how to add routerdynamicrouting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$Commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCAddRouterdynamicrouting: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('commandstring') ) { $payload.Add('commandstring', $commandstring) }
            if ( $PSCmdlet.ShouldProcess("routerdynamicrouting", "Add Router configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type routerdynamicrouting -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                Write-Output $result
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            throw $_
        }
    }
    end {
        Write-Verbose "Invoke-ADCAddRouterdynamicrouting: Finished"
    }
}

function Invoke-ADCDeleteRouterdynamicrouting {
    <#
    .SYNOPSIS
        Delete Router configuration Object.
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteRouterdynamicrouting 
        An example how to delete routerdynamicrouting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$Commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRouterdynamicrouting: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Commandstring') ) { $arguments.Add('commandstring', $Commandstring) }
            if ( $PSCmdlet.ShouldProcess("routerdynamicrouting", "Delete Router configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type routerdynamicrouting -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteRouterdynamicrouting: Finished"
    }
}

function Invoke-ADCUpdateRouterdynamicrouting {
    <#
    .SYNOPSIS
        Update Router configuration Object.
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateRouterdynamicrouting 
        An example how to update routerdynamicrouting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$Commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRouterdynamicrouting: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('commandstring') ) { $payload.Add('commandstring', $commandstring) }
            if ( $PSCmdlet.ShouldProcess("routerdynamicrouting", "Update Router configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type routerdynamicrouting -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateRouterdynamicrouting: Finished"
    }
}

function Invoke-ADCUnsetRouterdynamicrouting {
    <#
    .SYNOPSIS
        Unset Router configuration Object.
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetRouterdynamicrouting 
        An example how to unset routerdynamicrouting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting
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

        [Boolean]$commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRouterdynamicrouting: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('commandstring') ) { $payload.Add('commandstring', $commandstring) }
            if ( $PSCmdlet.ShouldProcess("routerdynamicrouting", "Unset Router configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type routerdynamicrouting -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetRouterdynamicrouting: Finished"
    }
}

function Invoke-ADCApplyRouterdynamicrouting {
    <#
    .SYNOPSIS
        Apply Router configuration Object.
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed.
    .EXAMPLE
        PS C:\>Invoke-ADCApplyRouterdynamicrouting 
        An example how to apply routerdynamicrouting configuration Object(s).
    .NOTES
        File Name : Invoke-ADCApplyRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$Commandstring 

    )
    begin {
        Write-Verbose "Invoke-ADCApplyRouterdynamicrouting: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('commandstring') ) { $payload.Add('commandstring', $commandstring) }
            if ( $PSCmdlet.ShouldProcess($Name, "Apply Router configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type routerdynamicrouting -Action apply -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCApplyRouterdynamicrouting: Finished"
    }
}

function Invoke-ADCGetRouterdynamicrouting {
    <#
    .SYNOPSIS
        Get Router configuration object(s).
    .DESCRIPTION
        Configuration for dynamic routing config resource.
    .PARAMETER Commandstring 
        command to be executed. 
    .PARAMETER Nodeid 
        Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retrieve all routerdynamicrouting object(s).
    .PARAMETER Count
        If specified, the count of the routerdynamicrouting object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRouterdynamicrouting
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRouterdynamicrouting -GetAll 
        Get all routerdynamicrouting data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetRouterdynamicrouting -Count 
        Get the number of routerdynamicrouting objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRouterdynamicrouting -name <string>
        Get routerdynamicrouting object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetRouterdynamicrouting -Filter @{ 'name'='<value>' }
        Get routerdynamicrouting data with a filter.
    .NOTES
        File Name : Invoke-ADCGetRouterdynamicrouting
        Version   : v2210.2317
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$Commandstring,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$Nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetRouterdynamicrouting: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all routerdynamicrouting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for routerdynamicrouting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving routerdynamicrouting objects by arguments"
                $arguments = @{ } 
                if ( $PSBoundParameters.ContainsKey('commandstring') ) { $arguments.Add('commandstring', $commandstring) } 
                if ( $PSBoundParameters.ContainsKey('nodeid') ) { $arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving routerdynamicrouting configuration for property ''"

            } else {
                Write-Verbose "Retrieving routerdynamicrouting configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetRouterdynamicrouting: Ended"
    }
}


