function Invoke-ADCGetCraction {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Configuration for cache redirection action resource.
    .PARAMETER Name 
        Name of the action for which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all craction object(s).
    .PARAMETER Count
        If specified, the count of the craction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCraction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCraction -GetAll 
        Get all craction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCraction -Count 
        Get the number of craction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCraction -name <string>
        Get craction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCraction -Filter @{ 'name'='<value>' }
        Get craction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCraction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/craction/
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
        [string]$Name,

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
        Write-Verbose "Invoke-ADCGetCraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all craction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for craction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving craction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving craction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving craction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCraction: Ended"
    }
}

function Invoke-ADCAddCrpolicy {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrpolicy -policyname <string> -rule <string>
        An example how to add crpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [string]$Rule,

        [string]$Action,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                rule                 = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("crpolicy", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrpolicy: Finished"
    }
}

function Invoke-ADCDeleteCrpolicy {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrpolicy -Policyname <string>
        An example how to delete crpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crpolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrpolicy: Finished"
    }
}

function Invoke-ADCUpdateCrpolicy {
    <#
    .SYNOPSIS
        Update Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCrpolicy -policyname <string>
        An example how to update crpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [string]$Rule,

        [string]$Action,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("crpolicy", "Update Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateCrpolicy: Finished"
    }
}

function Invoke-ADCUnsetCrpolicy {
    <#
    .SYNOPSIS
        Unset Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Logaction 
        The log action associated with the cache redirection policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCrpolicy -policyname <string>
        An example how to unset crpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$policyname", "Unset Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCrpolicy: Finished"
    }
}

function Invoke-ADCRenameCrpolicy {
    <#
    .SYNOPSIS
        Rename Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER Newname 
        The new name of the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCrpolicy -policyname <string> -newname <string>
        An example how to rename crpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCrpolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                newname              = $newname
            }

            if ( $PSCmdlet.ShouldProcess("crpolicy", "Rename Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCrpolicy: Finished"
    }
}

function Invoke-ADCGetCrpolicy {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Configuration for cache redirection policy resource.
    .PARAMETER Policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retrieve all crpolicy object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrpolicy -GetAll 
        Get all crpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrpolicy -Count 
        Get the number of crpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicy -name <string>
        Get crpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicy -Filter @{ 'name'='<value>' }
        Get crpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Policyname,

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
        Write-Verbose "Invoke-ADCGetCrpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all crpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrpolicy: Ended"
    }
}

function Invoke-ADCGetCrpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to crpolicy.
    .PARAMETER Policyname 
        Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all crpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrpolicybinding -GetAll 
        Get all crpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicybinding -name <string>
        Get crpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicybinding -Filter @{ 'name'='<value>' }
        Get crpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy_binding/
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
        [string]$Policyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrpolicybinding: Ended"
    }
}

function Invoke-ADCGetCrpolicycrvserverbinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to crpolicy.
    .PARAMETER Policyname 
        Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all crpolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crpolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicycrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrpolicycrvserverbinding -GetAll 
        Get all crpolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrpolicycrvserverbinding -Count 
        Get the number of crpolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicycrvserverbinding -name <string>
        Get crpolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrpolicycrvserverbinding -Filter @{ 'name'='<value>' }
        Get crpolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrpolicycrvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy_crvserver_binding/
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
        [string]$Policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrpolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrpolicycrvserverbinding: Ended"
    }
}

