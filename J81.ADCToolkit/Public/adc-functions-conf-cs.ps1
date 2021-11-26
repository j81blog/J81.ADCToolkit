function Invoke-ADCAddCsaction {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER Targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER Targetvserverexpr 
        Information about this content switching action. 
    .PARAMETER Comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsaction -name <string>
        An example how to add csaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Targetlbvserver,

        [string]$Targetvserver,

        [string]$Targetvserverexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserverexpr') ) { $payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("csaction", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsaction: Finished"
    }
}

function Invoke-ADCDeleteCsaction {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsaction -Name <string>
        An example how to delete csaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCDeleteCsaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsaction: Finished"
    }
}

function Invoke-ADCUpdateCsaction {
    <#
    .SYNOPSIS
        Update Content Switching configuration Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER Targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER Targetvserverexpr 
        Information about this content switching action. 
    .PARAMETER Comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCsaction -name <string>
        An example how to update csaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [string]$Targetlbvserver,

        [string]$Targetvserver,

        [string]$Targetvserverexpr,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserverexpr') ) { $payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("csaction", "Update Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateCsaction: Finished"
    }
}

function Invoke-ADCUnsetCsaction {
    <#
    .SYNOPSIS
        Unset Content Switching configuration Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Comment 
        Comments associated with this cs action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCsaction -name <string>
        An example how to unset csaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction
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

        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCsaction: Finished"
    }
}

function Invoke-ADCRenameCsaction {
    <#
    .SYNOPSIS
        Rename Content Switching configuration Object.
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER Newname 
        New name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCsaction -name <string> -newname <string>
        An example how to rename csaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCsaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("csaction", "Rename Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCsaction: Finished"
    }
}

function Invoke-ADCGetCsaction {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Configuration for Content Switching action resource.
    .PARAMETER Name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER GetAll 
        Retrieve all csaction object(s).
    .PARAMETER Count
        If specified, the count of the csaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsaction -GetAll 
        Get all csaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsaction -Count 
        Get the number of csaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsaction -name <string>
        Get csaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsaction -Filter @{ 'name'='<value>' }
        Get csaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCGetCsaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsaction: Ended"
    }
}

function Invoke-ADCUpdateCsparameter {
    <#
    .SYNOPSIS
        Update Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER Stateupdate 
        Specifies whether the virtual server checks the attached load balancing server for state information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCsparameter 
        An example how to update csparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter/
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
        [string]$Stateupdate 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSCmdlet.ShouldProcess("csparameter", "Update Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateCsparameter: Finished"
    }
}

function Invoke-ADCUnsetCsparameter {
    <#
    .SYNOPSIS
        Unset Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER Stateupdate 
        Specifies whether the virtual server checks the attached load balancing server for state information. 
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCsparameter 
        An example how to unset csparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter
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

        [Boolean]$stateupdate 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSCmdlet.ShouldProcess("csparameter", "Unset Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCsparameter: Finished"
    }
}

function Invoke-ADCGetCsparameter {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Configuration for CS parameter resource.
    .PARAMETER GetAll 
        Retrieve all csparameter object(s).
    .PARAMETER Count
        If specified, the count of the csparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsparameter -GetAll 
        Get all csparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsparameter -name <string>
        Get csparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsparameter -Filter @{ 'name'='<value>' }
        Get csparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter/
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
        Write-Verbose "Invoke-ADCGetCsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving csparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsparameter: Ended"
    }
}

function Invoke-ADCAddCspolicy {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCspolicy -policyname <string> -rule <string>
        An example how to add cspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCAddCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                rule                 = $rule
            }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("cspolicy", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCspolicy: Finished"
    }
}

function Invoke-ADCDeleteCspolicy {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCspolicy -Policyname <string>
        An example how to delete cspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCDeleteCspolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$policyname", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCspolicy: Finished"
    }
}

function Invoke-ADCUpdateCspolicy {
    <#
    .SYNOPSIS
        Update Content Switching configuration Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Rule 
        Expression, or name of a named expression, against which traffic is evaluated. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCspolicy -policyname <string>
        An example how to update cspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCUpdateCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("cspolicy", "Update Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cspolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateCspolicy: Finished"
    }
}

function Invoke-ADCUnsetCspolicy {
    <#
    .SYNOPSIS
        Unset Content Switching configuration Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Logaction 
        The log action associated with the content switching policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCspolicy -policyname <string>
        An example how to unset cspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy
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
        Write-Verbose "Invoke-ADCUnsetCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$policyname", "Unset Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cspolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCspolicy: Finished"
    }
}

function Invoke-ADCRenameCspolicy {
    <#
    .SYNOPSIS
        Rename Content Switching configuration Object.
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER Newname 
        The new name of the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCspolicy -policyname <string> -newname <string>
        An example how to rename cspolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCRenameCspolicy: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                newname              = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cspolicy", "Rename Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCspolicy: Finished"
    }
}

function Invoke-ADCGetCspolicy {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Configuration for content-switching policy resource.
    .PARAMETER Policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER GetAll 
        Retrieve all cspolicy object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicy -GetAll 
        Get all cspolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicy -Count 
        Get the number of cspolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicy -name <string>
        Get cspolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicy -Filter @{ 'name'='<value>' }
        Get cspolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCGetCspolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicy: Ended"
    }
}

function Invoke-ADCAddCspolicylabel {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER Cspolicylabeltype 
        Protocol supported by the policy label. All policies bound to the policy label must either match the specified protocol or be a subtype of that protocol. Available settings function as follows: 
        * HTTP - Supports policies that process HTTP traffic. Used to access unencrypted Web sites. (The default.) 
        * SSL - Supports policies that process HTTPS/SSL encrypted traffic. Used to access encrypted Web sites. 
        * TCP - Supports policies that process any type of TCP traffic, including HTTP. 
        * SSL_TCP - Supports policies that process SSL-encrypted TCP traffic, including SSL. 
        * UDP - Supports policies that process any type of UDP-based traffic, including DNS. 
        * DNS - Supports policies that process DNS traffic. 
        * ANY - Supports all types of policies except HTTP, SSL, and TCP. 
        * SIP_UDP - Supports policies that process UDP based Session Initiation Protocol (SIP) traffic. SIP initiates, manages, and terminates multimedia communications sessions, and has emerged as the standard for Internet telephony (VoIP). 
        * RTSP - Supports policies that process Real Time Streaming Protocol (RTSP) traffic. RTSP provides delivery of multimedia and other streaming data, such as audio, video, and other types of streamed media. 
        * RADIUS - Supports policies that process Remote Authentication Dial In User Service (RADIUS) traffic. RADIUS supports combined authentication, authorization, and auditing services for network management. 
        * MYSQL - Supports policies that process MYSQL traffic. 
        * MSSQL - Supports policies that process Microsoft SQL traffic. 
        Possible values = HTTP, TCP, RTSP, SSL, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, ANY, RADIUS, RDP, MYSQL, MSSQL, ORACLE, DIAMETER, SSL_DIAMETER, FTP, DNS_TCP, SMPP, MQTT, MQTT_TLS, HTTP_QUIC 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCspolicylabel -labelname <string> -cspolicylabeltype <string>
        An example how to add cspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateSet('HTTP', 'TCP', 'RTSP', 'SSL', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'ORACLE', 'DIAMETER', 'SSL_DIAMETER', 'FTP', 'DNS_TCP', 'SMPP', 'MQTT', 'MQTT_TLS', 'HTTP_QUIC')]
        [string]$Cspolicylabeltype,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                cspolicylabeltype   = $cspolicylabeltype
            }

            if ( $PSCmdlet.ShouldProcess("cspolicylabel", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCspolicylabel: Finished"
    }
}

