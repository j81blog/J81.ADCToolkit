function Invoke-ADCAddAutoscaleaction {
    <#
    .SYNOPSIS
        Add Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale action resource.
    .PARAMETER Name 
        ActionScale action name. 
    .PARAMETER Type 
        The type of action. 
        Possible values = SCALE_UP, SCALE_DOWN 
    .PARAMETER Profilename 
        AutoScale profile name. 
    .PARAMETER Parameters 
        Parameters to use in the action. 
    .PARAMETER Vmdestroygraceperiod 
        Time in minutes a VM is kept in inactive state before destroying. 
    .PARAMETER Quiettime 
        Time in seconds no other policy is evaluated or action is taken. 
    .PARAMETER Vserver 
        Name of the vserver on which autoscale action has to be taken. 
    .PARAMETER PassThru 
        Return details about the created autoscaleaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAutoscaleaction -name <string> -type <string> -profilename <string> -parameters <string> -vserver <string>
        An example how to add autoscaleaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAutoscaleaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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

        [Parameter(Mandatory)]
        [ValidateSet('SCALE_UP', 'SCALE_DOWN')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Profilename,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Parameters,

        [double]$Vmdestroygraceperiod = '10',

        [double]$Quiettime = '300',

        [Parameter(Mandatory)]
        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscaleaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
                profilename    = $profilename
                parameters     = $parameters
                vserver        = $vserver
            }
            if ( $PSBoundParameters.ContainsKey('vmdestroygraceperiod') ) { $payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('quiettime') ) { $payload.Add('quiettime', $quiettime) }
            if ( $PSCmdlet.ShouldProcess("autoscaleaction", "Add Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscaleaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscaleaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAutoscaleaction: Finished"
    }
}

function Invoke-ADCDeleteAutoscaleaction {
    <#
    .SYNOPSIS
        Delete Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale action resource.
    .PARAMETER Name 
        ActionScale action name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAutoscaleaction -Name <string>
        An example how to delete autoscaleaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAutoscaleaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscaleaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleaction: Finished"
    }
}

function Invoke-ADCUpdateAutoscaleaction {
    <#
    .SYNOPSIS
        Update Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale action resource.
    .PARAMETER Name 
        ActionScale action name. 
    .PARAMETER Profilename 
        AutoScale profile name. 
    .PARAMETER Parameters 
        Parameters to use in the action. 
    .PARAMETER Vmdestroygraceperiod 
        Time in minutes a VM is kept in inactive state before destroying. 
    .PARAMETER Quiettime 
        Time in seconds no other policy is evaluated or action is taken. 
    .PARAMETER Vserver 
        Name of the vserver on which autoscale action has to be taken. 
    .PARAMETER PassThru 
        Return details about the created autoscaleaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAutoscaleaction -name <string>
        An example how to update autoscaleaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAutoscaleaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        [string]$Profilename,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Parameters,

        [double]$Vmdestroygraceperiod,

        [double]$Quiettime,

        [string]$Vserver,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscaleaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('profilename') ) { $payload.Add('profilename', $profilename) }
            if ( $PSBoundParameters.ContainsKey('parameters') ) { $payload.Add('parameters', $parameters) }
            if ( $PSBoundParameters.ContainsKey('vmdestroygraceperiod') ) { $payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('quiettime') ) { $payload.Add('quiettime', $quiettime) }
            if ( $PSBoundParameters.ContainsKey('vserver') ) { $payload.Add('vserver', $vserver) }
            if ( $PSCmdlet.ShouldProcess("autoscaleaction", "Update Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscaleaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscaleaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAutoscaleaction: Finished"
    }
}

function Invoke-ADCUnsetAutoscaleaction {
    <#
    .SYNOPSIS
        Unset Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale action resource.
    .PARAMETER Name 
        ActionScale action name. 
    .PARAMETER Vmdestroygraceperiod 
        Time in minutes a VM is kept in inactive state before destroying. 
    .PARAMETER Quiettime 
        Time in seconds no other policy is evaluated or action is taken.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAutoscaleaction -name <string>
        An example how to unset autoscaleaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAutoscaleaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction
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
        [string]$Name,

        [Boolean]$vmdestroygraceperiod,

        [Boolean]$quiettime 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAutoscaleaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('vmdestroygraceperiod') ) { $payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ( $PSBoundParameters.ContainsKey('quiettime') ) { $payload.Add('quiettime', $quiettime) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Autoscale configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type autoscaleaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAutoscaleaction: Finished"
    }
}

