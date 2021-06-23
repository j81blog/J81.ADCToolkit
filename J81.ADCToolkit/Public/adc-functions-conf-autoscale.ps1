function Invoke-ADCAddAutoscaleaction {
<#
    .SYNOPSIS
        Add Autoscale configuration Object
    .DESCRIPTION
        Add Autoscale configuration Object 
    .PARAMETER name 
        ActionScale action name.  
        Minimum length = 1 
    .PARAMETER type 
        The type of action.  
        Possible values = SCALE_UP, SCALE_DOWN 
    .PARAMETER profilename 
        AutoScale profile name.  
        Minimum length = 1 
    .PARAMETER parameters 
        Parameters to use in the action.  
        Minimum length = 1 
    .PARAMETER vmdestroygraceperiod 
        Time in minutes a VM is kept in inactive state before destroying.  
        Default value: 10 
    .PARAMETER quiettime 
        Time in seconds no other policy is evaluated or action is taken.  
        Default value: 300 
    .PARAMETER vserver 
        Name of the vserver on which autoscale action has to be taken. 
    .PARAMETER PassThru 
        Return details about the created autoscaleaction item.
    .EXAMPLE
        Invoke-ADCAddAutoscaleaction -name <string> -type <string> -profilename <string> -parameters <string> -vserver <string>
    .NOTES
        File Name : Invoke-ADCAddAutoscaleaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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

        [Parameter(Mandatory = $true)]
        [ValidateSet('SCALE_UP', 'SCALE_DOWN')]
        [string]$type ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$profilename ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$parameters ,

        [double]$vmdestroygraceperiod = '10' ,

        [double]$quiettime = '300' ,

        [Parameter(Mandatory = $true)]
        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscaleaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
                profilename = $profilename
                parameters = $parameters
                vserver = $vserver
            }
            if ($PSBoundParameters.ContainsKey('vmdestroygraceperiod')) { $Payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ($PSBoundParameters.ContainsKey('quiettime')) { $Payload.Add('quiettime', $quiettime) }
 
            if ($PSCmdlet.ShouldProcess("autoscaleaction", "Add Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscaleaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscaleaction -Filter $Payload)
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
        Delete Autoscale configuration Object
    .DESCRIPTION
        Delete Autoscale configuration Object
    .PARAMETER name 
       ActionScale action name.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAutoscaleaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAutoscaleaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscaleaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Autoscale configuration Object
    .DESCRIPTION
        Update Autoscale configuration Object 
    .PARAMETER name 
        ActionScale action name.  
        Minimum length = 1 
    .PARAMETER profilename 
        AutoScale profile name.  
        Minimum length = 1 
    .PARAMETER parameters 
        Parameters to use in the action.  
        Minimum length = 1 
    .PARAMETER vmdestroygraceperiod 
        Time in minutes a VM is kept in inactive state before destroying.  
        Default value: 10 
    .PARAMETER quiettime 
        Time in seconds no other policy is evaluated or action is taken.  
        Default value: 300 
    .PARAMETER vserver 
        Name of the vserver on which autoscale action has to be taken. 
    .PARAMETER PassThru 
        Return details about the created autoscaleaction item.
    .EXAMPLE
        Invoke-ADCUpdateAutoscaleaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAutoscaleaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        [string]$profilename ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$parameters ,

        [double]$vmdestroygraceperiod ,

        [double]$quiettime ,

        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscaleaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('profilename')) { $Payload.Add('profilename', $profilename) }
            if ($PSBoundParameters.ContainsKey('parameters')) { $Payload.Add('parameters', $parameters) }
            if ($PSBoundParameters.ContainsKey('vmdestroygraceperiod')) { $Payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ($PSBoundParameters.ContainsKey('quiettime')) { $Payload.Add('quiettime', $quiettime) }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("autoscaleaction", "Update Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscaleaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscaleaction -Filter $Payload)
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
        Unset Autoscale configuration Object
    .DESCRIPTION
        Unset Autoscale configuration Object 
   .PARAMETER name 
       ActionScale action name. 
   .PARAMETER vmdestroygraceperiod 
       Time in minutes a VM is kept in inactive state before destroying. 
   .PARAMETER quiettime 
       Time in seconds no other policy is evaluated or action is taken.
    .EXAMPLE
        Invoke-ADCUnsetAutoscaleaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAutoscaleaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction
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

        [Boolean]$vmdestroygraceperiod ,

        [Boolean]$quiettime 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAutoscaleaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vmdestroygraceperiod')) { $Payload.Add('vmdestroygraceperiod', $vmdestroygraceperiod) }
            if ($PSBoundParameters.ContainsKey('quiettime')) { $Payload.Add('quiettime', $quiettime) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Autoscale configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type autoscaleaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Autoscale configuration object(s)
    .DESCRIPTION
        Get Autoscale configuration object(s)
    .PARAMETER name 
       ActionScale action name. 
    .PARAMETER GetAll 
        Retreive all autoscaleaction object(s)
    .PARAMETER Count
        If specified, the count of the autoscaleaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAutoscaleaction
    .EXAMPLE 
        Invoke-ADCGetAutoscaleaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAutoscaleaction -Count
    .EXAMPLE
        Invoke-ADCGetAutoscaleaction -name <string>
    .EXAMPLE
        Invoke-ADCGetAutoscaleaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAutoscaleaction
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleaction/
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
        Write-Verbose "Invoke-ADCGetAutoscaleaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all autoscaleaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscaleaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscaleaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscaleaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscaleaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Autoscale configuration Object
    .DESCRIPTION
        Add Autoscale configuration Object 
    .PARAMETER name 
        The name of the autoscale policy.  
        Minimum length = 1 
    .PARAMETER rule 
        The rule associated with the policy. 
    .PARAMETER action 
        The autoscale profile associated with the policy.  
        Minimum length = 1 
    .PARAMETER comment 
        Comments associated with this autoscale policy. 
    .PARAMETER logaction 
        The log action associated with the autoscale policy. 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        Invoke-ADCAddAutoscalepolicy -name <string> -rule <string> -action <string>
    .NOTES
        File Name : Invoke-ADCAddAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [Parameter(Mandatory = $true)]
        [string]$rule ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscalepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                rule = $rule
                action = $action
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("autoscalepolicy", "Add Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscalepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $Payload)
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
        Delete Autoscale configuration Object
    .DESCRIPTION
        Delete Autoscale configuration Object
    .PARAMETER name 
       The name of the autoscale policy.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAutoscalepolicy -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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
        Write-Verbose "Invoke-ADCDeleteAutoscalepolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscalepolicy -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Autoscale configuration Object
    .DESCRIPTION
        Update Autoscale configuration Object 
    .PARAMETER name 
        The name of the autoscale policy.  
        Minimum length = 1 
    .PARAMETER rule 
        The rule associated with the policy. 
    .PARAMETER action 
        The autoscale profile associated with the policy.  
        Minimum length = 1 
    .PARAMETER comment 
        Comments associated with this autoscale policy. 
    .PARAMETER logaction 
        The log action associated with the autoscale policy. 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        Invoke-ADCUpdateAutoscalepolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$action ,

        [string]$comment ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscalepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("autoscalepolicy", "Update Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscalepolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $Payload)
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
        Unset Autoscale configuration Object
    .DESCRIPTION
        Unset Autoscale configuration Object 
   .PARAMETER name 
       The name of the autoscale policy. 
   .PARAMETER rule 
       The rule associated with the policy. 
   .PARAMETER action 
       The autoscale profile associated with the policy. 
   .PARAMETER comment 
       Comments associated with this autoscale policy. 
   .PARAMETER logaction 
       The log action associated with the autoscale policy.
    .EXAMPLE
        Invoke-ADCUnsetAutoscalepolicy -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy
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

        [Boolean]$rule ,

        [Boolean]$action ,

        [Boolean]$comment ,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetAutoscalepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Autoscale configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type autoscalepolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Rename Autoscale configuration Object
    .DESCRIPTION
        Rename Autoscale configuration Object 
    .PARAMETER name 
        The name of the autoscale policy.  
        Minimum length = 1 
    .PARAMETER newname 
        The new name of the autoscale policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created autoscalepolicy item.
    .EXAMPLE
        Invoke-ADCRenameAutoscalepolicy -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameAutoscalepolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("autoscalepolicy", "Rename Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscalepolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscalepolicy -Filter $Payload)
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
        Get Autoscale configuration object(s)
    .DESCRIPTION
        Get Autoscale configuration object(s)
    .PARAMETER name 
       The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retreive all autoscalepolicy object(s)
    .PARAMETER Count
        If specified, the count of the autoscalepolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicy
    .EXAMPLE 
        Invoke-ADCGetAutoscalepolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAutoscalepolicy -Count
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicy
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all autoscalepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Autoscale configuration object(s)
    .DESCRIPTION
        Get Autoscale configuration object(s)
    .PARAMETER name 
       The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retreive all autoscalepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the autoscalepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicybinding
    .EXAMPLE 
        Invoke-ADCGetAutoscalepolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicybinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all autoscalepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Autoscale configuration object(s)
    .DESCRIPTION
        Get Autoscale configuration object(s)
    .PARAMETER name 
       The name of the autoscale policy. 
    .PARAMETER GetAll 
        Retreive all autoscalepolicy_nstimer_binding object(s)
    .PARAMETER Count
        If specified, the count of the autoscalepolicy_nstimer_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicynstimerbinding
    .EXAMPLE 
        Invoke-ADCGetAutoscalepolicynstimerbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAutoscalepolicynstimerbinding -Count
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicynstimerbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetAutoscalepolicynstimerbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAutoscalepolicynstimerbinding
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscalepolicy_nstimer_binding/
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
        Write-Verbose "Invoke-ADCGetAutoscalepolicynstimerbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all autoscalepolicy_nstimer_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscalepolicy_nstimer_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscalepolicy_nstimer_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscalepolicy_nstimer_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Autoscale configuration Object
    .DESCRIPTION
        Add Autoscale configuration Object 
    .PARAMETER name 
        AutoScale profile name.  
        Minimum length = 1 
    .PARAMETER type 
        The type of profile.  
        Possible values = CLOUDSTACK 
    .PARAMETER url 
        URL providing the service.  
        Minimum length = 1 
    .PARAMETER apikey 
        api key for authentication with service.  
        Minimum length = 1 
    .PARAMETER sharedsecret 
        shared secret for authentication with service.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created autoscaleprofile item.
    .EXAMPLE
        Invoke-ADCAddAutoscaleprofile -name <string> -type <string> -url <string> -apikey <string> -sharedsecret <string>
    .NOTES
        File Name : Invoke-ADCAddAutoscaleprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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

        [Parameter(Mandatory = $true)]
        [ValidateSet('CLOUDSTACK')]
        [string]$type ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$url ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$apikey ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sharedsecret ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddAutoscaleprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                type = $type
                url = $url
                apikey = $apikey
                sharedsecret = $sharedsecret
            }

 
            if ($PSCmdlet.ShouldProcess("autoscaleprofile", "Add Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type autoscaleprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscaleprofile -Filter $Payload)
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
        Delete Autoscale configuration Object
    .DESCRIPTION
        Delete Autoscale configuration Object
    .PARAMETER name 
       AutoScale profile name.  
       Minimum length = 1 
    .EXAMPLE
        Invoke-ADCDeleteAutoscaleprofile -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteAutoscaleprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        Write-Verbose "Invoke-ADCDeleteAutoscaleprofile: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Autoscale configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type autoscaleprofile -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Autoscale configuration Object
    .DESCRIPTION
        Update Autoscale configuration Object 
    .PARAMETER name 
        AutoScale profile name.  
        Minimum length = 1 
    .PARAMETER url 
        URL providing the service.  
        Minimum length = 1 
    .PARAMETER apikey 
        api key for authentication with service.  
        Minimum length = 1 
    .PARAMETER sharedsecret 
        shared secret for authentication with service.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created autoscaleprofile item.
    .EXAMPLE
        Invoke-ADCUpdateAutoscaleprofile -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateAutoscaleprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        [string]$url ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$apikey ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$sharedsecret ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateAutoscaleprofile: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('apikey')) { $Payload.Add('apikey', $apikey) }
            if ($PSBoundParameters.ContainsKey('sharedsecret')) { $Payload.Add('sharedsecret', $sharedsecret) }
 
            if ($PSCmdlet.ShouldProcess("autoscaleprofile", "Update Autoscale configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type autoscaleprofile -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetAutoscaleprofile -Filter $Payload)
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
        Get Autoscale configuration object(s)
    .DESCRIPTION
        Get Autoscale configuration object(s)
    .PARAMETER name 
       AutoScale profile name. 
    .PARAMETER GetAll 
        Retreive all autoscaleprofile object(s)
    .PARAMETER Count
        If specified, the count of the autoscaleprofile object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetAutoscaleprofile
    .EXAMPLE 
        Invoke-ADCGetAutoscaleprofile -GetAll 
    .EXAMPLE 
        Invoke-ADCGetAutoscaleprofile -Count
    .EXAMPLE
        Invoke-ADCGetAutoscaleprofile -name <string>
    .EXAMPLE
        Invoke-ADCGetAutoscaleprofile -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetAutoscaleprofile
        Version   : v2106.2309
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/autoscale/autoscaleprofile/
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
        Write-Verbose "Invoke-ADCGetAutoscaleprofile: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all autoscaleprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for autoscaleprofile objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving autoscaleprofile objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving autoscaleprofile configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving autoscaleprofile configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type autoscaleprofile -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


