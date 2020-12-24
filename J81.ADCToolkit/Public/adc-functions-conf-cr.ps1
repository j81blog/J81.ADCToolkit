function Invoke-ADCGetCraction {
<#
    .SYNOPSIS
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the action for which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all craction object(s)
    .PARAMETER Count
        If specified, the count of the craction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCraction
    .EXAMPLE 
        Invoke-ADCGetCraction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCraction -Count
    .EXAMPLE
        Invoke-ADCGetCraction -name <string>
    .EXAMPLE
        Invoke-ADCGetCraction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCraction
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/craction/
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
        [string]$name,

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
        Write-Verbose "Invoke-ADCGetCraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all craction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for craction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving craction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving craction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving craction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type craction -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        Invoke-ADCAddCrpolicy -policyname <string> -rule <string>
    .NOTES
        File Name : Invoke-ADCAddCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [string]$action ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                rule = $rule
            }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("crpolicy", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER policyname 
       Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteCrpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$policyname", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crpolicy -Resource $policyname -Arguments $Arguments
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
        Update Cache Redirection configuration Object
    .DESCRIPTION
        Update Cache Redirection configuration Object 
    .PARAMETER policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER action 
        Name of the built-in cache redirection action: CACHE/ORIGIN. 
    .PARAMETER logaction 
        The log action associated with the cache redirection policy. 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateCrpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUpdateCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [string]$rule ,

        [string]$action ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCrpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("crpolicy", "Update Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $Payload)
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
        Unset Cache Redirection configuration Object
    .DESCRIPTION
        Unset Cache Redirection configuration Object 
   .PARAMETER policyname 
       Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
   .PARAMETER logaction 
       The log action associated with the cache redirection policy.
    .EXAMPLE
        Invoke-ADCUnsetCrpolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUnsetCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCrpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$policyname", "Unset Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crpolicy -Action unset -Payload $Payload -GetWarning
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
        Rename Cache Redirection configuration Object
    .DESCRIPTION
        Rename Cache Redirection configuration Object 
    .PARAMETER policyname 
        Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER newname 
        The new name of the content switching policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created crpolicy item.
    .EXAMPLE
        Invoke-ADCRenameCrpolicy -policyname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCrpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("crpolicy", "Rename Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrpolicy -Filter $Payload)
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER policyname 
       Name for the cache redirection policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after the policy is created. 
    .PARAMETER GetAll 
        Retreive all crpolicy object(s)
    .PARAMETER Count
        If specified, the count of the crpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrpolicy
    .EXAMPLE 
        Invoke-ADCGetCrpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrpolicy -Count
    .EXAMPLE
        Invoke-ADCGetCrpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetCrpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrpolicy
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$policyname,

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
        Write-Verbose "Invoke-ADCGetCrpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all crpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER policyname 
       Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all crpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCrpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy_binding/
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
        [string]$policyname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER policyname 
       Name of the cache redirection policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all crpolicy_crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the crpolicy_crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrpolicycrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCrpolicycrvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrpolicycrvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCrpolicycrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrpolicycrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrpolicycrvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crpolicy_crvserver_binding/
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
        [string]$policyname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crpolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crpolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crpolicy_crvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER servicetype 
        Protocol (type of service) handled by the virtual server.  
        Possible values = HTTP, SSL, NNTP, HDX 
    .PARAMETER ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address.  
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER port 
        Port number of the virtual server.  
        Default value: 80  
        Minimum value = 1  
        Maximum value = 65534 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver.  
        Minimum length = 1 
    .PARAMETER range 
        Number of consecutive IP addresses, starting with the address specified by the IPAddress parameter, to include in a range of addresses assigned to this virtual server.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 254 
    .PARAMETER cachetype 
        Mode of operation for the cache redirection virtual server. Available settings function as follows:  
        * TRANSPARENT - Intercept all traffic flowing to the appliance and apply cache redirection policies to determine whether content should be served from the cache or from the origin server.  
        * FORWARD - Resolve the hostname of the incoming request, by using a DNS server, and forward requests for non-cacheable content to the resolved origin servers. Cacheable requests are sent to the configured cache servers.  
        * REVERSE - Configure reverse proxy caches for specific origin servers. Incoming traffic directed to the reverse proxy can either be served from a cache server or be sent to the origin server with or without modification to the URL.  
        The default value for cache type is TRANSPARENT if service is HTTP or SSL whereas the default cache type is FORWARD if the service is HDX.  
        Possible values = TRANSPARENT, REVERSE, FORWARD 
    .PARAMETER redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows:  
        * CACHE - Direct all requests to the cache.  
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin.  
        * ORIGIN - Direct all requests to the origin server.  
        Default value: POLICY  
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified.  
        Note: For this option to work, you must set the cache redirection type to POLICY.  
        Default value: ORIGIN  
        Possible values = CACHE, ORIGIN 
    .PARAMETER redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable.  
        Minimum length = 1  
        Maximum length = 128 
    .PARAMETER clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER precedence 
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
        Default value: RULE  
        Possible values = RULE, URL 
    .PARAMETER arp 
        Use ARP to determine the destination MAC address.  
        Possible values = ON, OFF 
    .PARAMETER ghost 
        .  
        Possible values = ON, OFF 
    .PARAMETER map 
        Obsolete.  
        Possible values = ON, OFF 
    .PARAMETER format 
        .  
        Possible values = ON, OFF 
    .PARAMETER via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server).  
        Minimum length = 1 
    .PARAMETER dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server.  
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent.  
        Minimum length = 1 
    .PARAMETER destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server.  
        Minimum length = 1 
    .PARAMETER domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain.  
        Minimum length = 1 
    .PARAMETER sopersistencetimeout 
        Time-out, in minutes, for spillover persistence.  
        Minimum value = 2  
        Maximum value = 24 
    .PARAMETER sothreshold 
        For CONNECTION (or) DYNAMICCONNECTION spillover, the number of connections above which the virtual server enters spillover mode. For BANDWIDTH spillover, the amount of incoming and outgoing traffic (in Kbps) before spillover. For HEALTH spillover, the percentage of active services (by weight) below which spillover occurs.  
        Minimum value = 1 
    .PARAMETER reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows:  
        * CACHE - TCP connections to the cache servers are not reused.  
        * ORIGIN - TCP connections to the origin servers are not reused.  
        * POLICY - TCP connections to the origin servers are not reused.  
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER state 
        Initial state of the cache redirection virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Perform delayed cleanup of connections to this virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable.  
        Minimum length = 1 
    .PARAMETER disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER l2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection.  
        Possible values = ON, OFF 
    .PARAMETER backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Comments associated with this virtual server.  
        Maximum length = 256 
    .PARAMETER srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression.  
        Minimum length = 1  
        Maximum length = 1500 
    .PARAMETER originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server.  
        Note: You can enable this parameter to implement fully transparent CR deployment.  
        Possible values = ON, OFF 
    .PARAMETER useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        A host route is injected according to the setting on the virtual servers  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        Invoke-ADCAddCrvserver -name <string> -servicetype <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [ValidateRange(0, 4094)]
        [double]$td ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'SSL', 'NNTP', 'HDX')]
        [string]$servicetype ,

        [string]$ipv46 ,

        [ValidateRange(1, 65534)]
        [int]$port = '80' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [ValidateRange(1, 254)]
        [double]$range = '1' ,

        [ValidateSet('TRANSPARENT', 'REVERSE', 'FORWARD')]
        [string]$cachetype ,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$redirect = 'POLICY' ,

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$onpolicymatch = 'ORIGIN' ,

        [ValidateLength(1, 128)]
        [string]$redirecturl ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('RULE', 'URL')]
        [string]$precedence = 'RULE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$arp ,

        [ValidateSet('ON', 'OFF')]
        [string]$ghost ,

        [ValidateSet('ON', 'OFF')]
        [string]$map ,

        [ValidateSet('ON', 'OFF')]
        [string]$format ,

        [ValidateSet('ON', 'OFF')]
        [string]$via = 'ON' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cachevserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsvservername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$destinationvserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [ValidateRange(2, 24)]
        [double]$sopersistencetimeout ,

        [double]$sothreshold ,

        [ValidateSet('ON', 'OFF')]
        [string]$reuse = 'ON' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown = 'DISABLED' ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$backendssl = 'DISABLED' ,

        [string]$listenpolicy = '"NONE"' ,

        [ValidateRange(0, 100)]
        [double]$listenpriority = '101' ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [string]$comment ,

        [ValidateLength(1, 1500)]
        [string]$srcipexpr ,

        [ValidateSet('ON', 'OFF')]
        [string]$originusip ,

        [ValidateSet('ON', 'OFF')]
        [string]$useportrange = 'OFF' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse = 'PASSIVE' ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate = 'PASSIVE' ,

        [ValidateSet('YES', 'NO')]
        [string]$useoriginipportforcache = 'NO' ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                servicetype = $servicetype
            }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('range')) { $Payload.Add('range', $range) }
            if ($PSBoundParameters.ContainsKey('cachetype')) { $Payload.Add('cachetype', $cachetype) }
            if ($PSBoundParameters.ContainsKey('redirect')) { $Payload.Add('redirect', $redirect) }
            if ($PSBoundParameters.ContainsKey('onpolicymatch')) { $Payload.Add('onpolicymatch', $onpolicymatch) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('arp')) { $Payload.Add('arp', $arp) }
            if ($PSBoundParameters.ContainsKey('ghost')) { $Payload.Add('ghost', $ghost) }
            if ($PSBoundParameters.ContainsKey('map')) { $Payload.Add('map', $map) }
            if ($PSBoundParameters.ContainsKey('format')) { $Payload.Add('format', $format) }
            if ($PSBoundParameters.ContainsKey('via')) { $Payload.Add('via', $via) }
            if ($PSBoundParameters.ContainsKey('cachevserver')) { $Payload.Add('cachevserver', $cachevserver) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('destinationvserver')) { $Payload.Add('destinationvserver', $destinationvserver) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('reuse')) { $Payload.Add('reuse', $reuse) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('backendssl')) { $Payload.Add('backendssl', $backendssl) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('srcipexpr')) { $Payload.Add('srcipexpr', $srcipexpr) }
            if ($PSBoundParameters.ContainsKey('originusip')) { $Payload.Add('originusip', $originusip) }
            if ($PSBoundParameters.ContainsKey('useportrange')) { $Payload.Add('useportrange', $useportrange) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('useoriginipportforcache')) { $Payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("crvserver", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .EXAMPLE
        Invoke-ADCDeleteCrvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [string]$name 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver -Resource $name -Arguments $Arguments
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
        Update Cache Redirection configuration Object
    .DESCRIPTION
        Update Cache Redirection configuration Object 
    .PARAMETER name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER ipv46 
        IPv4 or IPv6 address of the cache redirection virtual server. Usually a public IP address. Clients send connection requests to this IP address.  
        Note: For a transparent cache redirection virtual server, use an asterisk (*) to specify a wildcard virtual server address. 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver.  
        Minimum length = 1 
    .PARAMETER redirect 
        Type of cache server to which to redirect HTTP requests. Available settings function as follows:  
        * CACHE - Direct all requests to the cache.  
        * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin.  
        * ORIGIN - Direct all requests to the origin server.  
        Default value: POLICY  
        Possible values = CACHE, POLICY, ORIGIN 
    .PARAMETER onpolicymatch 
        Redirect requests that match the policy to either the cache or the origin server, as specified.  
        Note: For this option to work, you must set the cache redirection type to POLICY.  
        Default value: ORIGIN  
        Possible values = CACHE, ORIGIN 
    .PARAMETER precedence 
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
        Default value: RULE  
        Possible values = RULE, URL 
    .PARAMETER arp 
        Use ARP to determine the destination MAC address.  
        Possible values = ON, OFF 
    .PARAMETER via 
        Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER cachevserver 
        Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server).  
        Minimum length = 1 
    .PARAMETER dnsvservername 
        Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server.  
        Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent.  
        Minimum length = 1 
    .PARAMETER destinationvserver 
        Destination virtual server for a transparent or forward proxy cache redirection virtual server.  
        Minimum length = 1 
    .PARAMETER domain 
        Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain.  
        Minimum length = 1 
    .PARAMETER reuse 
        Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows:  
        * CACHE - TCP connections to the cache servers are not reused.  
        * ORIGIN - TCP connections to the origin servers are not reused.  
        * POLICY - TCP connections to the origin servers are not reused.  
        If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER backupvserver 
        Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable.  
        Minimum length = 1 
    .PARAMETER disableprimaryondown 
        Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER redirecturl 
        URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable.  
        Minimum length = 1  
        Maximum length = 128 
    .PARAMETER clttimeout 
        Time-out value, in seconds, after which to terminate an idle client connection.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER downstateflush 
        Perform delayed cleanup of connections to this virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER l2conn 
        Use L2 parameters, such as MAC, VLAN, and channel to identify a connection.  
        Possible values = ON, OFF 
    .PARAMETER backendssl 
        Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER listenpolicy 
        String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER tcpprofilename 
        Name of the profile containing TCP configuration information for the cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the profile containing HTTP configuration information for cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER netprofile 
        Name of the network profile containing network configurations for the cache redirection virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Comments associated with this virtual server.  
        Maximum length = 256 
    .PARAMETER srcipexpr 
        Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression.  
        Minimum length = 1  
        Maximum length = 1500 
    .PARAMETER originusip 
        Use the client's IP address as the source IP address in requests sent to the origin server.  
        Note: You can enable this parameter to implement fully transparent CR deployment.  
        Possible values = ON, OFF 
    .PARAMETER useportrange 
        Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER appflowlog 
        Enable logging of AppFlow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER icmpvsrresponse 
        Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        A host route is injected according to the setting on the virtual servers  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER useoriginipportforcache 
        Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        Invoke-ADCUpdateCrvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$ipv46 ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [ValidateSet('CACHE', 'POLICY', 'ORIGIN')]
        [string]$redirect ,

        [ValidateSet('CACHE', 'ORIGIN')]
        [string]$onpolicymatch ,

        [ValidateSet('RULE', 'URL')]
        [string]$precedence ,

        [ValidateSet('ON', 'OFF')]
        [string]$arp ,

        [ValidateSet('ON', 'OFF')]
        [string]$via ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cachevserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$dnsvservername ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$destinationvserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [ValidateSet('ON', 'OFF')]
        [string]$reuse ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupvserver ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown ,

        [ValidateLength(1, 128)]
        [string]$redirecturl ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$backendssl ,

        [string]$listenpolicy ,

        [ValidateRange(0, 100)]
        [double]$listenpriority ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [string]$comment ,

        [ValidateLength(1, 1500)]
        [string]$srcipexpr ,

        [ValidateSet('ON', 'OFF')]
        [string]$originusip ,

        [ValidateSet('ON', 'OFF')]
        [string]$useportrange ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate ,

        [ValidateSet('YES', 'NO')]
        [string]$useoriginipportforcache ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('redirect')) { $Payload.Add('redirect', $redirect) }
            if ($PSBoundParameters.ContainsKey('onpolicymatch')) { $Payload.Add('onpolicymatch', $onpolicymatch) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('arp')) { $Payload.Add('arp', $arp) }
            if ($PSBoundParameters.ContainsKey('via')) { $Payload.Add('via', $via) }
            if ($PSBoundParameters.ContainsKey('cachevserver')) { $Payload.Add('cachevserver', $cachevserver) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('destinationvserver')) { $Payload.Add('destinationvserver', $destinationvserver) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('reuse')) { $Payload.Add('reuse', $reuse) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('backendssl')) { $Payload.Add('backendssl', $backendssl) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('srcipexpr')) { $Payload.Add('srcipexpr', $srcipexpr) }
            if ($PSBoundParameters.ContainsKey('originusip')) { $Payload.Add('originusip', $originusip) }
            if ($PSBoundParameters.ContainsKey('useportrange')) { $Payload.Add('useportrange', $useportrange) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('useoriginipportforcache')) { $Payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("crvserver", "Update Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $Payload)
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
        Unset Cache Redirection configuration Object
    .DESCRIPTION
        Unset Cache Redirection configuration Object 
   .PARAMETER name 
       Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
   .PARAMETER cachevserver 
       Name of the default cache virtual server to which to redirect requests (the default target of the cache redirection virtual server). 
   .PARAMETER dnsvservername 
       Name of the DNS virtual server that resolves domain names arriving at the forward proxy virtual server.  
       Note: This parameter applies only to forward proxy virtual servers, not reverse or transparent. 
   .PARAMETER destinationvserver 
       Destination virtual server for a transparent or forward proxy cache redirection virtual server. 
   .PARAMETER domain 
       Default domain for reverse proxies. Domains are configured to direct an incoming request from a specified source domain to a specified target domain. There can be several configured pairs of source and target domains. You can select one pair to be the default. If the host header or URL of an incoming request does not include a source domain, this option sends the request to the specified target domain. 
   .PARAMETER backupvserver 
       Name of the backup virtual server to which traffic is forwarded if the active server becomes unavailable. 
   .PARAMETER clttimeout 
       Time-out value, in seconds, after which to terminate an idle client connection. 
   .PARAMETER redirecturl 
       URL of the server to which to redirect traffic if the cache redirection virtual server configured on the Citrix ADC becomes unavailable. 
   .PARAMETER l2conn 
       Use L2 parameters, such as MAC, VLAN, and channel to identify a connection.  
       Possible values = ON, OFF 
   .PARAMETER backendssl 
       Decides whether the backend connection made by Citrix ADC to the origin server will be HTTP or SSL. Applicable only for SSL type CR Forward proxy vserver.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER originusip 
       Use the client's IP address as the source IP address in requests sent to the origin server.  
       Note: You can enable this parameter to implement fully transparent CR deployment.  
       Possible values = ON, OFF 
   .PARAMETER useportrange 
       Use a port number from the port range (set by using the set ns param command, or in the Create Virtual Server (Cache Redirection) dialog box) as the source port in the requests sent to the origin server.  
       Possible values = ON, OFF 
   .PARAMETER srcipexpr 
       Expression used to extract the source IP addresses from the requests originating from the cache. Can be either an in-line expression or the name of a named expression. 
   .PARAMETER tcpprofilename 
       Name of the profile containing TCP configuration information for the cache redirection virtual server. 
   .PARAMETER httpprofilename 
       Name of the profile containing HTTP configuration information for cache redirection virtual server. 
   .PARAMETER appflowlog 
       Enable logging of AppFlow information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       Name of the network profile containing network configurations for the cache redirection virtual server. 
   .PARAMETER icmpvsrresponse 
       Criterion for responding to PING requests sent to this virtual server. If ACTIVE, respond only if the virtual server is available. If PASSIVE, respond even if the virtual server is not available.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER tcpprobeport 
       Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER ipset 
       The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cr vserver. 
   .PARAMETER redirect 
       Type of cache server to which to redirect HTTP requests. Available settings function as follows:  
       * CACHE - Direct all requests to the cache.  
       * POLICY - Apply the cache redirection policy to determine whether the request should be directed to the cache or to the origin.  
       * ORIGIN - Direct all requests to the origin server.  
       Possible values = CACHE, POLICY, ORIGIN 
   .PARAMETER onpolicymatch 
       Redirect requests that match the policy to either the cache or the origin server, as specified.  
       Note: For this option to work, you must set the cache redirection type to POLICY.  
       Possible values = CACHE, ORIGIN 
   .PARAMETER precedence 
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
   .PARAMETER arp 
       Use ARP to determine the destination MAC address.  
       Possible values = ON, OFF 
   .PARAMETER via 
       Insert a via header in each HTTP request. In the case of a cache miss, the request is redirected from the cache server to the origin server. This header indicates whether the request is being sent from a cache server.  
       Possible values = ON, OFF 
   .PARAMETER reuse 
       Reuse TCP connections to the origin server across client connections. Do not set this parameter unless the Service Type parameter is set to HTTP. If you set this parameter to OFF, the possible settings of the Redirect parameter function as follows:  
       * CACHE - TCP connections to the cache servers are not reused.  
       * ORIGIN - TCP connections to the origin servers are not reused.  
       * POLICY - TCP connections to the origin servers are not reused.  
       If you set the Reuse parameter to ON, connections to origin servers and connections to cache servers are reused.  
       Possible values = ON, OFF 
   .PARAMETER disableprimaryondown 
       Continue sending traffic to a backup virtual server even after the primary virtual server comes UP from the DOWN state.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER downstateflush 
       Perform delayed cleanup of connections to this virtual server.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER listenpolicy 
       String specifying the listen policy for the cache redirection virtual server. Can be either an in-line expression or the name of a named expression. 
   .PARAMETER listenpriority 
       Priority of the listen policy specified by the Listen Policy parameter. The lower the number, higher the priority. 
   .PARAMETER comment 
       Comments associated with this virtual server. 
   .PARAMETER rhistate 
       A host route is injected according to the setting on the virtual servers  
       * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
       * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
       * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER useoriginipportforcache 
       Use origin ip/port while forwarding request to the cache. Change the destination IP, destination port of the request came to CR vserver to Origin IP and Origin Port and forward it to Cache.  
       Possible values = YES, NO
    .EXAMPLE
        Invoke-ADCUnsetCrvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$cachevserver ,

        [Boolean]$dnsvservername ,

        [Boolean]$destinationvserver ,

        [Boolean]$domain ,

        [Boolean]$backupvserver ,

        [Boolean]$clttimeout ,

        [Boolean]$redirecturl ,

        [Boolean]$l2conn ,

        [Boolean]$backendssl ,

        [Boolean]$originusip ,

        [Boolean]$useportrange ,

        [Boolean]$srcipexpr ,

        [Boolean]$tcpprofilename ,

        [Boolean]$httpprofilename ,

        [Boolean]$appflowlog ,

        [Boolean]$netprofile ,

        [Boolean]$icmpvsrresponse ,

        [Boolean]$tcpprobeport ,

        [Boolean]$ipset ,

        [Boolean]$redirect ,

        [Boolean]$onpolicymatch ,

        [Boolean]$precedence ,

        [Boolean]$arp ,

        [Boolean]$via ,

        [Boolean]$reuse ,

        [Boolean]$disableprimaryondown ,

        [Boolean]$downstateflush ,

        [Boolean]$listenpolicy ,

        [Boolean]$listenpriority ,

        [Boolean]$comment ,

        [Boolean]$rhistate ,

        [Boolean]$useoriginipportforcache 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('cachevserver')) { $Payload.Add('cachevserver', $cachevserver) }
            if ($PSBoundParameters.ContainsKey('dnsvservername')) { $Payload.Add('dnsvservername', $dnsvservername) }
            if ($PSBoundParameters.ContainsKey('destinationvserver')) { $Payload.Add('destinationvserver', $destinationvserver) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('backendssl')) { $Payload.Add('backendssl', $backendssl) }
            if ($PSBoundParameters.ContainsKey('originusip')) { $Payload.Add('originusip', $originusip) }
            if ($PSBoundParameters.ContainsKey('useportrange')) { $Payload.Add('useportrange', $useportrange) }
            if ($PSBoundParameters.ContainsKey('srcipexpr')) { $Payload.Add('srcipexpr', $srcipexpr) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('redirect')) { $Payload.Add('redirect', $redirect) }
            if ($PSBoundParameters.ContainsKey('onpolicymatch')) { $Payload.Add('onpolicymatch', $onpolicymatch) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('arp')) { $Payload.Add('arp', $arp) }
            if ($PSBoundParameters.ContainsKey('via')) { $Payload.Add('via', $via) }
            if ($PSBoundParameters.ContainsKey('reuse')) { $Payload.Add('reuse', $reuse) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('useoriginipportforcache')) { $Payload.Add('useoriginipportforcache', $useoriginipportforcache) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -Action unset -Payload $Payload -GetWarning
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
        Enable Cache Redirection configuration Object
    .DESCRIPTION
        Enable Cache Redirection configuration Object 
    .PARAMETER name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        Invoke-ADCEnableCrvserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCEnableCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -Action enable -Payload $Payload -GetWarning
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
        Disable Cache Redirection configuration Object
    .DESCRIPTION
        Disable Cache Redirection configuration Object 
    .PARAMETER name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created.
    .EXAMPLE
        Invoke-ADCDisableCrvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name 

    )
    begin {
        Write-Verbose "Invoke-ADCDisableCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -Action disable -Payload $Payload -GetWarning
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
        Rename Cache Redirection configuration Object
    .DESCRIPTION
        Rename Cache Redirection configuration Object 
    .PARAMETER name 
        Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER newname 
        New name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. If the name includes one or more spaces, enclose the name in double or single quotation marks (for example, "my name" or 'my name').  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created crvserver item.
    .EXAMPLE
        Invoke-ADCRenameCrvserver -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCrvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("crvserver", "Rename Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type crvserver -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserver -Filter $Payload)
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name for the cache redirection virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the cache redirection virtual server is created. 
    .PARAMETER GetAll 
        Retreive all crvserver object(s)
    .PARAMETER Count
        If specified, the count of the crvserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserver
    .EXAMPLE 
        Invoke-ADCGetCrvserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserver -Count
    .EXAMPLE
        Invoke-ADCGetCrvserver -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserver
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name,

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
        Write-Verbose "Invoke-ADCGetCrvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all crvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER analyticsprofile 
        Name of the analytics profile bound to the CR vserver. 
    .PARAMETER PassThru 
        Return details about the created crvserver_analyticsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$name ,

        [string]$analyticsprofile ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_analyticsprofile_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_analyticsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserveranalyticsprofilebinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER analyticsprofile 
       Name of the analytics profile bound to the CR vserver.
    .EXAMPLE
        Invoke-ADCDeleteCrvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$name ,

        [string]$analyticsprofile 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Arguments.Add('analyticsprofile', $analyticsprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_analyticsprofile_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_analyticsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_analyticsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserveranalyticsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetCrvserveranalyticsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserveranalyticsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserveranalyticsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserveranalyticsprofilebinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_analyticsprofile_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_analyticsprofile_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appflowpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_appflowpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_appflowpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverappflowpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appflowpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverappflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverappflowpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverappflowpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverappflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverappflowpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appflowpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appflowpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appfwpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_appfwpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_appfwpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverappfwpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appfwpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverappfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverappfwpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverappfwpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverappfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverappfwpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appfwpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appfwpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_appqoepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_appqoepolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_appqoepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverappqoepolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_appqoepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_appqoepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_appqoepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverappqoepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverappqoepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverappqoepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverappqoepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverappqoepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_appqoepolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_appqoepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of a cache redirection virtual server about which to display detailed information. 
    .PARAMETER GetAll 
        Retreive all crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cachepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_cachepolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_cachepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvservercachepolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cachepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvservercachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvservercachepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvservercachepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvservercachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvservercachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvservercachepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cachepolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cachepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cmppolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_cmppolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_cmppolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvservercmppolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cmppolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_cmppolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_cmppolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvservercmppolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvservercmppolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvservercmppolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvservercmppolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvservercmppolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvservercmppolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cmppolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cmppolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_crpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvservercrpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvservercrpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercrpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_crpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_crpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvservercrpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvservercrpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercrpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercrpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_crpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_crpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_crpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvservercrpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvservercrpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvservercrpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvservercrpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvservercrpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvservercrpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_crpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_crpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_crpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_crpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        The CSW target server names. 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_cspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvservercspolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvservercspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservercspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_cspolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_cspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvservercspolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvservercspolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvservercspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservercspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_cspolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_cspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_cspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvservercspolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvservercspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvservercspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvservercspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvservercspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvservercspolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_cspolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_cspolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_feopolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_feopolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_feopolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverfeopolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_feopolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_feopolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_feopolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverfeopolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverfeopolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverfeopolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverfeopolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverfeopolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverfeopolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_feopolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_feopolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), b ut does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number incr ements by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_filterpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_filterpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_filterpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverfilterpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_filterpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_filterpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_filterpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverfilterpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverfilterpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverfilterpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverfilterpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverfilterpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_filterpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_filterpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_icapolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvservericapolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvservericapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvservericapolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_icapolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_icapolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvservericapolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvservericapolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvservericapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvservericapolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_icapolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_icapolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_icapolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvservericapolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvservericapolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvservericapolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvservericapolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvservericapolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvservericapolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_icapolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_icapolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_icapolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_icapolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER lbvserver 
        The Default target server name.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created crvserver_lbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverlbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$name ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$lbvserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('lbvserver')) { $Payload.Add('lbvserver', $lbvserver) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_lbvserver_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_lbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverlbvserverbinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER lbvserver 
       The Default target server name.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteCrvserverlbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$name ,

        [string]$lbvserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('lbvserver')) { $Arguments.Add('lbvserver', $lbvserver) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_lbvserver_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverlbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverlbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverlbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverlbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverlbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverlbvserverbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_lbvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_lbvserver_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        The CSW target server names. 
    .PARAMETER priority 
        An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), b ut does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number incr ements by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_policymap_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverpolicymapbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverpolicymapbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverpolicymapbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_policymap_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_policymap_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverpolicymapbinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       An unsigned integer that determines the priority of the policy relative to other policies bound to this cache redirection virtual server. The lower the value, higher the priority. Note: This option is available only when binding content switching, filtering, and compression policies to a cache redirection virtual server.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverpolicymapbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverpolicymapbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverpolicymapbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_policymap_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_policymap_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_policymap_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverpolicymapbinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverpolicymapbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverpolicymapbinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverpolicymapbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverpolicymapbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverpolicymapbinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_policymap_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_policymap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_policymap_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_policymap_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_policymap_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_responderpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_responderpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_responderpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverresponderpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_responderpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_responderpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_responderpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverresponderpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverresponderpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverresponderpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverresponderpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverresponderpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_responderpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_responderpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_rewritepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_rewritepolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_rewritepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverrewritepolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_rewritepolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_rewritepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_rewritepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverrewritepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverrewritepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverrewritepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverrewritepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverrewritepolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_rewritepolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_rewritepolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Cache Redirection configuration Object
    .DESCRIPTION
        Add Cache Redirection configuration Object 
    .PARAMETER name 
        Name of the cache redirection virtual server to which to bind the cache redirection policy.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetvserver 
        Name of the virtual server to which content is forwarded. Applicable only if the policy is a map policy and the cache redirection virtual server is of type REVERSE.  
        Minimum length = 1 
    .PARAMETER priority 
        The priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created crvserver_spilloverpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCrvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCrvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCrvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("crvserver_spilloverpolicy_binding", "Add Cache Redirection configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -Type crvserver_spilloverpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCrvserverspilloverpolicybinding -Filter $Payload)
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
        Delete Cache Redirection configuration Object
    .DESCRIPTION
        Delete Cache Redirection configuration Object
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST    .PARAMETER priority 
       The priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCrvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCrvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$name ,

        [string]$policyname ,

        [string]$bindpoint ,

        [double]$priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCrvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Cache Redirection configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type crvserver_spilloverpolicy_binding -Resource $name -Arguments $Arguments
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
        Get Cache Redirection configuration object(s)
    .DESCRIPTION
        Get Cache Redirection configuration object(s)
    .PARAMETER name 
       Name of the cache redirection virtual server to which to bind the cache redirection policy. 
    .PARAMETER GetAll 
        Retreive all crvserver_spilloverpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the crvserver_spilloverpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCrvserverspilloverpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCrvserverspilloverpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCrvserverspilloverpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCrvserverspilloverpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCrvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCrvserverspilloverpolicybinding
        Version   : v2012.2411
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cr/crvserver_spilloverpolicy_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all crvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for crvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving crvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type crvserver_spilloverpolicy_binding -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