function Invoke-ADCAddCrvserver {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Servicetype 
        Protocol (type of service) handled by the virtual server. 
        Possible values = HTTP, SSL, NNTP, HDX 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address. 
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER Port 
        Port number of the virtual server. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Range 
        Number of consecutive IP addresses, starting with the address specified by the IPAddress parameter, to include in a range of addresses assigned to this virtual server. 
    .PARAMETER Cachetype 
        Mode of operation for the cache redirection virtual server. Available settings function as follows: 
        * TRANSPARENT - Intercept all traffic flowing to the appliance and apply cache redirection policies to determine whether content should be served from the cache or from the origin server. 
        * FORWARD - Resolve the hostname of the incoming request, by using a DNS server, and forward requests for non-cacheable content to the resolved origin servers. Cacheable requests are sent to the configured cache servers. 
        * REVERSE - Configure reverse proxy caches for specific origin servers. Incoming traffic directed to the reverse proxy can either be served from a cache server or be sent to the origin server with or without modification to the URL. 
        The default value for cache type is TRANSPARENT if service is HTTP or SSL whereas the default cache type is FORWARD if the service is HDX. 
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
        Possible values = CACHE, ORIGIN 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Ghost 
        . 
        Possible values = ON, OFF 
    .PARAMETER Map 
        Obsolete. 
        Possible values = ON, OFF 
    .PARAMETER Format 
        . 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
        Possible values = ON, OFF 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Sopersistencetimeout 
        Time-out, in minutes, for spillover persistence. 
    .PARAMETER Sothreshold 
        For CONNECTION (or) DYNAMICCONNECTION spillover, the number of connections above which the virtual server enters spillover mode. For BANDWIDTH spillover, the amount of incoming and outgoing traffic (in Kbps) before spillover. For HEALTH spillover, the percentage of active services (by weight) below which spillover occurs. 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
        Possible values = ON, OFF 
    .PARAMETER State 
        Initial state of the cache redirection virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
        Possible values = ON, OFF 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
        Possible values = YES, NO 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserver -name <string> -servicetype <string>
        An example how to add crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [ValidateRange(0, 4094)]
        [double]$Td,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'SSL', 'NNTP', 'HDX')]
        [string]$Servicetype,

        [string]$Ipv46,

        [ValidateRange(1, 65534)]
        [int]$Port = '80',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateRange(1, 254)]
        [double]$Range = '1',

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$Cachetype,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$Redirect = 'POLICY',

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$Onpolicymatch = 'ORIGIN',

        [ValidateLength(1, 128)]
        [string]$Redirecturl,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence = 'RULE',

        [ValidateSet('ON', 'OFF')]
        [string]$Arp,

        [ValidateSet('ON', 'OFF')]
        [string]$Ghost,

        [ValidateSet('ON', 'OFF')]
        [string]$Map,

        [ValidateSet('ON', 'OFF')]
        [string]$Format,

        [ValidateSet('ON', 'OFF')]
        [string]$Via = 'ON',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachevserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destinationvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateRange(2, 24)]
        [double]$Sopersistencetimeout,

        [double]$Sothreshold,

        [ValidateSet('ON', 'OFF')]
        [string]$Reuse = 'ON',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backendssl = 'DISABLED',

        [string]$Listenpolicy = '"NONE"',

        [ValidateRange(0, 100)]
        [double]$Listenpriority = '101',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [string]$Comment,

        [ValidateLength(1, 1500)]
        [string]$Srcipexpr,

        [ValidateSet('ON', 'OFF')]
        [string]$Originusip,

        [ValidateSet('ON', 'OFF')]
        [string]$Useportrange = 'OFF',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse = 'PASSIVE',

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate = 'PASSIVE',

        [ValidateSet('YES', 'NO')]
        [string]$Useoriginipportforcache = 'NO',

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode = '"200 OK"',

        [ValidateRange(1, 65535)]
        [int]$Probeport = '0',

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('range') ) { $payload.Add('range', $range) }
            if ( $PSBoundParameters.ContainsKey('cachetype') ) { $payload.Add('cachetype', $cachetype) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('ghost') ) { $payload.Add('ghost', $ghost) }
            if ( $PSBoundParameters.ContainsKey('map') ) { $payload.Add('map', $map) }
            if ( $PSBoundParameters.ContainsKey('format') ) { $payload.Add('format', $format) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSCmdlet.ShouldProcess("crvserver", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserver: Finished"
    }
}

function Invoke-ADCDeleteCrvserver {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserver -Name <string>
        An example how to delete crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [string]$Name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserver: Finished"
    }
}

function Invoke-ADCUpdateCrvserver {
    <#
    .SYNOPSIS
        Update Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address. 
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
        Possible values = CACHE, ORIGIN 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
        Possible values = ON, OFF 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
        Possible values = ON, OFF 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
        Possible values = YES, NO 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case. 
    .PARAMETER Probeport 
        Citrix ADC provides support for external health check of the vserver status. Select port for HTTP/TCP monitring. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCrvserver -name <string>
        An example how to update crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Ipv46,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$Redirect,

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$Onpolicymatch,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence,

        [ValidateSet('ON', 'OFF')]
        [string]$Arp,

        [ValidateSet('ON', 'OFF')]
        [string]$Via,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cachevserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Dnsvservername,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Destinationvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domain,

        [ValidateSet('ON', 'OFF')]
        [string]$Reuse,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateLength(1, 128)]
        [string]$Redirecturl,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Backendssl,

        [string]$Listenpolicy,

        [ValidateRange(0, 100)]
        [double]$Listenpriority,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [string]$Comment,

        [ValidateLength(1, 1500)]
        [string]$Srcipexpr,

        [ValidateSet('ON', 'OFF')]
        [string]$Originusip,

        [ValidateSet('ON', 'OFF')]
        [string]$Useportrange,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate,

        [ValidateSet('YES', 'NO')]
        [string]$Useoriginipportforcache,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode,

        [ValidateRange(1, 65535)]
        [int]$Probeport,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSCmdlet.ShouldProcess("crvserver", "Update Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateCrvserver: Finished"
    }
}

