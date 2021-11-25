function Invoke-ADCAddVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Type 
        Type of video optimization action. Available settings function as follows: 
        * clear_text_pd - Cleartext PD type is detected. 
        * clear_text_abr - Cleartext ABR is detected. 
        * encrypted_abr - Encrypted ABR is detected. 
        * trigger_enc_abr - Possible encrypted ABR is detected. 
        * trigger_body_detection - Possible cleartext ABR is detected. Triggers body content detection. 
        Possible values = clear_text_pd, clear_text_abr, encrypted_abr, trigger_enc_abr, trigger_body_detection 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationdetectionaction -name <string> -type <string>
        An example how to add videooptimizationdetectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction/
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
        [ValidateSet('clear_text_pd', 'clear_text_abr', 'encrypted_abr', 'trigger_enc_abr', 'trigger_body_detection')]
        [string]$Type,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                type           = $type
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationdetectionaction -Name <string>
        An example how to delete videooptimizationdetectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-ADCUpdateVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Update VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Type 
        Type of video optimization action. Available settings function as follows: 
        * clear_text_pd - Cleartext PD type is detected. 
        * clear_text_abr - Cleartext ABR is detected. 
        * encrypted_abr - Encrypted ABR is detected. 
        * trigger_enc_abr - Possible encrypted ABR is detected. 
        * trigger_body_detection - Possible cleartext ABR is detected. Triggers body content detection. 
        Possible values = clear_text_pd, clear_text_abr, encrypted_abr, trigger_enc_abr, trigger_body_detection 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVideooptimizationdetectionaction -name <string>
        An example how to update videooptimizationdetectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction/
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

        [ValidateSet('clear_text_pd', 'clear_text_abr', 'encrypted_abr', 'trigger_enc_abr', 'trigger_body_detection')]
        [string]$Type,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Update VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-ADCUnsetVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Unset VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetVideooptimizationdetectionaction -name <string>
        An example how to unset videooptimizationdetectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Newname 
        New name for the videooptimization detection action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationdetectionaction -name <string> -newname <string>
        An example how to rename videooptimizationdetectionaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction/
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionaction", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionaction: Finished"
    }
}

function Invoke-ADCGetVideooptimizationdetectionaction {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization detectionaction resource.
    .PARAMETER Name 
        Name for the video optimization detection action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionaction object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionaction -GetAll 
        Get all videooptimizationdetectionaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionaction -Count 
        Get the number of videooptimizationdetectionaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionaction -name <string>
        Get videooptimizationdetectionaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionaction -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionaction/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionaction: Ended"
    }
}

function Invoke-ADCAddVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization detection policy. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization detection action to perform if the request matches this videooptimization detection policy. Built-in actions should be used. These are: 
        * DETECT_CLEARTEXT_PD - Cleartext PD is detected and increment related counters. 
        * DETECT_CLEARTEXT_ABR - Cleartext ABR is detected and increment related counters. 
        * DETECT_ENCRYPTED_ABR - Encrypted ABR is detected and increment related counters. 
        * TRIGGER_ENC_ABR_DETECTION - This is potentially encrypted ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * TRIGGER_CT_ABR_BODY_DETECTION - This is potentially cleartext ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * RESET - Reset the client connection by closing it. 
        * DROP - Drop the connection without sending a response. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationdetectionpolicy -name <string> -rule <string> -action <string>
        An example how to add videooptimizationdetectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy/
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationdetectionpolicy -Name <string>
        An example how to delete videooptimizationdetectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-ADCUpdateVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Update VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization detection policy. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization detection action to perform if the request matches this videooptimization detection policy. Built-in actions should be used. These are: 
        * DETECT_CLEARTEXT_PD - Cleartext PD is detected and increment related counters. 
        * DETECT_CLEARTEXT_ABR - Cleartext ABR is detected and increment related counters. 
        * DETECT_ENCRYPTED_ABR - Encrypted ABR is detected and increment related counters. 
        * TRIGGER_ENC_ABR_DETECTION - This is potentially encrypted ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * TRIGGER_CT_ABR_BODY_DETECTION - This is potentially cleartext ABR. Internal traffic heuristics algorithms will further process traffic to confirm detection. 
        * RESET - Reset the client connection by closing it. 
        * DROP - Drop the connection without sending a response. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVideooptimizationdetectionpolicy -name <string>
        An example how to update videooptimizationdetectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy/
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Update VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-ADCUnsetVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Unset VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization detection policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetVideooptimizationdetectionpolicy -name <string>
        An example how to unset videooptimizationdetectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy
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

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Newname 
        New name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationdetectionpolicy -name <string> -newname <string>
        An example how to rename videooptimizationdetectionpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy/
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicy", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionpolicy: Finished"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicy {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization detectionpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization detection policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicy -GetAll 
        Get all videooptimizationdetectionpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicy -Count 
        Get the number of videooptimizationdetectionpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicy -name <string>
        Get videooptimizationdetectionpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicy -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicy: Ended"
    }
}