function Invoke-ADCDeleteCspolicylabel {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCspolicylabel -Labelname <string>
        An example how to delete cspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [string]$Labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCspolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCspolicylabel: Finished"
    }
}

function Invoke-ADCRenameCspolicylabel {
    <#
    .SYNOPSIS
        Rename Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER Newname 
        The new name of the content switching policylabel. 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCspolicylabel -labelname <string> -newname <string>
        An example how to rename cspolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Labelname,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameCspolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("cspolicylabel", "Rename Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCspolicylabel: Finished"
    }
}

function Invoke-ADCGetCspolicylabel {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Configuration for CS policy label resource.
    .PARAMETER Labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicylabel -GetAll 
        Get all cspolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicylabel -Count 
        Get the number of cspolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabel -name <string>
        Get cspolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabel -Filter @{ 'name'='<value>' }
        Get cspolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Labelname,

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
        Write-Verbose "Invoke-ADCGetCspolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all cspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicylabel: Ended"
    }
}

function Invoke-ADCGetCspolicylabelbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the content switching policy label to display. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicylabelbinding -GetAll 
        Get all cspolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelbinding -name <string>
        Get cspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelbinding -Filter @{ 'name'='<value>' }
        Get cspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_binding/
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
        [string]$Labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicylabelbinding: Ended"
    }
}

function Invoke-ADCAddCspolicylabelcspolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER Policyname 
        Name of the content switching policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Targetvserver 
        Name of the virtual server to which to forward requests that match the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        . 
    .PARAMETER Labeltype 
        Type of policy label invocation. 
        Possible values = policylabel 
    .PARAMETER Invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCspolicylabelcspolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add cspolicylabel_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCspolicylabelcspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$Labelname,

        [Parameter(Mandatory)]
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Targetvserver,

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCspolicylabelcspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("cspolicylabel_cspolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cspolicylabel_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCspolicylabelcspolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCspolicylabelcspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCspolicylabelcspolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER Policyname 
        Name of the content switching policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCspolicylabelcspolicybinding -Labelname <string>
        An example how to delete cspolicylabel_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCspolicylabelcspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$Labelname,

        [string]$Policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCspolicylabelcspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCspolicylabelcspolicybinding: Finished"
    }
}

function Invoke-ADCGetCspolicylabelcspolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to cspolicylabel.
    .PARAMETER Labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER GetAll 
        Retrieve all cspolicylabel_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicylabel_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelcspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicylabelcspolicybinding -GetAll 
        Get all cspolicylabel_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicylabelcspolicybinding -Count 
        Get the number of cspolicylabel_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelcspolicybinding -name <string>
        Get cspolicylabel_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicylabelcspolicybinding -Filter @{ 'name'='<value>' }
        Get cspolicylabel_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicylabelcspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$Labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCspolicylabelcspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicylabel_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicylabelcspolicybinding: Ended"
    }
}

function Invoke-ADCGetCspolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicybinding -GetAll 
        Get all cspolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicybinding -name <string>
        Get cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicybinding -Filter @{ 'name'='<value>' }
        Get cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicybinding: Ended"
    }
}

function Invoke-ADCGetCspolicycrvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the crvserver that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_crvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_crvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycrvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycrvserverbinding -GetAll 
        Get all cspolicy_crvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycrvserverbinding -Count 
        Get the number of cspolicy_crvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycrvserverbinding -name <string>
        Get cspolicy_crvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycrvserverbinding -Filter @{ 'name'='<value>' }
        Get cspolicy_crvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicycrvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_crvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicycrvserverbinding: Ended"
    }
}

function Invoke-ADCGetCspolicycspolicylabelbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the cspolicylabel that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_cspolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_cspolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycspolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycspolicylabelbinding -GetAll 
        Get all cspolicy_cspolicylabel_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycspolicylabelbinding -Count 
        Get the number of cspolicy_cspolicylabel_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycspolicylabelbinding -name <string>
        Get cspolicy_cspolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycspolicylabelbinding -Filter @{ 'name'='<value>' }
        Get cspolicy_cspolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicycspolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_cspolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicycspolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetCspolicycsvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the csvserver that can be bound to cspolicy.
    .PARAMETER Policyname 
        Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retrieve all cspolicy_csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the cspolicy_csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycsvserverbinding -GetAll 
        Get all cspolicy_csvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCspolicycsvserverbinding -Count 
        Get the number of cspolicy_csvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycsvserverbinding -name <string>
        Get cspolicy_csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCspolicycsvserverbinding -Filter @{ 'name'='<value>' }
        Get cspolicy_csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCspolicycsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all cspolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCspolicycsvserverbinding: Ended"
    }
}

function Invoke-ADCAddCsvserver {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0. 
    .PARAMETER Servicetype 
        Protocol used by the virtual server. 
        Possible values = HTTP, SSL, TCP, FTP, RTSP, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, SIP_SSL, ANY, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, DNS_TCP, ORACLE, SMPP, PROXY, MONGO, MONGO_TLS, MQTT, MQTT_TLS, HTTP_QUIC 
    .PARAMETER Ipv46 
        IP address of the content switching virtual server. 
    .PARAMETER Targettype 
        Virtual server target type. 
        Possible values = GSLB 
    .PARAMETER Dnsrecordtype 
        . 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Range 
        Number of consecutive IP addresses, starting with the address specified by the IP Address parameter, to include in a range of addresses assigned to this virtual server. 
    .PARAMETER Port 
        Port number for content switching virtual server. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER State 
        Initial state of the load balancing virtual server. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
        Possible values = YES, NO 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
        Possible values = RULE, URL 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
        Possible values = ON, OFF 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
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
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserver -name <string> -servicetype <string>
        An example how to add csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        [ValidateSet('HTTP', 'SSL', 'TCP', 'FTP', 'RTSP', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'DNS_TCP', 'ORACLE', 'SMPP', 'PROXY', 'MONGO', 'MONGO_TLS', 'MQTT', 'MQTT_TLS', 'HTTP_QUIC')]
        [string]$Servicetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv46,

        [ValidateSet('GSLB')]
        [string]$Targettype,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype = 'NSGSLB_IPV4',

        [ValidateRange(0, 65535)]
        [double]$Persistenceid,

        [string]$Ippattern,

        [string]$Ipmask,

        [ValidateRange(1, 254)]
        [double]$Range = '1',

        [ValidateRange(1, 65535)]
        [int]$Port,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$State = 'ENABLED',

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$Stateupdate = 'DISABLED',

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable = 'NO',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirecturl,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence = 'RULE',

        [ValidateSet('ON', 'OFF')]
        [string]$Casesensitive = 'ON',

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence = 'DISABLED',

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout = '2',

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite = 'DISABLED',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush = 'ENABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Backupvserver,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown = 'DISABLED',

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat = 'OFF',

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication = 'OFF',

        [string]$Listenpolicy = '"NONE"',

        [ValidateRange(0, 100)]
        [double]$Listenpriority = '101',

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401 = 'OFF',

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push = 'DISABLED',

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel = '"none"',

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients = 'NO',

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion = '10G',

        [string]$Comment,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion = '2008R2',

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [double]$Mysqlprotocolversion = '10',

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset = '8',

        [double]$Mysqlservercapabilities = '41613',

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog = 'ENABLED',

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse = 'PASSIVE',

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate = 'PASSIVE',

        [string]$Authnprofile,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('ON', 'OFF')]
        [string]$Dtls = 'OFF',

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen = '128',

        [ValidateRange(0, 1440)]
        [double]$Timeout = '2',

        [string]$Cookiename,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout = '2',

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode = '"200 OK"',

        [ValidateRange(1, 65535)]
        [int]$Probeport = '0',

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                servicetype    = $servicetype
            }
            if ( $PSBoundParameters.ContainsKey('td') ) { $payload.Add('td', $td) }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('targettype') ) { $payload.Add('targettype', $targettype) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('range') ) { $payload.Add('range', $range) }
            if ( $PSBoundParameters.ContainsKey('port') ) { $payload.Add('port', $port) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('state') ) { $payload.Add('state', $state) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSCmdlet.ShouldProcess("csvserver", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserver: Finished"
    }
}

