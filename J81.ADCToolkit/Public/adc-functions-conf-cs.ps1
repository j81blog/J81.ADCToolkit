function Invoke-ADCAddCsaction {
<#
    .SYNOPSIS
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER targetvserverexpr 
        Information about this content switching action.  
        Maximum length = 1499 
    .PARAMETER comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        Invoke-ADCAddCsaction -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$targetlbvserver ,

        [string]$targetvserver ,

        [string]$targetvserverexpr ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('targetvserverexpr')) { $Payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("csaction", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .EXAMPLE
        Invoke-ADCDeleteCsaction -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCDeleteCsaction: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csaction -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Content Switching configuration Object
    .DESCRIPTION
        Update Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER targetlbvserver 
        Name of the load balancing virtual server to which the content is switched. 
    .PARAMETER targetvserver 
        Name of the VPN, GSLB or Authentication virtual server to which the content is switched. 
    .PARAMETER targetvserverexpr 
        Information about this content switching action.  
        Maximum length = 1499 
    .PARAMETER comment 
        Comments associated with this cs action. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        Invoke-ADCUpdateCsaction -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [string]$targetlbvserver ,

        [string]$targetvserver ,

        [string]$targetvserverexpr ,

        [string]$comment ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('targetvserverexpr')) { $Payload.Add('targetvserverexpr', $targetvserverexpr) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
 
            if ($PSCmdlet.ShouldProcess("csaction", "Update Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csaction -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $Payload)
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
        Unset Content Switching configuration Object
    .DESCRIPTION
        Unset Content Switching configuration Object 
   .PARAMETER name 
       Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
   .PARAMETER comment 
       Comments associated with this cs action.
    .EXAMPLE
        Invoke-ADCUnsetCsaction -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csaction -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Rename Content Switching configuration Object
    .DESCRIPTION
        Rename Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER newname 
        New name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csaction item.
    .EXAMPLE
        Invoke-ADCRenameCsaction -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$name ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCsaction: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("csaction", "Rename Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csaction -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsaction -Filter $Payload)
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name for the content switching action. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the content switching action is created. 
    .PARAMETER GetAll 
        Retreive all csaction object(s)
    .PARAMETER Count
        If specified, the count of the csaction object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsaction
    .EXAMPLE 
        Invoke-ADCGetCsaction -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsaction -Count
    .EXAMPLE
        Invoke-ADCGetCsaction -name <string>
    .EXAMPLE
        Invoke-ADCGetCsaction -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsaction
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csaction/
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
        Write-Verbose "Invoke-ADCGetCsaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all csaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csaction objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Update Content Switching configuration Object
    .DESCRIPTION
        Update Content Switching configuration Object 
    .PARAMETER stateupdate 
        Specifies whether the virtual server checks the attached load balancing server for state information.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUpdateCsparameter 
    .NOTES
        File Name : Invoke-ADCUpdateCsparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter/
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

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$stateupdate 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('stateupdate')) { $Payload.Add('stateupdate', $stateupdate) }
 
            if ($PSCmdlet.ShouldProcess("csparameter", "Update Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csparameter -Payload $Payload -GetWarning
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
        Unset Content Switching configuration Object
    .DESCRIPTION
        Unset Content Switching configuration Object 
   .PARAMETER stateupdate 
       Specifies whether the virtual server checks the attached load balancing server for state information.  
       Possible values = ENABLED, DISABLED
    .EXAMPLE
        Invoke-ADCUnsetCsparameter 
    .NOTES
        File Name : Invoke-ADCUnsetCsparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter
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

        [Boolean]$stateupdate 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsparameter: Starting"
    }
    process {
        try {
            $Payload = @{

            }
            if ($PSBoundParameters.ContainsKey('stateupdate')) { $Payload.Add('stateupdate', $stateupdate) }
            if ($PSCmdlet.ShouldProcess("csparameter", "Unset Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csparameter -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER GetAll 
        Retreive all csparameter object(s)
    .PARAMETER Count
        If specified, the count of the csparameter object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsparameter
    .EXAMPLE 
        Invoke-ADCGetCsparameter -GetAll
    .EXAMPLE
        Invoke-ADCGetCsparameter -name <string>
    .EXAMPLE
        Invoke-ADCGetCsparameter -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsparameter
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csparameter/
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
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCsparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all csparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csparameter objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving csparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER url 
        URL string that is matched with the URL of a request. Can contain a wildcard character. Specify the string value in the following format: [[prefix] [*]] [.suffix].  
        Minimum length = 1  
        Maximum length = 208 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER domain 
        The domain name. The string value can range to 63 characters.  
        Minimum length = 1 
    .PARAMETER action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        Invoke-ADCAddCspolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCAddCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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

        [ValidateLength(1, 208)]
        [string]$url ,

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [string]$action ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("cspolicy", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER policyname 
       Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .EXAMPLE
        Invoke-ADCDeleteCspolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCDeleteCspolicy: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$policyname", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Arguments $Arguments
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
        Update Content Switching configuration Object
    .DESCRIPTION
        Update Content Switching configuration Object 
    .PARAMETER policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER url 
        URL string that is matched with the URL of a request. Can contain a wildcard character. Specify the string value in the following format: [[prefix] [*]] [.suffix].  
        Minimum length = 1  
        Maximum length = 208 
    .PARAMETER rule 
        Expression, or name of a named expression, against which traffic is evaluated.  
        The following requirements apply only to the Citrix ADC CLI:  
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
        * If the expression itself includes double quotation marks, escape the quotations by using the character.  
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER domain 
        The domain name. The string value can range to 63 characters.  
        Minimum length = 1 
    .PARAMETER action 
        Content switching action that names the target load balancing virtual server to which the traffic is switched. 
    .PARAMETER logaction 
        The log action associated with the content switching policy. 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        Invoke-ADCUpdateCspolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUpdateCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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

        [ValidateLength(1, 208)]
        [string]$url ,

        [string]$rule ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domain ,

        [string]$action ,

        [string]$logaction ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSBoundParameters.ContainsKey('action')) { $Payload.Add('action', $action) }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
 
            if ($PSCmdlet.ShouldProcess("cspolicy", "Update Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cspolicy -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $Payload)
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
        Unset Content Switching configuration Object
    .DESCRIPTION
        Unset Content Switching configuration Object 
   .PARAMETER policyname 
       Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
   .PARAMETER logaction 
       The log action associated with the content switching policy. 
   .PARAMETER url 
       URL string that is matched with the URL of a request. Can contain a wildcard character. Specify the string value in the following format: [[prefix] [*]] [.suffix]. 
   .PARAMETER rule 
       Expression, or name of a named expression, against which traffic is evaluated.  
       The following requirements apply only to the Citrix ADC CLI:  
       * If the expression includes one or more spaces, enclose the entire expression in double quotation marks.  
       * If the expression itself includes double quotation marks, escape the quotations by using the character.  
       * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
   .PARAMETER domain 
       The domain name. The string value can range to 63 characters.
    .EXAMPLE
        Invoke-ADCUnsetCspolicy -policyname <string>
    .NOTES
        File Name : Invoke-ADCUnsetCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy
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

        [Boolean]$logaction ,

        [Boolean]$url ,

        [Boolean]$rule ,

        [Boolean]$domain 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
            }
            if ($PSBoundParameters.ContainsKey('logaction')) { $Payload.Add('logaction', $logaction) }
            if ($PSBoundParameters.ContainsKey('url')) { $Payload.Add('url', $url) }
            if ($PSBoundParameters.ContainsKey('rule')) { $Payload.Add('rule', $rule) }
            if ($PSBoundParameters.ContainsKey('domain')) { $Payload.Add('domain', $domain) }
            if ($PSCmdlet.ShouldProcess("$policyname", "Unset Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type cspolicy -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Rename Content Switching configuration Object
    .DESCRIPTION
        Rename Content Switching configuration Object 
    .PARAMETER policyname 
        Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER newname 
        The new name of the content switching policy.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cspolicy item.
    .EXAMPLE
        Invoke-ADCRenameCspolicy -policyname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCRenameCspolicy: Starting"
    }
    process {
        try {
            $Payload = @{
                policyname = $policyname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("cspolicy", "Rename Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicy -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicy -Filter $Payload)
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER policyname 
       Name for the content switching policy. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Cannot be changed after a policy is created. 
    .PARAMETER GetAll 
        Retreive all cspolicy object(s)
    .PARAMETER Count
        If specified, the count of the cspolicy object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicy
    .EXAMPLE 
        Invoke-ADCGetCspolicy -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicy -Count
    .EXAMPLE
        Invoke-ADCGetCspolicy -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicy -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicy
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy/
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
        Write-Verbose "Invoke-ADCGetCspolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER cspolicylabeltype 
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
        Possible values = HTTP, TCP, RTSP, SSL, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, ANY, RADIUS, RDP, MYSQL, MSSQL, ORACLE, DIAMETER, SSL_DIAMETER, FTP, DNS_TCP, SMPP 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        Invoke-ADCAddCspolicylabel -labelname <string> -cspolicylabeltype <string>
    .NOTES
        File Name : Invoke-ADCAddCspolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateSet('HTTP', 'TCP', 'RTSP', 'SSL', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'ORACLE', 'DIAMETER', 'SSL_DIAMETER', 'FTP', 'DNS_TCP', 'SMPP')]
        [string]$cspolicylabeltype ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCspolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                cspolicylabeltype = $cspolicylabeltype
            }

 
            if ($PSCmdlet.ShouldProcess("cspolicylabel", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicylabel -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER labelname 
       Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       The label name must be unique within the list of policy labels for content switching. 
    .EXAMPLE
        Invoke-ADCDeleteCspolicylabel -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCspolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [string]$labelname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCspolicylabel: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Rename Content Switching configuration Object
    .DESCRIPTION
        Rename Content Switching configuration Object 
    .PARAMETER labelname 
        Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER newname 
        The new name of the content switching policylabel.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel item.
    .EXAMPLE
        Invoke-ADCRenameCspolicylabel -labelname <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCspolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$newname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCRenameCspolicylabel: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("cspolicylabel", "Rename Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type cspolicylabel -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicylabel -Filter $Payload)
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER labelname 
       Name for the policy label. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       The label name must be unique within the list of policy labels for content switching. 
    .PARAMETER GetAll 
        Retreive all cspolicylabel object(s)
    .PARAMETER Count
        If specified, the count of the cspolicylabel object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicylabel
    .EXAMPLE 
        Invoke-ADCGetCspolicylabel -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicylabel -Count
    .EXAMPLE
        Invoke-ADCGetCspolicylabel -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicylabel -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicylabel
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel/
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
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$labelname,

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
        Write-Verbose "Invoke-ADCGetCspolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all cspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER labelname 
       Name of the content switching policy label to display. 
    .PARAMETER GetAll 
        Retreive all cspolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetCspolicylabelbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCspolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicylabelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_binding/
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
        [string]$labelname,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetCspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER labelname 
        Name of the policy label to which to bind a content switching policy. 
    .PARAMETER policyname 
        Name of the content switching policy. 
    .PARAMETER priority 
        Specifies the priority of the policy. 
    .PARAMETER targetvserver 
        Name of the virtual server to which to forward requests that match the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER invoke 
        . 
    .PARAMETER labeltype 
        Type of policy label invocation.  
        Possible values = policylabel 
    .PARAMETER invoke_labelname 
        Name of the label to invoke if the current policy rule evaluates to TRUE. 
    .PARAMETER PassThru 
        Return details about the created cspolicylabel_cspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCspolicylabelcspolicybinding -labelname <string> -policyname <string> -priority <double>
    .NOTES
        File Name : Invoke-ADCAddCspolicylabelcspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$labelname ,

        [Parameter(Mandatory = $true)]
        [string]$policyname ,

        [Parameter(Mandatory = $true)]
        [double]$priority ,

        [string]$targetvserver ,

        [string]$gotopriorityexpression ,

        [boolean]$invoke ,

        [ValidateSet('policylabel')]
        [string]$labeltype ,

        [string]$invoke_labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCspolicylabelcspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                labelname = $labelname
                policyname = $policyname
                priority = $priority
            }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('invoke_labelname')) { $Payload.Add('invoke_labelname', $invoke_labelname) }
 
            if ($PSCmdlet.ShouldProcess("cspolicylabel_cspolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type cspolicylabel_cspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCspolicylabelcspolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER labelname 
       Name of the policy label to which to bind a content switching policy.    .PARAMETER policyname 
       Name of the content switching policy.
    .EXAMPLE
        Invoke-ADCDeleteCspolicylabelcspolicybinding -labelname <string>
    .NOTES
        File Name : Invoke-ADCDeleteCspolicylabelcspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$labelname ,

        [string]$policyname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCspolicylabelcspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSCmdlet.ShouldProcess("$labelname", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER labelname 
       Name of the policy label to which to bind a content switching policy. 
    .PARAMETER GetAll 
        Retreive all cspolicylabel_cspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicylabel_cspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicylabelcspolicybinding
    .EXAMPLE 
        Invoke-ADCGetCspolicylabelcspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicylabelcspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCspolicylabelcspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicylabelcspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicylabelcspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicylabel_cspolicy_binding/
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
        [string]$labelname,

        [Parameter(ParameterSetName = 'Count', Mandatory = $true)]
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
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicylabel_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicylabel_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicylabel_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicylabel_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER policyname 
       Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all cspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicybinding
    .EXAMPLE 
        Invoke-ADCGetCspolicybinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER policyname 
       Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all cspolicy_crvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicy_crvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicycrvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCspolicycrvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicycrvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCspolicycrvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicycrvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicycrvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_crvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycrvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_crvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_crvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_crvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER policyname 
       Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all cspolicy_cspolicylabel_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicy_cspolicylabel_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicycspolicylabelbinding
    .EXAMPLE 
        Invoke-ADCGetCspolicycspolicylabelbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicycspolicylabelbinding -Count
    .EXAMPLE
        Invoke-ADCGetCspolicycspolicylabelbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicycspolicylabelbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicycspolicylabelbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_cspolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycspolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicy_cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_cspolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_cspolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_cspolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER policyname 
       Name of the content switching policy to display. If this parameter is omitted, details of all the policies are displayed. 
    .PARAMETER GetAll 
        Retreive all cspolicy_csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the cspolicy_csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCspolicycsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCspolicycsvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCspolicycsvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCspolicycsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCspolicycsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCspolicycsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/cspolicy_csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCspolicycsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all cspolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for cspolicy_csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration for property 'policyname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Resource $policyname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving cspolicy_csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type cspolicy_csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER td 
        Integer value that uniquely identifies the traffic domain in which you want to configure the entity. If you do not specify an ID, the entity becomes part of the default traffic domain, which has an ID of 0.  
        Minimum value = 0  
        Maximum value = 4094 
    .PARAMETER servicetype 
        Protocol used by the virtual server.  
        Possible values = HTTP, SSL, TCP, FTP, RTSP, SSL_TCP, UDP, DNS, SIP_UDP, SIP_TCP, SIP_SSL, ANY, RADIUS, RDP, MYSQL, MSSQL, DIAMETER, SSL_DIAMETER, DNS_TCP, ORACLE, SMPP, PROXY, MONGO, MONGO_TLS 
    .PARAMETER ipv46 
        IP address of the content switching virtual server.  
        Minimum length = 1 
    .PARAMETER targettype 
        Virtual server target type.  
        Possible values = GSLB 
    .PARAMETER dnsrecordtype 
        .  
        Default value: NSGSLB_IPV4  
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER persistenceid 
        .  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter.  
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask).  
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER range 
        Number of consecutive IP addresses, starting with the address specified by the IP Address parameter, to include in a range of addresses assigned to this virtual server.  
        Default value: 1  
        Minimum value = 1  
        Maximum value = 254 
    .PARAMETER port 
        Port number for content switching virtual server.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver.  
        Minimum length = 1 
    .PARAMETER state 
        Initial state of the load balancing virtual server.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows:  
        Global Level | Vserver Level | Result  
        ENABLED ENABLED ENABLED  
        ENABLED DISABLED ENABLED  
        DISABLED ENABLED ENABLED  
        DISABLED DISABLED DISABLED  
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL.  
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server.  
        Minimum length = 1 
    .PARAMETER clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are:  
        180 seconds for HTTP/SSL-based services.  
        9000 seconds for other TCP-based services.  
        120 seconds for DNS-based services.  
        120 seconds for other UDP-based services.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies.  
        Default value: RULE  
        Possible values = RULE, URL 
    .PARAMETER casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs.  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER redirectportrewrite 
        State of port rewrite while performing HTTP redirect.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows:  
        VIPADDR - Header contains the vserver's IP address and port number without any translation.  
        OFF - The virtual IP and port header insertion option is disabled.  
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command.  
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter.  
        Minimum length = 1 
    .PARAMETER rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL.  
        Minimum length = 3  
        Maximum length = 252 
    .PARAMETER authentication 
        Authenticate users who request a connection to the content switching virtual server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER authn401 
        Enable HTTP 401-response based authentication.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. .  
        Minimum length = 1  
        Maximum length = 252 
    .PARAMETER push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server.  
        Minimum length = 1 
    .PARAMETER pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL.  
        Default value: "none" 
    .PARAMETER pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dbprofilename 
        Name of the DB profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER oracleserverversion 
        Oracle server version.  
        Default value: 10G  
        Possible values = 10G, 11G 
    .PARAMETER comment 
        Information about this virtual server. 
    .PARAMETER mssqlserverversion 
        The version of the MSSQL server.  
        Default value: 2008R2  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER l2conn 
        Use L2 Parameters to identify a connection.  
        Possible values = ON, OFF 
    .PARAMETER mysqlprotocolversion 
        The protocol version returned by the mysql vserver.  
        Default value: 10 
    .PARAMETER mysqlserverversion 
        The server version string returned by the mysql vserver.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER mysqlcharacterset 
        The character set returned by the mysql vserver.  
        Default value: 8 
    .PARAMETER mysqlservercapabilities 
        The server capabilities returned by the mysql vserver.  
        Default value: 41613 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        The name of the network profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER icmpvsrresponse 
        Can be active or passive.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        A host route is injected according to the setting on the virtual servers  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dtls 
        This option starts/stops the dtls service on the vserver.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER persistencetype 
        Type of persistence for the virtual server. Available settings function as follows:  
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session.  
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session.  
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session.  
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        Invoke-ADCAddCsvserver -name <string> -servicetype <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        [ValidateSet('HTTP', 'SSL', 'TCP', 'FTP', 'RTSP', 'SSL_TCP', 'UDP', 'DNS', 'SIP_UDP', 'SIP_TCP', 'SIP_SSL', 'ANY', 'RADIUS', 'RDP', 'MYSQL', 'MSSQL', 'DIAMETER', 'SSL_DIAMETER', 'DNS_TCP', 'ORACLE', 'SMPP', 'PROXY', 'MONGO', 'MONGO_TLS')]
        [string]$servicetype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipv46 ,

        [ValidateSet('GSLB')]
        [string]$targettype ,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$dnsrecordtype = 'NSGSLB_IPV4' ,

        [ValidateRange(0, 65535)]
        [double]$persistenceid ,

        [string]$ippattern ,

        [string]$ipmask ,

        [ValidateRange(1, 254)]
        [double]$range = '1' ,

        [ValidateRange(1, 65535)]
        [int]$port ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$state = 'ENABLED' ,

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$stateupdate = 'DISABLED' ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable = 'NO' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$redirecturl ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('RULE', 'URL')]
        [string]$precedence = 'RULE' ,

        [ValidateSet('ON', 'OFF')]
        [string]$casesensitive = 'ON' ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence = 'DISABLED' ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout = '2' ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite = 'DISABLED' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush = 'ENABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$backupvserver ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown = 'DISABLED' ,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$insertvserveripport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vipheader ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspnat = 'OFF' ,

        [ValidateLength(3, 252)]
        [string]$authenticationhost ,

        [ValidateSet('ON', 'OFF')]
        [string]$authentication = 'OFF' ,

        [string]$listenpolicy = '"NONE"' ,

        [ValidateRange(0, 100)]
        [double]$listenpriority = '101' ,

        [ValidateSet('ON', 'OFF')]
        [string]$authn401 = 'OFF' ,

        [ValidateLength(1, 252)]
        [string]$authnvsname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$push = 'DISABLED' ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pushvserver ,

        [string]$pushlabel = '"none"' ,

        [ValidateSet('YES', 'NO')]
        [string]$pushmulticlients = 'NO' ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$dbprofilename ,

        [ValidateSet('10G', '11G')]
        [string]$oracleserverversion = '10G' ,

        [string]$comment ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlserverversion = '2008R2' ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [double]$mysqlprotocolversion = '10' ,

        [ValidateLength(1, 31)]
        [string]$mysqlserverversion ,

        [double]$mysqlcharacterset = '8' ,

        [double]$mysqlservercapabilities = '41613' ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog = 'ENABLED' ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse = 'PASSIVE' ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate = 'PASSIVE' ,

        [string]$authnprofile ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('ON', 'OFF')]
        [string]$dtls = 'OFF' ,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$persistencetype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen = '128' ,

        [ValidateRange(0, 1440)]
        [double]$timeout = '2' ,

        [string]$cookiename ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout = '2' ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                servicetype = $servicetype
            }
            if ($PSBoundParameters.ContainsKey('td')) { $Payload.Add('td', $td) }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('targettype')) { $Payload.Add('targettype', $targettype) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('ippattern')) { $Payload.Add('ippattern', $ippattern) }
            if ($PSBoundParameters.ContainsKey('ipmask')) { $Payload.Add('ipmask', $ipmask) }
            if ($PSBoundParameters.ContainsKey('range')) { $Payload.Add('range', $range) }
            if ($PSBoundParameters.ContainsKey('port')) { $Payload.Add('port', $port) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('state')) { $Payload.Add('state', $state) }
            if ($PSBoundParameters.ContainsKey('stateupdate')) { $Payload.Add('stateupdate', $stateupdate) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('casesensitive')) { $Payload.Add('casesensitive', $casesensitive) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('dtls')) { $Payload.Add('dtls', $dtls) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("csvserver", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       Cannot be changed after the CS virtual server is created. 
    .EXAMPLE
        Invoke-ADCDeleteCsvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCDeleteCsvserver: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }

            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Update Content Switching configuration Object
    .DESCRIPTION
        Update Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER ipv46 
        IP address of the content switching virtual server.  
        Minimum length = 1 
    .PARAMETER ipset 
        The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver.  
        Minimum length = 1 
    .PARAMETER ippattern 
        IP address pattern, in dotted decimal notation, for identifying packets to be accepted by the virtual server. The IP Mask parameter specifies which part of the destination IP address is matched against the pattern. Mutually exclusive with the IP Address parameter.  
        For example, if the IP pattern assigned to the virtual server is 198.51.100.0 and the IP mask is 255.255.240.0 (a forward mask), the first 20 bits in the destination IP addresses are matched with the first 20 bits in the pattern. The virtual server accepts requests with IP addresses that range from 198.51.96.1 to 198.51.111.254. You can also use a pattern such as 0.0.2.2 and a mask such as 0.0.255.255 (a reverse mask).  
        If a destination IP address matches more than one IP pattern, the pattern with the longest match is selected, and the associated virtual server processes the request. For example, if the virtual servers, vs1 and vs2, have the same IP pattern, 0.0.100.128, but different IP masks of 0.0.255.255 and 0.0.224.255, a destination IP address of 198.51.100.128 has the longest match with the IP pattern of vs1. If a destination IP address matches two or more virtual servers to the same extent, the request is processed by the virtual server whose port number matches the port number in the request. 
    .PARAMETER ipmask 
        IP mask, in dotted decimal notation, for the IP Pattern parameter. Can have leading or trailing non-zero octets (for example, 255.255.240.0 or 0.0.255.255). Accordingly, the mask specifies whether the first n bits or the last n bits of the destination IP address in a client request are to be matched with the corresponding bits in the IP pattern. The former is called a forward mask. The latter is called a reverse mask. 
    .PARAMETER stateupdate 
        Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows:  
        Global Level | Vserver Level | Result  
        ENABLED ENABLED ENABLED  
        ENABLED DISABLED ENABLED  
        DISABLED ENABLED ENABLED  
        DISABLED DISABLED DISABLED  
        If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
    .PARAMETER precedence 
        Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies.  
        Default value: RULE  
        Possible values = RULE, URL 
    .PARAMETER casesensitive 
        Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target.  
        Default value: ON  
        Possible values = ON, OFF 
    .PARAMETER backupvserver 
        Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
    .PARAMETER redirecturl 
        URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL.  
        Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server.  
        Minimum length = 1 
    .PARAMETER cacheable 
        Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER clttimeout 
        Idle time, in seconds, after which the client connection is terminated. The default values are:  
        180 seconds for HTTP/SSL-based services.  
        9000 seconds for other TCP-based services.  
        120 seconds for DNS-based services.  
        120 seconds for other UDP-based services.  
        Minimum value = 0  
        Maximum value = 31536000 
    .PARAMETER somethod 
        Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic.  
        Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
    .PARAMETER sopersistence 
        Maintain source-IP based persistence on primary and backup virtual servers.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER sopersistencetimeout 
        Time-out value, in minutes, for spillover persistence.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER sothreshold 
        Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs.  
        Minimum value = 1  
        Maximum value = 4294967287 
    .PARAMETER sobackupaction 
        Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
        Possible values = DROP, ACCEPT, REDIRECT 
    .PARAMETER redirectportrewrite 
        State of port rewrite while performing HTTP redirect.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER downstateflush 
        Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER disableprimaryondown 
        Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER insertvserveripport 
        Insert the virtual server's VIP address and port number in the request header. Available values function as follows:  
        VIPADDR - Header contains the vserver's IP address and port number without any translation.  
        OFF - The virtual IP and port header insertion option is disabled.  
        V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command.  
        Possible values = OFF, VIPADDR, V6TOV4MAPPING 
    .PARAMETER vipheader 
        Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter.  
        Minimum length = 1 
    .PARAMETER rtspnat 
        Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authenticationhost 
        FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL.  
        Minimum length = 3  
        Maximum length = 252 
    .PARAMETER authentication 
        Authenticate users who request a connection to the content switching virtual server.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER listenpolicy 
        String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression.  
        Default value: "NONE" 
    .PARAMETER listenpriority 
        Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request.  
        Default value: 101  
        Minimum value = 0  
        Maximum value = 100 
    .PARAMETER authn401 
        Enable HTTP 401-response based authentication.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER authnvsname 
        Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. .  
        Minimum length = 1  
        Maximum length = 252 
    .PARAMETER push 
        Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL.  
        Default value: DISABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER pushvserver 
        Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server.  
        Minimum length = 1 
    .PARAMETER pushlabel 
        Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL.  
        Default value: "none" 
    .PARAMETER pushmulticlients 
        Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
        Default value: NO  
        Possible values = YES, NO 
    .PARAMETER tcpprofilename 
        Name of the TCP profile containing TCP configuration settings for the virtual server.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER httpprofilename 
        Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dbprofilename 
        Name of the DB profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER comment 
        Information about this virtual server. 
    .PARAMETER l2conn 
        Use L2 Parameters to identify a connection.  
        Possible values = ON, OFF 
    .PARAMETER mssqlserverversion 
        The version of the MSSQL server.  
        Default value: 2008R2  
        Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
    .PARAMETER mysqlprotocolversion 
        The protocol version returned by the mysql vserver.  
        Default value: 10 
    .PARAMETER oracleserverversion 
        Oracle server version.  
        Default value: 10G  
        Possible values = 10G, 11G 
    .PARAMETER mysqlserverversion 
        The server version string returned by the mysql vserver.  
        Minimum length = 1  
        Maximum length = 31 
    .PARAMETER mysqlcharacterset 
        The character set returned by the mysql vserver.  
        Default value: 8 
    .PARAMETER mysqlservercapabilities 
        The server capabilities returned by the mysql vserver.  
        Default value: 41613 
    .PARAMETER appflowlog 
        Enable logging appflow flow information.  
        Default value: ENABLED  
        Possible values = ENABLED, DISABLED 
    .PARAMETER netprofile 
        The name of the network profile.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER authnprofile 
        Name of the authentication profile to be used when authentication is turned on. 
    .PARAMETER icmpvsrresponse 
        Can be active or passive.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER rhistate 
        A host route is injected according to the setting on the virtual servers  
        * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
        * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
        * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
        Default value: PASSIVE  
        Possible values = PASSIVE, ACTIVE 
    .PARAMETER dnsprofilename 
        Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers.  
        Minimum length = 1  
        Maximum length = 127 
    .PARAMETER dnsrecordtype 
        .  
        Default value: NSGSLB_IPV4  
        Possible values = A, AAAA, CNAME, NAPTR 
    .PARAMETER persistenceid 
        .  
        Minimum value = 0  
        Maximum value = 65535 
    .PARAMETER domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.  
        Minimum length = 1 
    .PARAMETER ttl 
        .  
        Minimum value = 1 
    .PARAMETER backupip 
        .  
        Minimum length = 1 
    .PARAMETER cookiedomain 
        .  
        Minimum length = 1 
    .PARAMETER cookietimeout 
        .  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER sitedomainttl 
        .  
        Minimum value = 1 
    .PARAMETER dtls 
        This option starts/stops the dtls service on the vserver.  
        Default value: OFF  
        Possible values = ON, OFF 
    .PARAMETER persistencetype 
        Type of persistence for the virtual server. Available settings function as follows:  
        * SOURCEIP - Connections from the same client IP address belong to the same persistence session.  
        * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session.  
        * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session.  
        Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
    .PARAMETER persistmask 
        Persistence mask for IP based persistence types, for IPv4 virtual servers.  
        Minimum length = 1 
    .PARAMETER v6persistmasklen 
        Persistence mask for IP based persistence types, for IPv6 virtual servers.  
        Default value: 128  
        Minimum value = 1  
        Maximum value = 128 
    .PARAMETER timeout 
        Time period for which a persistence session is in effect.  
        Default value: 2  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER cookiename 
        Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
    .PARAMETER persistencebackup 
        Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
        Possible values = SOURCEIP, NONE 
    .PARAMETER backuppersistencetimeout 
        Time period for which backup persistence is in effect.  
        Default value: 2  
        Minimum value = 2  
        Maximum value = 1440 
    .PARAMETER tcpprobeport 
        Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
        Minimum value = 1  
        Range 1 - 65535  
        * in CLI is represented as 65535 in NITRO API 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        Invoke-ADCUpdateCsvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUpdateCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipv46 ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$ipset ,

        [string]$ippattern ,

        [string]$ipmask ,

        [ValidateSet('ENABLED', 'DISABLED', 'UPDATEONBACKENDUPDATE')]
        [string]$stateupdate ,

        [ValidateSet('RULE', 'URL')]
        [string]$precedence ,

        [ValidateSet('ON', 'OFF')]
        [string]$casesensitive ,

        [ValidateScript({ $_.Length -gt 1 })]
        [ValidatePattern('^(([a-zA-Z0-9]|[_])+([a-zA-Z0-9]|[_])+)$')]
        [string]$backupvserver ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$redirecturl ,

        [ValidateSet('YES', 'NO')]
        [string]$cacheable ,

        [ValidateRange(0, 31536000)]
        [double]$clttimeout ,

        [ValidateSet('CONNECTION', 'DYNAMICCONNECTION', 'BANDWIDTH', 'HEALTH', 'NONE')]
        [string]$somethod ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$sopersistence ,

        [ValidateRange(2, 1440)]
        [double]$sopersistencetimeout ,

        [ValidateRange(1, 4294967287)]
        [double]$sothreshold ,

        [ValidateSet('DROP', 'ACCEPT', 'REDIRECT')]
        [string]$sobackupaction ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$redirectportrewrite ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$downstateflush ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$disableprimaryondown ,

        [ValidateSet('OFF', 'VIPADDR', 'V6TOV4MAPPING')]
        [string]$insertvserveripport ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$vipheader ,

        [ValidateSet('ON', 'OFF')]
        [string]$rtspnat ,

        [ValidateLength(3, 252)]
        [string]$authenticationhost ,

        [ValidateSet('ON', 'OFF')]
        [string]$authentication ,

        [string]$listenpolicy ,

        [ValidateRange(0, 100)]
        [double]$listenpriority ,

        [ValidateSet('ON', 'OFF')]
        [string]$authn401 ,

        [ValidateLength(1, 252)]
        [string]$authnvsname ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$push ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$pushvserver ,

        [string]$pushlabel ,

        [ValidateSet('YES', 'NO')]
        [string]$pushmulticlients ,

        [ValidateLength(1, 127)]
        [string]$tcpprofilename ,

        [ValidateLength(1, 127)]
        [string]$httpprofilename ,

        [ValidateLength(1, 127)]
        [string]$dbprofilename ,

        [string]$comment ,

        [ValidateSet('ON', 'OFF')]
        [string]$l2conn ,

        [ValidateSet('70', '2000', '2000SP1', '2005', '2008', '2008R2', '2012', '2014')]
        [string]$mssqlserverversion ,

        [double]$mysqlprotocolversion ,

        [ValidateSet('10G', '11G')]
        [string]$oracleserverversion ,

        [ValidateLength(1, 31)]
        [string]$mysqlserverversion ,

        [double]$mysqlcharacterset ,

        [double]$mysqlservercapabilities ,

        [ValidateSet('ENABLED', 'DISABLED')]
        [string]$appflowlog ,

        [ValidateLength(1, 127)]
        [string]$netprofile ,

        [string]$authnprofile ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$icmpvsrresponse ,

        [ValidateSet('PASSIVE', 'ACTIVE')]
        [string]$rhistate ,

        [ValidateLength(1, 127)]
        [string]$dnsprofilename ,

        [ValidateSet('A', 'AAAA', 'CNAME', 'NAPTR')]
        [string]$dnsrecordtype ,

        [ValidateRange(0, 65535)]
        [double]$persistenceid ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$domainname ,

        [double]$ttl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookiedomain ,

        [ValidateRange(0, 1440)]
        [double]$cookietimeout ,

        [double]$sitedomainttl ,

        [ValidateSet('ON', 'OFF')]
        [string]$dtls ,

        [ValidateSet('SOURCEIP', 'COOKIEINSERT', 'SSLSESSION', 'NONE')]
        [string]$persistencetype ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$persistmask ,

        [ValidateRange(1, 128)]
        [double]$v6persistmasklen ,

        [ValidateRange(0, 1440)]
        [double]$timeout ,

        [string]$cookiename ,

        [ValidateSet('SOURCEIP', 'NONE')]
        [string]$persistencebackup ,

        [ValidateRange(2, 1440)]
        [double]$backuppersistencetimeout ,

        [ValidateRange(1, 65535)]
        [int]$tcpprobeport ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCUpdateCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('ipv46')) { $Payload.Add('ipv46', $ipv46) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('ippattern')) { $Payload.Add('ippattern', $ippattern) }
            if ($PSBoundParameters.ContainsKey('ipmask')) { $Payload.Add('ipmask', $ipmask) }
            if ($PSBoundParameters.ContainsKey('stateupdate')) { $Payload.Add('stateupdate', $stateupdate) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('casesensitive')) { $Payload.Add('casesensitive', $casesensitive) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Payload.Add('domainname', $domainname) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('backupip')) { $Payload.Add('backupip', $backupip) }
            if ($PSBoundParameters.ContainsKey('cookiedomain')) { $Payload.Add('cookiedomain', $cookiedomain) }
            if ($PSBoundParameters.ContainsKey('cookietimeout')) { $Payload.Add('cookietimeout', $cookietimeout) }
            if ($PSBoundParameters.ContainsKey('sitedomainttl')) { $Payload.Add('sitedomainttl', $sitedomainttl) }
            if ($PSBoundParameters.ContainsKey('dtls')) { $Payload.Add('dtls', $dtls) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
 
            if ($PSCmdlet.ShouldProcess("csvserver", "Update Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $Payload)
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
        Unset Content Switching configuration Object
    .DESCRIPTION
        Unset Content Switching configuration Object 
   .PARAMETER name 
       Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       Cannot be changed after the CS virtual server is created. 
   .PARAMETER casesensitive 
       Consider case in URLs (for policies that use URLs instead of RULES). For example, with the ON setting, the URLs /a/1.html and /A/1.HTML are treated differently and can have different targets (set by content switching policies). With the OFF setting, /a/1.html and /A/1.HTML are switched to the same target.  
       Possible values = ON, OFF 
   .PARAMETER backupvserver 
       Name of the backup virtual server that you are configuring. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. Can be changed after the backup virtual server is created. You can assign a different backup virtual server or rename the existing virtual server. 
   .PARAMETER clttimeout 
       Idle time, in seconds, after which the client connection is terminated. The default values are:  
       180 seconds for HTTP/SSL-based services.  
       9000 seconds for other TCP-based services.  
       120 seconds for DNS-based services.  
       120 seconds for other UDP-based services. 
   .PARAMETER redirecturl 
       URL to which traffic is redirected if the virtual server becomes unavailable. The service type of the virtual server should be either HTTP or SSL.  
       Caution: Make sure that the domain in the URL does not match the domain specified for a content switching policy. If it does, requests are continuously redirected to the unavailable virtual server. 
   .PARAMETER authn401 
       Enable HTTP 401-response based authentication.  
       Possible values = ON, OFF 
   .PARAMETER authentication 
       Authenticate users who request a connection to the content switching virtual server.  
       Possible values = ON, OFF 
   .PARAMETER authenticationhost 
       FQDN of the authentication virtual server. The service type of the virtual server should be either HTTP or SSL. 
   .PARAMETER authnvsname 
       Name of authentication virtual server that authenticates the incoming user requests to this content switching virtual server. . 
   .PARAMETER pushvserver 
       Name of the load balancing virtual server, of type PUSH or SSL_PUSH, to which the server pushes updates received on the client-facing load balancing virtual server. 
   .PARAMETER pushlabel 
       Expression for extracting the label from the response received from server. This string can be either an existing rule name or an inline expression. The service type of the virtual server should be either HTTP or SSL. 
   .PARAMETER tcpprofilename 
       Name of the TCP profile containing TCP configuration settings for the virtual server. 
   .PARAMETER httpprofilename 
       Name of the HTTP profile containing HTTP configuration settings for the virtual server. The service type of the virtual server should be either HTTP or SSL. 
   .PARAMETER dbprofilename 
       Name of the DB profile. 
   .PARAMETER l2conn 
       Use L2 Parameters to identify a connection.  
       Possible values = ON, OFF 
   .PARAMETER mysqlprotocolversion 
       The protocol version returned by the mysql vserver. 
   .PARAMETER mysqlserverversion 
       The server version string returned by the mysql vserver. 
   .PARAMETER mysqlcharacterset 
       The character set returned by the mysql vserver. 
   .PARAMETER mysqlservercapabilities 
       The server capabilities returned by the mysql vserver. 
   .PARAMETER appflowlog 
       Enable logging appflow flow information.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER netprofile 
       The name of the network profile. 
   .PARAMETER icmpvsrresponse 
       Can be active or passive.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER authnprofile 
       Name of the authentication profile to be used when authentication is turned on. 
   .PARAMETER sothreshold 
       Depending on the spillover method, the maximum number of connections or the maximum total bandwidth (Kbps) that a virtual server can handle before spillover occurs. 
   .PARAMETER dnsprofilename 
       Name of the DNS profile to be associated with the VServer. DNS profile properties will applied to the transactions processed by a VServer. This parameter is valid only for DNS and DNS-TCP VServers. 
   .PARAMETER tcpprobeport 
       Port number for external TCP probe. NetScaler provides support for external TCP health check of the vserver status over the selected port. This option is only supported for vservers assigned with an IPAddress or ipset.  
       * in CLI is represented as 65535 in NITRO API 
   .PARAMETER ipset 
       The list of IPv4/IPv6 addresses bound to ipset would form a part of listening service on the current cs vserver. 
   .PARAMETER stateupdate 
       Enable state updates for a specific content switching virtual server. By default, the Content Switching virtual server is always UP, regardless of the state of the Load Balancing virtual servers bound to it. This parameter interacts with the global setting as follows:  
       Global Level | Vserver Level | Result  
       ENABLED ENABLED ENABLED  
       ENABLED DISABLED ENABLED  
       DISABLED ENABLED ENABLED  
       DISABLED DISABLED DISABLED  
       If you want to enable state updates for only some content switching virtual servers, be sure to disable the state update parameter.  
       Possible values = ENABLED, DISABLED, UPDATEONBACKENDUPDATE 
   .PARAMETER precedence 
       Type of precedence to use for both RULE-based and URL-based policies on the content switching virtual server. With the default (RULE) setting, incoming requests are evaluated against the rule-based content switching policies. If none of the rules match, the URL in the request is evaluated against the URL-based content switching policies.  
       Possible values = RULE, URL 
   .PARAMETER cacheable 
       Use this option to specify whether a virtual server, used for load balancing or content switching, routes requests to the cache redirection virtual server before sending it to the configured servers.  
       Possible values = YES, NO 
   .PARAMETER somethod 
       Type of spillover used to divert traffic to the backup virtual server when the primary virtual server reaches the spillover threshold. Connection spillover is based on the number of connections. Bandwidth spillover is based on the total Kbps of incoming and outgoing traffic.  
       Possible values = CONNECTION, DYNAMICCONNECTION, BANDWIDTH, HEALTH, NONE 
   .PARAMETER sopersistence 
       Maintain source-IP based persistence on primary and backup virtual servers.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER sopersistencetimeout 
       Time-out value, in minutes, for spillover persistence. 
   .PARAMETER sobackupaction 
       Action to be performed if spillover is to take effect, but no backup chain to spillover is usable or exists.  
       Possible values = DROP, ACCEPT, REDIRECT 
   .PARAMETER redirectportrewrite 
       State of port rewrite while performing HTTP redirect.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER downstateflush 
       Flush all active transactions associated with a virtual server whose state transitions from UP to DOWN. Do not enable this option for applications that must complete their transactions.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER disableprimaryondown 
       Continue forwarding the traffic to backup virtual server even after the primary server comes UP from the DOWN state.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER insertvserveripport 
       Insert the virtual server's VIP address and port number in the request header. Available values function as follows:  
       VIPADDR - Header contains the vserver's IP address and port number without any translation.  
       OFF - The virtual IP and port header insertion option is disabled.  
       V6TOV4MAPPING - Header contains the mapped IPv4 address corresponding to the IPv6 address of the vserver and the port number. An IPv6 address can be mapped to a user-specified IPv4 address using the set ns ip6 command.  
       Possible values = OFF, VIPADDR, V6TOV4MAPPING 
   .PARAMETER vipheader 
       Name of virtual server IP and port header, for use with the VServer IP Port Insertion parameter. 
   .PARAMETER rtspnat 
       Enable network address translation (NAT) for real-time streaming protocol (RTSP) connections.  
       Possible values = ON, OFF 
   .PARAMETER listenpolicy 
       String specifying the listen policy for the content switching virtual server. Can be either the name of an existing expression or an in-line expression. 
   .PARAMETER listenpriority 
       Integer specifying the priority of the listen policy. A higher number specifies a lower priority. If a request matches the listen policies of more than one virtual server the virtual server whose listen policy has the highest priority (the lowest priority number) accepts the request. 
   .PARAMETER push 
       Process traffic with the push virtual server that is bound to this content switching virtual server (specified by the Push VServer parameter). The service type of the push virtual server should be either HTTP or SSL.  
       Possible values = ENABLED, DISABLED 
   .PARAMETER pushmulticlients 
       Allow multiple Web 2.0 connections from the same client to connect to the virtual server and expect updates.  
       Possible values = YES, NO 
   .PARAMETER comment 
       Information about this virtual server. 
   .PARAMETER mssqlserverversion 
       The version of the MSSQL server.  
       Possible values = 70, 2000, 2000SP1, 2005, 2008, 2008R2, 2012, 2014 
   .PARAMETER oracleserverversion 
       Oracle server version.  
       Possible values = 10G, 11G 
   .PARAMETER rhistate 
       A host route is injected according to the setting on the virtual servers  
       * If set to PASSIVE on all the virtual servers that share the IP address, the appliance always injects the hostroute.  
       * If set to ACTIVE on all the virtual servers that share the IP address, the appliance injects even if one virtual server is UP.  
       * If set to ACTIVE on some virtual servers and PASSIVE on the others, the appliance, injects even if one virtual server set to ACTIVE is UP.  
       Possible values = PASSIVE, ACTIVE 
   .PARAMETER dnsrecordtype 
       .  
       Possible values = A, AAAA, CNAME, NAPTR 
   .PARAMETER persistenceid 
       . 
   .PARAMETER dtls 
       This option starts/stops the dtls service on the vserver.  
       Possible values = ON, OFF 
   .PARAMETER persistencetype 
       Type of persistence for the virtual server. Available settings function as follows:  
       * SOURCEIP - Connections from the same client IP address belong to the same persistence session.  
       * COOKIEINSERT - Connections that have the same HTTP Cookie, inserted by a Set-Cookie directive from a server, belong to the same persistence session.  
       * SSLSESSION - Connections that have the same SSL Session ID belong to the same persistence session.  
       Possible values = SOURCEIP, COOKIEINSERT, SSLSESSION, NONE 
   .PARAMETER persistmask 
       Persistence mask for IP based persistence types, for IPv4 virtual servers. 
   .PARAMETER v6persistmasklen 
       Persistence mask for IP based persistence types, for IPv6 virtual servers. 
   .PARAMETER timeout 
       Time period for which a persistence session is in effect. 
   .PARAMETER cookiename 
       Use this parameter to specify the cookie name for COOKIE peristence type. It specifies the name of cookie with a maximum of 32 characters. If not specified, cookie name is internally generated. 
   .PARAMETER persistencebackup 
       Backup persistence type for the virtual server. Becomes operational if the primary persistence mechanism fails.  
       Possible values = SOURCEIP, NONE 
   .PARAMETER backuppersistencetimeout 
       Time period for which backup persistence is in effect.
    .EXAMPLE
        Invoke-ADCUnsetCsvserver -name <string>
    .NOTES
        File Name : Invoke-ADCUnsetCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver
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

        [Boolean]$casesensitive ,

        [Boolean]$backupvserver ,

        [Boolean]$clttimeout ,

        [Boolean]$redirecturl ,

        [Boolean]$authn401 ,

        [Boolean]$authentication ,

        [Boolean]$authenticationhost ,

        [Boolean]$authnvsname ,

        [Boolean]$pushvserver ,

        [Boolean]$pushlabel ,

        [Boolean]$tcpprofilename ,

        [Boolean]$httpprofilename ,

        [Boolean]$dbprofilename ,

        [Boolean]$l2conn ,

        [Boolean]$mysqlprotocolversion ,

        [Boolean]$mysqlserverversion ,

        [Boolean]$mysqlcharacterset ,

        [Boolean]$mysqlservercapabilities ,

        [Boolean]$appflowlog ,

        [Boolean]$netprofile ,

        [Boolean]$icmpvsrresponse ,

        [Boolean]$authnprofile ,

        [Boolean]$sothreshold ,

        [Boolean]$dnsprofilename ,

        [Boolean]$tcpprobeport ,

        [Boolean]$ipset ,

        [Boolean]$stateupdate ,

        [Boolean]$precedence ,

        [Boolean]$cacheable ,

        [Boolean]$somethod ,

        [Boolean]$sopersistence ,

        [Boolean]$sopersistencetimeout ,

        [Boolean]$sobackupaction ,

        [Boolean]$redirectportrewrite ,

        [Boolean]$downstateflush ,

        [Boolean]$disableprimaryondown ,

        [Boolean]$insertvserveripport ,

        [Boolean]$vipheader ,

        [Boolean]$rtspnat ,

        [Boolean]$listenpolicy ,

        [Boolean]$listenpriority ,

        [Boolean]$push ,

        [Boolean]$pushmulticlients ,

        [Boolean]$comment ,

        [Boolean]$mssqlserverversion ,

        [Boolean]$oracleserverversion ,

        [Boolean]$rhistate ,

        [Boolean]$dnsrecordtype ,

        [Boolean]$persistenceid ,

        [Boolean]$dtls ,

        [Boolean]$persistencetype ,

        [Boolean]$persistmask ,

        [Boolean]$v6persistmasklen ,

        [Boolean]$timeout ,

        [Boolean]$cookiename ,

        [Boolean]$persistencebackup ,

        [Boolean]$backuppersistencetimeout 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('casesensitive')) { $Payload.Add('casesensitive', $casesensitive) }
            if ($PSBoundParameters.ContainsKey('backupvserver')) { $Payload.Add('backupvserver', $backupvserver) }
            if ($PSBoundParameters.ContainsKey('clttimeout')) { $Payload.Add('clttimeout', $clttimeout) }
            if ($PSBoundParameters.ContainsKey('redirecturl')) { $Payload.Add('redirecturl', $redirecturl) }
            if ($PSBoundParameters.ContainsKey('authn401')) { $Payload.Add('authn401', $authn401) }
            if ($PSBoundParameters.ContainsKey('authentication')) { $Payload.Add('authentication', $authentication) }
            if ($PSBoundParameters.ContainsKey('authenticationhost')) { $Payload.Add('authenticationhost', $authenticationhost) }
            if ($PSBoundParameters.ContainsKey('authnvsname')) { $Payload.Add('authnvsname', $authnvsname) }
            if ($PSBoundParameters.ContainsKey('pushvserver')) { $Payload.Add('pushvserver', $pushvserver) }
            if ($PSBoundParameters.ContainsKey('pushlabel')) { $Payload.Add('pushlabel', $pushlabel) }
            if ($PSBoundParameters.ContainsKey('tcpprofilename')) { $Payload.Add('tcpprofilename', $tcpprofilename) }
            if ($PSBoundParameters.ContainsKey('httpprofilename')) { $Payload.Add('httpprofilename', $httpprofilename) }
            if ($PSBoundParameters.ContainsKey('dbprofilename')) { $Payload.Add('dbprofilename', $dbprofilename) }
            if ($PSBoundParameters.ContainsKey('l2conn')) { $Payload.Add('l2conn', $l2conn) }
            if ($PSBoundParameters.ContainsKey('mysqlprotocolversion')) { $Payload.Add('mysqlprotocolversion', $mysqlprotocolversion) }
            if ($PSBoundParameters.ContainsKey('mysqlserverversion')) { $Payload.Add('mysqlserverversion', $mysqlserverversion) }
            if ($PSBoundParameters.ContainsKey('mysqlcharacterset')) { $Payload.Add('mysqlcharacterset', $mysqlcharacterset) }
            if ($PSBoundParameters.ContainsKey('mysqlservercapabilities')) { $Payload.Add('mysqlservercapabilities', $mysqlservercapabilities) }
            if ($PSBoundParameters.ContainsKey('appflowlog')) { $Payload.Add('appflowlog', $appflowlog) }
            if ($PSBoundParameters.ContainsKey('netprofile')) { $Payload.Add('netprofile', $netprofile) }
            if ($PSBoundParameters.ContainsKey('icmpvsrresponse')) { $Payload.Add('icmpvsrresponse', $icmpvsrresponse) }
            if ($PSBoundParameters.ContainsKey('authnprofile')) { $Payload.Add('authnprofile', $authnprofile) }
            if ($PSBoundParameters.ContainsKey('sothreshold')) { $Payload.Add('sothreshold', $sothreshold) }
            if ($PSBoundParameters.ContainsKey('dnsprofilename')) { $Payload.Add('dnsprofilename', $dnsprofilename) }
            if ($PSBoundParameters.ContainsKey('tcpprobeport')) { $Payload.Add('tcpprobeport', $tcpprobeport) }
            if ($PSBoundParameters.ContainsKey('ipset')) { $Payload.Add('ipset', $ipset) }
            if ($PSBoundParameters.ContainsKey('stateupdate')) { $Payload.Add('stateupdate', $stateupdate) }
            if ($PSBoundParameters.ContainsKey('precedence')) { $Payload.Add('precedence', $precedence) }
            if ($PSBoundParameters.ContainsKey('cacheable')) { $Payload.Add('cacheable', $cacheable) }
            if ($PSBoundParameters.ContainsKey('somethod')) { $Payload.Add('somethod', $somethod) }
            if ($PSBoundParameters.ContainsKey('sopersistence')) { $Payload.Add('sopersistence', $sopersistence) }
            if ($PSBoundParameters.ContainsKey('sopersistencetimeout')) { $Payload.Add('sopersistencetimeout', $sopersistencetimeout) }
            if ($PSBoundParameters.ContainsKey('sobackupaction')) { $Payload.Add('sobackupaction', $sobackupaction) }
            if ($PSBoundParameters.ContainsKey('redirectportrewrite')) { $Payload.Add('redirectportrewrite', $redirectportrewrite) }
            if ($PSBoundParameters.ContainsKey('downstateflush')) { $Payload.Add('downstateflush', $downstateflush) }
            if ($PSBoundParameters.ContainsKey('disableprimaryondown')) { $Payload.Add('disableprimaryondown', $disableprimaryondown) }
            if ($PSBoundParameters.ContainsKey('insertvserveripport')) { $Payload.Add('insertvserveripport', $insertvserveripport) }
            if ($PSBoundParameters.ContainsKey('vipheader')) { $Payload.Add('vipheader', $vipheader) }
            if ($PSBoundParameters.ContainsKey('rtspnat')) { $Payload.Add('rtspnat', $rtspnat) }
            if ($PSBoundParameters.ContainsKey('listenpolicy')) { $Payload.Add('listenpolicy', $listenpolicy) }
            if ($PSBoundParameters.ContainsKey('listenpriority')) { $Payload.Add('listenpriority', $listenpriority) }
            if ($PSBoundParameters.ContainsKey('push')) { $Payload.Add('push', $push) }
            if ($PSBoundParameters.ContainsKey('pushmulticlients')) { $Payload.Add('pushmulticlients', $pushmulticlients) }
            if ($PSBoundParameters.ContainsKey('comment')) { $Payload.Add('comment', $comment) }
            if ($PSBoundParameters.ContainsKey('mssqlserverversion')) { $Payload.Add('mssqlserverversion', $mssqlserverversion) }
            if ($PSBoundParameters.ContainsKey('oracleserverversion')) { $Payload.Add('oracleserverversion', $oracleserverversion) }
            if ($PSBoundParameters.ContainsKey('rhistate')) { $Payload.Add('rhistate', $rhistate) }
            if ($PSBoundParameters.ContainsKey('dnsrecordtype')) { $Payload.Add('dnsrecordtype', $dnsrecordtype) }
            if ($PSBoundParameters.ContainsKey('persistenceid')) { $Payload.Add('persistenceid', $persistenceid) }
            if ($PSBoundParameters.ContainsKey('dtls')) { $Payload.Add('dtls', $dtls) }
            if ($PSBoundParameters.ContainsKey('persistencetype')) { $Payload.Add('persistencetype', $persistencetype) }
            if ($PSBoundParameters.ContainsKey('persistmask')) { $Payload.Add('persistmask', $persistmask) }
            if ($PSBoundParameters.ContainsKey('v6persistmasklen')) { $Payload.Add('v6persistmasklen', $v6persistmasklen) }
            if ($PSBoundParameters.ContainsKey('timeout')) { $Payload.Add('timeout', $timeout) }
            if ($PSBoundParameters.ContainsKey('cookiename')) { $Payload.Add('cookiename', $cookiename) }
            if ($PSBoundParameters.ContainsKey('persistencebackup')) { $Payload.Add('persistencebackup', $persistencebackup) }
            if ($PSBoundParameters.ContainsKey('backuppersistencetimeout')) { $Payload.Add('backuppersistencetimeout', $backuppersistencetimeout) }
            if ($PSCmdlet.ShouldProcess("$name", "Unset Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type csvserver -NitroPath nitro/v1/config -Action unset -Payload $Payload -GetWarning
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
        Enable Content Switching configuration Object
    .DESCRIPTION
        Enable Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        Invoke-ADCEnableCsvserver -name <string>
    .NOTES
        File Name : Invoke-ADCEnableCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCEnableCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Enable Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action enable -Payload $Payload -GetWarning
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
        Disable Content Switching configuration Object
    .DESCRIPTION
        Disable Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        Cannot be changed after the CS virtual server is created.
    .EXAMPLE
        Invoke-ADCDisableCsvserver -name <string>
    .NOTES
        File Name : Invoke-ADCDisableCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCDisableCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }

            if ($PSCmdlet.ShouldProcess($Name, "Disable Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action disable -Payload $Payload -GetWarning
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
        Rename Content Switching configuration Object
    .DESCRIPTION
        Rename Content Switching configuration Object 
    .PARAMETER name 
        Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
        Cannot be changed after the CS virtual server is created. 
    .PARAMETER newname 
        New name for the virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters. 
    .PARAMETER PassThru 
        Return details about the created csvserver item.
    .EXAMPLE
        Invoke-ADCRenameCsvserver -name <string> -newname <string>
    .NOTES
        File Name : Invoke-ADCRenameCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCRenameCsvserver: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
                newname = $newname
            }

 
            if ($PSCmdlet.ShouldProcess("csvserver", "Rename Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type csvserver -Action rename -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserver -Filter $Payload)
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name for the content switching virtual server. Must begin with an ASCII alphanumeric or underscore (_) character, and must contain only ASCII alphanumeric, underscore, hash (#), period (.), space, colon (:), at sign (@), equal sign (=), and hyphen (-) characters.  
       Cannot be changed after the CS virtual server is created. 
    .PARAMETER GetAll 
        Retreive all csvserver object(s)
    .PARAMETER Count
        If specified, the count of the csvserver object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserver
    .EXAMPLE 
        Invoke-ADCGetCsvserver -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserver -Count
    .EXAMPLE
        Invoke-ADCGetCsvserver -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserver -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserver
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver/
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
        Write-Verbose "Invoke-ADCGetCsvserver: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ }
                Write-Verbose "Retrieving all csvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER analyticsprofile 
        Name of the analytics profile bound to the LB vserver. 
    .PARAMETER PassThru 
        Return details about the created csvserver_analyticsprofile_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserveranalyticsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCAddCsvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Payload.Add('analyticsprofile', $analyticsprofile) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_analyticsprofile_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_analyticsprofile_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserveranalyticsprofilebinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER analyticsprofile 
       Name of the analytics profile bound to the LB vserver.
    .EXAMPLE
        Invoke-ADCDeleteCsvserveranalyticsprofilebinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserveranalyticsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserveranalyticsprofilebinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('analyticsprofile')) { $Arguments.Add('analyticsprofile', $analyticsprofile) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_analyticsprofile_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_analyticsprofile_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserveranalyticsprofilebinding
    .EXAMPLE 
        Invoke-ADCGetCsvserveranalyticsprofilebinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserveranalyticsprofilebinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserveranalyticsprofilebinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserveranalyticsprofilebinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserveranalyticsprofilebinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_analyticsprofile_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserveranalyticsprofilebinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_analyticsprofile_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_analyticsprofile_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_analyticsprofile_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appflowpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverappflowpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_appflowpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appflowpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverappflowpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverappflowpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappflowpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappflowpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_appflowpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_appflowpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverappflowpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverappflowpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverappflowpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverappflowpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverappflowpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverappflowpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appflowpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappflowpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appflowpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appflowpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appflowpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appfwpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverappfwpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_appfwpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appfwpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverappfwpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverappfwpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappfwpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappfwpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_appfwpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_appfwpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverappfwpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverappfwpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverappfwpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverappfwpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverappfwpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverappfwpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appfwpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappfwpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appfwpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appfwpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appfwpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_appqoepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverappqoepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_appqoepolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_appqoepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverappqoepolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverappqoepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverappqoepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverappqoepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_appqoepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_appqoepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverappqoepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverappqoepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverappqoepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverappqoepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverappqoepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverappqoepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_appqoepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverappqoepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_appqoepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_appqoepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_appqoepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditnslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverauditnslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_auditnslogpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditnslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverauditnslogpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverauditnslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditnslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_auditnslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_auditnslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverauditnslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverauditnslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverauditnslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverauditnslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverauditnslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverauditnslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditnslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauditnslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditnslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditnslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditnslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_auditsyslogpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverauditsyslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_auditsyslogpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_auditsyslogpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverauditsyslogpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverauditsyslogpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauditsyslogpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_auditsyslogpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_auditsyslogpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverauditsyslogpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverauditsyslogpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverauditsyslogpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverauditsyslogpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverauditsyslogpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverauditsyslogpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_auditsyslogpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauditsyslogpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_auditsyslogpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_auditsyslogpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_auditsyslogpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_authorizationpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverauthorizationpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_authorizationpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_authorizationpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverauthorizationpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverauthorizationpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverauthorizationpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_authorizationpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_authorizationpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverauthorizationpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverauthorizationpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverauthorizationpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverauthorizationpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverauthorizationpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverauthorizationpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_authorizationpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverauthorizationpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_authorizationpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_authorizationpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_authorizationpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of a content switching virtual server for which to display information, including the policies bound to the virtual server. To display a list of all configured Content Switching virtual servers, do not specify a value for this parameter. 
    .PARAMETER GetAll 
        Retreive all csvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverbinding -GetAll
    .EXAMPLE
        Invoke-ADCGetCsvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_botpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverbotpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverbotpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_botpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_botpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverbotpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverbotpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverbotpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverbotpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_botpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_botpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverbotpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverbotpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverbotpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverbotpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverbotpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverbotpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_botpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverbotpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_botpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_botpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_botpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cachepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservercachepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_cachepolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cachepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservercachepolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservercachepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercachepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercachepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_cachepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_cachepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservercachepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservercachepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservercachepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservercachepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservercachepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservercachepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cachepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercachepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cachepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cachepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cachepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cmppolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservercmppolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_cmppolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cmppolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservercmppolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservercmppolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercmppolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercmppolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_cmppolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_cmppolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservercmppolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservercmppolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservercmppolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservercmppolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservercmppolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservercmppolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cmppolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercmppolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cmppolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cmppolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cmppolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_contentinspectionpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservercontentinspectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservercontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_contentinspectionpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_contentinspectionpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservercontentinspectionpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservercontentinspectionpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercontentinspectionpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_contentinspectionpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_contentinspectionpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservercontentinspectionpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservercontentinspectionpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservercontentinspectionpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservercontentinspectionpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservercontentinspectionpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservercontentinspectionpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_contentinspectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercontentinspectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_contentinspectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_contentinspectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_contentinspectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        target vserver name. 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_cspolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservercspolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservercspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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

        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservercspolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_cspolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_cspolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservercspolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservercspolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservercspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservercspolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_cspolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_cspolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservercspolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservercspolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservercspolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservercspolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservercspolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservercspolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_cspolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservercspolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_cspolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_cspolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_cspolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER domainname 
        Domain name for which to change the time to live (TTL) and/or backup service IP address.  
        Minimum length = 1 
    .PARAMETER ttl 
        .  
        Minimum value = 1 
    .PARAMETER backupip 
        .  
        Minimum length = 1 
    .PARAMETER cookiedomain 
        .  
        Minimum length = 1 
    .PARAMETER cookietimeout 
        .  
        Minimum value = 0  
        Maximum value = 1440 
    .PARAMETER sitedomainttl 
        .  
        Minimum value = 1 
    .PARAMETER PassThru 
        Return details about the created csvserver_domain_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverdomainbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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
        [string]$domainname ,

        [double]$ttl ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$backupip ,

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$cookiedomain ,

        [ValidateRange(0, 1440)]
        [double]$cookietimeout ,

        [double]$sitedomainttl ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverdomainbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Payload.Add('domainname', $domainname) }
            if ($PSBoundParameters.ContainsKey('ttl')) { $Payload.Add('ttl', $ttl) }
            if ($PSBoundParameters.ContainsKey('backupip')) { $Payload.Add('backupip', $backupip) }
            if ($PSBoundParameters.ContainsKey('cookiedomain')) { $Payload.Add('cookiedomain', $cookiedomain) }
            if ($PSBoundParameters.ContainsKey('cookietimeout')) { $Payload.Add('cookietimeout', $cookietimeout) }
            if ($PSBoundParameters.ContainsKey('sitedomainttl')) { $Payload.Add('sitedomainttl', $sitedomainttl) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_domain_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_domain_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverdomainbinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER domainname 
       Domain name for which to change the time to live (TTL) and/or backup service IP address.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteCsvserverdomainbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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

        [string]$domainname 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvserverdomainbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('domainname')) { $Arguments.Add('domainname', $domainname) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_domain_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_domain_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverdomainbinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverdomainbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverdomainbinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverdomainbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverdomainbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverdomainbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_domain_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverdomainbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_domain_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_domain_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_domain_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_domain_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_domain_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_feopolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_feopolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_feopolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverfeopolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverfeopolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfeopolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_feopolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_feopolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverfeopolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverfeopolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverfeopolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverfeopolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverfeopolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverfeopolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_feopolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverfeopolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_feopolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_feopolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_feopolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_filterpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_filterpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_filterpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverfilterpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverfilterpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverfilterpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_filterpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_filterpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverfilterpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverfilterpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverfilterpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverfilterpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverfilterpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverfilterpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_filterpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverfilterpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_filterpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_filterpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_filterpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created csvserver_gslbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservergslbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservergslbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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
        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservergslbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_gslbvserver_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_gslbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservergslbvserverbinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER vserver 
       Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteCsvservergslbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservergslbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvservergslbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_gslbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_gslbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservergslbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCsvservergslbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservergslbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservergslbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservergslbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservergslbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_gslbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservergslbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_gslbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_gslbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_gslbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER lbvserver 
        Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1.  
        Minimum length = 1 
    .PARAMETER targetvserver 
        The virtual server name (created with the add lb vserver command) to which content will be switched.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created csvserver_lbvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverlbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverlbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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

        [ValidateScript({ $_.Length -gt 1 })]
        [string]$targetvserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('lbvserver')) { $Payload.Add('lbvserver', $lbvserver) }
            if ($PSBoundParameters.ContainsKey('targetvserver')) { $Payload.Add('targetvserver', $targetvserver) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_lbvserver_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_lbvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverlbvserverbinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER lbvserver 
       Name of the default lb vserver bound. Use this param for Default binding only. For Example: bind cs vserver cs1 -lbvserver lb1.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteCsvserverlbvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverlbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverlbvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('lbvserver')) { $Arguments.Add('lbvserver', $lbvserver) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_lbvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_lbvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverlbvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverlbvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverlbvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverlbvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverlbvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverlbvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverlbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_responderpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverresponderpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_responderpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_responderpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverresponderpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverresponderpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverresponderpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverresponderpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_responderpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_responderpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverresponderpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverresponderpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverresponderpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverresponderpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverresponderpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverresponderpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_responderpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverresponderpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_responderpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_responderpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_responderpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_rewritepolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverrewritepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_rewritepolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_rewritepolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverrewritepolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverrewritepolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverrewritepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverrewritepolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_rewritepolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_rewritepolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverrewritepolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverrewritepolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverrewritepolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverrewritepolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverrewritepolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverrewritepolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_rewritepolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverrewritepolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_rewritepolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_rewritepolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_rewritepolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_spilloverpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_spilloverpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_spilloverpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvserverspilloverpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvserverspilloverpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvserverspilloverpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_spilloverpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_spilloverpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvserverspilloverpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvserverspilloverpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvserverspilloverpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvserverspilloverpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvserverspilloverpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvserverspilloverpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_spilloverpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvserverspilloverpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_spilloverpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_spilloverpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_spilloverpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression or other value specifying the next policy to be evaluated if the current policy evaluates to TRUE. Specify one of the following values: * NEXT - Evaluate the policy with the next higher priority number. * END - End policy evaluation. * USE_INVOCATION_RESULT - Applicable if this policy invokes another policy label. If the final goto in the invoked policy label has a value of END, the evaluation stops. If the final goto is anything other than END, the current policy label performs a NEXT. * An expression that evaluates to a number. If you specify an expression, the number to which it evaluates determines the next policy to evaluate, as follows: * If the expression evaluates to a higher numbered priority, the policy with that priority is evaluated next. * If the expression evaluates to the priority of the current policy, the policy with the next higher numbered priority is evaluated next. * If the expression evaluates to a priority number that is numerically higher than the highest numbered priority, policy evaluation ends. An UNDEF event is triggered if: * The expression is invalid. * The expression evaluates to a priority number that is numerically lower than the current policy's priority. * The expression evaluates to a priority number that is between the current policy's priority number (say, 30) and the highest priority number (say, 100), but does not match any configured priority number (for example, the expression evaluates to the number 85). This example assumes that the priority number increments by 10 for every successive policy, and therefore a priority number of 85 does not exist in the policy label. 
    .PARAMETER bindpoint 
        For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke a policy label if this policy's rule evaluates to TRUE (valid only for default-syntax policies such as application firewall, transform, integrated cache, rewrite, responder, and content switching). 
    .PARAMETER labeltype 
        Type of label to be invoked.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label to be invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_tmtrafficpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservertmtrafficpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservertmtrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_tmtrafficpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_tmtrafficpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservertmtrafficpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       For a rewrite policy, the bind point to which to bind the policy. Note: This parameter applies only to rewrite policies, because content switching policies are evaluated only at request time.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservertmtrafficpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservertmtrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservertmtrafficpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_tmtrafficpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_tmtrafficpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservertmtrafficpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservertmtrafficpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservertmtrafficpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservertmtrafficpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservertmtrafficpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservertmtrafficpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_tmtrafficpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservertmtrafficpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_tmtrafficpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_tmtrafficpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_tmtrafficpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER policyname 
        Policies bound to this vserver. 
    .PARAMETER targetlbvserver 
        Name of the Load Balancing virtual server to which the content is switched, if policy rule is evaluated to be TRUE. Example: bind cs vs cs1 -policyname pol1 -priority 101 -targetLBVserver lb1 Note: Use this parameter only in case of Content Switching policy bind operations to a CS vserver.  
        Minimum length = 1 
    .PARAMETER priority 
        Priority for the policy. 
    .PARAMETER gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER bindpoint 
        The bindpoint to which the policy is bound.  
        Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST 
    .PARAMETER invoke 
        Invoke flag. 
    .PARAMETER labeltype 
        The invocation type.  
        Possible values = reqvserver, resvserver, policylabel 
    .PARAMETER labelname 
        Name of the label invoked. 
    .PARAMETER PassThru 
        Return details about the created csvserver_transformpolicy_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservertransformpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservertransformpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        [string]$targetlbvserver ,

        [double]$priority ,

        [string]$gotopriorityexpression ,

        [ValidateSet('REQUEST', 'RESPONSE', 'ICA_REQUEST', 'OTHERTCP_REQUEST')]
        [string]$bindpoint ,

        [boolean]$invoke ,

        [ValidateSet('reqvserver', 'resvserver', 'policylabel')]
        [string]$labeltype ,

        [string]$labelname ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Payload.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('targetlbvserver')) { $Payload.Add('targetlbvserver', $targetlbvserver) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Payload.Add('priority', $priority) }
            if ($PSBoundParameters.ContainsKey('gotopriorityexpression')) { $Payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Payload.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('invoke')) { $Payload.Add('invoke', $invoke) }
            if ($PSBoundParameters.ContainsKey('labeltype')) { $Payload.Add('labeltype', $labeltype) }
            if ($PSBoundParameters.ContainsKey('labelname')) { $Payload.Add('labelname', $labelname) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_transformpolicy_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_transformpolicy_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservertransformpolicybinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER policyname 
       Policies bound to this vserver.    .PARAMETER bindpoint 
       The bindpoint to which the policy is bound.  
       Possible values = REQUEST, RESPONSE, ICA_REQUEST, OTHERTCP_REQUEST    .PARAMETER priority 
       Priority for the policy.
    .EXAMPLE
        Invoke-ADCDeleteCsvservertransformpolicybinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservertransformpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCDeleteCsvservertransformpolicybinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('policyname')) { $Arguments.Add('policyname', $policyname) }
            if ($PSBoundParameters.ContainsKey('bindpoint')) { $Arguments.Add('bindpoint', $bindpoint) }
            if ($PSBoundParameters.ContainsKey('priority')) { $Arguments.Add('priority', $priority) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_transformpolicy_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_transformpolicy_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservertransformpolicybinding
    .EXAMPLE 
        Invoke-ADCGetCsvservertransformpolicybinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservertransformpolicybinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservertransformpolicybinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservertransformpolicybinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservertransformpolicybinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_transformpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservertransformpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_transformpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_transformpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_transformpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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
        Add Content Switching configuration Object
    .DESCRIPTION
        Add Content Switching configuration Object 
    .PARAMETER name 
        Name of the content switching virtual server to which the content switching policy applies.  
        Minimum length = 1 
    .PARAMETER vserver 
        Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.  
        Minimum length = 1 
    .PARAMETER PassThru 
        Return details about the created csvserver_vpnvserver_binding item.
    .EXAMPLE
        Invoke-ADCAddCsvservervpnvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCAddCsvservervpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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
        [string]$vserver ,

        [Switch]$PassThru 

    )
    begin {
        Write-Verbose "Invoke-ADCAddCsvservervpnvserverbinding: Starting"
    }
    process {
        try {
            $Payload = @{
                name = $name
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Payload.Add('vserver', $vserver) }
 
            if ($PSCmdlet.ShouldProcess("csvserver_vpnvserver_binding", "Add Content Switching configuration Object")) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type csvserver_vpnvserver_binding -Payload $Payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ($PSBoundParameters.ContainsKey('PassThru')) {
                    Write-Output (Invoke-ADCGetCsvservervpnvserverbinding -Filter $Payload)
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
        Delete Content Switching configuration Object
    .DESCRIPTION
        Delete Content Switching configuration Object
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies.  
       Minimum length = 1    .PARAMETER vserver 
       Name of the default gslb or vpn vserver bound to CS vserver of type GSLB/VPN. For Example: bind cs vserver cs1 -vserver gslb1 or bind cs vserver cs1 -vserver vpn1.  
       Minimum length = 1
    .EXAMPLE
        Invoke-ADCDeleteCsvservervpnvserverbinding -name <string>
    .NOTES
        File Name : Invoke-ADCDeleteCsvservervpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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

        [string]$vserver 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteCsvservervpnvserverbinding: Starting"
    }
    process {
        try {
            $Arguments = @{ 
            }
            if ($PSBoundParameters.ContainsKey('vserver')) { $Arguments.Add('vserver', $vserver) }
            if ($PSCmdlet.ShouldProcess("$name", "Delete Content Switching configuration Object")) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Arguments $Arguments
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
        Get Content Switching configuration object(s)
    .DESCRIPTION
        Get Content Switching configuration object(s)
    .PARAMETER name 
       Name of the content switching virtual server to which the content switching policy applies. 
    .PARAMETER GetAll 
        Retreive all csvserver_vpnvserver_binding object(s)
    .PARAMETER Count
        If specified, the count of the csvserver_vpnvserver_binding object(s) will be returned
    .PARAMETER Filter
        Specify a filter
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned
    .EXAMPLE
        Invoke-ADCGetCsvservervpnvserverbinding
    .EXAMPLE 
        Invoke-ADCGetCsvservervpnvserverbinding -GetAll 
    .EXAMPLE 
        Invoke-ADCGetCsvservervpnvserverbinding -Count
    .EXAMPLE
        Invoke-ADCGetCsvservervpnvserverbinding -name <string>
    .EXAMPLE
        Invoke-ADCGetCsvservervpnvserverbinding -Filter @{ 'name'='<value>' }
    .NOTES
        File Name : Invoke-ADCGetCsvservervpnvserverbinding
        Version   : v2101.0322
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/cs/csvserver_vpnvserver_binding/
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
        Write-Verbose "Invoke-ADCGetCsvservervpnvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'Getall' ) {
                $Query = @{ 
                    bulkbindings = 'yes'
                }
                Write-Verbose "Retrieving all csvserver_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ($PSBoundParameters.ContainsKey('Count')) { $Query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for csvserver_vpnvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Query $Query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding objects by arguments"
                $Arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Arguments $Arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving csvserver_vpnvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type csvserver_vpnvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $Query -Filter $Filter -GetWarning
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