function Invoke-ADCAddVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER Policylabeltype 
        Type of responses sent by the policies bound to this policy label. Types are: 
        * HTTP - HTTP responses. 
        * OTHERTCP - NON-HTTP TCP responses. 
        Possible values = videoopt_req, videoopt_res 
    .PARAMETER Comment 
        Any comments to preserve information about this videooptimization detection policy label. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationdetectionpolicylabel -labelname <string>
        An example how to add videooptimizationdetectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationdetectionpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel/
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

        [ValidateSet('videoopt_req', 'videoopt_res')]
        [string]$Policylabeltype = 'NS_PLTMAP_RSP_REQ',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationdetectionpolicylabel -Labelname <string>
        An example how to delete videooptimizationdetectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationdetectionpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER Newname 
        New name for the videooptimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen ( 
        -), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationdetectionpolicylabel -labelname <string> -newname <string>
        An example how to rename videooptimizationdetectionpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationdetectionpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationdetectionpolicylabel: Finished"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicylabel {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization detection policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization detection policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization detection policy label is added. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabel -GetAll 
        Get all videooptimizationdetectionpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabel -Count 
        Get the number of videooptimizationdetectionpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabel -name <string>
        Get videooptimizationdetectionpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabel -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabel: Ended"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding -name <string>
        Get videooptimizationdetectionpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding -Count 
        Get the number of videooptimizationdetectionpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding -name <string>
        Get videooptimizationdetectionpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCAddVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
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

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -Labelname <string>
        An example how to delete videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationdetectionpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization detection policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -GetAll 
        Get all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -Count 
        Get the number of videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -name <string>
        Get videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicylabel_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylabelvideooptimizationdetectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicybinding -GetAll 
        Get all videooptimizationdetectionpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicybinding -name <string>
        Get videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding -GetAll 
        Get all videooptimizationdetectionpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding -Count 
        Get the number of videooptimizationdetectionpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding -name <string>
        Get videooptimizationdetectionpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationglobaldetection that can be bound to videooptimizationdetectionpolicy.
    .PARAMETER Name 
        Name of the videooptimization detection policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding -GetAll 
        Get all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding -Count 
        Get the number of videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding -name <string>
        Get videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationdetectionpolicy_videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationdetectionpolicyvideooptimizationglobaldetectionbinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationglobaldetectionbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationglobaldetection.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobaldetection_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobaldetection_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionbinding -GetAll 
        Get all videooptimizationglobaldetection_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionbinding -name <string>
        Get videooptimizationglobaldetection_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobaldetection_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationglobaldetectionbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobaldetection_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationglobaldetectionbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobaldetection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobaldetection_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobaldetection_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobaldetectionbinding: Ended"
    }
}

function Invoke-ADCAddVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER Policyname 
        Name of the videooptimization detection policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -policyname <string> -priority <double>
        An example how to add videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER Policyname 
        Name of the videooptimization detection policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding 
        An example how to delete videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
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

        [string]$Policyname,

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Finished"
    }
}

function Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationdetectionpolicy that can be bound to videooptimizationglobaldetection.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -GetAll 
        Get all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -Count 
        Get the number of videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -name <string>
        Get videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobaldetection_videooptimizationdetectionpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobaldetectionvideooptimizationdetectionpolicybinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationglobalpacingbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationglobalpacing.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobalpacing_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobalpacing_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingbinding -GetAll 
        Get all videooptimizationglobalpacing_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingbinding -name <string>
        Get videooptimizationglobalpacing_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobalpacing_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationglobalpacingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobalpacing_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationglobalpacingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobalpacing_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobalpacing_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobalpacing_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobalpacingbinding: Ended"
    }
}