function Invoke-ADCDeleteCsvserver {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserver -Name <string>
        An example how to delete csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCDeleteCsvserver: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserver: Finished"
    }
}

function Invoke-ADCUpdateCsvserver {
    <#
    .SYNOPSIS
        Update Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Ipv46 
        IP address of the content switching virtual server. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER Ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter. 
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask). 
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER Ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
        Possible values = RULE, URL 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
        Possible values = YES, NO 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Dnsrecordtype 
        . 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        . 
    .PARAMETER Backupip 
        . 
    .PARAMETER Cookiedomain 
        . 
    .PARAMETER Cookietimeout 
        . 
    .PARAMETER Sitedomainttl 
        . 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
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
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateCsvserver -name <string>
        An example how to update csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipv46,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Ipset,

        [string]$Ippattern,

        [string]$Ipmask,

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$Stateupdate,

        [ValidateSet('RULE', 'URL')]
        [string]$Precedence,

        [ValidateSet('ON', 'OFF')]
        [string]$Casesensitive,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$Backupvserver,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Redirecturl,

        [ValidateSet('YES', 'NO')]
        [string]$Cacheable,

        [ValidateRange(0, 31536000)]
        [double]$Clttimeout,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$Somethod,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Sopersistence,

        [ValidateRange(2, 1440)]
        [double]$Sopersistencetimeout,

        [ValidateRange(1, 4294967287)]
        [double]$Sothreshold,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$Sobackupaction,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Redirectportrewrite,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Downstateflush,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Disableprimaryondown,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$Insertvserveripport,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Vipheader,

        [ValidateSet('ON', 'OFF')]
        [string]$Rtspnat,

        [ValidateLength(3, 252)]
        [string]$Authenticationhost,

        [ValidateSet('ON', 'OFF')]
        [string]$Authentication,

        [string]$Listenpolicy,

        [ValidateRange(0, 100)]
        [double]$Listenpriority,

        [ValidateSet('ON', 'OFF')]
        [string]$Authn401,

        [ValidateLength(1, 252)]
        [string]$Authnvsname,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Push,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Pushvserver,

        [string]$Pushlabel,

        [ValidateSet('YES', 'NO')]
        [string]$Pushmulticlients,

        [ValidateLength(1, 127)]
        [string]$Tcpprofilename,

        [ValidateLength(1, 127)]
        [string]$Httpprofilename,

        [ValidateLength(1, 127)]
        [string]$Dbprofilename,

        [string]$Comment,

        [ValidateSet('ON', 'OFF')]
        [string]$L2conn,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$Mssqlserverversion,

        [double]$Mysqlprotocolversion,

        [ValidateSet('10G', '11G')]
        [string]$Oracleserverversion,

        [ValidateLength(1, 31)]
        [string]$Mysqlserverversion,

        [double]$Mysqlcharacterset,

        [double]$Mysqlservercapabilities,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$Appflowlog,

        [ValidateLength(1, 127)]
        [string]$Netprofile,

        [string]$Authnprofile,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Icmpvsrresponse,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$Rhistate,

        [ValidateLength(1, 127)]
        [string]$Dnsprofilename,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$Dnsrecordtype,

        [ValidateRange(0, 65535)]
        [double]$Persistenceid,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [ValidateRange(0, 1440)]
        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [ValidateSet('ON', 'OFF')]
        [string]$Dtls,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$Persistencetype,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Persistmask,

        [ValidateRange(1, 128)]
        [double]$V6persistmasklen,

        [ValidateRange(0, 1440)]
        [double]$Timeout,

        [string]$Cookiename,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$Persistencebackup,

        [ValidateRange(2, 1440)]
        [double]$Backuppersistencetimeout,

        [ValidateRange(1, 65535)]
        [int]$Tcpprobeport,

        [ValidateSet('TCP', 'HTTP')]
        [string]$Probeprotocol,

        [ValidateLength(1, 64)]
        [string]$Probesuccessresponsecode,

        [ValidateRange(1, 65535)]
        [int]$Probeport,

        [ValidateLength(1, 255)]
        [string]$Quicprofilename,

        [ValidateRange(1, 65535)]
        [int]$Redirectfromport,

        [string]$Httpsredirecturl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('ipv46') ) { $payload.Add('ipv46', $ipv46) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('ippattern') ) { $payload.Add('ippattern', $ippattern) }
            if ( $PSBoundParameters.ContainsKey('ipmask') ) { $payload.Add('ipmask', $ipmask) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSBoundParameters.ContainsKey('probeport') ) { $payload.Add('probeport', $probeport) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSCmdlet.ShouldProcess("csvserver", "Update Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateCsvserver: Finished"
    }
}

