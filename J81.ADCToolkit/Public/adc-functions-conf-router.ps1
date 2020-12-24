function Invoke-ADCAddRouterdynamicrouting {
<#
    .SYNOPSIS
        Add Router configuration Object
    .DESCRIPTION
        Add Router configuration Object 
    .PARAMETER commandstring 
        command to be executed.
    .EXAMPLE
        Invoke-ADCAddRouterdynamicrouting 
    .NOTES
        File Name : Invoke-ADCAddRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$commandstring 

    )
    begin {
        Write-Verbose "Invoke-ADCAddRouterdynamicrouting: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('commandstring')) { $Payload.Add('commandstring', $commandstring) }
 
            if ($PSCmdlet.ShouldProcess("routerdynamicrouting", "Add Router configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type routerdynamicrouting -Payload $Payload -GetWarning
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
        Delete Router configuration Object
    .DESCRIPTION
        Delete Router configuration Object
     .PARAMETER commandstring 
       command to be executed.
    .EXAMPLE
        Invoke-ADCDeleteRouterdynamicrouting 
    .NOTES
        File Name : Invoke-ADCDeleteRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteRouterdynamicrouting: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('commandstring')) { $Arguments.Add('commandstring', $commandstring) }
            if ($PSCmdlet.ShouldProcess("routerdynamicrouting", "Delete Router configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type routerdynamicrouting -Resource $ -Arguments $Arguments
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
        Update Router configuration Object
    .DESCRIPTION
        Update Router configuration Object 
    .PARAMETER commandstring 
        command to be executed.
    .EXAMPLE
        Invoke-ADCUpdateRouterdynamicrouting 
    .NOTES
        File Name : Invoke-ADCUpdateRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$commandstring 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateRouterdynamicrouting: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('commandstring')) { $Payload.Add('commandstring', $commandstring) }
 
            if ($PSCmdlet.ShouldProcess("routerdynamicrouting", "Update Router configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type routerdynamicrouting -Payload $Payload -GetWarning
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
        Unset Router configuration Object
    .DESCRIPTION
        Unset Router configuration Object 
   .PARAMETER commandstring 
       command to be executed.
    .EXAMPLE
        Invoke-ADCUnsetRouterdynamicrouting 
    .NOTES
        File Name : Invoke-ADCUnsetRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting
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

        [Boolean]$commandstring 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetRouterdynamicrouting: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('commandstring')) { $Payload.Add('commandstring', $commandstring) }
            if ($PSCmdlet.ShouldProcess("routerdynamicrouting", "Unset Router configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type routerdynamicrouting -Action unset -Payload $Payload -GetWarning
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
        Apply Router configuration Object
    .DESCRIPTION
        Apply Router configuration Object 
    .PARAMETER commandstring 
        command to be executed.
    .EXAMPLE
        Invoke-ADCApplyRouterdynamicrouting 
    .NOTES
        File Name : Invoke-ADCApplyRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [string]$commandstring 

    )
    begin {
        Write-Verbose "Invoke-ADCApplyRouterdynamicrouting: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('commandstring')) { $Payload.Add('commandstring', $commandstring) }
            if ($PSCmdlet.ShouldProcess($Name, "Apply Router configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type routerdynamicrouting -Action apply -Payload $Payload -GetWarning
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
        Get Router configuration object(s)
    .DESCRIPTION
        Get Router configuration object(s)
    .PARAMETER commandstring 
       command to be executed. 
    .PARAMETER nodeid 
       Unique number that identifies the cluster node. 
    .PARAMETER GetAll 
        Retreive all routerdynamicrouting object(s)
    .PARAMETER Count
        If specified, the count of the routerdynamicrouting object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetRouterdynamicrouting
    .EXAMPLE 
        Invoke-ADCGetRouterdynamicrouting -GetAll 
    .EXAMPLE 
        Invoke-ADCGetRouterdynamicrouting -Count
    .EXAMPLE
        Invoke-ADCGetRouterdynamicrouting -name <string>
    .EXAMPLE
        Invoke-ADCGetRouterdynamicrouting -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetRouterdynamicrouting
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/router/routerdynamicrouting/
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

        [Parameter(ParameterSetName = 'GetByArgument')]
        [string]$commandstring ,

        [Parameter(ParameterSetName = 'GetByArgument')]
        [ValidateRange(0, 31)]
        [double]$nodeid,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all routerdynamicrouting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for routerdynamicrouting objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving routerdynamicrouting objects by arguments"
                $Arguments = @{ } 
                if ($PSBoundParameters.ContainsKey('commandstring')) { $Arguments.Add('commandstring', $commandstring) } 
                if ($PSBoundParameters.ContainsKey('nodeid')) { $Arguments.Add('nodeid', $nodeid) }
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving routerdynamicrouting configuration for property ''"

            } else {
                Write-Verbose "Retrieving routerdynamicrouting configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type routerdynamicrouting -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


