function Invoke-ADCAddSpilloveraction {
    <#
    .SYNOPSIS
        Add Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover action resource.
    .PARAMETER Name 
        Name of the spillover action. 
    .PARAMETER Action 
        Spillover action. Currently only type SPILLOVER is supported. 
        Possible values = SPILLOVER 
    .PARAMETER PassThru 
        Return details about the created spilloveraction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSpilloveraction -name <string> -action <string>
        An example how to add spilloveraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSpilloveraction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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

        [Parameter(Mandatory)]
        [ValidateSet('SPILLOVER')]
        [string]$Action,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSpilloveraction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                action         = $action
            }

            if ( $PSCmdlet.ShouldProcess("spilloveraction", "Add Spillover configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloveraction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSpilloveraction -Filter $payload)
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
        Delete Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover action resource.
    .PARAMETER Name 
        Name of the spillover action.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSpilloveraction -Name <string>
        An example how to delete spilloveraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSpilloveraction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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
        Write-Verbose "Invoke-ADCDeleteSpilloveraction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Spillover configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type spilloveraction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Rename Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover action resource.
    .PARAMETER Name 
        Name of the spillover action. 
    .PARAMETER Newname 
        New name for the spillover action. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at 
        (@), equals (=), and hyphen (-) characters. 
        Choose a name that can be correlated with the function that the action performs. 
    .PARAMETER PassThru 
        Return details about the created spilloveraction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameSpilloveraction -name <string> -newname <string>
        An example how to rename spilloveraction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameSpilloveraction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameSpilloveraction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("spilloveraction", "Rename Spillover configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloveraction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSpilloveraction -Filter $payload)
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Configuration for Spillover action resource.
    .PARAMETER Name 
        Name of the spillover action. 
    .PARAMETER GetAll 
        Retrieve all spilloveraction object(s).
    .PARAMETER Count
        If specified, the count of the spilloveraction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloveraction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloveraction -GetAll 
        Get all spilloveraction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloveraction -Count 
        Get the number of spilloveraction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloveraction -name <string>
        Get spilloveraction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloveraction -Filter @{ 'name'='<value>' }
        Get spilloveraction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloveraction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloveraction/
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
        Write-Verbose "Invoke-ADCGetSpilloveraction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all spilloveraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloveraction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloveraction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloveraction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloveraction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloveraction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Add Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER Rule 
        Expression to be used by the spillover policy. 
    .PARAMETER Action 
        Action for the spillover policy. Action is created using add spillover action command. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the spillover policy. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddSpilloverpolicy -name <string> -rule <string> -action <string>
        An example how to add spilloverpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [string]$Action,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddSpilloverpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("spilloverpolicy", "Add Spillover configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloverpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $payload)
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
        Delete Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteSpilloverpolicy -Name <string>
        An example how to delete spilloverpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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
        Write-Verbose "Invoke-ADCDeleteSpilloverpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Spillover configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type spilloverpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Update Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER Rule 
        Expression to be used by the spillover policy. 
    .PARAMETER Action 
        Action for the spillover policy. Action is created using add spillover action command. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the spillover policy. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateSpilloverpolicy -name <string>
        An example how to update spilloverpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [string]$Rule,

        [string]$Action,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateSpilloverpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("spilloverpolicy", "Update Spillover configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type spilloverpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $payload)
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
        Unset Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER Comment 
        Any comments that you might want to associate with the spillover policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetSpilloverpolicy -name <string>
        An example how to unset spilloverpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy
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

        [string]$Name,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetSpilloverpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Spillover configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type spilloverpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Rename Spillover configuration Object.
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER Newname 
        New name for the spillover policy. Must begin with an ASCII alphabetic or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at (@), equals (=), and hyphen (-) characters. 
        Choose a name that reflects the function that the policy performs. 
    .PARAMETER PassThru 
        Return details about the created spilloverpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameSpilloverpolicy -name <string> -newname <string>
        An example how to rename spilloverpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameSpilloverpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("spilloverpolicy", "Rename Spillover configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type spilloverpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetSpilloverpolicy -Filter $payload)
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Configuration for Spillover policy resource.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER GetAll 
        Retrieve all spilloverpolicy object(s).
    .PARAMETER Count
        If specified, the count of the spilloverpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicy -GetAll 
        Get all spilloverpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicy -Count 
        Get the number of spilloverpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicy -name <string>
        Get spilloverpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicy -Filter @{ 'name'='<value>' }
        Get spilloverpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy/
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
        Write-Verbose "Invoke-ADCGetSpilloverpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all spilloverpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to spilloverpolicy.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER GetAll 
        Retrieve all spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicybinding -GetAll 
        Get all spilloverpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicybinding -name <string>
        Get spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicybinding -Filter @{ 'name'='<value>' }
        Get spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_binding/
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
        [string]$Name,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetSpilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to spilloverpolicy.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER GetAll 
        Retrieve all spilloverpolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicycsvserverbinding -GetAll 
        Get all spilloverpolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicycsvserverbinding -Count 
        Get the number of spilloverpolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicycsvserverbinding -name <string>
        Get spilloverpolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get spilloverpolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicycsvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_csvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all spilloverpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to spilloverpolicy.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER GetAll 
        Retrieve all spilloverpolicy_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicygslbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicygslbvserverbinding -GetAll 
        Get all spilloverpolicy_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicygslbvserverbinding -Count 
        Get the number of spilloverpolicy_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicygslbvserverbinding -name <string>
        Get spilloverpolicy_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicygslbvserverbinding -Filter @{ 'name'='<value>' }
        Get spilloverpolicy_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicygslbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_gslbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all spilloverpolicy_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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
        Get Spillover configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to spilloverpolicy.
    .PARAMETER Name 
        Name of the spillover policy. 
    .PARAMETER GetAll 
        Retrieve all spilloverpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the spilloverpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicylbvserverbinding -GetAll 
        Get all spilloverpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetSpilloverpolicylbvserverbinding -Count 
        Get the number of spilloverpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicylbvserverbinding -name <string>
        Get spilloverpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetSpilloverpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get spilloverpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetSpilloverpolicylbvserverbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/spillover/spilloverpolicy_lbvserver_binding/
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
        [string]$Name,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all spilloverpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for spilloverpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving spilloverpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type spilloverpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
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