function Invoke-ADCAddVideooptimizationglobalpacingvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER Policyname 
        Name of the videooptimization pacing policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label, and then forward the request to the specified virtual server or evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of invocation, Available settings function as follows: * vserver - Forward the request to the specified virtual server. * policylabel - Invoke the specified policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Labelname 
        Name of the policy label to invoke. If the current policy evaluates to TRUE, the invoke parameter is set, and Label Type is policylabel. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationglobalpacing_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -policyname <string> -priority <double>
        An example how to add videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationglobalpacingvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
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
        [string]$Policyname,

        [Parameter(Mandatory)]
        [double]$Priority,

        [string]$Gotopriorityexpression,

        [ValidateSet('REQ_OVERRIDE', 'REQ_DEFAULT', 'RES_OVERRIDE', 'RES_DEFAULT')]
        [string]$Type,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ policyname = $policyname
                priority             = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('type') ) { $payload.Add('type', $type) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('labelname') ) { $payload.Add('labelname', $labelname) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobalpacing_videooptimizationpacingpolicy_binding", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationglobalpacingvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER Policyname 
        Name of the videooptimization pacing policy. 
    .PARAMETER Type 
        Specifies the bind point whose policies you want to display. 
        Possible values = REQ_OVERRIDE, REQ_DEFAULT, RES_OVERRIDE, RES_DEFAULT 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationglobalpacingvideooptimizationpacingpolicybinding 
        An example how to delete videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationglobalpacingvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
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

        [string]$Policyname,

        [string]$Type,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Type') ) { $arguments.Add('type', $Type) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationglobalpacing_videooptimizationpacingpolicy_binding", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $ -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationglobalpacing.
    .PARAMETER GetAll 
        Retrieve all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -GetAll 
        Get all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -Count 
        Get the number of videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -name <string>
        Get videooptimizationglobalpacing_videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationglobalpacing_videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationglobalpacing_videooptimizationpacingpolicy_binding/
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

        [Parameter(ParameterSetName = 'Count', Mandatory)]
        [Switch]$Count,
			
        [hashtable]$Filter = @{ },

        [Parameter(ParameterSetName = 'GetAll')]
        [Switch]$GetAll
    )
    begin {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationglobalpacing_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationglobalpacing_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationglobalpacingvideooptimizationpacingpolicybinding: Ended"
    }
}

function Invoke-ADCAddVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationpacingaction -name <string> -rate <int>
        An example how to add videooptimizationpacingaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction/
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
        [ValidateRange(1, 2147483647)]
        [int]$Rate = '1000',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rate           = $rate
            }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingaction: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationpacingaction -Name <string>
        An example how to delete videooptimizationpacingaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingaction: Finished"
    }
}

function Invoke-ADCUpdateVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Update VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVideooptimizationpacingaction -name <string>
        An example how to update videooptimizationpacingaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction/
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

        [ValidateRange(1, 2147483647)]
        [int]$Rate,

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Update VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateVideooptimizationpacingaction: Finished"
    }
}

function Invoke-ADCUnsetVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Unset VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Rate 
        ABR Video Optimization Pacing Rate (in Kbps). 
    .PARAMETER Comment 
        Comment. Any type of information about this video optimization detection action.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetVideooptimizationpacingaction -name <string>
        An example how to unset videooptimizationpacingaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction
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

        [Boolean]$rate,

        [Boolean]$comment 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rate') ) { $payload.Add('rate', $rate) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationpacingaction: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER Newname 
        New name for the videooptimization pacing action. 
        Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingaction item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationpacingaction -name <string> -newname <string>
        An example how to rename videooptimizationpacingaction configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction/
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingaction: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingaction", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingaction -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingaction -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingaction: Finished"
    }
}

function Invoke-ADCGetVideooptimizationpacingaction {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization pacingaction resource.
    .PARAMETER Name 
        Name for the video optimization pacing action. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingaction object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingaction object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingaction
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingaction -GetAll 
        Get all videooptimizationpacingaction data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingaction -Count 
        Get the number of videooptimizationpacingaction objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingaction -name <string>
        Get videooptimizationpacingaction object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingaction -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingaction data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingaction
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingaction/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingaction: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingaction objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingaction objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingaction configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingaction configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingaction -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingaction: Ended"
    }
}

