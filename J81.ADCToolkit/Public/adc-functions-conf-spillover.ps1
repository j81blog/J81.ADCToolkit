function Invoke-ADCAddSpilloveraction {
<#
    .SYNOPSIS
        Add Spillover configuration Object
    .DESCRIPTION
        Add Spillover configuration Object 
    .PARAMETER name 
        Name of the spillover action. 
    .PARAMETER action 
        Spillover action. Currently only type SPILLOVER is supported.  
        Possible values = SPILLOVER 
    .PARAMETER PassThru 
        Return details about the created spilloveraction item.
    .EXAMPLE
        Invoke-ADCAddSpilloveraction -name <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddSpilloveraction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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

        [Parameter(Mandatory = $true)]
        [ValidateSet('SPILLOVER')]
        [string]$action ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSpilloveraction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                action = $action
            }

 
            if ($PSCmdlet.ShouldProcess("spilloveraction", "Add Spillover configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloveraction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSpilloveraction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSpilloveraction: Finished"
    }
}

function Invoke-ADCDeleteSpilloveraction {
<#
    .SYNOPSIS
        Delete Spillover configuration Object
    .DESCRIPTION
        Delete Spillover configuration Object
    .PARAMETER name 
       Name of the spillover action. 
    .EXAMPLE
        Invoke-ADCDeleteSpilloveraction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSpilloveraction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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
        Write-Verbose "Invoke-ADCDeleteSpilloveraction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Spillover configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type spilloveraction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSpilloveraction: Finished"
    }
}

function Invoke-ADCRenameSpilloveraction {
<#
    .SYNOPSIS
        Rename Spillover configuration Object
    .DESCRIPTION
        Rename Spillover configuration Object 
    .PARAMETER name 
        Name of the spillover action. 
    .PARAMETER newname 
        New name for the spillover action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at  
        (@), equals (=), and hyphen (-) characters.  
        Choose a name that can be correlated with the function that the action performs. 
    .PARAMETER PassThru 
        Return details about the created spilloveraction item.
    .EXAMPLE
        Invoke-ADCRenameSpilloveraction -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameSpilloveraction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameSpilloveraction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("spilloveraction", "Rename Spillover configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloveraction -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSpilloveraction -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameSpilloveraction: Finished"
    }
}

function Invoke-ADCGetSpilloveraction {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover action. 
    .PARAMETER GetAll 
        Retreive all spilloveraction object(s)
    .PARAMETER Count
        If specified, the count of the spilloveraction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloveraction
    .EXAMPLE 
        Invoke-ADCGetSpilloveraction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSpilloveraction -Count
    .EXAMPLE
        Invoke-ADCGetSpilloveraction -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloveraction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloveraction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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
        Write-Verbose "Invoke-ADCGetSpilloveraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all spilloveraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloveraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloveraction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloveraction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloveraction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloveraction: Ended"
    }
}

function Invoke-ADCAddSpilloverpolicy {
<#
    .SYNOPSIS
        Add Spillover configuration Object
    .DESCRIPTION
        Add Spillover configuration Object 
    .PARAMETER name 
        Name of the spillover policy. 
    .PARAMETER rule 
        Expression to be used by the spillover policy. 
    .PARAMETER action 
        Action for the spillover policy. Action is created using add spillover action command. 
    .PARAMETER comment 
        Any comments that you might want to associate with the spillover policy. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        Invoke-ADCAddSpilloverpolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [string]$action ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddSpilloverpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("spilloverpolicy", "Add Spillover configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloverpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCAddSpilloverpolicy: Finished"
    }
}

function Invoke-ADCDeleteSpilloverpolicy {
<#
    .SYNOPSIS
        Delete Spillover configuration Object
    .DESCRIPTION
        Delete Spillover configuration Object
    .PARAMETER name 
       Name of the spillover policy. 
    .EXAMPLE
        Invoke-ADCDeleteSpilloverpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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
        Write-Verbose "Invoke-ADCDeleteSpilloverpolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Spillover configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type spilloverpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Write-Verbose "Invoke-ADCDeleteSpilloverpolicy: Finished"
    }
}