function Invoke-ADCGetAutoscaleaction {
    <#
    .SYNOPSIS
        Get Autoscale configuration object(s).
    .DESCRIPTION
        Configuration for autoscale action resource.
    .PARAMETER Name 
        ActionScale action name. 
    .PARAMETER GetAll 
        Retrieve all autoscaleaction object(s).
    .PARAMETER Count
        If specified, the count of the autoscaleaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscaleaction -GetAll 
        Get all autoscaleaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscaleaction -Count 
        Get the number of autoscaleaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleaction -name <string>
        Get autoscaleaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleaction -Filter @{ 'name'='<value>' }
        Get autoscaleaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAutoscaleaction
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        Write-Verbose "Invoke-ADCGetAutoscaleaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all autoscaleaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscaleaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscaleaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscaleaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscaleaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAutoscaleaction: Ended"
    }
}

function Invoke-ADCAddAutoscalepolicy {
    <#
    .SYNOPSIS
        Add Autoscale configuration Object.
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER Rule 
        The rule associated with the policy. 
    .PARAMETER Action 
        The autoscale profile associated with the policy. 
    .PARAMETER Comment 
        Comments associated with this autoscale policy. 
    .PARAMETER Logaction 
        The log action associated with the autoscale policy. 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAutoscalepolicy -name <string> -rule <string> -action <string>
        An example how to add autoscalepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [Parameter(Mandatory)]
        [string]$Rule,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscalepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("autoscalepolicy", "Add Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscalepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAutoscalepolicy: Finished"
    }
}

function Invoke-ADCDeleteAutoscalepolicy {
    <#
    .SYNOPSIS
        Delete Autoscale configuration Object.
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAutoscalepolicy -Name <string>
        An example how to delete autoscalepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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
        Write-Verbose "Invoke-ADCDeleteAutoscalepolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscalepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAutoscalepolicy: Finished"
    }
}

function Invoke-ADCUpdateAutoscalepolicy {
    <#
    .SYNOPSIS
        Update Autoscale configuration Object.
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER Rule 
        The rule associated with the policy. 
    .PARAMETER Action 
        The autoscale profile associated with the policy. 
    .PARAMETER Comment 
        Comments associated with this autoscale policy. 
    .PARAMETER Logaction 
        The log action associated with the autoscale policy. 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAutoscalepolicy -name <string>
        An example how to update autoscalepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [string]$Rule,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Action,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscalepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("autoscalepolicy", "Update Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscalepolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAutoscalepolicy: Finished"
    }
}

function Invoke-ADCUnsetAutoscalepolicy {
    <#
    .SYNOPSIS
        Unset Autoscale configuration Object.
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER Rule 
        The rule associated with the policy. 
    .PARAMETER Action 
        The autoscale profile associated with the policy. 
    .PARAMETER Comment 
        Comments associated with this autoscale policy. 
    .PARAMETER Logaction 
        The log action associated with the autoscale policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetAutoscalepolicy -name <string>
        An example how to unset autoscalepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy
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
        [string]$Name,

        [Boolean]$rule,

        [Boolean]$action,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAutoscalepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset Autoscale configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type autoscalepolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetAutoscalepolicy: Finished"
    }
}

function Invoke-ADCRenameAutoscalepolicy {
    <#
    .SYNOPSIS
        Rename Autoscale configuration Object.
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER Newname 
        The new name of the autoscale policy. 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameAutoscalepolicy -name <string> -newname <string>
        An example how to rename autoscalepolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameAutoscalepolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("autoscalepolicy", "Rename Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscalepolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameAutoscalepolicy: Finished"
    }
}

function Invoke-ADCGetAutoscalepolicy {
    <#
    .SYNOPSIS
        Get Autoscale configuration object(s).
    .DESCRIPTION
        Configuration for Autoscale policy resource.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retrieve all autoscalepolicy object(s).
    .PARAMETER Count
        If specified, the count of the autoscalepolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscalepolicy -GetAll 
        Get all autoscalepolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscalepolicy -Count 
        Get the number of autoscalepolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicy -name <string>
        Get autoscalepolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicy -Filter @{ 'name'='<value>' }
        Get autoscalepolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicy
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all autoscalepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAutoscalepolicy: Ended"
    }
}

function Invoke-ADCGetAutoscalepolicybinding {
    <#
    .SYNOPSIS
        Get Autoscale configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to autoscalepolicy.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retrieve all autoscalepolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the autoscalepolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscalepolicybinding -GetAll 
        Get all autoscalepolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicybinding -name <string>
        Get autoscalepolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicybinding -Filter @{ 'name'='<value>' }
        Get autoscalepolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicybinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all autoscalepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAutoscalepolicybinding: Ended"
    }
}