function Invoke-ADCUnsetCrvserver {
    <#
    .SYNOPSIS
        Unset Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
    .PARAMETER Dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server. 
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
    .PARAMETER Destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
    .PARAMETER Domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
    .PARAMETER Backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
    .PARAMETER Clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection. 
    .PARAMETER Redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
    .PARAMETER L2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server. 
        Note: You can enable this parameter to implement fully transparent CR deployment. 
        Possible values = ON, OFF 
    .PARAMETER Useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server. 
        Possible values = ON, OFF 
    .PARAMETER Srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server. 
    .PARAMETER Httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server. 
    .PARAMETER Appflowlog 
        Enable logging of AppFlow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server. 
    .PARAMETER Icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
    .PARAMETER Redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows: 
        * CACHE - Direct all requests to the cache. 
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin. 
        * ORIGIN - Direct all requests to the origin server. 
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER Onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified. 
        Note: For this option to work, you must set the cache redirection type to POLICY. 
        Possible values = CACHE, ORIGIN 
    .PARAMETER Precedence 
        Type of policy (URL or RULE) that takes precedence on the cache redirection virtual server. Applies only to cache redirection virtual servers that have both URL and RULE based policies. If you specify URL, URL based policies are applied first, in the following order: 
        1. Domain and exact URL 
        2. Domain, prefix and suffix 
        3. Domain and suffix 
        4. Domain and prefix 
        5. Domain only 
        6. Exact URL 
        7. Prefix and suffix 
        8. Suffix only 
        9. Prefix only 
        10. Default 
        If you specify RULE, the rule based policies are applied before URL based policies are applied. 
        Possible values = RULE, URL 
    .PARAMETER Arp 
        Use ARP to determine the destination MAC address. 
        Possible values = ON, OFF 
    .PARAMETER Via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server. 
        Possible values = ON, OFF 
    .PARAMETER Reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows: 
        * CACHE - TCP connections to the cache servers are not reused. 
        * ORIGIN - TCP connections to the origin servers are not reused. 
        * POLICY - TCP connections to the origin servers are not reused. 
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused. 
        Possible values = ON, OFF 
    .PARAMETER Disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Perform delayed cleanup of connections to this virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
    .PARAMETER Listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
    .PARAMETER Comment 
        Comments associated with this virtual server. 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache. 
        Possible values = YES, NO 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCrvserver -name <string>
        An example how to unset crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$cachevserver,

        [Boolean]$dnsvservername,

        [Boolean]$destinationvserver,

        [Boolean]$domain,

        [Boolean]$backupvserver,

        [Boolean]$clttimeout,

        [Boolean]$redirecturl,

        [Boolean]$l2conn,

        [Boolean]$backendssl,

        [Boolean]$originusip,

        [Boolean]$useportrange,

        [Boolean]$srcipexpr,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$icmpvsrresponse,

        [Boolean]$tcpprobeport,

        [Boolean]$probeprotocol,

        [Boolean]$ipset,

        [Boolean]$redirect,

        [Boolean]$onpolicymatch,

        [Boolean]$precedence,

        [Boolean]$arp,

        [Boolean]$via,

        [Boolean]$reuse,

        [Boolean]$disableprimaryondown,

        [Boolean]$downstateflush,

        [Boolean]$listenpolicy,

        [Boolean]$listenpriority,

        [Boolean]$comment,

        [Boolean]$rhistate,

        [Boolean]$useoriginipportforcache,

        [Boolean]$probesuccessresponsecode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('cachevserver') ) { $payload.Add('cachevserver', $cachevserver) }
            if ( $PSBoundParameters.ContainsKey('dnsvservername') ) { $payload.Add('dnsvservername', $dnsvservername) }
            if ( $PSBoundParameters.ContainsKey('destinationvserver') ) { $payload.Add('destinationvserver', $destinationvserver) }
            if ( $PSBoundParameters.ContainsKey('domain') ) { $payload.Add('domain', $domain) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('backendssl') ) { $payload.Add('backendssl', $backendssl) }
            if ( $PSBoundParameters.ContainsKey('originusip') ) { $payload.Add('originusip', $originusip) }
            if ( $PSBoundParameters.ContainsKey('useportrange') ) { $payload.Add('useportrange', $useportrange) }
            if ( $PSBoundParameters.ContainsKey('srcipexpr') ) { $payload.Add('srcipexpr', $srcipexpr) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('redirect') ) { $payload.Add('redirect', $redirect) }
            if ( $PSBoundParameters.ContainsKey('onpolicymatch') ) { $payload.Add('onpolicymatch', $onpolicymatch) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('arp') ) { $payload.Add('arp', $arp) }
            if ( $PSBoundParameters.ContainsKey('via') ) { $payload.Add('via', $via) }
            if ( $PSBoundParameters.ContainsKey('reuse') ) { $payload.Add('reuse', $reuse) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('useoriginipportforcache') ) { $payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCrvserver: Finished"
    }
}