function Invoke-ADCUpdateSpilloverpolicy {
<#
    .SYNOPSIS
        Update Spillover configuration Object
    .DESCRIPTION
        Update Spillover configuration Object 
    .PARAMETER name 
        Name of the spillover policy. 
    .PARAMETER rule 
        Expression to be used by the spillover policy. 
    .PARAMETER action 
        Action for the spillover policy. Action is created using add spillover action command. 
    .PARAMETER comment 
        Any comments that you might want to associate with the spillover policy. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        Invoke-ADCUpdateSpilloverpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [string]$rule ,

        [string]$action ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSpilloverpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("spilloverpolicy", "Update Spillover configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type spilloverpolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCUpdateSpilloverpolicy: Finished"
    }
}

function Invoke-ADCUnsetSpilloverpolicy {
<#
    .SYNOPSIS
        Unset Spillover configuration Object
    .DESCRIPTION
        Unset Spillover configuration Object 
   .PARAMETER name 
       Name of the spillover policy. 
   .PARAMETER comment 
       Any comments that you might want to associate with the spillover policy.
    .EXAMPLE
        Invoke-ADCUnsetSpilloverpolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy
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

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSpilloverpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Spillover configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type spilloverpolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetSpilloverpolicy: Finished"
    }
}

function Invoke-ADCRenameSpilloverpolicy {
<#
    .SYNOPSIS
        Rename Spillover configuration Object
    .DESCRIPTION
        Rename Spillover configuration Object 
    .PARAMETER name 
        Name of the spillover policy. 
    .PARAMETER newname 
        New name for the spillover policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters.  
        Choose a name that reflects the function that the policy performs. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        Invoke-ADCRenameSpilloverpolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameSpilloverpolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("spilloverpolicy", "Rename Spillover configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloverpolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $Payload)
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
        Write-Verbose "Invoke-ADCRenameSpilloverpolicy: Finished"
    }
}

function Invoke-ADCGetSpilloverpolicy {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover policy. 
    .PARAMETER GetAll 
        Retreive all spilloverpolicy object(s)
    .PARAMETER Count
        If specified, the count of the spilloverpolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicy
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicy -Count
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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
        Write-Verbose "Invoke-ADCGetSpilloverpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all spilloverpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloverpolicy: Ended"
    }
}

function Invoke-ADCGetSpilloverpolicybinding {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover policy. 
    .PARAMETER GetAll 
        Retreive all spilloverpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicybinding
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_binding/
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
        [string]$name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSpilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloverpolicybinding: Ended"
    }
}

function Invoke-ADCGetSpilloverpolicycsvserverbinding {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover policy. 
    .PARAMETER GetAll 
        Retreive all spilloverpolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicycsvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_csvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSpilloverpolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all spilloverpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloverpolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCGetSpilloverpolicygslbvserverbinding {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover policy. 
    .PARAMETER GetAll 
        Retreive all spilloverpolicy_gslbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_gslbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicygslbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicygslbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicygslbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicygslbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicygslbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicygslbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_gslbvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSpilloverpolicygslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all spilloverpolicy_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloverpolicygslbvserverbinding: Ended"
    }
}

function Invoke-ADCGetSpilloverpolicylbvserverbinding {
<#
    .SYNOPSIS
        Get Spillover configuration object(s)
    .DESCRIPTION
        Get Spillover configuration object(s)
    .PARAMETER name 
       Name of the spillover policy. 
    .PARAMETER GetAll 
        Retreive all spilloverpolicy_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicylbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicylbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetSpilloverpolicylbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicylbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetSpilloverpolicylbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicylbvserverbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_lbvserver_binding/
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
        [string]$name,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSpilloverpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all spilloverpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetSpilloverpolicylbvserverbinding: Ended"
    }
}