function Invoke-ADCGetAutoscalepolicynstimerbinding {
    <#
    .SYNOPSIS
        Get Autoscale configuration object(s).
    .DESCRIPTION
        Binding object showing the nstimer that can be bound to autoscalepolicy.
    .PARAMETER Name 
        The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retrieve all autoscalepolicy_nstimer_binding object(s).
    .PARAMETER Count
        If specified, the count of the autoscalepolicy_nstimer_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicynstimerbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscalepolicynstimerbinding -GetAll 
        Get all autoscalepolicy_nstimer_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscalepolicynstimerbinding -Count 
        Get the number of autoscalepolicy_nstimer_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicynstimerbinding -name <string>
        Get autoscalepolicy_nstimer_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscalepolicynstimerbinding -Filter @{ 'name'='<value>' }
        Get autoscalepolicy_nstimer_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicynstimerbinding
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy_nstimer_binding/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicynstimerbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all autoscalepolicy_nstimer_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy_nstimer_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAutoscalepolicynstimerbinding: Ended"
    }
}

function Invoke-ADCAddAutoscaleprofile {
    <#
    .SYNOPSIS
        Add Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale profile resource.
    .PARAMETER Name 
        AutoScale profile name. 
    .PARAMETER Type 
        The type of profile. 
        Possible values = CLOUDSTACK 
    .PARAMETER Url 
        URL providing the service. 
    .PARAMETER Apikey 
        api key for authentication with service. 
    .PARAMETER Sharedsecret 
        shared secret for authentication with service. 
    .PARAMETER PassThru 
        Return details about the created autoscaleprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddAutoscaleprofile -name <string> -type <string> -url <string> -apikey <string> -sharedsecret <string>
        An example how to add autoscaleprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddAutoscaleprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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

        [Parameter(Mandatory)]
        [ValidateSet('CLOUDSTACK')]
        [string]$Type,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Url,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Apikey,

        [Parameter(Mandatory)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sharedsecret,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscaleprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
                url            = $url
                apikey         = $apikey
                sharedsecret   = $sharedsecret
            }

            if ( $PSCmdlet.ShouldProcess("autoscaleprofile", "Add Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscaleprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscaleprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddAutoscaleprofile: Finished"
    }
}

function Invoke-ADCDeleteAutoscaleprofile {
    <#
    .SYNOPSIS
        Delete Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale profile resource.
    .PARAMETER Name 
        AutoScale profile name.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteAutoscaleprofile -Name <string>
        An example how to delete autoscaleprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteAutoscaleprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleprofile: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscaleprofile -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleprofile: Finished"
    }
}

function Invoke-ADCUpdateAutoscaleprofile {
    <#
    .SYNOPSIS
        Update Autoscale configuration Object.
    .DESCRIPTION
        Configuration for autoscale profile resource.
    .PARAMETER Name 
        AutoScale profile name. 
    .PARAMETER Url 
        URL providing the service. 
    .PARAMETER Apikey 
        api key for authentication with service. 
    .PARAMETER Sharedsecret 
        shared secret for authentication with service. 
    .PARAMETER PassThru 
        Return details about the created autoscaleprofile item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateAutoscaleprofile -name <string>
        An example how to update autoscaleprofile configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateAutoscaleprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        [string]$Url,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Apikey,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Sharedsecret,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscaleprofile: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('url') ) { $payload.Add('url', $url) }
            if ( $PSBoundParameters.ContainsKey('apikey') ) { $payload.Add('apikey', $apikey) }
            if ( $PSBoundParameters.ContainsKey('sharedsecret') ) { $payload.Add('sharedsecret', $sharedsecret) }
            if ( $PSCmdlet.ShouldProcess("autoscaleprofile", "Update Autoscale configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscaleprofile -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetAutoscaleprofile -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateAutoscaleprofile: Finished"
    }
}

function Invoke-ADCGetAutoscaleprofile {
    <#
    .SYNOPSIS
        Get Autoscale configuration object(s).
    .DESCRIPTION
        Configuration for autoscale profile resource.
    .PARAMETER Name 
        AutoScale profile name. 
    .PARAMETER GetAll 
        Retrieve all autoscaleprofile object(s).
    .PARAMETER Count
        If specified, the count of the autoscaleprofile object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleprofile
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscaleprofile -GetAll 
        Get all autoscaleprofile data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetAutoscaleprofile -Count 
        Get the number of autoscaleprofile objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleprofile -name <string>
        Get autoscaleprofile object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetAutoscaleprofile -Filter @{ 'name'='<value>' }
        Get autoscaleprofile data with a filter.
    .NOTES
        File Name : Invoke-ADCGetAutoscaleprofile
        Version   : v2111.2111
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        Write-Verbose "Invoke-ADCGetAutoscaleprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all autoscaleprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscaleprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscaleprofile objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscaleprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscaleprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetAutoscaleprofile: Ended"
    }
}