function Invoke-ADCEnableCrvserver {
    <#
    .SYNOPSIS
        Enable Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableCrvserver -name <string>
        An example how to enable crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableCrvserver: Finished"
    }
}

function Invoke-ADCDisableCrvserver {
    <#
    .SYNOPSIS
        Disable Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableCrvserver -name <string>
        An example how to disable crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableCrvserver: Finished"
    }
}

function Invoke-ADCRenameCrvserver {
    <#
    .SYNOPSIS
        Rename Cache Redirection configuration Object.
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER Newname 
        New name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my name" or 'my name'). 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCrvserver -name <string> -newname <string>
        An example how to rename crvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCrvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("crvserver", "Rename Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type crvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCrvserver: Finished"
    }
}

function Invoke-ADCGetCrvserver {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Configuration for CR virtual server resource.
    .PARAMETER Name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER GetAll 
        Retrieve all crvserver object(s).
    .PARAMETER Count
        If specified, the count of the crvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserver -GetAll 
        Get all crvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserver -Count 
        Get the number of crvserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserver -name <string>
        Get crvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserver -Filter @{ 'name'='<value>' }
        Get crvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserver
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

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
        Write-Verbose "Invoke-ADCGetCrvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all crvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserver: Ended"
    }
}

function Invoke-ADCAddCrvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the CR vserver. 
    .PARAMETER PassThru 
        Return details about the created crvserver_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserveranalyticsprofilebinding -name <string>
        An example how to add crvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$Name,

        [string]$Analyticsprofile,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("crvserver_analyticsprofile_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserveranalyticsprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the CR vserver.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserveranalyticsprofilebinding -Name <string>
        An example how to delete crvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$Name,

        [string]$Analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCGetCrvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserveranalyticsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserveranalyticsprofilebinding -GetAll 
        Get all crvserver_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserveranalyticsprofilebinding -Count 
        Get the number of crvserver_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserveranalyticsprofilebinding -name <string>
        Get crvserver_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
        Get crvserver_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserveranalyticsprofilebinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserveranalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserveranalyticsprofilebinding: Ended"
    }
}

function Invoke-ADCAddCrvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverappflowpolicybinding -name <string>
        An example how to add crvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appflowpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverappflowpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverappflowpolicybinding -Name <string>
        An example how to delete crvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappflowpolicybinding -GetAll 
        Get all crvserver_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappflowpolicybinding -Count 
        Get the number of crvserver_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappflowpolicybinding -name <string>
        Get crvserver_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverappflowpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverappflowpolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverappfwpolicybinding -name <string>
        An example how to add crvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appfwpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverappfwpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverappfwpolicybinding -Name <string>
        An example how to delete crvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappfwpolicybinding -GetAll 
        Get all crvserver_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappfwpolicybinding -Count 
        Get the number of crvserver_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappfwpolicybinding -name <string>
        Get crvserver_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverappfwpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverappfwpolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appqoepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverappqoepolicybinding -name <string>
        An example how to add crvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_appqoepolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_appqoepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverappqoepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverappqoepolicybinding -Name <string>
        An example how to delete crvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappqoepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappqoepolicybinding -GetAll 
        Get all crvserver_appqoepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverappqoepolicybinding -Count 
        Get the number of crvserver_appqoepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappqoepolicybinding -name <string>
        Get crvserver_appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverappqoepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverappqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverappqoepolicybinding: Ended"
    }
}