function Invoke-ADCAddVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization pacing policy. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization pacing action to perform if the request matches this videooptimization pacing policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationpacingpolicy -name <string> -rule <string> -action <string>
        An example how to add videooptimizationpacingpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy/
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                rule           = $rule
                action         = $action
            }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationpacingpolicy -Name <string>
        An example how to delete videooptimizationpacingpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$name", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Resource $name -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-ADCUpdateVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Update VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Rule 
        Expression that determines which request or response match the video optimization pacing policy. 
        The following requirements apply only to the Citrix ADC CLI: 
        * If the expression includes one or more spaces, enclose the entire expression in double quotation marks. 
        * If the expression itself includes double quotation marks, escape the quotations by using the \ character. 
        * Alternatively, you can use single quotation marks to enclose the rule, in which case you do not have to escape the double quotation marks. 
    .PARAMETER Action 
        Name of the videooptimization pacing action to perform if the request matches this videooptimization pacing policy. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVideooptimizationpacingpolicy -name <string>
        An example how to update videooptimizationpacingpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy/
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

        [string]$Undefaction,

        [string]$Comment,

        [string]$Logaction,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('rule') ) { $payload.Add('rule', $rule) }
            if ( $PSBoundParameters.ContainsKey('action') ) { $payload.Add('action', $action) }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Update VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCUpdateVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-ADCUnsetVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Unset VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Undefaction 
        Action to perform if the result of policy evaluation is undefined (UNDEF). An UNDEF event indicates an internal error condition. Only the above built-in actions can be used. 
    .PARAMETER Comment 
        Any type of information about this videooptimization pacing policy. 
    .PARAMETER Logaction 
        Name of the messagelog action to use for requests that match this policy.
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetVideooptimizationpacingpolicy -name <string>
        An example how to unset videooptimizationpacingpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy
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

        [Boolean]$undefaction,

        [Boolean]$comment,

        [Boolean]$logaction 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name }
            if ( $PSBoundParameters.ContainsKey('undefaction') ) { $payload.Add('undefaction', $undefaction) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSBoundParameters.ContainsKey('logaction') ) { $payload.Add('logaction', $logaction) }
            if ( $PSCmdlet.ShouldProcess("$name", "Unset VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER Newname 
        New name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicy item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationpacingpolicy -name <string> -newname <string>
        An example how to rename videooptimizationpacingpolicy configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy/
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingpolicy: Starting"
    }
    process {
        try {
            $payload = @{ name = $name
                newname        = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicy", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicy -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicy -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingpolicy: Finished"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicy {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization pacingpolicy resource.
    .PARAMETER Name 
        Name for the videooptimization pacing policy. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period (.) pound (#), space ( ), at (@), equals (=), colon (:), and underscore characters.Can be modified, removed or renamed. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicy
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicy -GetAll 
        Get all videooptimizationpacingpolicy data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicy -Count 
        Get the number of videooptimizationpacingpolicy objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicy -name <string>
        Get videooptimizationpacingpolicy object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicy -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicy
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicy: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicy: Ended"
    }
}

function Invoke-ADCAddVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER Policylabeltype 
        Type of responses sent by the policies bound to this policy label. Types are: 
        * HTTP - HTTP responses. 
        * OTHERTCP - NON-HTTP TCP responses. 
        Possible values = videoopt_req, videoopt_res 
    .PARAMETER Comment 
        Any comments to preserve information about this videooptimization pacing policy label. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationpacingpolicylabel -labelname <string>
        An example how to add videooptimizationpacingpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationpacingpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel/
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

        [ValidateSet('videoopt_req', 'videoopt_res')]
        [string]$Policylabeltype = 'NS_PLTMAP_RSP_REQ',

        [string]$Comment,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname }
            if ( $PSBoundParameters.ContainsKey('policylabeltype') ) { $payload.Add('policylabeltype', $policylabeltype) }
            if ( $PSBoundParameters.ContainsKey('comment') ) { $payload.Add('comment', $comment) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationpacingpolicylabel -Labelname <string>
        An example how to delete videooptimizationpacingpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationpacingpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel/
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $arguments = @{ }

            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-ADCRenameVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Rename VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER Newname 
        New name for the videooptimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen ( 
        -), period (.) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel item.
    .EXAMPLE
        PS C:\>Invoke-ADCRenameVideooptimizationpacingpolicylabel -labelname <string> -newname <string>
        An example how to rename videooptimizationpacingpolicylabel configuration Object(s).
    .NOTES
        File Name : Invoke-ADCRenameVideooptimizationpacingpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel/
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
        [ValidateScript({ $_.Length -gt 1 })]
        [string]$Newname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingpolicylabel: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                newname             = $newname
            }

            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel", "Rename VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel -Action rename -Payload $payload -GetWarning
                #HTTP Status Code on Success: 200 OK
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicylabel -Filter $payload)
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
        Write-Verbose "Invoke-ADCRenameVideooptimizationpacingpolicylabel: Finished"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicylabel {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for videooptimization pacing policy label resource.
    .PARAMETER Labelname 
        Name for the Video optimization pacing policy label. Must begin with a letter, number, or the underscore character (_), and must contain only letters, numbers, and the hyphen (-), period ( 
        .) hash (#), space ( ), at (@), equals (=), colon (:), and underscore characters. Cannot be changed after the videooptimization pacing policy label is added. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabel
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabel -GetAll 
        Get all videooptimizationpacingpolicylabel data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabel -Count 
        Get the number of videooptimizationpacingpolicylabel objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabel -name <string>
        Get videooptimizationpacingpolicylabel object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabel -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicylabel
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel/
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
        [Switch]$GetAll,

        [Parameter(ParameterSetName = 'GetAll')]
        [Parameter(ParameterSetName = 'Get')]
        [Switch]$ViewSummary

    )
    begin {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabel: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabel: Ended"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicylabelbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelbinding -GetAll 
        Get all videooptimizationpacingpolicylabel_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelbinding -name <string>
        Get videooptimizationpacingpolicylabel_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicylabelbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelbinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the policybinding that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_policybinding_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_policybinding_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding -GetAll 
        Get all videooptimizationpacingpolicylabel_policybinding_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding -Count 
        Get the number of videooptimizationpacingpolicylabel_policybinding_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding -name <string>
        Get videooptimizationpacingpolicylabel_policybinding_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_policybinding_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel_policybinding_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_policybinding_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_policybinding_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_policybinding_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelpolicybindingbinding: Ended"
    }
}

function Invoke-ADCAddVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Add VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy. 
    .PARAMETER Gotopriorityexpression 
        Expression specifying the priority of the next policy which will get evaluated if the current policy rule evaluates to TRUE. 
    .PARAMETER Invoke 
        If the current policy evaluates to TRUE, terminate evaluation of policies bound to the current policy label and evaluate the specified policy label. 
    .PARAMETER Labeltype 
        Type of policy label to invoke. Available settings function as follows: * vserver - Invoke an unnamed policy label associated with a virtual server. * policylabel - Invoke a user-defined policy label. 
        Possible values = vserver, policylabel 
    .PARAMETER Invoke_labelname 
        * If labelType is policylabel, name of the policy label to invoke. * If labelType is reqvserver or resvserver, name of the virtual server. 
    .PARAMETER PassThru 
        Return details about the created videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding item.
    .EXAMPLE
        PS C:\>Invoke-ADCAddVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -labelname <string> -policyname <string> -priority <double>
        An example how to add videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCAddVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
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

        [string]$Gotopriorityexpression,

        [boolean]$Invoke,

        [ValidateSet('vserver', 'policylabel')]
        [string]$Labeltype,

        [string]$Invoke_labelname,

        [Switch]$PassThru 
    )
    begin {
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $payload = @{ labelname = $labelname
                policyname          = $policyname
                priority            = $priority
            }
            if ( $PSBoundParameters.ContainsKey('gotopriorityexpression') ) { $payload.Add('gotopriorityexpression', $gotopriorityexpression) }
            if ( $PSBoundParameters.ContainsKey('invoke') ) { $payload.Add('invoke', $invoke) }
            if ( $PSBoundParameters.ContainsKey('labeltype') ) { $payload.Add('labeltype', $labeltype) }
            if ( $PSBoundParameters.ContainsKey('invoke_labelname') ) { $payload.Add('invoke_labelname', $invoke_labelname) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding", "Add VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -Payload $payload -GetWarning
                #HTTP Status Code on Success: 201 Created
                #HTTP Status Code on Failure: 4xx <string> (for general HTTP errors) or 5xx <string> (for NetScaler-specific errors). The response payload provides details of the error
                if ( $PSBoundParameters.ContainsKey('PassThru') ) {
                    Write-Output (Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -Filter $payload)
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
        Write-Verbose "Invoke-ADCAddVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCDeleteVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Delete VideoOptimization configuration Object.
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER Policyname 
        Name of the videooptimization policy. 
    .PARAMETER Priority 
        Specifies the priority of the policy.
    .EXAMPLE
        PS C:\>Invoke-ADCDeleteVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -Labelname <string>
        An example how to delete videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration Object(s).
    .NOTES
        File Name : Invoke-ADCDeleteVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
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

        [string]$Policyname,

        [double]$Priority 
    )
    begin {
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Starting"
    }
    process {
        try {
            $arguments = @{ }
            if ( $PSBoundParameters.ContainsKey('Policyname') ) { $arguments.Add('policyname', $Policyname) }
            if ( $PSBoundParameters.ContainsKey('Priority') ) { $arguments.Add('priority', $Priority) }
            if ( $PSCmdlet.ShouldProcess("$labelname", "Delete VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method DELETE -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Arguments $arguments
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
        Write-Verbose "Invoke-ADCDeleteVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Finished"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationpacingpolicy that can be bound to videooptimizationpacingpolicylabel.
    .PARAMETER Labelname 
        Name of the videooptimization pacing policy label to which to bind the policy. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -GetAll 
        Get all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -Count 
        Get the number of videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -name <string>
        Get videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration for property 'labelname'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $labelname -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicylabel_videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylabelvideooptimizationpacingpolicybinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicybinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object which returns the resources bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicybinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicybinding -GetAll 
        Get all videooptimizationpacingpolicy_binding data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicybinding -name <string>
        Get videooptimizationpacingpolicy_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicybinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicybinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicybinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicybinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the lbvserver that can be bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_lbvserver_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_lbvserver_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding -GetAll 
        Get all videooptimizationpacingpolicy_lbvserver_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding -Count 
        Get the number of videooptimizationpacingpolicy_lbvserver_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding -name <string>
        Get videooptimizationpacingpolicy_lbvserver_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_lbvserver_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy_lbvserver_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_lbvserver_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_lbvserver_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_lbvserver_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicylbvserverbinding: Ended"
    }
}

function Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Binding object showing the videooptimizationglobalpacing that can be bound to videooptimizationpacingpolicy.
    .PARAMETER Name 
        Name of the videooptimization pacing policy for which to display settings.Must provide policy name. 
    .PARAMETER GetAll 
        Retrieve all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding -GetAll 
        Get all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding data. 
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding -Count 
        Get the number of videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding -name <string>
        Get videooptimizationpacingpolicy_videooptimizationglobalpacing_binding object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding -Filter @{ 'name'='<value>' }
        Get videooptimizationpacingpolicy_videooptimizationglobalpacing_binding data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationpacingpolicy_videooptimizationglobalpacing_binding/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{  bulkbindings = 'yes' }
                Write-Verbose "Retrieving all videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding configuration for property 'name'"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Resource $name -Summary:$ViewSummary -Filter $Filter -GetWarning
            } else {
                Write-Verbose "Retrieving videooptimizationpacingpolicy_videooptimizationglobalpacing_binding configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationpacingpolicy_videooptimizationglobalpacing_binding -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationpacingpolicyvideooptimizationglobalpacingbinding: Ended"
    }
}

function Invoke-ADCUpdateVideooptimizationparameter {
    <#
    .SYNOPSIS
        Update VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER Randomsamplingpercentage 
        Random Sampling Percentage. 
    .PARAMETER Quicpacingrate 
        QUIC Video Pacing Rate (Kbps).
    .EXAMPLE
        PS C:\>Invoke-ADCUpdateVideooptimizationparameter 
        An example how to update videooptimizationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUpdateVideooptimizationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationparameter/
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

        [ValidateRange(0, 100)]
        [double]$Randomsamplingpercentage,

        [ValidateRange(0, 2147483647)]
        [double]$Quicpacingrate 
    )
    begin {
        Write-Verbose "Invoke-ADCUpdateVideooptimizationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('randomsamplingpercentage') ) { $payload.Add('randomsamplingpercentage', $randomsamplingpercentage) }
            if ( $PSBoundParameters.ContainsKey('quicpacingrate') ) { $payload.Add('quicpacingrate', $quicpacingrate) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationparameter", "Update VideoOptimization configuration Object") ) {
                $result = Invoke-ADCNitroApi -ADCSession $ADCSession -Method PUT -NitroPath nitro/v1/config -Type videooptimizationparameter -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUpdateVideooptimizationparameter: Finished"
    }
}

function Invoke-ADCUnsetVideooptimizationparameter {
    <#
    .SYNOPSIS
        Unset VideoOptimization configuration Object.
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER Randomsamplingpercentage 
        Random Sampling Percentage. 
    .PARAMETER Quicpacingrate 
        QUIC Video Pacing Rate (Kbps).
    .EXAMPLE
        PS C:\>Invoke-ADCUnsetVideooptimizationparameter 
        An example how to unset videooptimizationparameter configuration Object(s).
    .NOTES
        File Name : Invoke-ADCUnsetVideooptimizationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationparameter
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

        [Boolean]$randomsamplingpercentage,

        [Boolean]$quicpacingrate 
    )
    begin {
        Write-Verbose "Invoke-ADCUnsetVideooptimizationparameter: Starting"
    }
    process {
        try {
            $payload = @{ }
            if ( $PSBoundParameters.ContainsKey('randomsamplingpercentage') ) { $payload.Add('randomsamplingpercentage', $randomsamplingpercentage) }
            if ( $PSBoundParameters.ContainsKey('quicpacingrate') ) { $payload.Add('quicpacingrate', $quicpacingrate) }
            if ( $PSCmdlet.ShouldProcess("videooptimizationparameter", "Unset VideoOptimization configuration Object") ) {
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method POST -Type videooptimizationparameter -NitroPath nitro/v1/config -Action unset -Payload $payload -GetWarning
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
        Write-Verbose "Invoke-ADCUnsetVideooptimizationparameter: Finished"
    }
}

function Invoke-ADCGetVideooptimizationparameter {
    <#
    .SYNOPSIS
        Get VideoOptimization configuration object(s).
    .DESCRIPTION
        Configuration for VideoOptimization parameter resource.
    .PARAMETER GetAll 
        Retrieve all videooptimizationparameter object(s).
    .PARAMETER Count
        If specified, the count of the videooptimizationparameter object(s) will be returned.
    .PARAMETER Filter
        Specify a filter.
        -Filter @{ 'name'='<value>' }
    .PARAMETER ViewSummary
        When specified, only a summary of information is returned.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationparameter
        Get data.
    .EXAMPLE 
        PS C:\>Invoke-ADCGetVideooptimizationparameter -GetAll 
        Get all videooptimizationparameter data.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationparameter -name <string>
        Get videooptimizationparameter object by specifying for example the name.
    .EXAMPLE
        PS C:\>Invoke-ADCGetVideooptimizationparameter -Filter @{ 'name'='<value>' }
        Get videooptimizationparameter data with a filter.
    .NOTES
        File Name : Invoke-ADCGetVideooptimizationparameter
        Version   : v2111.2521
        Author    : John Billekens
        Reference : https://developer-docs.citrix.com/projects/citrix-adc-nitro-api-reference/en/latest/configuration/videooptimization/videooptimizationparameter/
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
        Write-Verbose "Invoke-ADCGetVideooptimizationparameter: Beginning"
    }
    process {
        try {
            if ( $PsCmdlet.ParameterSetName -eq 'GetAll' ) {
                $query = @{ }
                Write-Verbose "Retrieving all videooptimizationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'Count' ) {
                if ( $PSBoundParameters.ContainsKey('Count') ) { $query = @{ 'count' = 'yes' } }
                Write-Verbose "Retrieving total count for videooptimizationparameter objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Query $query -Summary:$ViewSummary -Filter $Filter -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByArgument' ) {
                Write-Verbose "Retrieving videooptimizationparameter objects by arguments"
                $arguments = @{ } 
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Arguments $arguments -GetWarning
            } elseif ( $PsCmdlet.ParameterSetName -eq 'GetByResource' ) {
                Write-Verbose "Retrieving videooptimizationparameter configuration for property ''"

            } else {
                Write-Verbose "Retrieving videooptimizationparameter configuration objects"
                $response = Invoke-ADCNitroApi -ADCSession $ADCSession -Method GET -Type videooptimizationparameter -NitroPath nitro/v1/config -Summary:$ViewSummary -Query $query -Filter $Filter -GetWarning
            }
        } catch {
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $response = $null
        }
        Write-Output $response
    }
    end {
        Write-Verbose "Invoke-ADCGetVideooptimizationparameter: Ended"
    }
}