function Invoke-ADCUnsetCsvserver {
    <#
    .SYNOPSIS
        Unset Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target. 
        Possible values = ON, OFF 
    .PARAMETER Backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER Clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are: 
        180 seconds for HTTP/SSL-based services. 
        9000 seconds for other TCP-based services. 
        120 seconds for DNS-based services. 
        120 seconds for other UDP-based services. 
    .PARAMETER Redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL. 
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
    .PARAMETER Authn401 
        Enable HTTP 401-response based authentication. 
        Possible values = ON, OFF 
    .PARAMETER Authentication 
        Authenticate users who request a connection to the content switching virtual server. 
        Possible values = ON, OFF 
    .PARAMETER Authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
    .PARAMETER Pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
    .PARAMETER Pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server. 
    .PARAMETER Httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
    .PARAMETER Dbprofilename 
        Name of the DB profile. 
    .PARAMETER L2conn 
        Use L2 Parameters to identify a connection. 
        Possible values = ON, OFF 
    .PARAMETER Mysqlprotocolversion 
        The protocol version returned by the mysql vserver. 
    .PARAMETER Mysqlserverversion 
        The server version string returned by the mysql vserver. 
    .PARAMETER Mysqlcharacterset 
        The character set returned by the mysql vserver. 
    .PARAMETER Mysqlservercapabilities 
        The server capabilities returned by the mysql vserver. 
    .PARAMETER Appflowlog 
        Enable logging appflow flow information. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Netprofile 
        The name of the network profile. 
    .PARAMETER Icmpvsrresponse 
        Can be active or passive. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER Sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
    .PARAMETER Dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
    .PARAMETER Tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Probeprotocol 
        Citrix ADC provides support for external health check of the vserver status. Select HTTP or TCP probes for healthcheck. 
        Possible values = TCP, HTTP 
    .PARAMETER Quicprofilename 
        Name of QUIC profile which will be attached to the Content Switching VServer. 
    .PARAMETER Redirectfromport 
        Port number for the virtual server, from which we absorb the traffic for http redirect. 
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER Httpsredirecturl 
        URL to which all HTTP traffic received on the port specified in the -redirectFromPort parameter is redirected. 
    .PARAMETER Ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
    .PARAMETER Stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows: 
        Global Level | Vserver Level | Result 
        ENABLED ENABLED ENABLED 
        ENABLED DISABLED ENABLED 
        DISABLED ENABLED ENABLED 
        DISABLED DISABLED DISABLED 
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter. 
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER Precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies. 
        Possible values = RULE, URL 
    .PARAMETER Cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers. 
        Possible values = YES, NO 
    .PARAMETER Somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic. 
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER Sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence. 
    .PARAMETER Sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists. 
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER Redirectportrewrite 
        State of port rewrite while performing HTTP redirect. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows: 
        VIPADDR - Header contains the vserver's IP address and port number without any translation. 
        OFF - The virtual IP and port header insertion option is disabled. 
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command. 
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER Vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
    .PARAMETER Rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections. 
        Possible values = ON, OFF 
    .PARAMETER Listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
    .PARAMETER Listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
    .PARAMETER Push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL. 
        Possible values = ENABLED, DISABLED 
    .PARAMETER Pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates. 
        Possible values = YES, NO 
    .PARAMETER Comment 
        Information about this virtual server. 
    .PARAMETER Mssqlserverversion 
        The version of the MSSQL server. 
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER Oracleserverversion 
        Oracle server version. 
        Possible values = 10G, 11G 
    .PARAMETER Rhistate 
        A host route is injected according to the setting on the virtual servers 
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute. 
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP. 
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP. 
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER Dnsrecordtype 
        . 
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER Persistenceid 
        . 
    .PARAMETER Dtls 
        This option starts/stops the dtls service on the vserver. 
        Possible values = ON, OFF 
    .PARAMETER Persistencetype 
        Type of persistence for the virtual server. Available settings function as follows: 
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session. 
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session. 
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session. 
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER Persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers. 
    .PARAMETER V6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers. 
    .PARAMETER Timeout 
        Time period for which a persistence session is in effect. 
    .PARAMETER Cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER Persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails. 
        Possible values = SOURCEIP, NONE 
    .PARAMETER Backuppersistencetimeout 
        Time period for which backup persistence is in effect. 
    .PARAMETER Probesuccessresponsecode 
        HTTP code to return in SUCCESS case.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetCsvserver -name <string>
        An example how to unset csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver
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

        [Boolean]$casesensitive,

        [Boolean]$backupvserver,

        [Boolean]$clttimeout,

        [Boolean]$redirecturl,

        [Boolean]$authn401,

        [Boolean]$authentication,

        [Boolean]$authenticationhost,

        [Boolean]$authnvsname,

        [Boolean]$pushvserver,

        [Boolean]$pushlabel,

        [Boolean]$tcpprofilename,

        [Boolean]$httpprofilename,

        [Boolean]$dbprofilename,

        [Boolean]$l2conn,

        [Boolean]$mysqlprotocolversion,

        [Boolean]$mysqlserverversion,

        [Boolean]$mysqlcharacterset,

        [Boolean]$mysqlservercapabilities,

        [Boolean]$appflowlog,

        [Boolean]$netprofile,

        [Boolean]$icmpvsrresponse,

        [Boolean]$authnprofile,

        [Boolean]$sothreshold,

        [Boolean]$dnsprofilename,

        [Boolean]$tcpprobeport,

        [Boolean]$probeprotocol,

        [Boolean]$quicprofilename,

        [Boolean]$redirectfromport,

        [Boolean]$httpsredirecturl,

        [Boolean]$ipset,

        [Boolean]$stateupdate,

        [Boolean]$precedence,

        [Boolean]$cacheable,

        [Boolean]$somethod,

        [Boolean]$sopersistence,

        [Boolean]$sopersistencetimeout,

        [Boolean]$sobackupaction,

        [Boolean]$redirectportrewrite,

        [Boolean]$downstateflush,

        [Boolean]$disableprimaryondown,

        [Boolean]$insertvserveripport,

        [Boolean]$vipheader,

        [Boolean]$rtspnat,

        [Boolean]$listenpolicy,

        [Boolean]$listenpriority,

        [Boolean]$push,

        [Boolean]$pushmulticlients,

        [Boolean]$comment,

        [Boolean]$mssqlserverversion,

        [Boolean]$oracleserverversion,

        [Boolean]$rhistate,

        [Boolean]$dnsrecordtype,

        [Boolean]$persistenceid,

        [Boolean]$dtls,

        [Boolean]$persistencetype,

        [Boolean]$persistmask,

        [Boolean]$v6persistmasklen,

        [Boolean]$timeout,

        [Boolean]$cookiename,

        [Boolean]$persistencebackup,

        [Boolean]$backuppersistencetimeout,

        [Boolean]$probesuccessresponsecode 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('casesensitive') ) { $payload.Add('casesensitive', $casesensitive) }
            if ( $PSBoundParameters.ContainsKey('backupvserver') ) { $payload.Add('backupvserver', $backupvserver) }
            if ( $PSBoundParameters.ContainsKey('clttimeout') ) { $payload.Add('clttimeout', $clttimeout) }
            if ( $PSBoundParameters.ContainsKey('redirecturl') ) { $payload.Add('redirecturl', $redirecturl) }
            if ( $PSBoundParameters.ContainsKey('authn401') ) { $payload.Add('authn401', $authn401) }
            if ( $PSBoundParameters.ContainsKey('authentication') ) { $payload.Add('authentication', $authentication) }
            if ( $PSBoundParameters.ContainsKey('authenticationhost') ) { $payload.Add('authenticationhost', $authenticationhost) }
            if ( $PSBoundParameters.ContainsKey('authnvsname') ) { $payload.Add('authnvsname', $authnvsname) }
            if ( $PSBoundParameters.ContainsKey('pushvserver') ) { $payload.Add('pushvserver', $pushvserver) }
            if ( $PSBoundParameters.ContainsKey('pushlabel') ) { $payload.Add('pushlabel', $pushlabel) }
            if ( $PSBoundParameters.ContainsKey('tcpprofilename') ) { $payload.Add('tcpprofilename', $tcpprofilename) }
            if ( $PSBoundParameters.ContainsKey('httpprofilename') ) { $payload.Add('httpprofilename', $httpprofilename) }
            if ( $PSBoundParameters.ContainsKey('dbprofilename') ) { $payload.Add('dbprofilename', $dbprofilename) }
            if ( $PSBoundParameters.ContainsKey('l2conn') ) { $payload.Add('l2conn', $l2conn) }
            if ( $PSBoundParameters.ContainsKey('mysqlprotocolversion') ) { $payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlserverversion') ) { $payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('mysqlcharacterset') ) { $payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ( $PSBoundParameters.ContainsKey('mysqlservercapabilities') ) { $payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ( $PSBoundParameters.ContainsKey('appflowlog') ) { $payload.Add('appflowlog', $appflowlog) }
            if ( $PSBoundParameters.ContainsKey('netprofile') ) { $payload.Add('netprofile', $netprofile) }
            if ( $PSBoundParameters.ContainsKey('icmpvsrresponse') ) { $payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ( $PSBoundParameters.ContainsKey('authnprofile') ) { $payload.Add('authnprofile', $authnprofile) }
            if ( $PSBoundParameters.ContainsKey('sothreshold') ) { $payload.Add('sothreshold', $sothreshold) }
            if ( $PSBoundParameters.ContainsKey('dnsprofilename') ) { $payload.Add('dnsprofilename', $dnsprofilename) }
            if ( $PSBoundParameters.ContainsKey('tcpprobeport') ) { $payload.Add('tcpprobeport', $tcpprobeport) }
            if ( $PSBoundParameters.ContainsKey('probeprotocol') ) { $payload.Add('probeprotocol', $probeprotocol) }
            if ( $PSBoundParameters.ContainsKey('quicprofilename') ) { $payload.Add('quicprofilename', $quicprofilename) }
            if ( $PSBoundParameters.ContainsKey('redirectfromport') ) { $payload.Add('redirectfromport', $redirectfromport) }
            if ( $PSBoundParameters.ContainsKey('httpsredirecturl') ) { $payload.Add('httpsredirecturl', $httpsredirecturl) }
            if ( $PSBoundParameters.ContainsKey('ipset') ) { $payload.Add('ipset', $ipset) }
            if ( $PSBoundParameters.ContainsKey('stateupdate') ) { $payload.Add('stateupdate', $stateupdate) }
            if ( $PSBoundParameters.ContainsKey('precedence') ) { $payload.Add('precedence', $precedence) }
            if ( $PSBoundParameters.ContainsKey('cacheable') ) { $payload.Add('cacheable', $cacheable) }
            if ( $PSBoundParameters.ContainsKey('somethod') ) { $payload.Add('somethod', $somethod) }
            if ( $PSBoundParameters.ContainsKey('sopersistence') ) { $payload.Add('sopersistence', $sopersistence) }
            if ( $PSBoundParameters.ContainsKey('sopersistencetimeout') ) { $payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('sobackupaction') ) { $payload.Add('sobackupaction', $sobackupaction) }
            if ( $PSBoundParameters.ContainsKey('redirectportrewrite') ) { $payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ( $PSBoundParameters.ContainsKey('downstateflush') ) { $payload.Add('downstateflush', $downstateflush) }
            if ( $PSBoundParameters.ContainsKey('disableprimaryondown') ) { $payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ( $PSBoundParameters.ContainsKey('insertvserveripport') ) { $payload.Add('insertvserveripport', $insertvserveripport) }
            if ( $PSBoundParameters.ContainsKey('vipheader') ) { $payload.Add('vipheader', $vipheader) }
            if ( $PSBoundParameters.ContainsKey('rtspnat') ) { $payload.Add('rtspnat', $rtspnat) }
            if ( $PSBoundParameters.ContainsKey('listenpolicy') ) { $payload.Add('listenpolicy', $listenpolicy) }
            if ( $PSBoundParameters.ContainsKey('listenpriority') ) { $payload.Add('listenpriority', $listenpriority) }
            if ( $PSBoundParameters.ContainsKey('push') ) { $payload.Add('push', $push) }
            if ( $PSBoundParameters.ContainsKey('pushmulticlients') ) { $payload.Add('pushmulticlients', $pushmulticlients) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('mssqlserverversion') ) { $payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ( $PSBoundParameters.ContainsKey('oracleserverversion') ) { $payload.Add('oracleserverversion', $oracleserverversion) }
            if ( $PSBoundParameters.ContainsKey('rhistate') ) { $payload.Add('rhistate', $rhistate) }
            if ( $PSBoundParameters.ContainsKey('dnsrecordtype') ) { $payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ( $PSBoundParameters.ContainsKey('persistenceid') ) { $payload.Add('persistenceid', $persistenceid) }
            if ( $PSBoundParameters.ContainsKey('dtls') ) { $payload.Add('dtls', $dtls) }
            if ( $PSBoundParameters.ContainsKey('persistencetype') ) { $payload.Add('persistencetype', $persistencetype) }
            if ( $PSBoundParameters.ContainsKey('persistmask') ) { $payload.Add('persistmask', $persistmask) }
            if ( $PSBoundParameters.ContainsKey('v6persistmasklen') ) { $payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ( $PSBoundParameters.ContainsKey('timeout') ) { $payload.Add('timeout', $timeout) }
            if ( $PSBoundParameters.ContainsKey('cookiename') ) { $payload.Add('cookiename', $cookiename) }
            if ( $PSBoundParameters.ContainsKey('persistencebackup') ) { $payload.Add('persistencebackup', $persistencebackup) }
            if ( $PSBoundParameters.ContainsKey('backuppersistencetimeout') ) { $payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ( $PSBoundParameters.ContainsKey('probesuccessresponsecode') ) { $payload.Add('probesuccessresponsecode', $probesuccessresponsecode) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetCsvserver: Finished"
    }
}

function Invoke-ADCEnableCsvserver {
    <#
    .SYNOPSIS
        Enable Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCEnableCsvserver -name <string>
        An example how to enable csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCEnableCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCEnableCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Enable Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action enable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCEnableCsvserver: Finished"
    }
}

function Invoke-ADCDisableCsvserver {
    <#
    .SYNOPSIS
        Disable Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        PS C:\>Invoke-ADCDisableCsvserver -name <string>
        An example how to disable csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDisableCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCDisableCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }

            if ( $PSCmdlet.ShouldProcess($Name, "Disable Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action disable -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCDisableCsvserver: Finished"
    }
}

function Invoke-ADCRenameCsvserver {
    <#
    .SYNOPSIS
        Rename Content Switching configuration Object.
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER Newname 
        New name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameCsvserver -name <string> -newname <string>
        An example how to rename csvserver configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCRenameCsvserver: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("csvserver", "Rename Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameCsvserver: Finished"
    }
}

function Invoke-ADCGetCsvserver {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Configuration for CS virtual server resource.
    .PARAMETER Name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER GetAll 
        Retrieve all csvserver object(s).
    .PARAMETER Count
        If specified, the count of the csvserver object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserver
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserver -GetAll 
        Get all csvserver data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserver -Count 
        Get the number of csvserver objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserver -name <string>
        Get csvserver object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserver -Filter @{ 'name'='<value>' }
        Get csvserver data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserver
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCGetCsvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all csvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserver: Ended"
    }
}

function Invoke-ADCAddCsvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver. 
    .PARAMETER PassThru 
        Return details about the created csvserver_analyticsprofile_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserveranalyticsprofilebinding -name <string>
        An example how to add csvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserveranalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCAddCsvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('analyticsprofile') ) { $payload.Add('analyticsprofile', $analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("csvserver_analyticsprofile_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_analyticsprofile_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserveranalyticsprofilebinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Analyticsprofile 
        Name of the analytics profile bound to the LB vserver.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserveranalyticsprofilebinding -Name <string>
        An example how to delete csvserver_analyticsprofile_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserveranalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Analyticsprofile') ) { $arguments.Add('analyticsprofile', $Analyticsprofile) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserveranalyticsprofilebinding: Finished"
    }
}

function Invoke-ADCGetCsvserveranalyticsprofilebinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the analyticsprofile that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_analyticsprofile_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_analyticsprofile_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserveranalyticsprofilebinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserveranalyticsprofilebinding -GetAll 
        Get all csvserver_analyticsprofile_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserveranalyticsprofilebinding -Count 
        Get the number of csvserver_analyticsprofile_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserveranalyticsprofilebinding -name <string>
        Get csvserver_analyticsprofile_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
        Get csvserver_analyticsprofile_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserveranalyticsprofilebinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserveranalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserveranalyticsprofilebinding: Ended"
    }
}

function Invoke-ADCAddCsvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appflowpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverappflowpolicybinding -name <string>
        An example how to add csvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appflowpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appflowpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverappflowpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverappflowpolicybinding -Name <string>
        An example how to delete csvserver_appflowpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappflowpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverappflowpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the appflowpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appflowpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appflowpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappflowpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappflowpolicybinding -GetAll 
        Get all csvserver_appflowpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappflowpolicybinding -Count 
        Get the number of csvserver_appflowpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappflowpolicybinding -name <string>
        Get csvserver_appflowpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_appflowpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverappflowpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverappflowpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appfwpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverappfwpolicybinding -name <string>
        An example how to add csvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appfwpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appfwpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverappfwpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverappfwpolicybinding -Name <string>
        An example how to delete csvserver_appfwpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappfwpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverappfwpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the appfwpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appfwpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appfwpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappfwpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappfwpolicybinding -GetAll 
        Get all csvserver_appfwpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappfwpolicybinding -Count 
        Get the number of csvserver_appfwpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappfwpolicybinding -name <string>
        Get csvserver_appfwpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_appfwpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverappfwpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverappfwpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appqoepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverappqoepolicybinding -name <string>
        An example how to add csvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverappqoepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_appqoepolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appqoepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverappqoepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverappqoepolicybinding -Name <string>
        An example how to delete csvserver_appqoepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappqoepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappqoepolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverappqoepolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the appqoepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_appqoepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_appqoepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappqoepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappqoepolicybinding -GetAll 
        Get all csvserver_appqoepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverappqoepolicybinding -Count 
        Get the number of csvserver_appqoepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappqoepolicybinding -name <string>
        Get csvserver_appqoepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_appqoepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverappqoepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverappqoepolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditnslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverauditnslogpolicybinding -name <string>
        An example how to add csvserver_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_auditnslogpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditnslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverauditnslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverauditnslogpolicybinding -Name <string>
        An example how to delete csvserver_auditnslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditnslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverauditnslogpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the auditnslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_auditnslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_auditnslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditnslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauditnslogpolicybinding -GetAll 
        Get all csvserver_auditnslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauditnslogpolicybinding -Count 
        Get the number of csvserver_auditnslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditnslogpolicybinding -name <string>
        Get csvserver_auditnslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditnslogpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_auditnslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverauditnslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverauditnslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditsyslogpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverauditsyslogpolicybinding -name <string>
        An example how to add csvserver_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_auditsyslogpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditsyslogpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverauditsyslogpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverauditsyslogpolicybinding -Name <string>
        An example how to delete csvserver_auditsyslogpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditsyslogpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverauditsyslogpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the auditsyslogpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_auditsyslogpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_auditsyslogpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditsyslogpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauditsyslogpolicybinding -GetAll 
        Get all csvserver_auditsyslogpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauditsyslogpolicybinding -Count 
        Get the number of csvserver_auditsyslogpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditsyslogpolicybinding -name <string>
        Get csvserver_auditsyslogpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_auditsyslogpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverauditsyslogpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverauditsyslogpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_authorizationpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverauthorizationpolicybinding -name <string>
        An example how to add csvserver_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_authorizationpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_authorizationpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverauthorizationpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverauthorizationpolicybinding -Name <string>
        An example how to delete csvserver_authorizationpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauthorizationpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverauthorizationpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the authorizationpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_authorizationpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_authorizationpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauthorizationpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauthorizationpolicybinding -GetAll 
        Get all csvserver_authorizationpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverauthorizationpolicybinding -Count 
        Get the number of csvserver_authorizationpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauthorizationpolicybinding -name <string>
        Get csvserver_authorizationpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverauthorizationpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_authorizationpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverauthorizationpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverauthorizationpolicybinding: Ended"
    }
}

function Invoke-ADCGetCsvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to csvserver.
    .PARAMETER Name 
        Name of a content switching virtual server for which to display information, including the policies bound to the virtual server. To display a list of all configured Content Switching virtual servers, do not specify a value for this parameter. 
    .PARAMETER GetAll 
        Retrieve all csvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverbinding -GetAll 
        Get all csvserver_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbinding -name <string>
        Get csvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbinding -Filter @{ 'name'='<value>' }
        Get csvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverbinding: Ended"
    }
}