function Invoke-ADCGetCrvserverbinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to crvserver.
    .PARAMETER Name 
        Name of a cache redirection virtual server about which to display detailed information. 
    .PARAMETER GetAll 
        Retrieve all crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverbinding -GetAll 
        Get all crvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverbinding -name <string>
        Get crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverbinding -Filter @{ 'name'='<value>' }
        Get crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverbinding: Ended"
    }
}

function Invoke-ADCAddCrvservercachepolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvservercachepolicybinding -name <string>
        An example how to add crvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercachepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cachepolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvservercachepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvservercachepolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvservercachepolicybinding -Name <string>
        An example how to delete crvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercachepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvservercachepolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercachepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercachepolicybinding -GetAll 
        Get all crvserver_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercachepolicybinding -Count 
        Get the number of crvserver_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercachepolicybinding -name <string>
        Get crvserver_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercachepolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvservercachepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvservercachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvservercachepolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvservercmppolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvservercmppolicybinding -name <string>
        An example how to add crvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercmppolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cmppolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvservercmppolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvservercmppolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvservercmppolicybinding -Name <string>
        An example how to delete crvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercmppolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvservercmppolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercmppolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercmppolicybinding -GetAll 
        Get all crvserver_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercmppolicybinding -Count 
        Get the number of crvserver_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercmppolicybinding -name <string>
        Get crvserver_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercmppolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvservercmppolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvservercmppolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvservercmppolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvservercrpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_crpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvservercrpolicybinding -name <string>
        An example how to add crvserver_crpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvservercrpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercrpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_crpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_crpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvservercrpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvservercrpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvservercrpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvservercrpolicybinding -Name <string>
        An example how to delete crvserver_crpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercrpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercrpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvservercrpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvservercrpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the crpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_crpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_crpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercrpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercrpolicybinding -GetAll 
        Get all crvserver_crpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercrpolicybinding -Count 
        Get the number of crvserver_crpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercrpolicybinding -name <string>
        Get crvserver_crpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercrpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_crpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvservercrpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvservercrpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvservercrpolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvservercspolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        The CSW target server names. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvservercspolicybinding -name <string>
        An example how to add crvserver_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvservercspolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_cspolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvservercspolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvservercspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvservercspolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvservercspolicybinding -Name <string>
        An example how to delete crvserver_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercspolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvservercspolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvservercspolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercspolicybinding -GetAll 
        Get all crvserver_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservercspolicybinding -Count 
        Get the number of crvserver_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercspolicybinding -name <string>
        Get crvserver_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservercspolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvservercspolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvservercspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvservercspolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverfeopolicybinding -name <string>
        An example how to add crvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_feopolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverfeopolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverfeopolicybinding -Name <string>
        An example how to delete crvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfeopolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverfeopolicybinding -GetAll 
        Get all crvserver_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverfeopolicybinding -Count 
        Get the number of crvserver_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfeopolicybinding -name <string>
        Get crvserver_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfeopolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverfeopolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverfeopolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), b ut does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number incr ements by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_filterpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverfilterpolicybinding -name <string>
        An example how to add crvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding.md/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_filterpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_filterpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverfilterpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverfilterpolicybinding -Name <string>
        An example how to delete crvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding.md/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_filterpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_filterpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfilterpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverfilterpolicybinding -GetAll 
        Get all crvserver_filterpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverfilterpolicybinding -Count 
        Get the number of crvserver_filterpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfilterpolicybinding -name <string>
        Get crvserver_filterpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_filterpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverfilterpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding.md/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverfilterpolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvservericapolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_icapolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvservericapolicybinding -name <string>
        An example how to add crvserver_icapolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvservericapolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservericapolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_icapolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_icapolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvservericapolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvservericapolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvservericapolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvservericapolicybinding -Name <string>
        An example how to delete crvserver_icapolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvservericapolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservericapolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvservericapolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvservericapolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the icapolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_icapolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_icapolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservericapolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservericapolicybinding -GetAll 
        Get all crvserver_icapolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvservericapolicybinding -Count 
        Get the number of crvserver_icapolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservericapolicybinding -name <string>
        Get crvserver_icapolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvservericapolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_icapolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvservericapolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvservericapolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvservericapolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Lbvserver 
        The Default target server name. 
    .PARAMETER PassThru 
        Return details about the created crvserver_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverlbvserverbinding -name <string>
        An example how to add crvserver_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$Name,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Lbvserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('lbvserver') ) { $payload.Add('lbvserver', $lbvserver) }
            if ( $PSCmdlet.ShouldProcess("crvserver_lbvserver_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverlbvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverlbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Lbvserver 
        The Default target server name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverlbvserverbinding -Name <string>
        An example how to delete crvserver_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$Name,

        [string]$Lbvserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lbvserver') ) { $arguments.Add('lbvserver', $Lbvserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverlbvserverbinding: Finished"
    }
}