function Invoke-ADCAddCsvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_botpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverbotpolicybinding -name <string>
        An example how to add csvserver_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverbotpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_botpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_botpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverbotpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverbotpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverbotpolicybinding -Name <string>
        An example how to delete csvserver_botpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverbotpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverbotpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverbotpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the botpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_botpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_botpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbotpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverbotpolicybinding -GetAll 
        Get all csvserver_botpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverbotpolicybinding -Count 
        Get the number of csvserver_botpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbotpolicybinding -name <string>
        Get csvserver_botpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverbotpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_botpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverbotpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverbotpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservercachepolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cachepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservercachepolicybinding -name <string>
        An example how to add csvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservercachepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercachepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cachepolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cachepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservercachepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservercachepolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservercachepolicybinding -Name <string>
        An example how to delete csvserver_cachepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercachepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercachepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservercachepolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservercachepolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the cachepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cachepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cachepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercachepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercachepolicybinding -GetAll 
        Get all csvserver_cachepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercachepolicybinding -Count 
        Get the number of csvserver_cachepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercachepolicybinding -name <string>
        Get csvserver_cachepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercachepolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_cachepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservercachepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservercachepolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservercmppolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cmppolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservercmppolicybinding -name <string>
        An example how to add csvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservercmppolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercmppolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cmppolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cmppolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservercmppolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservercmppolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservercmppolicybinding -Name <string>
        An example how to delete csvserver_cmppolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercmppolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercmppolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservercmppolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservercmppolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the cmppolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cmppolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cmppolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercmppolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercmppolicybinding -GetAll 
        Get all csvserver_cmppolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercmppolicybinding -Count 
        Get the number of csvserver_cmppolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercmppolicybinding -name <string>
        Get csvserver_cmppolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercmppolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_cmppolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservercmppolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercmppolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservercmppolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_contentinspectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservercontentinspectionpolicybinding -name <string>
        An example how to add csvserver_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservercontentinspectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_contentinspectionpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_contentinspectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservercontentinspectionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservercontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservercontentinspectionpolicybinding -Name <string>
        An example how to delete csvserver_contentinspectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercontentinspectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservercontentinspectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservercontentinspectionpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the contentinspectionpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_contentinspectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_contentinspectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercontentinspectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercontentinspectionpolicybinding -GetAll 
        Get all csvserver_contentinspectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercontentinspectionpolicybinding -Count 
        Get the number of csvserver_contentinspectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercontentinspectionpolicybinding -name <string>
        Get csvserver_contentinspectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_contentinspectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservercontentinspectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservercontentinspectionpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservercspolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        target vserver name. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cspolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservercspolicybinding -name <string>
        An example how to add csvserver_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservercspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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

        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercspolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_cspolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cspolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservercspolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservercspolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservercspolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservercspolicybinding -Name <string>
        An example how to delete csvserver_cspolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercspolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservercspolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservercspolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the cspolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_cspolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_cspolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercspolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercspolicybinding -GetAll 
        Get all csvserver_cspolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservercspolicybinding -Count 
        Get the number of csvserver_cspolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercspolicybinding -name <string>
        Get csvserver_cspolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservercspolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_cspolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservercspolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservercspolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverdomainbinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address. 
    .PARAMETER Ttl 
        . 
    .PARAMETER Backupip 
        . 
    .PARAMETER Cookiedomain 
        . 
    .PARAMETER Cookietimeout 
        . 
    .PARAMETER Sitedomainttl 
        . 
    .PARAMETER PassThru 
        Return details about the created csvserver_domain_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverdomainbinding -name <string>
        An example how to add csvserver_domain_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverdomainbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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
        [string]$Domainname,

        [double]$Ttl,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Backupip,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Cookiedomain,

        [ValidateRange(0, 1440)]
        [double]$Cookietimeout,

        [double]$Sitedomainttl,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverdomainbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('domainname') ) { $payload.Add('domainname', $domainname) }
            if ( $PSBoundParameters.ContainsKey('ttl') ) { $payload.Add('ttl', $ttl) }
            if ( $PSBoundParameters.ContainsKey('backupip') ) { $payload.Add('backupip', $backupip) }
            if ( $PSBoundParameters.ContainsKey('cookiedomain') ) { $payload.Add('cookiedomain', $cookiedomain) }
            if ( $PSBoundParameters.ContainsKey('cookietimeout') ) { $payload.Add('cookietimeout', $cookietimeout) }
            if ( $PSBoundParameters.ContainsKey('sitedomainttl') ) { $payload.Add('sitedomainttl', $sitedomainttl) }
            if ( $PSCmdlet.ShouldProcess("csvserver_domain_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_domain_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverdomainbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverdomainbinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverdomainbinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverdomainbinding -Name <string>
        An example how to delete csvserver_domain_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverdomainbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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

        [string]$Domainname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvserverdomainbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Domainname') ) { $arguments.Add('domainname', $Domainname) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverdomainbinding: Finished"
    }
}

function Invoke-ADCGetCsvserverdomainbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the domain that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_domain_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_domain_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverdomainbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverdomainbinding -GetAll 
        Get all csvserver_domain_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverdomainbinding -Count 
        Get the number of csvserver_domain_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverdomainbinding -name <string>
        Get csvserver_domain_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverdomainbinding -Filter @{ 'name'='<value>' }
        Get csvserver_domain_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverdomainbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverdomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_domain_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_domain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverdomainbinding: Ended"
    }
}

function Invoke-ADCAddCsvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_feopolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverfeopolicybinding -name <string>
        An example how to add csvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverfeopolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_feopolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_feopolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverfeopolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverfeopolicybinding -Name <string>
        An example how to delete csvserver_feopolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverfeopolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfeopolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverfeopolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the feopolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_feopolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_feopolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfeopolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverfeopolicybinding -GetAll 
        Get all csvserver_feopolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverfeopolicybinding -Count 
        Get the number of csvserver_feopolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfeopolicybinding -name <string>
        Get csvserver_feopolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfeopolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_feopolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverfeopolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverfeopolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_filterpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverfilterpolicybinding -name <string>
        An example how to add csvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverfilterpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding.md/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_filterpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_filterpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverfilterpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverfilterpolicybinding -Name <string>
        An example how to delete csvserver_filterpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverfilterpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfilterpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverfilterpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the filterpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_filterpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_filterpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfilterpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverfilterpolicybinding -GetAll 
        Get all csvserver_filterpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverfilterpolicybinding -Count 
        Get the number of csvserver_filterpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfilterpolicybinding -name <string>
        Get csvserver_filterpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_filterpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverfilterpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding.md/
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
        Write-Verbose "Invoke-ADCGetCsvserverfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverfilterpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservergslbvserverbinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1. 
    .PARAMETER PassThru 
        Return details about the created csvserver_gslbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservergslbvserverbinding -name <string>
        An example how to add csvserver_gslbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservergslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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
        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservergslbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_gslbvserver_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_gslbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservergslbvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservergslbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservergslbvserverbinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservergslbvserverbinding -Name <string>
        An example how to delete csvserver_gslbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservergslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvservergslbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservergslbvserverbinding: Finished"
    }
}

function Invoke-ADCGetCsvservergslbvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the gslbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_gslbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_gslbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservergslbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservergslbvserverbinding -GetAll 
        Get all csvserver_gslbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservergslbvserverbinding -Count 
        Get the number of csvserver_gslbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservergslbvserverbinding -name <string>
        Get csvserver_gslbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservergslbvserverbinding -Filter @{ 'name'='<value>' }
        Get csvserver_gslbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservergslbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservergslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservergslbvserverbinding: Ended"
    }
}

function Invoke-ADCAddCsvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Lbvserver 
        Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1. 
    .PARAMETER Targetvserver 
        The virtual server name (created with the add lb vserver command) to which content will be switched. 
    .PARAMETER PassThru 
        Return details about the created csvserver_lbvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverlbvserverbinding -name <string>
        An example how to add csvserver_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverlbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Targetvserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('lbvserver') ) { $payload.Add('lbvserver', $lbvserver) }
            if ( $PSBoundParameters.ContainsKey('targetvserver') ) { $payload.Add('targetvserver', $targetvserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_lbvserver_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_lbvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverlbvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverlbvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Lbvserver 
        Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverlbvserverbinding -Name <string>
        An example how to delete csvserver_lbvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverlbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Lbvserver') ) { $arguments.Add('lbvserver', $Lbvserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverlbvserverbinding: Finished"
    }
}

function Invoke-ADCGetCsvserverlbvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverlbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverlbvserverbinding -GetAll 
        Get all csvserver_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverlbvserverbinding -Count 
        Get the number of csvserver_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverlbvserverbinding -name <string>
        Get csvserver_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverlbvserverbinding -Filter @{ 'name'='<value>' }
        Get csvserver_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverlbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverlbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverlbvserverbinding: Ended"
    }
}

function Invoke-ADCAddCsvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_responderpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverresponderpolicybinding -name <string>
        An example how to add csvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverresponderpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_responderpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_responderpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverresponderpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverresponderpolicybinding -Name <string>
        An example how to delete csvserver_responderpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverresponderpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverresponderpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverresponderpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the responderpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_responderpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_responderpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverresponderpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverresponderpolicybinding -GetAll 
        Get all csvserver_responderpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverresponderpolicybinding -Count 
        Get the number of csvserver_responderpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverresponderpolicybinding -name <string>
        Get csvserver_responderpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_responderpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverresponderpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverresponderpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverresponderpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_rewritepolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverrewritepolicybinding -name <string>
        An example how to add csvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverrewritepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_rewritepolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_rewritepolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverrewritepolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverrewritepolicybinding -Name <string>
        An example how to delete csvserver_rewritepolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverrewritepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverrewritepolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverrewritepolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the rewritepolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_rewritepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_rewritepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverrewritepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverrewritepolicybinding -GetAll 
        Get all csvserver_rewritepolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverrewritepolicybinding -Count 
        Get the number of csvserver_rewritepolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverrewritepolicybinding -name <string>
        Get csvserver_rewritepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_rewritepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverrewritepolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverrewritepolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_spilloverpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvserverspilloverpolicybinding -name <string>
        An example how to add csvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvserverspilloverpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_spilloverpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_spilloverpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvserverspilloverpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvserverspilloverpolicybinding -Name <string>
        An example how to delete csvserver_spilloverpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverspilloverpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvserverspilloverpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvserverspilloverpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the spilloverpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_spilloverpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_spilloverpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverspilloverpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverspilloverpolicybinding -GetAll 
        Get all csvserver_spilloverpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvserverspilloverpolicybinding -Count 
        Get the number of csvserver_spilloverpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverspilloverpolicybinding -name <string>
        Get csvserver_spilloverpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_spilloverpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvserverspilloverpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvserverspilloverpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE. 
    .PARAMETER Labeltype 
        Type of label to be invoked. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_tmtrafficpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservertmtrafficpolicybinding -name <string>
        An example how to add csvserver_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservertmtrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_tmtrafficpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_tmtrafficpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservertmtrafficpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservertmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        Bind point at which policy needs to be bound. Note: Content switching policies are evaluated only at request time. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservertmtrafficpolicybinding -Name <string>
        An example how to delete csvserver_tmtrafficpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservertmtrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservertmtrafficpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservertmtrafficpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the tmtrafficpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_tmtrafficpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_tmtrafficpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertmtrafficpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservertmtrafficpolicybinding -GetAll 
        Get all csvserver_tmtrafficpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservertmtrafficpolicybinding -Count 
        Get the number of csvserver_tmtrafficpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertmtrafficpolicybinding -name <string>
        Get csvserver_tmtrafficpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertmtrafficpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_tmtrafficpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservertmtrafficpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservertmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservertmtrafficpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver. 
    .PARAMETER Priority 
        Priority for the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Invoke 
        Invoke flag. 
    .PARAMETER Labeltype 
        The invocation type. 
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER Labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_transformpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservertransformpolicybinding -name <string>
        An example how to add csvserver_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservertransformpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        [string]$Targetlbvserver,

        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST', 'MQTT_JUMBO_REQ')]
        [string]$Bindpoint,

        [boolean]$Invoke,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('policyname') ) { $payload.Add('policyname', $policyname) }
            if ( $PSBoundParameters.ContainsKey('targetlbvserver') ) { $payload.Add('targetlbvserver', $targetlbvserver) }
            if ( $PSBoundParameters.ContainsKey('priority') ) { $payload.Add('priority', $priority) }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('bindpoint') ) { $payload.Add('bindpoint', $bindpoint) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("csvserver_transformpolicy_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_transformpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservertransformpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservertransformpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Policyname 
        Policies bound to this vserver. 
    .PARAMETER Bindpoint 
        The bindpoint to which the policy is bound. 
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST, MQTT_JUMBO_REQ 
    .PARAMETER Priority 
        Priority for the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservertransformpolicybinding -Name <string>
        An example how to delete csvserver_transformpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservertransformpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Bindpoint') ) { $arguments.Add('bindpoint', $Bindpoint) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservertransformpolicybinding: Finished"
    }
}

function Invoke-ADCGetCsvservertransformpolicybinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the transformpolicy that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_transformpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_transformpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertransformpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservertransformpolicybinding -GetAll 
        Get all csvserver_transformpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservertransformpolicybinding -Count 
        Get the number of csvserver_transformpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertransformpolicybinding -name <string>
        Get csvserver_transformpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservertransformpolicybinding -Filter @{ 'name'='<value>' }
        Get csvserver_transformpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservertransformpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservertransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservertransformpolicybinding: Ended"
    }
}

function Invoke-ADCAddCsvservervpnvserverbinding {
    <#
    .SYNOPSIS
        Add Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1. 
    .PARAMETER PassThru 
        Return details about the created csvserver_vpnvserver_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddCsvservervpnvserverbinding -name <string>
        An example how to add csvserver_vpnvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddCsvservervpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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
        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservervpnvserverbinding: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("csvserver_vpnvserver_binding", "Add Content Switching configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_vpnvserver_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetCsvservervpnvserverbinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddCsvservervpnvserverbinding: Finished"
    }
}

function Invoke-ADCDeleteCsvservervpnvserverbinding {
    <#
    .SYNOPSIS
        Delete Content Switching configuration Object.
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER Vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteCsvservervpnvserverbinding -Name <string>
        An example how to delete csvserver_vpnvserver_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteCsvservervpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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

        [string]$Vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvservervpnvserverbinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Vserver') ) { $arguments.Add('vserver', $Vserver) }
            if ( $PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteCsvservervpnvserverbinding: Finished"
    }
}

function Invoke-ADCGetCsvservervpnvserverbinding {
    <#
    .SYNOPSIS
        Get Content Switching configuration object(s).
    .DESCRIPTION
        Binding object showing the vpnvserver that can be bound to csvserver.
    .PARAMETER Name 
        Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retrieve all csvserver_vpnvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the csvserver_vpnvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservervpnvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservervpnvserverbinding -GetAll 
        Get all csvserver_vpnvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetCsvservervpnvserverbinding -Count 
        Get the number of csvserver_vpnvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservervpnvserverbinding -name <string>
        Get csvserver_vpnvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetCsvservervpnvserverbinding -Filter @{ 'name'='<value>' }
        Get csvserver_vpnvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetCsvservervpnvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservervpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all csvserver_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetCsvservervpnvserverbinding: Ended"
    }
}