function Invoke-ADCGetCrvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverlbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverlbvserverbinding -GetAll 
        Get all crvserver_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverlbvserverbinding -Count 
        Get the number of crvserver_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverlbvserverbinding -name <string>
        Get crvserver_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverlbvserverbinding -Filter @{ 'name'='<value>' }
        Get crvserver_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverlbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverlbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverlbvserverbinding: Ended"
    }
}

function Invoke-ADCAddCrvserverpolicymapbinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        The CSW target server names. 
    .PARAMETER Priority 
        An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), b ut does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number incr ements by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_policymap_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverpolicymapbinding -name <string>
        An example how to add crvserver_policymap_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverpolicymapbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverpolicymapbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_policymap_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_policymap_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverpolicymapbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverpolicymapbinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverpolicymapbinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverpolicymapbinding -Name <string>
        An example how to delete crvserver_policymap_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverpolicymapbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverpolicymapbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverpolicymapbinding: Finished"
    }
}

function Invoke-ADCGetCrvserverpolicymapbinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the policymap that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_policymap_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_policymap_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverpolicymapbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverpolicymapbinding -GetAll 
        Get all crvserver_policymap_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverpolicymapbinding -Count 
        Get the number of crvserver_policymap_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverpolicymapbinding -name <string>
        Get crvserver_policymap_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverpolicymapbinding -Filter @{ 'name'='<value>' }
        Get crvserver_policymap_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverpolicymapbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverpolicymapbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_policymap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_policymap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverpolicymapbinding: Ended"
    }
}

function Invoke-ADCAddCrvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_responderpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverresponderpolicybinding -name <string>
        An example how to add crvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_responderpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_responderpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverresponderpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverresponderpolicybinding -Name <string>
        An example how to delete crvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_responderpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_responderpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverresponderpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverresponderpolicybinding -GetAll 
        Get all crvserver_responderpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverresponderpolicybinding -Count 
        Get the number of crvserver_responderpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverresponderpolicybinding -name <string>
        Get crvserver_responderpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_responderpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverresponderpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverresponderpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverresponderpolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverrewritepolicybinding -name <string>
        An example how to add crvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_rewritepolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverrewritepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverrewritepolicybinding -Name <string>
        An example how to delete crvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverrewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverrewritepolicybinding -GetAll 
        Get all crvserver_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverrewritepolicybinding -Count 
        Get the number of crvserver_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverrewritepolicybinding -name <string>
        Get crvserver_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverrewritepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverrewritepolicybinding: Ended"
    }
}

function Invoke-ADCAddCrvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Add Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE. 
    .PARAMETER Priority 
        The priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCrvserverspilloverpolicybinding -name <string>
        An example how to add crvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCrvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("crvserver_spilloverpolicy_binding", "Add Cache Redirection configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type crvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCrvserverspilloverpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCrvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCrvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Delete Cache Redirection configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER Priority 
        The priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCrvserverspilloverpolicybinding -Name <string>
        An example how to delete crvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$Name,

        [string]$Policyname,

        [string]$Bindpoint,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCrvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCGetCrvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Get Cache Redirection configuration object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to crvserver.
    .PARAMETER Name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retrieve all crvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the crvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverspilloverpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverspilloverpolicybinding -GetAll 
        Get all crvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCrvserverspilloverpolicybinding -Count 
        Get the number of crvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverspilloverpolicybinding -name <string>
        Get crvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCrvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
        Get crvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCrvserverspilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all crvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCrvserverspilloverpolicybinding: Ended"
    }
}


